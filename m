Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3A57BCEB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiGTRk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiGTRkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F5481CC;
        Wed, 20 Jul 2022 10:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0373E615F7;
        Wed, 20 Jul 2022 17:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF2C36AE7;
        Wed, 20 Jul 2022 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658338853;
        bh=WfYi/BhtMY0afgPXBetwwnngHy3gOqIEhszPyFrt6to=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvEVmQcVYAWcyH492tj8U6fAmZYyRlH6VlwcMrCBbokxpA0WUpHnTwr779pqatWPZ
         XUMxzHVR0zOQIknmnlZXpumhMkgaDVIR2nkLLzBk379S3pxWW2V3N2BEDeVQnY+QSR
         5vL8gO9wRTCs/N9KKuGwLEEEzRAQ/KRoKbU9pAmdQV4aiHtqRPlJsD7k34SaZhWofN
         QWcA+1Hd8GXZqNwIvQr3jto8vtyVQ9SWr9FxEM+YE08O5U4VBQyhkTlM49nkFHQ2U0
         swDxfE/RcTtF0bVWnIvUOk3zAdTt59V8oCiTCl5lvCneB6Bex2upX+K+fmtzpH/Ue5
         S80mAkYovC4Pg==
Received: by mail-vk1-f169.google.com with SMTP id c185so7263507vkh.12;
        Wed, 20 Jul 2022 10:40:53 -0700 (PDT)
X-Gm-Message-State: AJIora/3sLBGtbeiGhHfkXrzXAk+9Yv2RyIjlmrth9NQwIQLKv1J6nBc
        jYCT1qqcakKHVQk11KE37mEHbSrRVS4KTs3RPQ==
X-Google-Smtp-Source: AGRyM1vqhG3YXF5i1gvh8yLgBdQlamgFHdK/ECn2oPRqnCH28gYrN3RiQpRx1CwG3MT6fSbj9ytvNfWePKN6VYl9ZmA=
X-Received: by 2002:a1f:1ec8:0:b0:36c:643a:e985 with SMTP id
 e191-20020a1f1ec8000000b0036c643ae985mr14132012vke.14.1658338852305; Wed, 20
 Jul 2022 10:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220718202843.6766-1-maukka@ext.kapsi.fi> <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
 <20220719094649.pzyrqdvm3fm5fqh2@pali> <CAK8P3a1RpMQ5zdiH_jkydxDOCm6WyD7qqdN+5T+503tN4SnOqw@mail.gmail.com>
 <20220720161315.rr4ujakl7akm7pur@pali>
In-Reply-To: <20220720161315.rr4ujakl7akm7pur@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jul 2022 11:40:40 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+H+nzacGEZ4TRgZ70jUHugpNj=jpA+XfaWjhuduH1GLA@mail.gmail.com>
Message-ID: <CAL_Jsq+H+nzacGEZ4TRgZ70jUHugpNj=jpA+XfaWjhuduH1GLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 10:13 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 19 July 2022 12:16:34 Arnd Bergmann wrote:
> > On Tue, Jul 19, 2022 at 11:46 AM Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > > On Tuesday 19 July 2022 10:05:28 Arnd Bergmann wrote:
> > > > > +/* Relevant only for Orion-1/Orion-NAS */
> > > > > +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> > > > > +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)
> > > >
> > > > You should not need to hardcode these here. The ORION5X_PCIE_WA_PHY=
S_BASE
> > > > should already be part of the DT binding.
> > >
> > > Of course! But the issue is that we do not know how to do this DT
> > > binding. I have already wrote email with asking for help in which
> > > property and which format should be this config range defined, but no
> > > answer yet: https://lore.kernel.org/linux-pci/20220710225108.bgedria6=
igtqpz5l@pali/
> >
> > Ah, I had not seen that email. Quoting from there:
> >
> > > So my question is: How to properly define config space range in devic=
e
> > > tree file? In which device tree property and in which format? Please
> > > note that this memory range of config space is PCIe root port specifi=
c
> > > and it requires its own MBUS_ID() like memory range of PCIe MEM and P=
CIe
> > > IO mapping. Please look e.g. at armada-385.dtsi how are MBUS_ID() use=
d:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm/boot/dts/armada-385.dtsi
> >
> > This is probably a question for Rob as the mvebu driver is a rather spe=
cial
> > case. Normally this would just be a 'reg' property of the host bridge,
> > but I think
> > in your case the root device is imaginary, and the ports under it are t=
he
> > actual hardware devices
>
> yes
>
> > so you'll probably have to do the same thing as
> > the armada-385, translating the mbus ranges for the config space in the
> > "ranges" property of the parent
>
> Problem is that "ranges" in PCIe are used for specifying MEM and IO
> mappings and kernel PCI code does not allow any other type.

The kernel does not, but the binding does (well, the original OF PCI
bus supplement does, but the schema currently does not). If there's a
real need to support config space in ranges, then we can relax the
constraints.

Rob
