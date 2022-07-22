Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3928B57E7A2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiGVTrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiGVTrM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 15:47:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864621E3E;
        Fri, 22 Jul 2022 12:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1425B828EB;
        Fri, 22 Jul 2022 19:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A66C341D0;
        Fri, 22 Jul 2022 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658519228;
        bh=k1kecu27UOxg6c6RvnOriO0pqtKqAK/t5BBpPxWwgvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X9o4TDJQj6UKuRVRXllkeL8bUoN//CK+zVX9e1Ev5AjBUIZasR2fsPyq7CcRMjOXH
         bIROU9Pwm3zQAB+V6mBjygZIXtBkynu7Mdo0bDig/0mChVsdeyqb2Kgql8B6WtP5q5
         th5rJnI5nTV2JPB4r1smcbTEDFftKzr91ESUDOJaDApop05cNmdWhSYNqALn2kHXGr
         DYyEJfBF6pFc6Ml+TH3YRu7gQlcfet2wGogCiRecgLHGPLWdsz1btkCwZnlG+tQRsx
         uHXM736BF7CsfIwSZOTwvBpEDSFTBotarGpqWpAAp+jU9BTyYwsgmAPXg7hzCPD8EC
         huHoTSb0pd8eQ==
Received: by mail-vk1-f171.google.com with SMTP id b2so927738vkg.2;
        Fri, 22 Jul 2022 12:47:08 -0700 (PDT)
X-Gm-Message-State: AJIora/PBKKnJ3MB5WpLXpNxjDSYzdqi9xNL+tNQMbick+wGQhdqjZSB
        RNBKAbA8MbNbrxyge6g6TaIDAREZk1hrDM2iXg==
X-Google-Smtp-Source: AGRyM1t/qED/RzNJtCJKxlNwMdvxy06ft+4UAxfO0C+byw3FDjsg8eO5ieMlJsAxhe/hzjmnpgB+FAwcyBtoBwAtcC0=
X-Received: by 2002:a1f:2454:0:b0:375:10ae:8bca with SMTP id
 k81-20020a1f2454000000b0037510ae8bcamr502088vkk.26.1658519227394; Fri, 22 Jul
 2022 12:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <226ac31e-2ac4-cb73-ab67-62f86d5e5783@linaro.org> <20220721205819.GA1753070@bhelgaas>
In-Reply-To: <20220721205819.GA1753070@bhelgaas>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Jul 2022 13:46:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Li_PhkRw4LkZwGdRn5mpCO5cePgBMLORF21-W65fqEA@mail.gmail.com>
Message-ID: <CAL_Jsq+Li_PhkRw4LkZwGdRn5mpCO5cePgBMLORF21-W65fqEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 2:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 11:04:00AM +0200, Krzysztof Kozlowski wrote:
> > On 20/07/2022 08:01, Wangseok Lee wrote:
> > > Add support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform of Axis
> > > Communications. This is based on arm64 and support GEN4 & 2lane. This
> > > PCIe controller is based on DesignWare Hardware core and uses DesignWare
> > > core functions to implement the driver. "pcie-artpec6. c" supports artpec6
> > > and artpec7 H/W. artpec8 can not be expanded because H/W configuration is
> > > completely different from artpec6/7. PHY and sub controller are different.
> > >
> > > Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> > > Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>
> > > ---
> > > v3->v4 :
> > > -Remove unnecessary enum type
> > > -Fix indentation
> > >
> >
> > Thanks for the changes. This starts to look good, however I am not going
> > to ack it. This is also not a strong NAK, as I would respect Bjorn and
> > other maintainers decision.
> >
> > I don't like the approach of creating only Artpec-8 specific driver.
> > Samsung heavily reuses its block in all Exynos devices. Now it re-uses
> > them for other designs as well. Therefore, even if merging with existing
> > Exynos PCIe driver is not feasible (we had such discussions), I expect
> > this to cover all Samsung Foundry PCIe devices. From all current designs
> > up to future licensed blocks, including some new Samsung Exynos SoC. Or
> > at least be ready for it.
>
> I would certainly prefer fewer drivers but I don't know enough about
> the underlying IP and the places it's integrated to to know what's
> practical.  The only way I could figure that out would be by manually
> comparing the drivers for similarity.  I assume/expect all driver
> authors are doing that.

Sadly, I would not assume that. :(

Just looking at the ELBI registers between Exynos and this one, the
registers look completely different with nothing shared between the 2.
Maybe sharing is possible with some new, yet to be upstreamed Samsung
PCIe IP, but not the existing one. Same vendor is not always a good
reason to share a driver.

I think the way to further shrink the vendor DWC drivers is getting
the DWC core and PCI core to do more in terms of clocks, resets, and
phys management, handling of PERST, and link state management. We
should also get rid of vendor drivers doing their own abstraction
layers (ops structs) (looking at you QCom).

Rob
