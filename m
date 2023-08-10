Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9707777EE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHJMN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHJMN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:13:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7653CE;
        Thu, 10 Aug 2023 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691669635; x=1723205635;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M9K6xJx8RUvgRqMgb5Yj3IJ3eVGvba8EcAYj4FU72So=;
  b=aJzPIoqp8aM45SuuN2nfIVw7yLJ1UV/mBdNN9qUipeCHHGbwDj9zONQy
   lgQYL5dljzCyDxY+wdpXhxlOQoJs5yJHaTivmM7FquVFQE/sMQDPoh4Xb
   +siO9003DtaBr6QQ/zHOfQkye8jVM3r66yfd5uxIYjZNN+m0/KL+OMiDo
   2Ei9B+yUw9VSnmD6wCh4hde/kxIAKIoIpyEQ+b8EehlaHG00cBbX80OY+
   rYB75wc4uULdYURW0TKrCAKU33cA9XoSH9zFCxkTOhszRTixb7IYqnRK5
   +tEnYYy950GTpqHfKm5htIgD1QKj7x0meeX2XdXqUJ9xroU3H2TivF/+N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356348128"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="356348128"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="735401276"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="735401276"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:13:52 -0700
Date:   Thu, 10 Aug 2023 15:13:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     suijingfeng <suijingfeng@loongson.cn>
cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] PCI/VGA: vga_client_register() return -ENODEV
 on failure, not -1
In-Reply-To: <bfe424f2-6dad-c8c9-ec82-8eda70f23cdf@loongson.cn>
Message-ID: <1f288175-a290-6f19-d562-cf98f613323c@linux.intel.com>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev> <20230808223412.1743176-8-sui.jingfeng@linux.dev> <b1a964e-a94b-2316-eeaf-fec2b2fa833b@linux.intel.com> <bfe424f2-6dad-c8c9-ec82-8eda70f23cdf@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1008233500-1691669634=:1816"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1008233500-1691669634=:1816
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 10 Aug 2023, suijingfeng wrote:
> On 2023/8/9 21:52, Ilpo Järvinen wrote:
> > On Wed, 9 Aug 2023, Sui Jingfeng wrote:
> > 
> > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > 
> > Changelog body is missing.
> 
> 
> I thought that probably the Fixes tag could be taken as the body of this
> commit,
> since there are no warnings when I check the whole series with checkpatch.pl.
> 
> 
> > > Fixes: 934f992c763a ("drm/i915: Recognise non-VGA display devices")
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > ---
> > >   drivers/pci/vgaarb.c | 15 ++++++---------
> > >   1 file changed, 6 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > > index 811510253553..a6b8c0def35d 100644
> > > --- a/drivers/pci/vgaarb.c
> > > +++ b/drivers/pci/vgaarb.c
> > > @@ -964,7 +964,7 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
> > >    *
> > >    * To unregister just call vga_client_unregister().
> > >    *
> > > - * Returns: 0 on success, -1 on failure
> > > + * Returns: 0 on success, -ENODEV on failure
> > So this is the true substance of this change??
> > 
> Yes.
> 
> 
> > It doesn't warrant Fixes tag which requires a real problem to fix. An
> > incorrect comment is not enough.
> > 
> > I think the shortlog is a bit misleading as is because it doesn't in any
> > way indicate the problem is only in a comment.
> 
> But it's that commit(934f992c763a) alter the return value of
> vga_client_register(),
> which make the commit and code don't match anymore.

This is useful information, no point in withholding it which forces 
others to figure it out by looking that commit up so put that detail into 
the changelog body.

> >   I'd prefer to
> > initialize ret = 0 instead:
> > 
> > 	int ret = 0;
> > 	...
> > 	if (!vgadev) {
> > 		err = -ENODEV;
> > 		goto unlock;
> > 	}
> > 	...
> > unlock:
> > 	...
> > 
> 
> But this is same as the original coding style, no fundamental improve.
> The key point is to make the wrapped code between the spin_lock_irqsave() and
> spin_unlock_irqrestore() compact.
> my patch remove the necessary 'goto' statement and the 'bail' label.
> After apply my patch, the vga_client_register() function became as this:
> 
> int vga_client_register(struct pci_dev *pdev,
>         unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
> {
>     int ret = -ENODEV;
>     struct vga_device *vgadev;
>     unsigned long flags;
> 
>     spin_lock_irqsave(&vga_lock, flags);
>     vgadev = vgadev_find(pdev);
>     if (vgadev) {
>         vgadev->set_decode = set_decode;
>         ret = 0;
>     }
>     spin_unlock_irqrestore(&vga_lock, flags);
> 
>     return ret;
> }

I'm not too attached to either of the ways around since there's no 
correctness issues here. Feel free to ignore my alternative suggestion
(make the separate patch out of it in anycase).

-- 
 i.

--8323329-1008233500-1691669634=:1816--
