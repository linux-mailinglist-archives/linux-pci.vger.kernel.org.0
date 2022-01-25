Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18CF49B6FF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiAYOzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 09:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385259AbiAYOxn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 09:53:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BFC06175E
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 06:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E54961652
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 14:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CC2C340E0;
        Tue, 25 Jan 2022 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643122421;
        bh=MG6PPK4J4Z0W/4hEFH1gf9zUWf6kWhi+Ti4lsbcUgYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJV665taiWugFCikAtarnLCoyaNueGtPFX9KS3iefcctdjXZnNlELlLxgwtsPFBoJ
         nyP8IC8XbJbWQiyU1jun6ZUg+gOXCRNCNHjy6e9H+u8+s0dSpIGCUn1oxnks1tW3U7
         xu9UyXJTOM82Ta9BSwJ7drm8pdO3GQw5/9qHvqYYdkDHphmVsgAcXeVuvnW/Zbc0lf
         +zy0fWoe6JDgdOvr7E5yyKY8KWzGasbUoZndpS7dKCbrhWdO4Ht6J2Htsndx2oO/RA
         /fIGmYlF8BFXNfmy/mgU1y4mTcS7XtuNqRt50XELIaXczFtkhg7cYJFSrer8TmUZf5
         ifkJTIm+Kd5VQ==
Received: by pali.im (Postfix)
        id 5F18A12F7; Tue, 25 Jan 2022 15:53:39 +0100 (CET)
Date:   Tue, 25 Jan 2022 15:53:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v4 3/3] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220125145339.2p7e4pz5lqd7k7go@pali>
References: <20220125071820.2247260-1-sr@denx.de>
 <20220125071820.2247260-4-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125071820.2247260-4-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 25 January 2022 08:18:20 Stefan Roese wrote:
> With this change, AER is now enabled on all PCIe devices, also when the
> PCIe device is hot-plugged.
> 
> Please note that this change is quite invasive, as with this patch
> applied, AER now will be enabled in the Device Control registers of all
> available PCIe Endpoints, which currently is not the case.
> 
> When "pci=noaer" is selected, AER stays disabled of course.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> v4:
> - No change
> 
> v3:
> - New patch, replacing the "old" 2/2 patch
>   Now enabling of AER for each PCIe device is done in pci_aer_init(),
>   which also makes sure that AER is enabled in each PCIe device even when
>   it's hot-plugged.
> 
>  drivers/pci/pcie/aer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 5585fefc4d0e..10b2f7db8adb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -388,6 +388,10 @@ void pci_aer_init(struct pci_dev *dev)
>  
>  	pci_aer_clear_status(dev);
>  
> +	/* Enable AER if requested */
> +	if (pci_aer_available())
> +		pci_enable_pcie_error_reporting(dev);
> +
>  	/* Enable ECRC checking if enabled and configured */
>  	pcie_set_ecrc_checking(dev);
>  }
> -- 
> 2.35.0
> 
