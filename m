Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1182155FCCD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiF2KD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiF2KDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 06:03:25 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9421814
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 03:03:24 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id t21so432205uaq.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n0TKhf60BqUxKXVTgyVUgDzgOfNCHMkV9BtL5abMEak=;
        b=Qze4bmIABPB3DOjT6JZDsnXCOs3r0WbO0IhtJ6/mnX2mZ2biTnIzcW9imK89aFhcFH
         E8tJHJG3Q3CUQvE01nLUhG59MCn1Dp/AUuRudYStbGpo7HcRAJOUlNMq25i0tc95SoUf
         LSW/BRcpJgctI5TXNgzKGILCYkwZu/qWZmDZLbfZ5gu1zJ/C9sLuMD/DOpir1s1WAuPt
         MkqW81qNCAwcOLZKf+kLIuDgjr4EZCTOjHSucOSBgoYHr1dz8KsUnAPtx941F9Ki0z86
         +ltm61oYjqf9PogzCvLol1pfPaIaYjxE8zBgUSOIb2EohOn1yO4qVAVjUe+sjxHaHezp
         /Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n0TKhf60BqUxKXVTgyVUgDzgOfNCHMkV9BtL5abMEak=;
        b=n0rQL/yp0ugWRCjder0bMj0CJlJ/lN9Ll9BTjgeDO/e53AV7BEhbcHSKV4yR2FbpHa
         tH/SBB1nnInN+7N1CyVKnCMmQicxtpsYqg4R8ZhoH33J8mNYJ3l8UGbSHYaPwv9gwlko
         MusNAonqQ30ffVd9pVtkcTWfl2LPVDxuOaMc7Fcr158G9bmyqHjOCJH8UTjjGoH7hBP7
         QTt4kUSchIdknnyEm9CdRnuugupOX7nqawLqbMeP0rkXENxdKvIoOa694Rt4w29ifjmF
         4G74fxjz05RQlF1ON7ELZqpd45ndK8MNw7CXzL2zYW+vRj83yRMMiu1gdTO8gd02+Haw
         gs/w==
X-Gm-Message-State: AJIora9bTRsX+NGP0vLQzGNMrkYXQFmPskP2BLKdWCk5W3mLifBulkHL
        YM+Dpah9QIWrp4g6uLk1UlM4q8+lEO18x4GncI0=
X-Google-Smtp-Source: AGRyM1ugi+E9dvHKag5mD/45cItYHSbu15nRrjhET90cNNSDwH/iSKTsvrP3bonIefuVA7gST2nyiDdZknwCRY0447A=
X-Received: by 2002:a9f:2c9a:0:b0:381:c1c7:82a6 with SMTP id
 w26-20020a9f2c9a000000b00381c1c782a6mr727463uaj.23.1656497003300; Wed, 29 Jun
 2022 03:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220628160402.GA1842175@bhelgaas> <3d0b6e83-e653-7cab-4a87-02aa00a806a0@loongson.cn>
In-Reply-To: <3d0b6e83-e653-7cab-4a87-02aa00a806a0@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 29 Jun 2022 18:03:10 +0800
Message-ID: <CAAhV-H4i+UpFXcrvaHwHDKZH+yCyNtWw5vrjPHocZ38fL5CDbg@mail.gmail.com>
Subject: Re: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jianmin and Bjorn,

On Wed, Jun 29, 2022 at 8:33 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/6/29 =E4=B8=8A=E5=8D=8812:04, Bjorn Helgaas wrote:
> > On Tue, Jun 28, 2022 at 09:03:02PM +0800, Jianmin Lv wrote:
> >> On 2022/6/28 =E4=B8=8A=E5=8D=885:38, Bjorn Helgaas wrote:
> >>> On Fri, Jun 17, 2022 at 03:43:27PM +0800, Huacai Chen wrote:
> >>>> On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
> >>>> scanning. This is a hardware flaw but we can only avoid it by softwa=
re
> >>>> now.
> >>>
> >>> We should say what *does* happen if we do a config read to a device
> >>> that doesn't exit.  Machine check, hang, etc?
> >>
> >> The device is a hidden device(only for debug) that should not be
> >> scanned. If scanned in a non-normal way, the machine is hang(one
> >> case in ltp pci test can trigger the issue, which is explained
> >> below).
> >
> > Reading the Vendor ID is the *normal* way to scan for a device.  It
> > seems that this hardware just hangs in some cases when the device
> > doesn't exist.
> >
> >>> Generally speaking we only probe for functions > 0 if .0 is marked as
> >>> multi-function, so I guess this means 00:09.0 is marked as a
> >>> multi-function device, but config reads to 00:09.1 would fail?
> >>
> >> Yes, definitely. Actually, the 00:09.0 is a single device, so fun1(09.=
1)
> >> will not be scanned(e.g. the fun1 will be not scanned on pci enumerati=
on
> >> during kernel booting).
> >>
> >> But, there is one situation: when running ltp pci test case on LS7A,
> >> the 00:08.2 is a sata controller(a valid device), and the bus number(0=
)
> >> and devfn(0x42) are inputted to kernel api pci_scan_slot(), which has
> >> clear note: devfn must have zero function. So, apparently, the inputte=
d
> >> devfn's function is not zero, but 2, and then in the pci_scan_slot():
> >>
> >>          for (fn =3D next_fn(bus, dev, 0); fn > 0; fn =3D next_fn(bus,=
 dev, fn))
> >> {
> >>                  dev =3D pci_scan_single_device(bus, devfn + fn);
> >>                  ...
> >>          }
> >>
> >> 08.2,08.3...and 09.1 will be scanned one by one, so the 09.1(fun1) is
> >> scanned.
> >
> > Does the "((bus =3D=3D 0) && (device >=3D 9 && device <=3D 20) && (func=
tion > 0))"
> > test catch *all* devfns where the hang occurs?  I wouldn't want to
> > only avoid the ones that LTP happens to use.  If we did that, a future
> > LTP change could easily break things again.  But I assume you know
> > exactly what devices are present on the root bus.
> >
>
> Yes, as you said, I'm sure that only these hidden functions(fun1 of dev
> 9 to 20) on root bus can cause issue, so this fix is enough to address it=
.
>
> >>>> -  if (priv->data->flags & FLAG_DEV_FIX &&
> >>>> -                  !pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> >>>> +  if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> >>>> +          if (!pci_is_root_bus(bus) && (device > 0))
> >>>> +                  return NULL;
> >>>> +  }
> >>>> +
> >>>> +  /* Don't access non-existant devices */
> >>>> +  if (!pdev_is_existant(busnum, device, function))
> >>>>                    return NULL;
> >>>
> >>> Is this a "forever" hardware bug that will never be fixed, or should
> >>> there be a flag like FLAG_DEV_FIX so we only do this on the broken
> >>> devices?
> >>
> >> No, the next new version LS7A will correct it, so maybe we can use
> >> FLAG_DEV_FIX-like to address it.
> >
> > You should add the flag now instead of waiting for the new hardware.
> > Otherwise you may not remember or notice the need to make this
> > conditional on the hardware version, you'll wonder why the fixed
> > hardware doesn't enumerate devices correctly.
> >
>
> Thanks for your suggestion, I agree that, Huacai, WDYT?
Agree, I think we can use a FLAG_DEV_HIDDEN flag.

Huacai
>
>
> > Bjorn
> >
>
