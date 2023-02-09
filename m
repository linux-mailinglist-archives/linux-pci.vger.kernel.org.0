Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23A7690039
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBIGMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 01:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBIGMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 01:12:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC91DBA9;
        Wed,  8 Feb 2023 22:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6D76190D;
        Thu,  9 Feb 2023 06:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F07BC433A7;
        Thu,  9 Feb 2023 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675923143;
        bh=DdJSvxTswgC5jU5eayppndGJdLst1jQJDDB7kJ+HZLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Txo6IukQjvrRIUdOPYgOGOtVA15oo8ClBPsTSHSOA0EQhxQi0X/BTyy7ArTJeTcaL
         ipA0VyVjjlAI93OOeIkMhz1rH6H1YYi0cFLASWeOfMCcCipd9ujyBSbGsL2oOXiBT/
         Al9w1EfuncWJr4VD0BOAA/cogdiW38l7nco+Qh8UmNSmVqZVg34lea/0Gr+McNgB42
         oYVt34HmCLIJSnQVuAaHvu2eC3NVD78rngrQ65i2gbbwF/4BSfPQqZbUWZi6o71c2y
         D6rxtyBSIZ0hus1EREIf9sVRRidELjW0GzhX/pFknwy+d8TvyTHucg0JKPThgFdGr1
         AfLBSWBLCx2dg==
Received: by mail-ej1-f48.google.com with SMTP id jg8so3327637ejc.6;
        Wed, 08 Feb 2023 22:12:22 -0800 (PST)
X-Gm-Message-State: AO0yUKWAevxe1pmBeidYRzsl0uuggcA/oLHasVcnyHAKndnYHC3rmFyR
        tjHynC1MriHb6Jf4X9PdTdkaTHKhJ5SuUECMvQw=
X-Google-Smtp-Source: AK7set9+nIqiU+rckSMqjLBSgwaVt9UEWZf6c5d2LjRTGI9OEfPfNfhbvCgOqvaCPOxk5mUX9jgRC44cWeC44zdUhv8=
X-Received: by 2002:a17:906:5202:b0:877:7480:c561 with SMTP id
 g2-20020a170906520200b008777480c561mr248371ejm.1.1675923141276; Wed, 08 Feb
 2023 22:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20221117020935.32086-1-liupeibao@loongson.cn> <0bb33ba8-00af-777b-fb97-a086b91865b0@loongson.cn>
In-Reply-To: <0bb33ba8-00af-777b-fb97-a086b91865b0@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 9 Feb 2023 14:12:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6CFm2=nDe52NjT6Uy1_mAO=gkTdJfanX8_ZrjifVjMjg@mail.gmail.com>
Message-ID: <CAAhV-H6CFm2=nDe52NjT6Uy1_mAO=gkTdJfanX8_ZrjifVjMjg@mail.gmail.com>
Subject: Re: [PATCH V6] PCI: loongson: Skip scanning disabled child devices
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 8, 2023 at 11:00 AM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
>
> =E5=9C=A8 2022/11/17 10:09, Liu Peibao =E5=86=99=E9=81=93:
> > Add a mechanism to disable on chip PCI devices by DT. Typically, when t=
here
> > are pins shareable between the platform device and the on chip PCI devi=
ce,
> > if the PCI device is not preferred, add `status =3D "disabled"` propert=
y to
> > this PCI device DT node.
> >
> > For example, on LS2K1000, GMAC1 (on chip PCI device) and GPIO (platform
> > device, not PCI device) 14 share the same pin. If GMAC1 is not preferre=
d,
> > add `status =3D "disabled"` property in GMAC1 DT node.
> >
> > Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>


> > ---
> > V5 -> V6: 1. rewrite the commit log to make things clear.
> >         2. replace "unavailable" as "disabled" in patch subject.
> > V4 -> V5: clear the issue we are facing in commit log.
> > V3 -> V4: 1. get rid of the masklist and search the status property
> >         directly.
> >            2. check the status property only when accessing the vendor =
ID.
> > V2 -> V3: 1. use list_for_each_entry() for more clearly.
> >            2. fix wrong use of sizeof().
> > V1 -> V2: use existing property "status" instead of adding new property=
.
> >
> >   drivers/pci/controller/pci-loongson.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index 05c50408f13b..efca0b3b5a29 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct p=
ci_bus *bus,
> >                       return NULL;
> >       }
> >
> > +#ifdef CONFIG_OF
> > +     /* Don't access disabled devices. */
> > +     if (pci_is_root_bus(bus) && where =3D=3D PCI_VENDOR_ID) {
> > +             struct device_node *dn;
> > +
> > +             dn =3D of_pci_find_child_device(bus->dev.of_node, devfn);
> > +             if (dn && !of_device_is_available(dn))
> > +                     return NULL;
> > +     }
> > +#endif
> > +
> >       /* CFG0 can only access standard space */
> >       if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
> >               return cfg0_map(priv, bus, devfn, where);
>
