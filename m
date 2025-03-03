Return-Path: <linux-pci+bounces-22784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC0A4CC57
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B213A70D3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011982010F6;
	Mon,  3 Mar 2025 20:00:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059D3BBD8;
	Mon,  3 Mar 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032039; cv=none; b=iMEYImQmWOl8r0uhG67Yqk4LjjZzCkKn/e3rQ/nJqi7mfoVmHmn+38lwpeM3pwgnq17M9DhoHfWPMrN9MlmgSJ6bU9TT2K3DQ4X2f97KG7ihX83erOOcSlT47/fgunZ6QBw0jDrCn/yd+O5zGy9zXcWXDARM64RRXELITl72lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032039; c=relaxed/simple;
	bh=fuKfx+52mOKNtlZjc5ULPHxnRDn1ChhMsm0q83VOu28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTx1YnzX673k7x0VcIi0GlK1d5jKju+O+iOcccJYOT3CJEi1VgGdXvFOAqlkhdGgsKM/V9JTV0pC8qsNGELA8rfj5KBvLkyz11wSzmyLKS/VYMsVvyAhyTwA+6oyO5BpGOc360qGe7Wt/atd12rKiAzkUHAnzJFiO1MyJjeWz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8016230015867;
	Mon,  3 Mar 2025 21:00:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6792D4A3B; Mon,  3 Mar 2025 21:00:28 +0100 (CET)
Date: Mon, 3 Mar 2025 21:00:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <Z8YKXC1IXYXctQrZ@wunner.de>
References: <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226091958.GN3713119@black.fi.intel.com>

On Wed, Feb 26, 2025 at 11:19:58AM +0200, Mika Westerberg wrote:
> On Wed, Feb 26, 2025 at 10:10:43AM +0100, Lukas Wunner wrote:
> > On Wed, Feb 26, 2025 at 10:44:04AM +0200, Mika Westerberg wrote:
> > >   [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
> > [...]
> > > I added "no_console_suspend" to the command line and the did sysrq-w to
> > > get list of blocked tasks. I've attached it just in case it is needed.
> > 
> > This looks like the deadlock we've had for years when hot-removing
> > nested hotplug ports.
> > 
> > If you attach only a single device to the host, I guess the issue
> > does not occur, right?
> 
> Yes.
> 
> > Previous attempts to fix this:
> > 
> > https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> > 
> > https://lore.kernel.org/all/20240612181625.3604512-1-kbusch@meta.com/
> 
> Well, it does not happen if I revert the commit so isn't that a
> regresssion?

Does the below fix the issue?

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e6..b0b4d46 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -287,24 +287,26 @@ static int pciehp_suspend(struct pcie_device *dev)
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
 	struct pci_dev *pdev __free(pci_dev_put);
+	u64 dsn;
 	u32 reg;
 
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
-		return true;
+		return false;
 
-	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
-	    reg != (pdev->vendor | (pdev->device << 16)) ||
-	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
-	    reg != (pdev->revision | (pdev->class << 8)))
+	if ((pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) == 0 &&
+	     reg != (pdev->vendor | (pdev->device << 16))) ||
+	    (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) == 0 &&
+	     reg != (pdev->revision | (pdev->class << 8))))
 		return true;
 
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+	    pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) == 0 &&
+	    reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16)))
 		return true;
 
-	if (pci_get_dsn(pdev) != ctrl->dsn)
+	dsn = pci_get_dsn(pdev);
+	if ((dsn || ctrl->dsn) && dsn != ctrl->dsn)
 		return true;
 
 	return false;

