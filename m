Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C72E0532
	for <lists+linux-pci@lfdr.de>; Tue, 22 Dec 2020 04:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgLVD4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 22:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgLVD4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 22:56:40 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBCC061793
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2020 19:55:59 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x4so6364987vsp.7
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2020 19:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBdY+iGV2k1HyD2s2ItPRsC+/Ij4zOZsTARmabtWF14=;
        b=BEtMAK/Ln7aSQYZB3kzWI2QxXg3ZjJTwvkkPaJIi8TiAvqmropOMZ2PHYAhx7rJzki
         TlQGDs5l4Ngxi5eZ3K6mHDk7R5TIpMvxlnOWsdiA6wkNUiKMvFSVF9/fkj1lzGerCq/0
         IPTWf4AApotLJTiBuuxr/E+GW0Eat60kG2B6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBdY+iGV2k1HyD2s2ItPRsC+/Ij4zOZsTARmabtWF14=;
        b=fAbvUbgUV9iBeJC6EnFvRrptfJPdKySsjmEQji+Azs3BOnwn7bH57x4bmoQ8DdZtsV
         OZpreAF1GbOZEeQq1czHiNrmyrpK++h2mbfx42+KgadHONqRWw7euv11kxuyf06Zu5G5
         W7ycGutdTUX5QvKrbu0PDFSW+0oidPe5PO/h2lHWZi6hIZmZwJAPwJr8w7Wq2mHH7gWM
         7sCKY2XkDHBdL2+ETwrA80Lhks5DLaq0PQ9wUPqHm9cRJnz8FyfZ/eRFVWrSTDuFWBAS
         ojiGxv/isRwogtyS7L1O6yeTI9TQrl/W4GEtH8sBLmmd93XCFZiK+7lxDhsQtP1dK5uy
         u+hQ==
X-Gm-Message-State: AOAM531r6aTTBcX3QvS2Xs0DBt43ZvMOn7uu3iUwu66TqyM/BHORUj2y
        iaRahndWuUfRCM0uVcFE8YvS5PCQJVdQBtpT8QPCTA==
X-Google-Smtp-Source: ABdhPJzZ0hdnkwXJgJV2+C+Ef3YdVvAN8t9K9JjReqGbKUR1SNJ3k+OtA3Skw19bt8acyhLtegwBYiZy1L1X2Z295M8=
X-Received: by 2002:a67:6182:: with SMTP id v124mr14263455vsb.16.1608609358592;
 Mon, 21 Dec 2020 19:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20201202133813.6917-1-jianjun.wang@mediatek.com>
 <20201202133813.6917-3-jianjun.wang@mediatek.com> <CANMq1KCSWf4PDMVhxFiLHOHe3dFqZbq1gzn4ph8aApVMX56MDg@mail.gmail.com>
 <1608608319.14736.97.camel@mhfsdcap03>
In-Reply-To: <1608608319.14736.97.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 22 Dec 2020 11:55:47 +0800
Message-ID: <CANMq1KB3UXg8QKwuv3mFaodx-s_AXSrOWp6C+RN7LaA69nsTyg@mail.gmail.com>
Subject: Re: [v5,2/3] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     youlin.pei@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        qizhong.cheng@mediatek.com,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sj Huang <sj.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, sin_jieyang@mediatek.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 22, 2020 at 11:38 AM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> On Mon, 2020-12-21 at 10:18 +0800, Nicolas Boichat wrote:
> > On Wed, Dec 2, 2020 at 9:39 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
> > > [snip]
> > > +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> > > +                                             msi_alloc_info_t *arg)
> > > +{
> > > +       struct msi_desc *entry = arg->desc;
> > > +       struct mtk_pcie_port *port = info->chip_data;
> > > +       int hwirq;
> > > +
> > > +       mutex_lock(&port->lock);
> > > +
> > > +       hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
> > > +                                       order_base_2(entry->nvec_used));
> > > +       if (hwirq < 0) {
> > > +               mutex_unlock(&port->lock);
> > > +               return -ENOSPC;
> > > +       }
> > > +
> > > +       mutex_unlock(&port->lock);
> > > +
> > > +       return hwirq;
> >
> > Code is good, but I had to look twice to make sure the mutex is
> > unlocked. Is the following marginally better?
> >
> > hwirq = ...;
> >
> > mutex_unlock(&port->lock);
> >
> > if (hwirq < 0)
> >    return -ENOSPC;
> >
> > return hwirq;
>
> Impressive, I will fix it in the next version, and I think the hwirq can
> be returned directly since it will be a negative value if
> bitmap_find_free_region is failed. The code will be like the following:
>
> hwirq = ...;
>
> mutex_unlock(&port->lock);
>
> return hwirq;

SG, as long as you're okay with returning -ENOMEM instead of -ENOSPC.

But now I'm having doubt if negative return values are ok, as
irq_hw_number_t is unsigned long.

msi_domain_alloc
(https://elixir.bootlin.com/linux/latest/source/kernel/irq/msi.c#L143)
uses it to call irq_find_mapping
(https://elixir.bootlin.com/linux/latest/source/kernel/irq/irqdomain.c#L882)
without check, and I'm not convinced irq_find_mapping will error out
gracefully...

> >
> > > +}
> > > +
> > > [snip]
> > > +static void mtk_pcie_msi_handler(struct irq_desc *desc)
> > > +{
> > > +       struct mtk_pcie_msi *msi_info = irq_desc_get_handler_data(desc);
> > > +       struct irq_chip *irqchip = irq_desc_get_chip(desc);
> > > +       unsigned long msi_enable, msi_status;
> > > +       unsigned int virq;
> > > +       irq_hw_number_t bit, hwirq;
> > > +
> > > +       chained_irq_enter(irqchip, desc);
> > > +
> > > +       msi_enable = readl(msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> > > +       while ((msi_status = readl(msi_info->base + PCIE_MSI_STATUS_OFFSET))) {
> > > +               msi_status &= msi_enable;
> >
> > I don't know much about MSI, but what happens if you have a bit that
> > is set in PCIE_MSI_STATUS_OFFSET register, but not in msi_enable?
>
> If the bit that in PCIE_MSI_STATUS_OFFSET register is set but not in
> msi_enable, it must be an abnormal usage of MSI or something goes wrong,
> it should be ignored in case we can not find the corresponding handler.
>
> > Sounds like you'll just spin-loop forever without acknowledging the
> > interrupt.
>
> The interrupt will be acknowledged in the irq_ack callback of
> mtk_msi_irq_chip, which belongs to the msi_domain.

Let's try to go through it (and please explain to me if I get this wrong).

Say we have:

msi_enable = [PCIE_MSI_ENABLE_OFFSET] = 0x1;

while loop:

msi_status = [PCIE_MSI_STATUS_OFFSET] = 0x3;
msi_status &= msi_enable => msi_status = 0x3 & 0x1 = 0x1;
for_each_set_bit(msi_status) {
   do something that presumably will disable the MSI interrupt status?
}
(next loop iteration)

msi_status = [PCIE_MSI_STATUS_OFFSET] = 0x2;
msi_status &= msi_enable => msi_status = 0x2 & 0x1 = 0x0;
for_each_set_bit(msi_status) => does nothing.

msi_status = [PCIE_MSI_STATUS_OFFSET] = 0x2;
(infinite loop)

Basically, I'm wondering if you should replace the while condition
statement with:

while ((msi_status = readl(msi_info->base + PCIE_MSI_STATUS_OFFSET) &
msi_enable))
