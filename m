Return-Path: <linux-pci+bounces-10226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C29301C7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 23:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BF2B21030
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7F45024;
	Fri, 12 Jul 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CffIxSpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D55C8EF;
	Fri, 12 Jul 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821428; cv=none; b=prAttIx8b8i/vx6RJpaqtoXYu8msDN9/fhZhgxFjFOJq1E+toVIPToRtJ/JSR2KDHNpHEvda4S4R5cmo2R6LvWgEDKBPPVBvQDu7siT+okzAIf2TrsF+DPOVOopuWUIBWG0dhtMFSOYUJjh4Re34D37dSTizj4NjkTh3sXn+AQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821428; c=relaxed/simple;
	bh=gMvjgABn2rC1WCGMa+90tACneqzV3lMM0d4FPK/OVok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=joOIxPEcClskYrH8ao09iQRw1dt/rZ6/eOAr8XYxeW657/j/zlRcHPbI0QC2YTOiBpzr9gfOLVMEuPJIVDOmkg2fIpcMWdu80E0v3bI1OxemhqceJZUnZCrzKyCCLp4+Vt/eD92NxkF64UlUW7xEA++YyFftuzBcmxvApiSe4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CffIxSpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C1C32782;
	Fri, 12 Jul 2024 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720821427;
	bh=gMvjgABn2rC1WCGMa+90tACneqzV3lMM0d4FPK/OVok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CffIxSpUWEYf+kh0psNeiWtyceFHyeneEUlzOCTe/BYhs0MionqiKEMYX8k9Ujx6y
	 /QMIcWZMy/psXetvrBOBa6rIXW2Gb/fETJD3sSeOHfkhMkYbhRYCyHrey8jLAeIyPZ
	 K+Hq4BQHXg2v/JVD96Rik3FyAvejQtiShWXPcY8AtmbKpq8daDcAIbOYiHB+21QnKx
	 j/eUfk28O9Sf64MHd6QuHSqLPJUo+xqqfrkh8M/0Whe8887uLIVGNIApGf7+TNYSkP
	 8loPrDuEEhzn/D05IHeO4L5NnwFcCE32upFi3MIHYPTO7GGP53w3pf46z6tWNlLWrW
	 tVIFd0B5MKOwQ==
Date: Fri, 12 Jul 2024 16:57:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20240712215705.GA346113@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625153150.159310-1-vidyas@nvidia.com>

On Tue, Jun 25, 2024 at 09:01:50PM +0530, Vidya Sagar wrote:
> PCIe ACS settings control the level of isolation and the possible P2P
> paths between devices. With greater isolation the kernel will create
> smaller iommu_groups and with less isolation there is more HW that
> can achieve P2P transfers. From a virtualization perspective all
> devices in the same iommu_group must be assigned to the same VM as
> they lack security isolation.
> 
> There is no way for the kernel to automatically know the correct
> ACS settings for any given system and workload. Existing command line
> options (ex:- disable_acs_redir) allow only for large scale change,
> disabling all isolation, but this is not sufficient for more complex cases.
> 
> Add a kernel command-line option 'config_acs' to directly control all the
> ACS bits for specific devices, which allows the operator to setup the
> right level of isolation to achieve the desired P2P configuration.
> The definition is future proof, when new ACS bits are added to the spec
> the open syntax can be extended.
> 
> ACS needs to be setup early in the kernel boot as the ACS settings
> effect how iommu_groups are formed. iommu_group formation is a one
> time event during initial device discovery, changing ACS bits after
> kernel boot can result in an inaccurate view of the iommu_groups
> compared to the current isolation configuration.
> 
> ACS applies to PCIe Downstream Ports and multi-function devices.
> The default ACS settings are strict and deny any direct traffic
> between two functions. This results in the smallest iommu_group the
> HW can support. Frequently these values result in slow or
> non-working P2PDMA.
> 
> ACS offers a range of security choices controlling how traffic is
> allowed to go directly between two devices. Some popular choices:
>   - Full prevention
>   - Translated requests can be direct, with various options
>   - Asymmetric direct traffic, A can reach B but not the reverse
>   - All traffic can be direct
> Along with some other less common ones for special topologies.
> 
> The intention is that this option would be used with expert knowledge
> of the HW capability and workload to achieve the desired
> configuration.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied with the tweaks below to pci/acs for v6.11, thanks!

I added an example to the doc; please check it to see if I interpreted
the doc correctly.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42d0f6fd40d0..b2057241ea6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4621,24 +4621,34 @@
 				may put more devices in an IOMMU group.
 		config_acs=
 				Format:
-				=<ACS flags>@<pci_dev>[; ...]
+				<ACS flags>@<pci_dev>[; ...]
 				Specify one or more PCI devices (in the format
 				specified above) optionally prepended with flags
 				and separated by semicolons. The respective
-				capabilities will be enabled, disabled or unchanged
-				based on what is specified in flags.
-				ACS Flags is defined as follows
-				bit-0 : ACS Source Validation
-				bit-1 : ACS Translation Blocking
-				bit-2 : ACS P2P Request Redirect
-				bit-3 : ACS P2P Completion Redirect
-				bit-4 : ACS Upstream Forwarding
-				bit-5 : ACS P2P Egress Control
-				bit-6 : ACS Direct Translated P2P
-				Each bit can be marked as
-				‘0‘ – force disabled
-				‘1’ – force enabled
-				‘x’ – unchanged.
+				capabilities will be enabled, disabled or
+				unchanged based on what is specified in
+				flags.
+
+				ACS Flags is defined as follows:
+				  bit-0 : ACS Source Validation
+				  bit-1 : ACS Translation Blocking
+				  bit-2 : ACS P2P Request Redirect
+				  bit-3 : ACS P2P Completion Redirect
+				  bit-4 : ACS Upstream Forwarding
+				  bit-5 : ACS P2P Egress Control
+				  bit-6 : ACS Direct Translated P2P
+				Each bit can be marked as:
+				  '0' – force disabled
+				  '1' – force enabled
+				  'x' – unchanged
+				For example,
+				  pci=config_acs=10x
+				would configure all devices that support
+				ACS to enable P2P Request Redirect, disable
+				Translation Blocking, and leave Source
+				Validation unchanged from whatever power-up
+				or firmware set it to.
+
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1afe650ce338..45d93101a08b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1006,7 +1006,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_info_once("PCI: Can't parse acs command line parameter\n");
+			pr_info_once("PCI: Can't parse ACS command line parameter\n");
 			break;
 		} else if (ret == 1) {
 			/* Found a match */
@@ -1026,14 +1026,14 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
-	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
+	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
+	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 
 	/* If mask is 0 then we copy the bit from the firmware setting. */
 	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
 	caps->ctrl |= flags;
 
-	pci_info(dev, "Configured ACS to 0x%x\n", caps->ctrl);
+	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
 }
 
 /**

