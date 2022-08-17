Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB35966E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiHQBoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiHQBoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 21:44:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25985AC5D
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 18:44:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a9so17196344lfm.12
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=fs4Zw8pySDSqaoEJWdBDfrMG3gZcqDenZx3uRmVVluc=;
        b=iFZ48bJIT68QElZCnFGUJUzGaz0sNHdt9olCCsZx4p6aGWH+FzZdGPSrMrsg14GGPq
         euhAqHesA3zbWdcRTuCB2jDU0LslO6XoHB0vDi4S4+ZXoeDjguzqP5d/D1Oy0ec6IDjA
         ldjcjiWucUdEBigxod9CT22gmyOyVQV1jGs/N8upQ5Ca9TiIaJVS6NZtFjlMVq/d0j/N
         uDwVC2Qh2aJPjwd/OHo49gbA6KQ/AnexhGG0S7B7R+tS1LZXnMW2sRPIj0Jnl2/2UmT0
         dE8QSsCTIfOqZmLYH0f0L0yVkCN7C4uQdS6rHEkc92JC9ArDJ9HSo4T6HixIHap1Rtr7
         nSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=fs4Zw8pySDSqaoEJWdBDfrMG3gZcqDenZx3uRmVVluc=;
        b=a8LwqbYR09MY8XEbxyWkHfrdtrvGWVoe/yJHfeLABNsgB71bJ4Jvr4r7JGZpF9rrhl
         dYPtIek8mDv56bGfXkJ7P1qFTJkcJN+/EBSBNLeqgO06Zwy9CEDRUqhPhRrnQ4+Pltk0
         B325TRC8TkNGHBkID8Xxqr8qqV5eviNQc7QkjsZoH9/8Ax0B8/GoavaSIIPVCJm3//Nm
         n5g5+b37KrXvD0svShw0j8yuxjkXsec3f7aenqB9H//VGtW0A9ZAVzJJODn/6+VaWjzP
         ySZPP6Pzt/5nmy2Zfz3fZtdfGyZflrG1KQlZq+m6czIfNQgWMPNVxuIaMdPrQHd5nTYz
         wHRA==
X-Gm-Message-State: ACgBeo1PwoYcRaGvVDYB4IcsmI2/M+VfaZJmD/V0yDUsY/cUNoDl1cWo
        NngrypkS0qCja/N06x1AvoJgHuTMTSvpx9gE+h69EQ==
X-Google-Smtp-Source: AA6agR4w110F5QrTQ2y5I9QcOksAyLVY0/T3J1+M4e1+Ou1c9jU4DBVLdjvIKiUd+71LlQzJCFct1X42aqIf6ckrl2g=
X-Received: by 2002:a05:6512:687:b0:48b:3b50:ba56 with SMTP id
 t7-20020a056512068700b0048b3b50ba56mr8249358lfe.32.1660700647348; Tue, 16 Aug
 2022 18:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220816100617.90720-1-mie@igel.co.jp> <YvtxAN7E4nmZmL/X@kroah.com>
In-Reply-To: <YvtxAN7E4nmZmL/X@kroah.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 17 Aug 2022 10:43:50 +0900
Message-ID: <CANXvt5qhUTmhWk9nJMoLDwAkUfOYyWF24+0yv0tJ6Q6voQ-ypw@mail.gmail.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}()
 panic
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B48=E6=9C=8816=E6=97=A5(=E7=81=AB) 19:27 Greg Kroah-Hartman <gre=
gkh@linuxfoundation.org>:
>
> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
> > Although dma_map_single() doesn't permit zero length mapping, the each
> > test functions called the function without zero checking.
> >
> > A panic was reported on arm64:
> >
> > [   60.137988] ------------[ cut here ]------------
> > [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> > [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridg=
e rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> > 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test video=
buf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> > c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes=
 phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> > [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-=
dev+ #237
> > [   60.193387] Hardware name: Renesas Salvator-X 2nd version board base=
d on r8a77951 (DT)
> > [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> > [   60.213149] lr : swiotlb_map+0x88/0x1f0
> > [   60.216982] sp : ffff80000a883bc0
> > [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000=
000000000
> > [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff800=
00a1f77c0
> > [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 0000000=
07a000000
> > [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000=
000000000
> > [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff000=
6ff7b9180
> > [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000=
000000000
> > [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000=
000000000
> > [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000=
000000000
> > [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000=
000000001
> > [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000=
040000010
> > [   60.291658] Call trace:
> > [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> > [   60.298629]  swiotlb_map+0x88/0x1f0
> > [   60.302115]  dma_map_page_attrs+0x188/0x230
> > [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
> > [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> > [   60.316583]  invoke_syscall+0x44/0x108
> > [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> > [   60.325038]  do_el0_svc+0x2c/0xb8
> > [   60.328351]  el0_svc+0x2c/0x88
> > [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> > [   60.335587]  el0t_64_sync+0x18c/0x190
> > [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
> > [   60.345344] ---[ end trace 0000000000000000 ]---
> >
> > To fix it, this patch adds checkings the payload length if it is zero.
> >
> > Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer ove=
rflows")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoi=
nt_test.c
> > index 8f786a225dcf..d45426a73396 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpo=
int_test *test,
> >       }
> >
> >       size =3D param.size;
> > -     if (size > SIZE_MAX - alignment)
> > +     if (size > SIZE_MAX - alignment || !size)
> >               goto err;
>
> Can we test size first?  And do it in the ioctl handler in one place so
> you don't have to add it everywhere?
>
> Or have a "validate all parameters" function that you do it in one
> place?
Yes, it is reasonable I think. I'll unify validations to the function.

> Also, all of these ioctl handlers are wrong, they are returning "0" to
> userspace if they fail, which is not correct at all.
> thanks,
>
> greg k-h
