Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57C36EA05C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 01:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjDTX74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjDTX7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 19:59:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0CB26BC;
        Thu, 20 Apr 2023 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682035186; x=1713571186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpEntu6l/eeVNixIK8KkWnFiYafeFGCsSXL9kU9VUOs=;
  b=Vk85LSgDcw7fa2kzGeEBkH8OqjYjxhDW+K+Gw1aSAIenr19AtlQGPY6L
   ugqL4Kn9YM4eXeKcQM7r5tWSh1HeDklTvTw1HbkSvfRRocP82nron6CHl
   BmRjM3IzMdIcHvHTdfTMSejQCYR2PMsZyExU91vQSjeSxXRl+y1tbKVvo
   +Yw0RS6oZu0ah0s4JKHHLhTSQy5PJMD1E6W/miKh4k5f6VoitQHdTamY/
   fuGizxQu8O9sQsLw82NWMEYHxnKpeJG7vViGcV9pmbAUYjbRItVFrxo9P
   R3H1RBCcd+Nr1f6ow9UDRq3rEzGTTAzXrpVRdHdlSyZe4RilZJxqTLLRC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432157881"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="432157881"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="761380847"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="761380847"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.134.178]) ([10.209.134.178])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:59:43 -0700
Message-ID: <ba9806d8-2b37-a78e-9199-c7de3cc17172@linux.intel.com>
Date:   Thu, 20 Apr 2023 16:59:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] PCI: vmd: Fix one uninitialized symbol error
 reported by Smatch
Content-Language: en-US
To:     korantwork@gmail.com, dlemoal@kernel.org, helgaas@kernel.org,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230420094332.1507900-1-korantwork@gmail.com>
 <20230420094332.1507900-2-korantwork@gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230420094332.1507900-2-korantwork@gmail.com>
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
> There is one uninitialized symbol error reported by smatch:
> "drivers/pci/controller/vmd.c:931 vmd_enable_domain()
> error: uninitialized symbol 'ret'."
>
> Fix it by assigning ret with pci_reset_bus return.
>
> Fixes: 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..1a36e9a52b93 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -927,7 +927,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		if (!list_empty(&child->devices)) {
>  			dev = list_first_entry(&child->devices,
>  					       struct pci_dev, bus_list);
> -			if (pci_reset_bus(dev))
> +			ret = pci_reset_bus(dev);
> +			if (ret)
>  				pci_warn(dev, "can't reset device: %d\n", ret);
>  
>  			break;

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

