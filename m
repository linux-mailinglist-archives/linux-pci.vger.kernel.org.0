Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85473726B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjFTROP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjFTROO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:14:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831F1726
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687281252; x=1718817252;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=+//NSmHVnvBN8wMm3rEMDPNC5Md8W/4ifYblChDWkmY=;
  b=jOEvhsbUOfWG4O/hQd9d5n2yrZfyhx6PMIm01iS3bxCpJhWWs0heRIxE
   6DwX19glWSLuy3oxUeHFWADayW/Yvy62QKiI40qDvSCcl/zVdO4bu4jGx
   dZTSqof6H6fA8LweVWP8/4EQ6lL8OUWN/ZoboCS41VohnZrlFL9qDhRzE
   SiWwkzmXQ5/4pHjo1/hC6G/hUeBR37PcvOdpiFiT1L3PXJbfF0bahoCl9
   pyCnktf3HxpsqEEB5aqKYI3DfsuaeMgSZB+Eclx+H98JaTpm8TfXOJ1pz
   8lEtF+NHG8tQzWbv1iINs+s9nbzUePIKgTTc1PjfnSUN5/df0cl5Beyah
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344668323"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="344668323"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044370524"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="1044370524"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.163]) ([10.78.16.163])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:14:10 -0700
Message-ID: <605ab332-dade-3ce4-d73b-617d6fa2cd8b@linux.intel.com>
Date:   Tue, 20 Jun 2023 10:14:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI: vmd: Fix domain reset operation
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230530214706.75700-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/30/2023 2:47 PM, Nirmal Patel wrote:

> During domain reset process we are accidentally enabling
> the prefetchable memory by writing 0x0 to Prefetchable Memory
> Base and Prefetchable Memory Limit registers. As a result certain
> platforms failed to boot up.
>
> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>
>   The Prefetchable Memory Limit register must be programmed to a smaller
>   value than the Prefetchable Memory Base register if there is no
>   prefetchable memory on the secondary side of the bridge.
>
> When clearing Prefetchable Memory Base, Prefetchable Memory
> Limit and Prefetchable Base Upper 32 bits, the prefetchable
> memory range becomes 0x0-0x575000fffff. As a result the
> prefetchable memory is enabled accidentally.
>
> Implementing correct operation by writing a value to Prefetchable
> Base Memory larger than the value of Prefetchable Memory Limit.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..f3eb740e3028 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -526,8 +526,18 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>  				     PCI_CLASS_BRIDGE_PCI))
>  					continue;
>  
> -				memset_io(base + PCI_IO_BASE, 0,
> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +				writel(0, base + PCI_IO_BASE);
> +				writew(0xFFF0, base + PCI_MEMORY_BASE);
> +				writew(0, base + PCI_MEMORY_LIMIT);
> +
> +				writew(0xFFF1, base + PCI_PREF_MEMORY_BASE);
> +				writew(0, base + PCI_PREF_MEMORY_LIMIT);
> +
> +				writel(0xFFFFFFFF, base + PCI_PREF_BASE_UPPER32);
> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> +
> +				writel(0, base + PCI_IO_BASE_UPPER16);
> +				writeb(0, base + PCI_CAPABILITY_LIST);
>  			}
>  		}
>  	}

Gentle reminder!
Thanks.

