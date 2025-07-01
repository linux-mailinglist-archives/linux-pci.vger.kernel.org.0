Return-Path: <linux-pci+bounces-31197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FAAAF02BE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA04E5266
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C181DAC92;
	Tue,  1 Jul 2025 18:19:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F5283121
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393941; cv=none; b=Gpb+HR/K0Y+HQL0HVUWVB0fYzdR1f2/E/AqmWjxvZ0RsAbAzYbMR59eXpVrwNnzASTXJYWHSPsSRRpA25lzsoRslKDbJBJ4TgYz4ATupxkk7dTgnhHv2RX/cAMB7BDc0+cTOiAIVeiEGCtp1pL83xoAzTenGENIn658JEPFWNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393941; c=relaxed/simple;
	bh=px7phovNT5PQUKjV0J2k2pWUSUnsijwglUegTDNnP0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvhhrzXIUFb64+ur3VPOGCzlBTRucIy10nmGSEj97EtY+DLdzrc9aSo7H67c2i4tph1RscXHYDeWtHs7cfMn6nMf6Jw+Ap3ZaCRfuiwXeDl5P52MalcYuA0RvqREr4fJNuv7SJMTEIZpi0tlP5BhE2ORx/hu8OK36qQGjP319zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id DF1A62009180;
	Tue,  1 Jul 2025 20:18:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CAF983D5715; Tue,  1 Jul 2025 20:18:56 +0200 (CEST)
Date: Tue, 1 Jul 2025 20:18:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aGQmkIbRy4sRKD0Y@wunner.de>
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>

On Tue, Jun 24, 2025 at 11:54:46PM +0200, Ben Hutchings wrote:
> On Sat, 2025-06-21 at 16:05 +0200, Lukas Wunner wrote:
> > So please propose a more accurate explanation.
> 
> Something like "The driver iterates over all PCI devices, checking for
> an AGP capability.  Since commit 6fd024893911 ("amd64-agp: Probe unknown
> AGP devices the right way") this is done with driver_attach() and a
> wildcard PCI ID table, and the preparation for probing the IOMMU device
> produces this error message."

Thanks, I will respin and amend the commit message.


> Thinking about this further:
> 
> - Why *does* the IOMMU device have resources assigned but no driver
>   bound?  Is that the real bug?

I don't really know, I was hoping the AMD IOMMU maintainers could
comment on that.


> - If not, and there's a general problem with this promiscuous probing,
>   would it make more sense to:
>   1. Restore the search for an AGP capability in agp_amd64_init().
>   2. If and only if an AGP device is found, poke the appropriate device
>      ID into agp_amd64_pci_promisc_table and then call driver_attach().
>   ?

I like the idea.  I've realized that we've got pci_add_dynid() for
just this sort of thing.  It avoids the need to poke device IDs
into an array at runtime.  The (as yet completely untested) patch
below should do the trick.

-- >8 --

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index bf49096..9b9c473 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -720,11 +720,6 @@ static int agp_amd64_resume(struct device *dev)
 
 MODULE_DEVICE_TABLE(pci, agp_amd64_pci_table);
 
-static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
-	{ PCI_DEVICE_CLASS(0, 0) },
-	{ }
-};
-
 static DEFINE_SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, NULL, agp_amd64_resume);
 
 static struct pci_driver agp_amd64_pci_driver = {
@@ -739,7 +734,8 @@ static int agp_amd64_resume(struct device *dev)
 /* Not static due to IOMMU code calling it early. */
 int __init agp_amd64_init(void)
 {
-	int err = 0;
+	struct pci_dev *pdev = NULL;
+	int err, ret;
 
 	if (agp_off)
 		return -EINVAL;
@@ -767,8 +763,15 @@ int __init agp_amd64_init(void)
 		}
 
 		/* Look for any AGP bridge */
-		agp_amd64_pci_driver.id_table = agp_amd64_pci_promisc_table;
-		err = driver_attach(&agp_amd64_pci_driver.driver);
+		for_each_pci_dev(pdev)
+			if (pci_find_capability(pdev, PCI_CAP_ID_AGP)) {
+				ret = pci_add_dynid(&agp_amd64_pci_driver,
+						    pdev->vendor, pdev->device,
+						    pdev->subvendor,
+						    pdev->subdevice, 0, 0, 0);
+				if (ret)
+					err = ret;
+			}
 		if (err == 0 && agp_bridges_found == 0) {
 			pci_unregister_driver(&agp_amd64_pci_driver);
 			err = -ENODEV;

