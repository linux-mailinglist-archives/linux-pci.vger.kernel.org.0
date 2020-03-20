Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1E18DB00
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 23:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCTWTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 18:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbgCTWTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 18:19:33 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F273720732;
        Fri, 20 Mar 2020 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584742773;
        bh=csXHNoHEZCJcFFkQwtkt+kVeFZplv3+QRXaIVcYDwQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J+xGqQlCtBvhli5sKpaYIumlmnmPLQMuzUvK+e8vtVT4koVbA0y3k2Xhs3XOvhyjP
         z7CnJCejD4kGynSVMX8iRp15ep+5F6fRLvEq9gEey/bLfvDb8DdYpL/lVRxR5bvib6
         dM4eV4c79FU+H+e1gIhkKh7KO+hXghOT8OIuNoJU=
Date:   Fri, 20 Mar 2020 17:19:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20200320221931.GA23783@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310192627.437947-1-kherbst@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 08:26:27PM +0100, Karol Herbst wrote:
> Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
> Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.
> 
> Depending on the used kernel there might be messages like those in demsg:
> 
> "nouveau 0000:01:00.0: Refused to change power state, currently in D3"
> "nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
> space inaccessible)"
> followed by backtraces of kernel crashes or timeouts within nouveau.
> 
> It's still unkown why this issue exists, but this is a reliable workaround
> and solves a very annoying issue for user having to choose between a
> crashing kernel or higher power consumption of their Laptops.

Thanks for the bugzilla link.  The bugzilla mentions lots of mailing
list discussion.  Can you include links to some of that?

IIUC this basically just turns off PCI power management for the GPU.
Can you do that with something like the following?  I don't know
anything about DRM, so I don't know where you could save the pm_cap,
but I'm sure the driver could keep it somewhere.


diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index b65ae817eabf..2ad825e8891c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -618,6 +618,23 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	kfree(drm);
 }
 
+static void quirk_broken_nv_runpm(struct drm_device *drm_dev)
+{
+	struct pci_dev *pdev = drm_dev->pdev;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+
+	if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	switch (bridge->device) {
+	case 0x1901:
+		STASH->pm_cap = pdev->pm_cap;
+		pdev->pm_cap = 0;
+		NV_INFO(drm_dev, "Disabling PCI power management to avoid bug\n");
+		break;
+	}
+}
+
 static int nouveau_drm_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *pent)
 {
@@ -699,6 +716,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	if (ret)
 		goto fail_drm_dev_init;
 
+	quirk_broken_nv_runpm(drm_dev);
 	return 0;
 
 fail_drm_dev_init:
@@ -735,6 +753,9 @@ nouveau_drm_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	/* If we disabled PCI power management, restore it */
+	if (STASH->pm_cap)
+		pdev->pm_cap = STASH->pm_cap;
 	nouveau_drm_device_remove(dev);
 	pci_disable_device(pdev);
 }
