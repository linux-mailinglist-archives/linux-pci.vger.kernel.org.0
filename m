Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A725CD6F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgICWZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICWZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 18:25:46 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBE820897;
        Thu,  3 Sep 2020 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599171945;
        bh=UIAXSve0SRrcUd0B8D3XS6dXgn/vQBkLbJ8pkN798Co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qluRU6tE3yEoLU2P/PGujeCsrKHYEEuTTVUhauwotQKC7B9OoafcrZW39TyQ+RWuU
         AOBoW9Eo44laSXkfHd3e6+DkRHt1Hu8KHa4U+OZiPVTYjSbeSWkfXmMuCDJEepbSRJ
         qccqng13joImKSahk+j3VAVuPZWx1O5WrcMQfqtk=
Received: by mail-oi1-f173.google.com with SMTP id 3so4765417oih.0;
        Thu, 03 Sep 2020 15:25:45 -0700 (PDT)
X-Gm-Message-State: AOAM530a2GkD2fS6KFhiNQVGHp3iCAWAI4y5ws74NCVzpiQTpxa8eEuD
        LJfzLpJwfHSXX8d2klYoFG0UqAbgOW+msB0+Bw==
X-Google-Smtp-Source: ABdhPJwrVduZhw2vlihPd2/Z7wXfAVL2xOnsNA6Q5zcbi6DAiVrLsMvntTI9GWRi9G26Rm5JgVmKH/NsVP5BMycbvEE=
X-Received: by 2002:aca:1711:: with SMTP id j17mr3621820oii.152.1599171945008;
 Thu, 03 Sep 2020 15:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
 <CAL_JsqJhvpiAWfa7w4-85-GObkW+pq6PUpZUGg8Sc5p4+qsuQA@mail.gmail.com> <aadb805d-e5fb-438a-d7e1-4e1ad31ddbac@socionext.com>
In-Reply-To: <aadb805d-e5fb-438a-d7e1-4e1ad31ddbac@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Sep 2020 16:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQ-jwgUst1PLM1jnoo8hiAap=D2jhKP-Z9YktiUgrU_g@mail.gmail.com>
Message-ID: <CAL_JsqKQ-jwgUst1PLM1jnoo8hiAap=D2jhKP-Z9YktiUgrU_g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] PCI: uniphier: Add error message when failed to
 get phy
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
> On 2020/08/18 1:39, Rob Herring wrote:
> > On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> >>
> >> Even if phy driver doesn't probe, the error message can't be distinguished
> >> from other errors. This displays error message caused by the phy driver
> >> explicitly.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> >> index 93ef608..7c8721e 100644
> >> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> >> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> >> @@ -489,8 +489,12 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
> >>                  return PTR_ERR(priv->rst);
> >>
> >>          priv->phy = devm_phy_optional_get(dev, "pcie-phy");
> >
> > The point of the optional variant vs. devm_phy_get() is whether or not
> > you get an error message. So shouldn't you switch to devm_phy_get
> > instead?
> >
> >> -       if (IS_ERR(priv->phy))
> >> -               return PTR_ERR(priv->phy);
> >> +       if (IS_ERR(priv->phy)) {
> >> +               ret = PTR_ERR(priv->phy);
> >> +               if (ret != -EPROBE_DEFER)
> >> +                       dev_err(dev, "Failed to get phy (%d)\n", ret);
> >> +               return ret;
> >> +       }
>
> The 'phys' property is optional, so if there isn't 'phys' in the PCIe node,
> devm_phy_get() returns -ENODEV, and devm_phy_optional_get() returns NULL.
>
> When devm_phy_optional_get() replaces devm_phy_get(),
> condition for displaying an error message changes to:
>
>     (ret != -EPROBE_DEFER && ret != -ENODEV)
>
> This won't be simple, but should it be replaced?

Nevermind. I was thinking we had some error prints for the optional
vs. non-optional variants.

Rob
