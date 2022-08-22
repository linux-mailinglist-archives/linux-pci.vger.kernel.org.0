Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4959B83B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 06:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiHVELT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 00:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiHVELS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 00:11:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5913D41
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:11:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s1so10783648lfp.6
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=YYEY3HoesRJZtmoDYsjk2PeXO/8ic8daNq/Rhp63QXE=;
        b=nMxd/KKAfmi9hX+XxVxfkxX5iYtyBEtMc5poYZWipGZYRuOhGFCmzQgS4HbdfEOsNz
         sZCPtah+HiPjQgjkFNVh5fKMo8Jy+GKaPqGHO3qmXrAef8K+FmbBrUn7r/iEhMHHuUGu
         DdPrzk2u+JXQBr2JQ8JQe1BlB7vdYPBbmSVwNthmQBXWPEEcqngFN/SuQr2mFObuRfNL
         kahVGqa/blCUuu9ixofWB+4+/m34dmYh5o3AicoBJhVU5eaoLJmVgCKyoDc6ma/V0IZ3
         2KDF8eC7lfHHDsCS9mdRaiwVCtQduukPcHja09S1LWspz6e4yCyep31dr9Ja0HVbLuwQ
         OnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=YYEY3HoesRJZtmoDYsjk2PeXO/8ic8daNq/Rhp63QXE=;
        b=O5YMmXJw4l30tjWyc6/B/3pKnB79zqok1bQxNFx3iGCwVzhM25JEL0hiTM66/UrK+U
         TufBtY95hGnXsmL3NxjscrcuJtQDOWwC6kg7SIHQ6m4ySbkYClJy314GfgwaAYsW+JIQ
         vizABSXY9YRgybxA+iTb8oMbX/8mdKxy4xESDHBL2uAwKVuFsdGoSfp1C/yHHnL3KEck
         PElPMzHgg68JPDFB6FPRwmdnnAdwiksvwAiH0XUixKt2N6d7SvsosKV06NDrrjjl7P4M
         rCH2pAqt3YBGaiIF7fJ90b8c9ffFxCRaIu12b1r/5Ujp5/gPZS2+eIBUdK1zq/iSUgF6
         UnaA==
X-Gm-Message-State: ACgBeo1A/a0eP5ca+rt2mNs+qwPLfgWUPOcDzPdUsKDF26EOtFu4TFTt
        Xq2RF4tewbhBoM+2+rCECNCF85dk0R+FfU1gfHei2Q==
X-Google-Smtp-Source: AA6agR5sp7USyoNUU/Gd0/0ibra+Svt9ZC65OIwCGbgcFub0pqBtOl3i/uVsHxppsnK6R4p6FbZE0sVR3vMiG5PBuXg=
X-Received: by 2002:a05:6512:3c87:b0:492:d161:c014 with SMTP id
 h7-20020a0565123c8700b00492d161c014mr3803885lfv.490.1661141474717; Sun, 21
 Aug 2022 21:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220816100617.90720-1-mie@igel.co.jp> <YvtxAN7E4nmZmL/X@kroah.com>
 <Yvuvpd9n59mp96p0@lpieralisi> <695ab9b3-8385-e8bd-0095-14b07de66b15@ti.com>
 <YvzNg5ROnxEApDgS@kroah.com> <632f447c-fe1a-e6aa-2fda-73669964fc92@ti.com>
 <20220819105255.GD215264@thinkpad> <20220819145253.GA35978@thinkpad>
In-Reply-To: <20220819145253.GA35978@thinkpad>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 22 Aug 2022 13:10:58 +0900
Message-ID: <CANXvt5oKUeBS5GdcUeV-A7sk+C=SGWSf83qTkxOti4zsXuCXjA@mail.gmail.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}()
 panic
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B48=E6=9C=8819=E6=97=A5(=E9=87=91) 23:53 Manivannan Sadhasivam <=
manivannan.sadhasivam@linaro.org>:
>
> On Fri, Aug 19, 2022 at 04:23:03PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Aug 19, 2022 at 04:08:13PM +0530, Kishon Vijay Abraham I wrote:
> > > +Mani
> > >
> > > On 17/08/22 16:44, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 17, 2022 at 02:18:58PM +0530, Kishon Vijay Abraham I wr=
ote:
> > > >> Hi Lorenzo,
> > > >>
> > > >> On 16/08/22 20:24, Lorenzo Pieralisi wrote:
> > > >>> On Tue, Aug 16, 2022 at 12:27:12PM +0200, Greg Kroah-Hartman wrot=
e:
> > > >>>> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
> > > >>>>> Although dma_map_single() doesn't permit zero length mapping, t=
he each
> > > >>>>> test functions called the function without zero checking.
> > > >>>>>
> > > >>>>> A panic was reported on arm64:
> > > >>>>>
> > > >>>>> [   60.137988] ------------[ cut here ]------------
> > > >>>>> [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> > > >>>>> [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > > >>>>> [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simp=
le_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> > > >>>>> 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_te=
st videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> > > >>>>> c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authen=
c libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> > > >>>>> [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-=
rc1rpci-dev+ #237
> > > >>>>> [   60.193387] Hardware name: Renesas Salvator-X 2nd version bo=
ard based on r8a77951 (DT)
> > > >>>>> [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> > > >>>>> [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> > > >>>>> [   60.213149] lr : swiotlb_map+0x88/0x1f0
> > > >>>>> [   60.216982] sp : ffff80000a883bc0
> > > >>>>> [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27:=
 0000000000000000
> > > >>>>> [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24:=
 ffff80000a1f77c0
> > > >>>>> [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21:=
 000000007a000000
> > > >>>>> [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18:=
 0000000000000000
> > > >>>>> [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15:=
 ffff0006ff7b9180
> > > >>>>> [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12:=
 0000000000000000
> > > >>>>> [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 :=
 0000000000000000
> > > >>>>> [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 :=
 0000000000000000
> > > >>>>> [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 :=
 0000000000000001
> > > >>>>> [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 :=
 0000000040000010
> > > >>>>> [   60.291658] Call trace:
> > > >>>>> [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> > > >>>>> [   60.298629]  swiotlb_map+0x88/0x1f0
> > > >>>>> [   60.302115]  dma_map_page_attrs+0x188/0x230
> > > >>>>> [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoi=
nt_test]
> > > >>>>> [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> > > >>>>> [   60.316583]  invoke_syscall+0x44/0x108
> > > >>>>> [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> > > >>>>> [   60.325038]  do_el0_svc+0x2c/0xb8
> > > >>>>> [   60.328351]  el0_svc+0x2c/0x88
> > > >>>>> [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> > > >>>>> [   60.335587]  el0t_64_sync+0x18c/0x190
> > > >>>>> [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210=
000)
> > > >>>>> [   60.345344] ---[ end trace 0000000000000000 ]---
> > > >>>>>
> > > >>>>> To fix it, this patch adds checkings the payload length if it i=
s zero.
> > > >>>>>
> > > >>>>> Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some int=
eger overflows")
> > > >>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > >>>>> ---
> > > >>>>>  drivers/misc/pci_endpoint_test.c | 6 +++---
> > > >>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pc=
i_endpoint_test.c
> > > >>>>> index 8f786a225dcf..d45426a73396 100644
> > > >>>>> --- a/drivers/misc/pci_endpoint_test.c
> > > >>>>> +++ b/drivers/misc/pci_endpoint_test.c
> > > >>>>> @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct p=
ci_endpoint_test *test,
> > > >>>>>       }
> > > >>>>>
> > > >>>>>       size =3D param.size;
> > > >>>>> -     if (size > SIZE_MAX - alignment)
> > > >>>>> +     if (size > SIZE_MAX - alignment || !size)
> > > >>>>>               goto err;
> > > >>>>
> > > >>>> Can we test size first?  And do it in the ioctl handler in one p=
lace so
> > > >>>> you don't have to add it everywhere?
> > > >>>>
> > > >>>> Or have a "validate all parameters" function that you do it in o=
ne
> > > >>>> place?
> > > >>>>
> > > >>>> Also, all of these ioctl handlers are wrong, they are returning =
"0" to
> > > >>>> userspace if they fail, which is not correct at all.
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/tools/pci/pcitest.c
> > > >>> This is bad, thanks Greg for spotting it.
> > > >>>
> > > >>> @Kishon, we have to fix it asap, please let me know if you
> > > >>> can post a patch promptly.
> > > >>
> > > >> The userspace tool (pcitest [1]) that calls these IOCTLS prints "N=
OT
> > > >> OKAY" on 0 and "OKAY" for 1.
> > > >>
> > > >> I'll change to negative value for error and still keep '0' for dat=
a
> > > >> mismatch error?
> > > >
> > > > No, 0 as a return value from a system call means "success".  You ca=
n not
> > > > redefine it to mean something else for a tiny single kernel driver,
> > > > otherwise so much for consistency.
> > > >
> > > > 0 is success, -ERROR_NUMBER is an error, please read the ioctl man =
page.
> > >
> > > Thanks Greg!
> > >
> > > Mani, Would you be able to post a patch fixing it? If not I'll post i=
t
> > > mid next week.
> > >
> >
> > Will do!
> >
>
> Done! But I haven't fixed the size issue that _this_ patch fixes. I'll le=
ave it
> up to Shunsuke.
I'll do that.

> Thanks,
> Mani
>
> > Thanks,
> > Mani
> >
> > > Regards,
> > > Kishon
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks,
Shunsuke
