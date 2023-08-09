Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9048776220
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHIOMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHIOMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:12:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF11FCC;
        Wed,  9 Aug 2023 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691590359; x=1723126359;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6GS0XxoJsjgkr+UbXS+Gx5yVANo5mAltvKz8q1xkYrY=;
  b=d3nGhMzHo4NCwafGWO+WoJkOykcaMrM2rmiHmVP09InycOxT16IOYvKW
   Ppd2UuCs/LJi7eJybna0c7Hax8T09Z1uuWtxsdQ85feuJJF264YkyISAY
   7kfqZOb2HAEm+x/DQMJRvycs6NdDE0RTStO5w6dUrLKkbjGN/usH7SHt4
   E811Q0gVuQ8SJhAUW06DCacJBPWhFkcuKgnoyH6nNG4FTGD7+7qi/xOnJ
   b88jgz8zjhaJVAbACj9L2oG6JFuhGrSim6t0cicynkiY3WQOsG/It8ISK
   pqYhPtpDd8ML0mWzpral7A+wpAbJqViGNszTzIlWd3xv7PTpQnlGQgFCK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356097035"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="356097035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797203705"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="797203705"
Received: from cvogler-mobl1.ger.corp.intel.com ([10.252.40.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:12:30 -0700
Date:   Wed, 9 Aug 2023 17:12:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v2 06/11] PCI/VGA: Fix two typos in the comments of
 pci_notify()
In-Reply-To: <20230808223412.1743176-7-sui.jingfeng@linux.dev>
Message-ID: <d8fa683-bee4-2c6-612a-9fab3269c498@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-7-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2003169425-1691590352=:1846"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2003169425-1691590352=:1846
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 9 Aug 2023, Sui Jingfeng wrote:

> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> 1) s/intereted/interested
> 2) s/hotplugable/hot-pluggable
> 
> While at it, convert the comments to the conventional multi-line style,
> and rewrap to fill 78 columns.
> 
> Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/vgaarb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 6883067a802a..811510253553 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1535,9 +1535,11 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>  	if (!pci_dev_is_vga(pdev))
>  		return 0;
>  
> -	/* For now we're only intereted in devices added and removed. I didn't
> -	 * test this thing here, so someone needs to double check for the
> -	 * cases of hotplugable vga cards. */
> +	/*
> +	 * For now, we're only interested in devices added and removed.
> +	 * I didn't test this thing here, so someone needs to double check
> +	 * for the cases of hot-pluggable VGA cards.
> +	 */
>  	if (action == BUS_NOTIFY_ADD_DEVICE)
>  		notify = vga_arbiter_add_pci_device(pdev);
>  	else if (action == BUS_NOTIFY_DEL_DEVICE)

Don't use Fixes tag for comment changes. After removing it, feel free to 
add:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2003169425-1691590352=:1846--
