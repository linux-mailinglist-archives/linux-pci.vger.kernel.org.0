Return-Path: <linux-pci+bounces-28258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A044AC05BF
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C298F16664D
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE222155F;
	Thu, 22 May 2025 07:31:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1B4A3C;
	Thu, 22 May 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899086; cv=none; b=WQiU+ao8k/4Moh/zDZOfYSmTCiVWherG456hB6sRluTife+VtIlT50a/nCCv20Exe4yhNSTADciJxcyiuxKAZPHfMpTNXejCJg4Otgrg0h2QrlQ2TSJ9EDWqimu3PtMZjoGLLNz9zLm60zrP5UABvOWrNzHv/Aj11snViCEhmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899086; c=relaxed/simple;
	bh=NFZt1VhNtWX7jDY9C5p1Hu6OXloY8TUL9Rgfibs2nzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6/HFQAO0q58HVEb0ZIdj684tzxaQwSQ44Lt2vxLJZpxFjtKT/LgUfHFOCxmEjW7pNlgV+8WmKo7KJPQl00tV7LKp3H47E7L4KojVpnTFWmyDD24Aur0OQyCxLfNkPvQeiWQP5VxGl4IJCGmbv3Iwk1boAW3Ih0bMuIExBUl4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6B0272C000B4;
	Thu, 22 May 2025 09:31:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 406E010652; Thu, 22 May 2025 09:31:16 +0200 (CEST)
Date: Thu, 22 May 2025 09:31:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	aravind.iddamsetty@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aC7SxEzfRwmL2eBH@wunner.de>
References: <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <aC3XiuOPVYB2EX18@wunner.de>
 <6bddf9bb-0c57-4823-bef1-e5bdf16ef5f7@kernel.org>
 <442887ac-d53c-4a89-8916-e7c8b1f2e6a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442887ac-d53c-4a89-8916-e7c8b1f2e6a8@gmail.com>

[cc += Mika, Mathias]

On Tue, May 20, 2025 at 07:22:04PM +0200, Denis Benato wrote:
> This is the very same exact kernel, minus the patch in question:
> https://pastebin.com/rwMYgG7C

I note that your machine uses an Intel Maple Ridge 2C Thunderbolt
controller.  It looks like we're missing that one in the list of
XHCI devices which are allowed to runtime suspend.  Only the 4C
variant of that controller was allowed to runtime suspend by commit
5a8e3229ac27 ("xhci-pci: Allow host runtime PM as default for Intel
Maple Ridge xHCI").

Commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on
all xHC 1.2 or later devices") has since obviated the need to
continuously amend the list of controllers, but it's unclear to me
whether it encompasses Maple Ridge 2C or not.  Chances are it doesn't
because the 4C variant was kept in the whitelist.

What do you get if you run:

cat /sys/bus/pci/devices/0000:38:00.0/power/runtime_enabled
cat /sys/bus/pci/devices/0000:38:00.0/power/runtime_status

Below is a small patch to add the 2C variant to the whitelist.
Does it help in any way?  What's the output for the two commands
above if you apply the patch?

Upthread it was said that it's a problem if the Root Port stays in D0.
Of course if the XHCI doesn't runtime suspend, that will keep the
Root Port in D0 as well.  The patch may eliminate one reason for the
Root Port to stay in D0.

The PCI IDs database was also missing the IDs of the 2C variant,
I just went ahead and fixed that.

Thanks,

Lukas

-- >8 --

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 0c481cb..5233d59 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -61,7 +61,8 @@
 #define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
 
 /* Thunderbolt */
-#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
+#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_2C_XHCI		0x1135
+#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_4C_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI	0x15b6
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI	0x15c1
@@ -387,7 +388,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_2C_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_4C_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&

