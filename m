Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D957B25CD43
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICWM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgICWMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 18:12:23 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502C020DD4;
        Thu,  3 Sep 2020 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599171142;
        bh=kWp2jy1cl38XtJEa2J7tj4Dfu/Rm93sjy3IsxSOhjdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q95uRIFMtQEFAq7kDesYZrFOttACnICmuo00MquGyIFu+v88cWsaya/Xhuh3DH+GX
         lL7ZKPFBCMZkEcqsE4w2LVKmxHoz7Osz4yY4DYQIxVp5JImc0QUCuqlkdPWisfWele
         uw1HB/bIxj3wrcIHp/vxB2i4ReLaDLwVuHmZCmQY=
Received: by mail-ot1-f44.google.com with SMTP id g10so4150831otq.9;
        Thu, 03 Sep 2020 15:12:22 -0700 (PDT)
X-Gm-Message-State: AOAM533GR0M+5JyA8xDJBeucKIqlBmbpySW67xSMgfQeDSj91HB3SVts
        7fpjJgbcI4zEckZjNCLxkjgGnq/NkOu+NqOmYg==
X-Google-Smtp-Source: ABdhPJz61ghK3HLBNa4m7HkLBA3p58WrqZyuBgtMUBvuBzBFvzHhgwPpfLk6CFGDI1jTJPNvgjpxjr8y+wdNBfWxRPM=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr3111655otp.107.1599171141596;
 Thu, 03 Sep 2020 15:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
 <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com> <ab0f7338-045c-8565-134b-757769c9235f@socionext.com>
In-Reply-To: <ab0f7338-045c-8565-134b-757769c9235f@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Sep 2020 16:12:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HnaosmJgekrS-DynGvNR742m00vLN1yCiZ4YBf3T2-Q@mail.gmail.com>
Message-ID: <CAL_Jsq+HnaosmJgekrS-DynGvNR742m00vLN1yCiZ4YBf3T2-Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] PCI: uniphier: Add iATU register support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 1:05 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> On 2020/08/18 1:48, Rob Herring wrote:
> > On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> >>
> >> This gets iATU register area from reg property. In Synopsys DWC version
> >> 4.80 or later, since iATU register area is separated from core register
> >> area, this area is necessary to get from DT independently.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-uniphier.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> >> index 55a7166..93ef608 100644
> >> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> >> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> >> @@ -471,6 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
> >>          if (IS_ERR(priv->pci.dbi_base))
> >>                  return PTR_ERR(priv->pci.dbi_base);
> >>
> >> +       priv->pci.atu_base =
> >> +               devm_platform_ioremap_resource_byname(pdev, "atu");
> >> +       if (IS_ERR(priv->pci.atu_base))
> >> +               priv->pci.atu_base = NULL;
> >
> > Keystone has the same 'atu' resource setup. Please move its code to
> > the DW core and use that.
>
> There are some platforms that pci.atu_base is set by other way.
> The 'atu' code shouldn't be conflicted with the following existing code.

No, it's not a conflict but needless duplication.

>    drivers/pci/controller/dwc/pci-keystone.c:              atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
>    drivers/pci/controller/dwc/pci-keystone.c:              pci->atu_base = atu_base;
>    drivers/pci/controller/dwc/pcie-designware.c:                   pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>    drivers/pci/controller/dwc/pcie-intel-gw.c:     pci->atu_base = pci->dbi_base + data->pcie_atu_offset;

This one should have had an 'atu' region in DT.

>    drivers/pci/controller/dwc/pcie-tegra194.c:     pci->atu_base = devm_ioremap_resource(dev, atu_dma_res);

Unfortunately, a different name was used. That is the mess which is
the DW PCI controller.

>
> So I'm not sure where to move the code in the DW core.
> Is there any idea?

You just need this and then remove the keystone code:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c
b/drivers/pci/controller/dwc/pcie-designware.c
index b723e0cc41fb..680084467447 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,6 +556,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
                                       dw_pcie_iatu_unroll_enabled(pci))) {
                pci->iatu_unroll_enabled = true;
                if (!pci->atu_base)
+                       pci->atu_base =
devm_platform_ioremap_resource_byname(pdev, "atu");
+               if (IS_ERR(pci->atu_base))
                        pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
        }
        dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
