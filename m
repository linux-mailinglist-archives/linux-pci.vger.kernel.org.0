Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44E776226
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjHIOON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjHIOOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:14:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD81FD8;
        Wed,  9 Aug 2023 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691590452; x=1723126452;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dIu/KtDIfb3bVpk0hNJeVwvKE20Hkkj0wBoXJehkF5w=;
  b=KqHBaQHSy86fF+61YgC8XvCIVo5BBm47qLFcDDbeW0qclQsB9vi/9fbd
   PKViHgCXmRWWgx4kVMz/ULD5Rt892aHEDBDugYS23aklZru0dM+mbgqFe
   0DHj8p+FnA9nU5RVrTBtwH+qtwK4vNaPo+HRADJ7LSSHEFr3LTh3dNhGS
   KcIzg+H8LpUPb0glhvibHB43AA3YLFdwKN6EKWuBsQRGuTsEQ5SATyOPs
   87ueGovqmKpQQWI+zxYxnJOnA2++BVHZV5Xgwx3gMTPw3eeRogaTiBmyL
   pwP9hT5uN3OYvFm4UetCnhFOu2kpmfwDOTU0QQXMPtOEEZ4x5xfvkqL/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370034221"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="370034221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="845970689"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="845970689"
Received: from cvogler-mobl1.ger.corp.intel.com ([10.252.40.229])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:14:09 -0700
Date:   Wed, 9 Aug 2023 17:14:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v2 08/11] PCI/VGA: Fix a typo to the comment of
 vga_default
In-Reply-To: <20230808223412.1743176-9-sui.jingfeng@linux.dev>
Message-ID: <c1972961-1cd-392c-b3bc-ea98beb0f9e9@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-9-sui.jingfeng@linux.dev>
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

Please add changelog text.

> Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/vgaarb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index a6b8c0def35d..d80d92e8012b 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -99,7 +99,7 @@ static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
>  	return 1;
>  }
>  
> -/* this is only used a cookie - it should not be dereferenced */
> +/* This is only used as a cookie, it should not be dereferenced */
>  static struct pci_dev *vga_default;
>  
>  /* Find somebody in our list */

Again, no Fixes tag for comment corrections.

-- 
 i.

