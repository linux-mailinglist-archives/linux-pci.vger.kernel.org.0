Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1B62B035
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKPAoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 19:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKPAob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 19:44:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190D2E688;
        Tue, 15 Nov 2022 16:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559467; x=1700095467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2NiRuwSx5FT9zdz2LSg6+qqLsUwF4AGVTUaVRQ/KA5E=;
  b=SRwm2vbV0775HtR1JBlHS1JqTamzcpZYgQpu80PbyPKLb5b4PIIQ2eED
   rcMo6Uw2FgOxzXtnX6gPAjOlVm0UPC4uC9Dpq+MzmrWlOcCuH+LWTzqGR
   X04LWGSKJqu0r6z649fRSwSxTX5/LWj01NYBh+Bt2RQ2j05yEhrz++lHC
   pRcmL1wuVmGf/gMUe1e+07zjWdHjVWveZs5Zs15wprFR9tmyn2UN+PFGi
   wOklhDiOUmcLb9oFkvRR6MoCKxLPdfVtcgOxoynD0aanvLZ3Qvsp63d1O
   CtOuZjVSPIUOqPk+/iYEZYpa9c04huIfHV5R/FwX0parfs+hbCbMHkipp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299935418"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="299935418"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968210506"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968210506"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.162.56]) ([10.209.162.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:26 -0800
Message-ID: <67109900-0292-885c-4530-5ff58ff8329b@linux.intel.com>
Date:   Tue, 15 Nov 2022 17:44:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: vmd: Clean up some inconsistent indenting
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jonathan.derrick@linux.dev, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221115054847.77829-1-jiapeng.chong@linux.alibaba.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20221115054847.77829-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/14/2022 9:48 PM, Jiapeng Chong wrote:
> No functional modification involved.
>
> drivers/pci/controller/vmd.c:983 vmd_resume() warn: inconsistent indenting.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3074
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/pci/controller/vmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 98e0746e681c..b7914637048a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -980,10 +980,10 @@ static int vmd_resume(struct device *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(pdev);
>  	int err, i;
>  
> -       if (vmd->irq_domain)
> -               vmd_set_msi_remapping(vmd, true);
> -       else
> -               vmd_set_msi_remapping(vmd, false);
> +	if (vmd->irq_domain)
> +		vmd_set_msi_remapping(vmd, true);
> +	else
> +		vmd_set_msi_remapping(vmd, false);
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		err = devm_request_irq(dev, vmd->irqs[i].virq,

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Thanks

