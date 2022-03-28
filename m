Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485264E99B0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiC1Ogb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiC1Oga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 10:36:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865514C7A2
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648478090; x=1680014090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eld+XUx3Dd7Kgp5gzFhRqjK+JX8VoTyZCnVwE/ZJw3M=;
  b=Gh7BQ1VNVBEGyQZnvcdft0MxRkcBtIFmkRvG8yqEs/hbKx4QJDHJyl7N
   x/Nc4sfU248JN7ergmRpxtq4zFE2AMac9liTUFV400FslHiS84B8OEHeP
   rHqC6ZH0Su8oF1tcqLCZyJ5DfzJ+oQvHpaAiE0+qsxiTKphI8vC9ZTkx3
   NsfaS7l3vlcf7Xj78fNOdn0p1MtBoAy6aOsGUlFRNYlFch6ZRnQDiG8XB
   nG8xlAXJgkT+SMVpdzxfn9wYWHZgN5y5oSn9qeXhMZf0YsoQOZIIqVgs/
   OZ63VF2JxM14BoHif+m6+XjSjHWQRU5C/4nwUVeWgXm+yloLWyUPCyKNJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="258979802"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258979802"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 07:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="545979918"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2022 07:34:46 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 22SEYj3i010795;
        Mon, 28 Mar 2022 15:34:45 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Date:   Mon, 28 Mar 2022 16:32:28 +0200
Message-Id: <20220328143228.1902883-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
References: <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: 이왕석 <wangseok.lee@samsung.com>
Date: Mon, 28 Mar 2022 11:30:09 +0900

> If dma_mask is more than 32 bits this will trigger an error occurs when
> dma_map_single_attrs() is performed.
> 
> dma_map_single_attrs() -> dma_map_page_attrs()->
> error return in dma_direct_map_page().
> 
> On ARTPEC-8, this fails with:
> artpec8-pcie 17200000.pcie: DMA addr 0x0000000106b052c8+2 overflow
> (mask ffffffff, bus limit 27fffffff)

Isn't it a bug in the platform DMA code? dma_set_mask(32)
explicitly says that the system *must not* give DMA addresses wider
than 32 bits. If the system can't satisfy this requirement, then it
should return failure on dma_set_mask(32) -- this way you will only
get the corresponding warning, but there'll be no overflows (as the
mask will not be changed).
The idea of this call is to try to avoid getting 33+ bit mappings
so that PCI controllers which support only 32-bit masks could still
work correctly on the 64-bit systems. If the call fails, then this
message gets printed that you've been warned and it's your
responsibility to make sure that the controller won't get truncated
addresses. Having the call succeeded and then 33+ bit DMA addresses
is wrong.

Please correct me if I'm wrong.

> 
> There is no sequence that re-sets dev->dma_mask to more than 32 bits
> before call dma_map_single_attrs().
> The dev->dma_mask is first set just prior to the dw_pcie_host_init() call.
> Therefore, the check logic was modified to be performed only when
> the dev-dma_mask is not set larger than 32 bits.
> 
> Always setting dma_mask to 32 bits is not always correct,
> for example the ARTPEC-8 is an arm64 platform, and can access
> more than 32 bits
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f3..7e25958 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -388,9 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  							    dw_chained_msi_isr,
>  							    pp);
>  
> -			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> -			if (ret)
> -				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +			if (!(*dev->dma_mask &  ~(GENMASK(31, 0)))) {
> +				ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +					if (ret)
> +						dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +			}
>  
>  			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
>  						      sizeof(pp->msi_msg),
> -- 
> 2.9.5

Thanks,
Al
