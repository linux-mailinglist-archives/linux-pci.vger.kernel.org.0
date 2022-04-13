Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8198D4FF675
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiDMMMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiDMMMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 08:12:13 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF73F8B4;
        Wed, 13 Apr 2022 05:09:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2eba37104a2so20206037b3.0;
        Wed, 13 Apr 2022 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uHgjRJ5n7gxa3U8bHk8ZxYgUPiikIG3e7D0EHXtK/WI=;
        b=Bu0b0Y/KrqMGaQ4XJKkH1snEUiP5tOPA+/pDExEqKjnvrtenziyOmLtOByO8yMXuLz
         vPf6g56ZQ4o6xcz7/UTrb6IvkeJIhqpA7ATKqKSPVVqO/k33/xFJ4Aed/FocWMs2WUN2
         0xXheoOV9fn4KwKnhOc3foPFRav+bDee4afUyrIyRksibz+ruSPBSV5AbpzjtlqrMzZR
         2xB5e8PvEx6vA3cAEDbuAViP/fmX07uF+XyZTZ31Ij0vssvoggpeuX6Z2JEuNeJkMrn4
         a2aKUJ2/jXxmFnQw0+1zMapR577dUDxf0G9Kem3oDSZquoK9lNXdGMO405vjkV39C+Fm
         J7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uHgjRJ5n7gxa3U8bHk8ZxYgUPiikIG3e7D0EHXtK/WI=;
        b=koVKMEpVqm+bEnMMj9wZ2aUm8f+cZUkBGdN6IAg4MNXXooQnJmV2E4gPrJClsUltXX
         rNk8SdY9XubDCCPBU85nzuIrXplkZ/t9NbIhzXg9mqI8SVvnd2j3WZy/8trp/jsiXvpd
         0txAPY84KKdVLdkDUMBgI3Ayz1eWynboxlDKWUCNxnToiMLuqVWJB8NNGA+xoUSTHw23
         PPOdcJKYqqjAyQpbmZulSuKyPgvdDEFhGDlzK8dv31d5yPPI3dF7+jVtVUkXHHrRZVxi
         79G14g4muwY3t4KYjJngUN2HZjkQGK4PX6QipAhMr/dY6+wPRvhNARD1XMDd44AWe15n
         p7Mw==
X-Gm-Message-State: AOAM533nxEPOLztRHscrGNVGsR0BmAWaUWVi6/MkbDMs5BqBtyhgLCrq
        9N6JKf0rjmb2/gGrmSsWnF5WmezMvxXOh91yjVE=
X-Google-Smtp-Source: ABdhPJwMJK0m2bHfAT/ZqxMVu8kycGcqPLvMYcqzO9MiUl1ZsR/O2Xc/2lRjo9G2u4vlQIt0yFuVlD/CuSh3WZ381yg=
X-Received: by 2002:a81:578c:0:b0:2e6:2488:7ef8 with SMTP id
 l134-20020a81578c000000b002e624887ef8mr34012300ywb.519.1649851787737; Wed, 13
 Apr 2022 05:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220412185751.124783-1-pgwipeout@gmail.com> <20220412185751.124783-3-pgwipeout@gmail.com>
 <0cf83ec0-29d3-fbde-0b7d-9d58d210f0a4@rock-chips.com>
In-Reply-To: <0cf83ec0-29d3-fbde-0b7d-9d58d210f0a4@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 13 Apr 2022 08:09:36 -0400
Message-ID: <CAMdYzYoX=4a_nMfNJ++nVTm18896g6jDngPrq36mRs8e2kj7tA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] PCI: dwc: rockchip: add legacy interrupt support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Apr 12, 2022 at 10:54 PM Shawn Lin <shawn.lin@rock-chips.com> wrote=
:
>
> Hi Peter,
>
> =E5=9C=A8 2022/4/13 2:57, Peter Geis =E5=86=99=E9=81=93:
> > The legacy interrupts on the rk356x pcie controller are handled by a
> > single muxed interrupt. Add irq domain support to the pcie-dw-rockchip =
>
> > +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     struct rockchip_pcie *rockchip =3D irq_desc_get_handler_data(desc=
);
> > +     struct device *dev =3D rockchip->pci.dev;
> > +     u32 reg;
> > +     u32 hwirq;
> > +     u32 virq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     reg =3D rockchip_pcie_readl_apb(rockchip, 0x8);
> > +
>
>
> Overall it looks good except that 0x8 has a name,
> PCIE_CLIENT_INTR_STATUS_LEGACY. BTW, If you consider adding more support
> to it, for instance, enable/disable/affinity?  The downstream kernel
> finished these for better fitting for function driver usage.

Good catch, thanks.

This patch has remained largely unchanged from when I first created it
prior to asking for Rockchip to include support for it in the initial
series.
I would have left it out based on the original counter arguments,
except in testing we have discovered two issues:
A surprising number of cards do not support MSIs.
The current MSI implementation has poor compatibility.

I will look at the downstream implementation and consider possible
changes, but for the time being this does the job.
