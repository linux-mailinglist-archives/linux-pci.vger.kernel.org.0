Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F346A7337C8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFPR6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFPR6M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6933A3AA8;
        Fri, 16 Jun 2023 10:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE0A62D55;
        Fri, 16 Jun 2023 17:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1C3C433CC;
        Fri, 16 Jun 2023 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686938278;
        bh=yZ8eEA+x+5gozagiComb31MKFfHvm1oQLeCgj8pDoEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q0csU51xJSe3z57XK+uNhWB8+Mjt/9Cjdr+9YejZTkvkjX+brhGBXKl4Gd1kTHeBa
         qdsfOcz4pxPbtegCYxvv2QztEsOh4/GDC2ihnUuO2OWZqd7HxPSSMyTm+LtGhCdVEe
         Ybfbp6+WpsLB/bTYCBvZNMS+eYKG85d2rFJtbqBWkUrLq6qlTC4P8OIL1Q3lUJLk1f
         foI7ZlMiMqGp7qmtlI4S4/GlaLqAhxfOpJKYcUGbGMlTkej/MO/BquYDjpZ9g1UIAm
         RUvQeHoQ37ZuqhcUmTE3CiyMnAyH1iXmYL0b0BeAyRZqnxoFi/Rfm6Urf4cBrloR7E
         xq+i601kTs/dg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f84d70bf96so1286575e87.0;
        Fri, 16 Jun 2023 10:57:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDwQakx8rH2xvv04sWlGQjGGgGK5IKexCv/MDAaX/HsTBNLICfMn
        9cRHzIJ2QkpV2wbkyk4J0Vt9T1qPOwKtG7Amvg==
X-Google-Smtp-Source: ACHHUZ4ibV3Qa76jehM/K30WUyK2tw9YnxpHB+I2hoSJfKa80o9Cg3HiXq9qR+Rp3ZXrDPDqAK9c0zq4XdhEvvCBWUo=
X-Received: by 2002:a05:6512:33c7:b0:4f8:4b19:9533 with SMTP id
 d7-20020a05651233c700b004f84b199533mr1185954lfg.19.1686938276276; Fri, 16 Jun
 2023 10:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230601163335.6zw4ojbqxz2ws6vx@skbuf> <ZHjaq+TDW/RFcoxW@bhelgaas>
 <20230601221532.2rfcda4sg5nl7pzp@skbuf> <dc430271-8511-e6e4-041b-ede197e7665d@loongson.cn>
 <7a7f78ae-7fd8-b68d-691c-609a38ab3161@loongson.cn> <20230602101628.jkgq3cmwccgsfb4c@skbuf>
 <87f2b231-2e16-e7b8-963b-fc86c407bc96@loongson.cn> <20230604085500.ioaos3ydehvqq24i@skbuf>
In-Reply-To: <20230604085500.ioaos3ydehvqq24i@skbuf>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Jun 2023 11:57:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com>
Message-ID: <CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com>
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 4, 2023 at 2:55=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>

Sorry, just now seeing this as I've been out the last month.

> On Sat, Jun 03, 2023 at 10:35:50AM +0800, Jianmin Lv wrote:
> > > How about 3. handle of_device_is_available() in the probe function of
> > > the "loongson, pci-gmac" driver? Would that not work?
> > >
> > This way does work only for the specified device. There are other devic=
es,
> > such as HDA, I2S, etc, which have shared pins. Then we have to add
> > of_device_is_available() checking to those drivers one by one. And we a=
re
> > not sure if there are other devices in new generation chips in future. =
So
> > I'm afraid that the way you mentioned is not suitable for us.

If we decided that disabled devices should probe, then that is exactly
what will have to be done. The restriction (of shared pins) is in the
devices and is potentially per device, so it makes more sense for the
device's drivers to handle than the host bridge IMO. (Assuming the
core doesn't handle a per device property.)


> Got it, so you have more on-chip PCIe devices than the ones listed in
> loongson64-2k1000.dtsi, and you don't want to describe them in the
> device tree just to put status =3D "disabled" for those devices/functions
> that you don't want Linux to use - although you could, and it wouldn't
> be that hard or have unintended side effects.
>
> Though you need to admit, in case you had an on-chip multi-function PCIe
> device like the NXP ENETC, and you wanted Linux to not use function 0,
> the strategy you're suggesting here that is acceptable for Loongson
> would not have worked.
>
> I believe we need a bit of coordination from PCIe and device tree
> maintainers, to suggest what would be the encouraged best practices and
> ways to solve this regression for the ENETC.

I think we need to define what behavior is correct for 'status =3D
"disabled"'. For almost everywhere in DT, it is equivalent to the
device is not present. A not present device doesn't probe. There are
unfortunately cases where status got ignored/forgotten and PCI was one
of those. PCI is a bit different since there are 2 sources of
information about a device being present. The intent with PCI is DT
overrides what's discovered. For example, 'vendor-id' overrides what's
read from the h/w.

I think we can fix making the status per function simply by making
'match_driver' be set based on the status. This would move the check
later to just before probing. That would not work for a case where
accessing the config registers is a problem. It doesn't sound like
that's a problem for Loongson based on the above response, but their
original solution did prevent that. This change would also mean the
PCI quirks would run. Perhaps the func0 memory clearing you need could
be run as a quirk instead?

Rob
