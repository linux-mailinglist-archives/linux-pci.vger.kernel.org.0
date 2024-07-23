Return-Path: <linux-pci+bounces-10658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EE93A282
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C981C22BD7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B92154BFC;
	Tue, 23 Jul 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFysC4+A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2BE154BE8;
	Tue, 23 Jul 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744260; cv=none; b=Wnsg9qbIdmcCMbPXonPupb+GO0wtwt9DQvZnvmPjd1lJq8iHuVrkZ8flDwSAQCN4vWuO0HEk/j/FUe+U4tCco12ENU04TJesM044yug54Nd3slCupqsPqNjEElM/7Mk06y0GXH1OZy8POjTi64k6mUVglIewm/3LOZvO8JJD7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744260; c=relaxed/simple;
	bh=BNRpzun9rkE0eh56ElQCopvHM5RntwbE6IrO8VcsIKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPzVJuVQ26o9cLUDqFFHfw5KnZtqpHPFRTcL9dXA9AfjxxZIaNroS4k6EDRcbdN8wQyZue6r3KKn4iZdwdbtKo2Gogh/qAiwHXfyVhA/iaEIM84NqnSrXVydmX/VKomMkGI89GoyP/GyYFIxJFDRe2T1PXrCv8bGQ3JNbkokTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFysC4+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A1C4AF09;
	Tue, 23 Jul 2024 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744259;
	bh=BNRpzun9rkE0eh56ElQCopvHM5RntwbE6IrO8VcsIKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFysC4+AWVuC34Rk319E1zxE1piH/q43OkJKXIIrzGcxMAvjKTeHJjUJOHnZcwfPI
	 ZCc8ypQBOqoS9kraZKIeYSwaB6IKR9jdUJE7nrvdWDvVrsxlezx9FFQg5EBW+pznzC
	 fuPviFhqFQw4/80qtFuiXseBWbw7nD4EsI8zlRWuxYWWNgU99rR7XKtYgNItSZ6E+s
	 SVPOUkQnyXpE2y1F9Tm8ySyrpP8LECfDHbeocGgLshnrDYlRq4GHeDMR1QgZW2v/zh
	 KnDwh8F/lrbeObMUBCnGDA89vEk7BaPUuBuN+/7ZhlCeTTLPPumXXcYYJGSakmmW+s
	 FeMJc9ydZ2R1w==
Date: Tue, 23 Jul 2024 16:17:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719115741.3694893-2-rick.wertenbroek@gmail.com>

On Fri, Jul 19, 2024 at 01:57:38PM +0200, Rick Wertenbroek wrote:
> The current mechanism for BARs is as follows: The endpoint function
> allocates memory with 'pci_epf_alloc_space' which calls
> 'dma_alloc_coherent' to allocate memory for the BAR and fills a
> 'pci_epf_bar' structure with the physical address, virtual address,
> size, BAR number and flags. This 'pci_epf_bar' structure is passed
> to the endpoint controller driver through 'set_bar'. The endpoint
> controller driver configures the actual endpoint to reroute PCI
> read/write TLPs to the BAR memory space allocated.
> 
> The problem with this is that not all PCI endpoint controllers can
> be configured to reroute read/write TLPs to their BAR to a given
> address in memory space. Some PCI endpoint controllers e.g., FPGA
> IPs for Intel/Altera and AMD/Xilinx PCI endpoints. These controllers
> come with pre-assigned memory for the BARs (e.g., in FPGA BRAM),
> because of this the endpoint controller driver has no way to tell
> these controllers to reroute the read/write TLPs to the memory
> allocated by 'pci_epf_alloc_space' and no way to get access to the
> memory pre-assigned to the BARs through the current API.

Looking at your series, it seems that you skip not only setting up the
PCI address to internal address translation, you also skip the whole
call to set_bar(). set_bar() takes a 'pci_epf_bar' struct, and configures
the hardware accordingly, that means setting the flags for the BARs,
configuring it as 32 or 64-bit etc.

I think you should still call set_bar(). Your PCIe EPC .set_bar() callback
can then detect that the type is fixed address, and skip setting up the
internal address translation. (Although I can imagine someone in the
future might need a fixed internal address for the BAR, but they still
need to setup internal address translation.)

Maybe something like this:
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 85bdf2adb760..50ad728b3b3e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -151,18 +151,22 @@ struct pci_epc {
 /**
  * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
  * @BAR_FIXED: The BAR mask is fixed by the hardware.
+ * @BAR_FIXED_ADDR: The BAR mask and physical address is fixed by the hardware.
  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
  */
 enum pci_epc_bar_type {
        BAR_PROGRAMMABLE = 0,
        BAR_FIXED,
+       BAR_FIXED_ADDR,
        BAR_RESERVED,
 };
 
 /**
  * struct pci_epc_bar_desc - hardware description for a BAR
  * @type: the type of the BAR
- * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_MASK.
+ * @fixed_size: the fixed size, only applicable if type is BAR_FIXED or
+ *             BAR_FIXED_ADDRESS.
+ * @fixed_addr: the fixed address, only applicable if type is BAR_FIXED_ADDRESS.
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *             should be configured as 32-bit or 64-bit, the EPF driver must
  *             configure this BAR as 64-bit. Additionally, the BAR succeeding


I know you are using a FPGA, but for e.g. DWC, you would simply
ignore:
https://github.com/torvalds/linux/blob/master/drivers/pci/controller/dwc/pcie-designware-ep.c#L232-L234


Perhaps we even want the EPF drivers to keep calling pci_epf_alloc_space(),
by doing something like:

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 323f2a60ab16..35f7a9b68006 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -273,7 +273,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
        if (size < 128)
                size = 128;
 
-       if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+       if ((epc_features->bar[bar].type == BAR_FIXED ||
+            epc_features->bar[bar].type == BAR_FIXED_ADDR)
+           && bar_fixed_size) {
                if (size > bar_fixed_size) {
                        dev_err(&epf->dev,
                                "requested BAR size is larger than fixed size\n");
@@ -296,10 +298,15 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
        }
 
        dev = epc->dev.parent;
-       space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
-       if (!space) {
-               dev_err(dev, "failed to allocate mem space\n");
-               return NULL;
+       if (epc_features->bar[bar].type == BAR_FIXED_ADDR) {
+               request_mem_region(...);
+               ioremap(...);
+       } else {
+               space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+               if (!space) {
+                       dev_err(dev, "failed to allocate mem space\n");
+                       return NULL;
+               }
        }
 
        epf_bar[bar].phys_addr = phys_addr;



I could also see some logic in the request_mem_region() and ioremap() call
being in the EPC driver's set_bar() callback.

But like you suggested in the other mail, the right thing is to merge
alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
instead.)


Kind regards,
Niklas

