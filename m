Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF67D4AFEC1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiBIU4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 15:56:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBIU4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 15:56:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160AC043181
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644440198; x=1675976198;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=vGBofuGFicTj0fkBkEFjB45gdOlL5LlyuD4bSZRrJNY=;
  b=H7AqzkoyaxeTHZ2RjnCH1zSMIPSse1OEXJVvhrR8HEq0h9mlIv1tHw3O
   LIZXv2HjLgjkHMhh4CSHSdNuqKHgWjk3D5ROLdEB4ATDQvmIS7MHqxsfe
   S29W/cVD6wxyKiotQ0iJ3TOuHKX4TBb7neuhTXFe0R2EIVNo91l8g7OlK
   xGDsW2FeHoOHcXrRxUqnSbafw4OFMONjUyyFSIiwattySartAzgDtm1SO
   GHfFPGefInqYrDM6F6YmLDZxhRD6X8tR3Azp3D6FxGaPNLbotKEPxLc+n
   glvysZzVScZrK3SnPIHkAAgiX01qN+rexRAUdsuinK16XmzhuVCmGrzpf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248165273"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="248165273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 12:56:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="541294224"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.232.194]) ([10.212.232.194])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 12:56:34 -0800
Message-ID: <6def8bea-d6ae-90ec-0804-11812d1ae8eb@linux.intel.com>
Date:   Wed, 9 Feb 2022 13:56:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] PCI: vmd: Check EIME mode before MSI remapping
Content-Language: en-US
To:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220204084036.5017-1-nirmal.patel@linux.intel.com>
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220204084036.5017-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/4/2022 1:40 AM, Nirmal Patel wrote:
> We are observing DMAR errors from vt-d when vmd is enabled along with
> interrupt remapping and extended interrupt mode. As a result the host
> machine is not able boot successfully.
>
> DMAR: DRHD: handling fault status reg 2
> DMAR: [INTR-REMAP] Request device [0xc9:0x05.0] fault index 0xa00
> [fault reason 0x25] Blocked a compatibility format interrupt request
>
> The issue was observed in intel Whitley platform and newer with ICE
> Lake processor with latest kernel. The issued was also reproduced in
> 5.10 by backporting patches related to commit ee81ee84f873 ("PCI: vmd:
> Disable MSI-X remapping when possible")
>
> According to Intel VT-d specs section "5.1.4 Interrupt-Remapping
> Hardware Operation", If Extended Interrupt Mode is enabled (EIME), or
> if the Compatibility format interrupts are disabled (CFIS), the
> Compatibility format interrupts are blocked.
>
> Do not disable MSI remapping if interrupt remapping enabled and
> x2apic_opt_out mode is disabled.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..4eb38c6bd578 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <asm/apic.h>
>  
>  #include <asm/irqdomain.h>
>  
> @@ -814,7 +815,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
>  	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	    x2apic_enabled() || !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>  	    offset[0] || offset[1]) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)

Hello,

Gentle ping. Please let me know if there is a suggestion.

Thanks.

