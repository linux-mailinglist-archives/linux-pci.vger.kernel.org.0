Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8A6EA05A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDTX7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 19:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDTX7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 19:59:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9B8213F;
        Thu, 20 Apr 2023 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682035173; x=1713571173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D5Q3PsaoE8g+KMSRqsTaJQq6kSrNTQl0R37BiRKDz88=;
  b=J60OHQzK22dNuQzVelQwpLRMpO518jib1g5vlXjYNGcpWWS2TSBECzOY
   +Vm6kHsW0a15AJG1lRkbgyggO16MJ/+HUk08jUbPeTh9Mg3EzAVNSYB69
   Qk5yW/qoXQWAIH9C7LPk/RSOZAdE7A4Xt/A1gkNr1rbfvsPlssWZ1/jmj
   aRHeJg6XAt1MSGIcoDsLzYsIvLjGQqgljjUm6XTjSNcB3W5/7dnujnwlQ
   0rik6NhJWI4pD2blJjoaMD0G9LxEH62aYD6WYhV5I51IITQpa5mHhmDG2
   pGfw9SRyXFJ7BCURd9Wf/BUWLfJ3A+kpLoWedGT4taAw1g1rRuXMYXa5b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432157835"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="432157835"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="761380841"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="761380841"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.134.178]) ([10.209.134.178])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:59:32 -0700
Message-ID: <a134567a-afa2-e7fb-fab9-d44107614e1f@linux.intel.com>
Date:   Thu, 20 Apr 2023 16:59:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] PCI: vmd: Clean up one inconsistent indenting warn
 reported by Smatch
Content-Language: en-US
To:     korantwork@gmail.com, dlemoal@kernel.org, helgaas@kernel.org,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230420094332.1507900-1-korantwork@gmail.com>
 <20230420094332.1507900-3-korantwork@gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230420094332.1507900-3-korantwork@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/20/2023 2:43 AM, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
>
> There is one inconsistent indenting warning:
> "drivers/pci/controller/vmd.c:1058 vmd_resume()
> warn: inconsistent indenting"
>
> Fix it by formating its indenting.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 1a36e9a52b93..1b68fa606bff 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1056,10 +1056,10 @@ static int vmd_resume(struct device *dev)
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

