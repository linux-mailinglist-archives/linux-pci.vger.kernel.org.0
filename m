Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E237C2F5F44
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhANKub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 05:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbhANKua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 05:50:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27344C061573;
        Thu, 14 Jan 2021 02:49:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ga15so7501727ejb.4;
        Thu, 14 Jan 2021 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ndg4DzK5tx5X4El9lZvtof/dcnyIAi2qDb/LCZ6Ys0=;
        b=kM2NffTpZ8i8YRZV02LaWQG3uVsBj8lKxGdxTbOx4AvotYpx3O6iTpYVjfnll1ms3f
         WJAFo7tyw82Kx/bUVXLYmcre5vTNRSN9jn7AX/q6xxdH9ZnAdS2Xn6JmGisvlZ7zBSlw
         GqAtGMU1oHBqDQGJ5sB9lgIE7Vv05yj6oQD6RFIFpGcyjsnEM2wL3ZuSMBbrN/9fKeXG
         jTgaDdb1zN25/QWqrjHW+WcgHGCtUQMmRMIXAfzTSnE25UbZz1xIbJR1PI6UVOMr1XdZ
         LtKU/EVvLYsqgHPeSyNF+5N3ps/DLdMxT06KTxJWEhZYIxx7Rw6jPOi0Zv9AUEXLTlmO
         hOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ndg4DzK5tx5X4El9lZvtof/dcnyIAi2qDb/LCZ6Ys0=;
        b=NZVXzng6QZ9+fcwPpf9oIt/NgnNwu3rl3rCucNl/ysyQx2SRrgrDSPghn+7DsVBUE+
         XCtbjHznOQkjeX5Bw339fy325y2BPp1rf/p65pNYCWI3B+wbBPbnlD+q+ZzBKKljQZuT
         FM4aFORWf5Hkiap0cq7LtOa5MJxnnY3hroASvxnZkeVAZfNcMTD9L3FlCNF8pA4bJ8i+
         t+Q/9GMd8p5R+lSoNdkwnjWInQ2igNLm+taNTqC68iLiMkEAi1MTuhb7zmFaSJ+KjFp8
         sv+2UI5moZ8utrDyPqKNIfMgKn/JI1qUNN8KwIPikZ3zp+gG1i0NJgUFo5E5crwtp0Xp
         knpw==
X-Gm-Message-State: AOAM530he3QcCJJ3C6yavHDuhrvaRkSyV4O0wcb6nOS+E7YGCQNi8KfU
        38OX8KaKXLllZxQcfC3puyvIMLxCj1gcmNYHgWs=
X-Google-Smtp-Source: ABdhPJwaW7DQD9pCC25nbWXZW7HHqX3ZyyapminGKzDUB6t1uIzPcEweoYPD0AH+7ph68psQoapttu5C957/wtHmAOY=
X-Received: by 2002:a17:906:cf81:: with SMTP id um1mr4898352ejb.122.1610621388916;
 Thu, 14 Jan 2021 02:49:48 -0800 (PST)
MIME-Version: 1.0
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
 <1610612968-26612-3-git-send-email-wuht06@gmail.com> <20210114085233.GO4678@unreal>
In-Reply-To: <20210114085233.GO4678@unreal>
From:   Hongtao Wu <wuht06@gmail.com>
Date:   Thu, 14 Jan 2021 18:49:37 +0800
Message-ID: <CAG_R4_WuQMimCKZdj6rpGrxjRT_7NxjxSPd2AxS7r1VRNctTAw@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/2] PCI: sprd: Add support for Unisoc SoCs'
 PCIe controller
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 4:52 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 14, 2021 at 04:29:28PM +0800, Hongtao Wu wrote:
> > From: Hongtao Wu <billows.wu@unisoc.com>
> >
> > This series adds PCIe controller driver for Unisoc SoCs.
> > This controller is based on DesignWare PCIe IP.
> >
> > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  12 ++
> >  drivers/pci/controller/dwc/Makefile    |   1 +
> >  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++++++++++
> >  3 files changed, 306 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
>
> <...>
>
> > +static struct platform_driver sprd_pcie_driver = {
> > +     .probe = sprd_pcie_probe,
> > +     .remove = __exit_p(sprd_pcie_remove),
>                    ^^^^^^ why is that?
>
> > +     .driver = {
> > +             .name = "sprd-pcie",
> > +             .of_match_table = sprd_pcie_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(sprd_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > +MODULE_LICENSE("GPL v2");
>
> I think that it needs to be "GPL" and not "GPL v2".
>
> Thanks

Thanks for the review.
I'll fix it in the next version.

>
> > --
> > 2.7.4
> >
