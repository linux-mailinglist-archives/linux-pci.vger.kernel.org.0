Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27829EC5F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJ2NCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ2NCd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 09:02:33 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CD321775;
        Thu, 29 Oct 2020 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603976507;
        bh=OzIlRpXLdeGRcoA/MVFEQyHps4XuaG+UwlBrggFdE0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j1mT2NYHsoJ27PjrIOdCHm29Dr0jIJanUSSvW3ovjtCA+2JsQwP4TF17V8h45KLn6
         q/rWGnzjK5R5HCKtdT1UjO2CPNs0DlEyYrKGlf249zeQobn/tqoqqoSOkKF0nQ/tJx
         XzpLkOIXBR85Tjr1fxwi0eRNQozFeZBPxlNnWRvE=
Received: by mail-ot1-f42.google.com with SMTP id 32so2168065otm.3;
        Thu, 29 Oct 2020 06:01:47 -0700 (PDT)
X-Gm-Message-State: AOAM5329DpT5iisbFeMEkjPiTDZobOkh/2X8xi/6R5qq43OgNt+uDnFa
        blf46M/oSl5GRRIFDY/naVaedT2VoUIM2xChbQ==
X-Google-Smtp-Source: ABdhPJy/bhS7KTF1WNqgQUUalxQA1GfpAd7FTQIi3yYFWyIBt0GxzCWPuCwRMAMfnaaUFyZdFb4NCZ8rTg453LUEqGQ=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr3193317otk.192.1603976506229;
 Thu, 29 Oct 2020 06:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201028204646.356535-1-robh@kernel.org> <20201028204646.356535-2-robh@kernel.org>
 <87h7qdx4oz.fsf@mpe.ellerman.id.au>
In-Reply-To: <87h7qdx4oz.fsf@mpe.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Oct 2020 08:01:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWzmGNifrJEKGg582kZNtjnWHaUkG0EinWqjhGaeL1dg@mail.gmail.com>
Message-ID: <CAL_JsqJWzmGNifrJEKGg582kZNtjnWHaUkG0EinWqjhGaeL1dg@mail.gmail.com>
Subject: Re: [PATCH 01/13] PCI: dwc/imx6: Drop setting PCI_MSI_FLAGS_ENABLE
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        PCI <linux-pci@vger.kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@axis.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yue Wang <yue.wang@amlogic.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 7:21 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Rob Herring <robh@kernel.org> writes:
> > No other host driver sets the PCI_MSI_FLAGS_ENABLE bit, so it must not
> > be necessary. If it is, a comment is needed.
>
> Yeah, but git blame directly points to:
>
>   75cb8d20c112 ("PCI: imx: Enable MSI from downstream components")

I think I did read this at some point and then forgot about it when I
made the change later...

> Which has a pretty long explanation. The relevant bit probably being:
>
>   ... on i.MX6, the MSI Enable bit controls delivery of MSI interrupts
>   from components below the Root Port.

The thing is that all seems not i.MX6 specific but DWC specific given
MSI handling is contained within the DWC block. So I don't see how
this could be an integration difference.

So maybe everyone else is still just setting CONFIG_PCIEPORTBUS
typically and haven't noticed? Is it correct for the host driver to
set MSI enable?

Rob
