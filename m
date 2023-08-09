Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1177623A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHIOSs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjHIOSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:18:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28591FD8;
        Wed,  9 Aug 2023 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691590724; x=1723126724;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=egJcWHJBDvwzfC17N46JLtCEDljGhvGBo354SWU8O+0=;
  b=fdnkb2IVIyYuDRbvd9qOPTif48wSJkxKQKq227scPXsdPoFHeUyM8dyX
   mct6YbvdpMgAtMQgD2QjyaRh0BGIHNuG4i3mSiX25QtliTKS2jY0RReS4
   Ll49t0wyApV8cYbGdsreZaa92Kk5x8i4ahTr86o/nQY35DSyW5YhxDSzN
   HaandpKynWKXsAiK/O3kD7h8dedLzt6qys5BI0XfbJhjwSj3p25ht4Gxo
   4tgazMZulcZ4lnNVAVMsNzqDcwEJC2WNEZBYPIJTKMTYfI/yNRV/YHOyY
   6Qc9r5k5FeqCtrcrjZQMWgz1N4sTqvQAGRuw1r8WMpNRyEiHe5xIFoyrm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370035453"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="370035453"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062494286"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1062494286"
Received: from cvogler-mobl1.ger.corp.intel.com ([10.252.40.229])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:18:41 -0700
Date:   Wed, 9 Aug 2023 17:18:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 10/11] PCI/VGA: Tidy up the code and comment format
In-Reply-To: <20230808223412.1743176-11-sui.jingfeng@linux.dev>
Message-ID: <6617a813-d840-3c39-5c4a-7288fd2f7295@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-11-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1484049110-1691590724=:1846"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1484049110-1691590724=:1846
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 9 Aug 2023, Sui Jingfeng wrote:

> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> This patch replaces the leading space with a tab and removes the double
> blank line and fix various typos, no functional change.
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/vgaarb.c   | 90 ++++++++++++++++++++++++------------------
>  include/linux/vgaarb.h |  4 +-
>  2 files changed, 53 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 9f5cf6a6e3a2..a2f6e0e6b634 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -30,14 +30,13 @@
>  #include <linux/vt.h>
>  #include <linux/console.h>
>  #include <linux/acpi.h>
> -
>  #include <linux/uaccess.h>
> -
>  #include <linux/vgaarb.h>
>  
>  static void vga_arbiter_notify_clients(void);
> +
>  /*
> - * We keep a list of all vga devices in the system to speed
> + * We keep a list of all VGA devices in the system to speed
>   * up the various operations of the arbiter
>   */
>  struct vga_device {
> @@ -61,7 +60,6 @@ static bool vga_arbiter_used;
>  static DEFINE_SPINLOCK(vga_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
>  
> -
>  static const char *vga_iostate_to_str(unsigned int iostate)
>  {
>  	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> @@ -195,14 +193,16 @@ int vga_remove_vgacon(struct pci_dev *pdev)
>  #endif
>  EXPORT_SYMBOL(vga_remove_vgacon);
>  
> -/* If we don't ever use VGA arb we should avoid
> -   turning off anything anywhere due to old X servers getting
> -   confused about the boot device not being VGA */
> +/*
> + * If we don't ever use vgaarb, we should avoid turning off anything anywhere.
> + * Due to old X servers getting confused about the boot device not being VGA.
> + */
>  static void vga_check_first_use(void)
>  {
> -	/* we should inform all GPUs in the system that
> -	 * VGA arb has occurred and to try and disable resources
> -	 * if they can */
> +	/*
> +	 * We should inform all GPUs in the system that
> +	 * vgaarb has occurred and to try and disable resources if they can
> +	 */
>  	if (!vga_arbiter_used) {
>  		vga_arbiter_used = true;
>  		vga_arbiter_notify_clients();
> @@ -218,7 +218,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	unsigned int pci_bits;
>  	u32 flags = 0;
>  
> -	/* Account for "normal" resources to lock. If we decode the legacy,
> +	/*
> +	 * Account for "normal" resources to lock. If we decode the legacy,
>  	 * counterpart, we need to request it as well
>  	 */
>  	if ((rsrc & VGA_RSRC_NORMAL_IO) &&
> @@ -238,7 +239,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  	if (wants == 0)
>  		goto lock_them;
>  
> -	/* We don't need to request a legacy resource, we just enable
> +	/*
> +	 * We don't need to request a legacy resource, we just enable
>  	 * appropriate decoding and go
>  	 */
>  	legacy_wants = wants & VGA_RSRC_LEGACY_MASK;
> @@ -254,7 +256,8 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
>  		if (vgadev == conflict)
>  			continue;
>  
> -		/* We have a possible conflict. before we go further, we must
> +		/*
> +		 * We have a possible conflict. before we go further, we must

Before

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1484049110-1691590724=:1846--
