Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB07761D1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHINzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjHINzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 09:55:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A72109;
        Wed,  9 Aug 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691589339; x=1723125339;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gJzCp6ekx7CCevIM8uCATPGn/y4r8KOXNfeq4gNJ+QM=;
  b=Qg0+2Nep+LaeHsWEXoTUyECVQGp/Eyy1eQLr7qzNRBwX4iRVUngxLudL
   ICBnlAlAVPMuXrp0aBxFR8JAntGf5xxTJ9rZObs5ogZyl5hj/qNVZt+CR
   90/H6M781soOAnKJHO4aindbjK1W6qm2daOEovl75Dhx48AB+9Lp739QB
   0x4HFsFVLiROi3ieB3fqMqN/lnVP0w2J6LCGqHCNF5THGxyz6sEiRz3N0
   Low51pM6/sFwSJSBFEEkNgnCsv3CmTfwC8hE2bzvxOACmoFu2rrIbzHoG
   x6imQVQingK30rZRBcy1NQPa330R16r+EfZ7Oj1BfPoGz7u8FCiNnsTCQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370029111"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="370029111"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 06:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845966693"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="845966693"
Received: from cvogler-mobl1.ger.corp.intel.com ([10.252.40.229])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 06:55:23 -0700
Date:   Wed, 9 Aug 2023 16:55:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v2 05/11] PCI/VGA: Move the new_state assignment out of
 the loop
In-Reply-To: <20230808223412.1743176-6-sui.jingfeng@linux.dev>
Message-ID: <ce60a772-4a6d-e31d-a195-c6a7e36ff26@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-6-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Aug 2023, Sui Jingfeng wrote:

> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> In the vga_arbiter_notify_clients() function, the value of the 'new_state'
> variable will be 'false' on systems that have more than one VGA device.
> The value will be 'true' if there is only one VGA device or no VGA device
> at all. Hence, its value is not relevant to the iteration of the loop.
> 
> So move the assignment clause out of the loop. For a system with multiple
> video cards, this patch saves unnecessary assignment.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/vgaarb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index dc10a262fb5e..6883067a802a 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1468,22 +1468,20 @@ static void vga_arbiter_notify_clients(void)
>  {
>  	struct vga_device *vgadev;
>  	unsigned long flags;
> -	uint32_t new_decodes;
> -	bool new_state;
> +	bool state;
>  
>  	if (!vga_arbiter_used)
>  		return;
>  
> +	state = (vga_count > 1) ? false : true;
> +

Is it safe to move this outside of the lock?

This would be enough (no need for ?: construct):

state = vga_count <= 1;

Or if you want to keep it as > 1:

state = !(vga_count > 1);

>  	spin_lock_irqsave(&vga_lock, flags);
>  	list_for_each_entry(vgadev, &vga_list, list) {
> -		if (vga_count > 1)
> -			new_state = false;
> -		else
> -			new_state = true;
>  		if (vgadev->set_decode) {
> -			new_decodes = vgadev->set_decode(vgadev->pdev,
> -							 new_state);
> -			vga_update_device_decodes(vgadev, new_decodes);
> +			unsigned int decodes;
> +
> +			decodes = vgadev->set_decode(vgadev->pdev, state);
> +			vga_update_device_decodes(vgadev, decodes);
>  		}
>  	}
>  	spin_unlock_irqrestore(&vga_lock, flags);
> 


-- 
 i.


