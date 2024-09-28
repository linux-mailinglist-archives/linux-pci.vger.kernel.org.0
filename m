Return-Path: <linux-pci+bounces-13619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD650988F44
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA7F1C20C85
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CF187874;
	Sat, 28 Sep 2024 12:51:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3993157490;
	Sat, 28 Sep 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527889; cv=none; b=GqP03QSQxZHeSIfC5RqLD9PoMsdGf1ejg3OnZO2nu1MZoOhpeEjLAkR7fOoHKqy0bju6YqYzG2McEWcjunV8FtKj4fU2rpmm1j27L9aXARiB5gnVOb6TDKZS4HqhhQuMRaqz7SKWBS20gqKUFNm+veSPJEvLMFrPH97kOK6elW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527889; c=relaxed/simple;
	bh=6S+YyEr/c3fqAX5Kkcpvp25mS8aOOd74ckZaAniXTOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNkiXo+FpeGmoEEDiU3kDJ3Aob4wipZFmgUSmKCiXSOElxGq4eBrPdckoUhLzPrgsohHdtWwxlgrU7PrndxGISwLER2oMSjoSGJng8kGOgZs233TYvNOmqVhdq31Y/BWaQ3Z2W5zXufKTGzZ57QfQ+TGA1Osq6bKp+A1lzya4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4B3F5300002D0;
	Sat, 28 Sep 2024 14:51:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 448663972FA; Sat, 28 Sep 2024 14:51:17 +0200 (CEST)
Date: Sat, 28 Sep 2024 14:51:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <Zvf7xYEA32VgLRJ6@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvZ61srt3QAca2AI@wunner.de>

On Fri, Sep 27, 2024 at 11:28:54AM +0200, Lukas Wunner wrote:
> I realize now that commit 9d573d19547b ("PCI: pciehp: Detect device
> replacement during system sleep") is a little overzealous because it
> not only reacts to *replaced* devices but also to *unplugged* devices:
> If the device was unplugged, reading the vendor and device ID returns
> 0xffff, which is different from the cached value, so the device is
> assumed to have been replaced even though it's actually been unplugged.
> 
> The device replacement check runs in the ->resume_noirq phase.  Later on
> in the ->resume phase, pciehp_resume() calls pciehp_check_presence() to
> check for unplugged devices.  Commit 9d573d19547b inadvertantly reacts
> before pciehp_check_presence() gets a chance to react.  So that's something
> that we should probably change.

FWIW, below is a (compile-tested only) patch which modifies
pciehp_device_replaced() to return false if the device was
*unplugged* during system sleep.  It continues to return
true if it was *replaced* during system sleep.

This might avoid the issue you're seeing, though it would
be good if you could also try Keith's deadlock prevention
patch (without any other patch) to determine if the deadlock
is the actual root cause (as I suspect).

Thanks!

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e6..174832b 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev)
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
 	struct pci_dev *pdev __free(pci_dev_put);
+	u64 dsn;
 	u32 reg;
 
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
+		return false;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
+	    reg != (pdev->vendor | (pdev->device << 16)))
 		return true;
 
-	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
-	    reg != (pdev->vendor | (pdev->device << 16)) ||
-	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
 	    reg != (pdev->revision | (pdev->class << 8)))
 		return true;
 
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+	    pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
+	    reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16)))
 		return true;
 
-	if (pci_get_dsn(pdev) != ctrl->dsn)
+	dsn = pci_get_dsn(pdev);
+	if (!PCI_POSSIBLE_ERROR(dsn) &&
+	    dsn != ctrl->dsn)
 		return true;
 
 	return false;

