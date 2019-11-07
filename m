Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304A6F2DBC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfKGLwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 06:52:42 -0500
Received: from mx.socionext.com ([202.248.49.38]:58147 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfKGLwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 06:52:42 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2019 20:52:40 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 11A78605F8;
        Thu,  7 Nov 2019 20:52:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Nov 2019 20:52:50 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D23A61A04FC;
        Thu,  7 Nov 2019 20:52:39 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A4AD7120C15;
        Thu,  7 Nov 2019 20:52:39 +0900 (JST)
Date:   Thu, 07 Nov 2019 20:52:39 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is deasserted
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20191107100207.GV9723@e119886-lin.cambridge.arm.com>
References: <1573102695-7018-2-git-send-email-hayashi.kunihiko@socionext.com> <20191107100207.GV9723@e119886-lin.cambridge.arm.com>
Message-Id: <20191107205239.65C1.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,
Thank you for your comments.

On Thu, 7 Nov 2019 10:02:08 +0000 <andrew.murray@arm.com> wrote:

> On Thu, Nov 07, 2019 at 01:58:15PM +0900, Kunihiko Hayashi wrote:
> > When PERST# is asserted once, EP configuration will be initialized.
> 
> I don't quite understand this - does the EP/RC mode depend on how often
> PERST# is toggled?

I think of connecting this RC controller and EP based on `Linux PCI
endpoint framework' in another machine.

While this RC driver is probing, the EP driver might be also probing and
configurating itself using configfs. If PERST# is toggled after the EP
has done its configuration, this configuration will be lost.

I expect that the EP configurates after RC has toggled PERST#, however,
there is no way to synchronize both of them.


> 
> > If PERST# has been already deasserted, it isn't necessary to assert
> > here.
> 
> What is the motativation for this patch? Is it to avoid a delay during
> boot, or to fix some bug? Isn't it nice to always reset the IP before
> use anyway?

Since EP device usually works without its configuration after PERST#,
deassering PERST# here is no problem. Since bus reset breaks configuration
of EP as shown above, bus reset should be done before EP has probed.
Maybe boot sequence in host machine will do.


>
> > 
> > This checks whether PERST# is deasserted using PCL_PINMON register,
> > and adds omit controlling PERST#.
> 
> Should this read 'and omits controlling PERST#'?

Yes, I'll fix it.


> 
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > index 8fd7bad..1ea4220 100644
> > --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > @@ -22,6 +22,9 @@
> >  
> >  #include "pcie-designware.h"
> >  
> > +#define PCL_PINMON			0x0028
> > +#define PCL_PINMON_PERST_OUT		BIT(16)
> > +
> >  #define PCL_PINCTRL0			0x002c
> >  #define PCL_PERST_PLDN_REGEN		BIT(12)
> >  #define PCL_PERST_NOE_REGEN		BIT(11)
> > @@ -100,6 +103,11 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
> >  	val |= PCL_SYS_AUX_PWR_DET;
> >  	writel(val, priv->base + PCL_APP_PM0);
> >  
> > +	/* return if PERST# is already deasserted */
> 
> This comment just describes what the following line does which may be
> self-explanatory, perhaps a better comment would describe why we avoid
> a reset.

Indeed. I'll write the reason here.

Thank you,

---
Best Regards,
Kunihiko Hayashi

