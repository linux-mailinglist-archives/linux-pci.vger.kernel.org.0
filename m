Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9435918EEBF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 05:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgCWEDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 00:03:25 -0400
Received: from mx.socionext.com ([202.248.49.38]:59585 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgCWEDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 00:03:25 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Mar 2020 13:03:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5182C60057;
        Mon, 23 Mar 2020 13:03:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 23 Mar 2020 13:03:23 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B034D1A12AD;
        Mon, 23 Mar 2020 13:03:22 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7646812013D;
        Mon, 23 Mar 2020 13:03:22 +0900 (JST)
Date:   Mon, 23 Mar 2020 13:03:22 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: uniphier: Add UniPhier PCIe endpoint controller support
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20200319170659.GA158868@google.com>
References: <1584604449-13461-3-git-send-email-hayashi.kunihiko@socionext.com> <20200319170659.GA158868@google.com>
Message-Id: <20200323130322.E519.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for your comment.

On Thu, 19 Mar 2020 12:06:59 -0500 <helgaas@kernel.org> wrote:

> On Thu, Mar 19, 2020 at 04:54:09PM +0900, Kunihiko Hayashi wrote:
> > This introduces specific glue layer for UniPhier platform to support
> > PCIe controller that is based on the DesignWare PCIe core, and
> > this driver supports endpoint mode. This supports for Pro5 SoC only.
> 
> Possible alternate text: ("specific glue layer" isn't the usual way to
> describe a driver)
> 
>   PCI: uniphier: Add Socionext UniPhier Pro5 SoC endpoint controller driver
> 
>   Add driver for the Socionext UniPhier Pro5 SoC endpoint controller.
>   This controller is based on the DesignWare PCIe core.

I see. I'll accept your suggestion for the commit log.

> > +/* assertion time of intx in usec */
> 
> s/intx/INTx/ to match usage in spec (and in comments below :))

Certainly this isn't unified. I'll fix it.

> > +#define PCL_INTX_WIDTH_USEC		30
> 
> > +struct uniphier_pcie_ep_soc_data {
> > +	bool is_legacy;
> 
> I'd prefer "unsigned int is_legacy:1".  See [1].
> 
> But AFAICT you actually don't need this at all (yet), since you only
> have a single of_device_id, and it sets "is_legacy = true".  That
> means the *not* legacy code is effectively dead and hasn't been
> tested.

Yes.
Now I know the difference about between legacy and non-legacy SoC,
however, currently the driver doesn't have any non-legacy SoC support.

> My preference would be to add "is_legacy" and the associated tests
> when you actually *need* them, i.e., when you add support for a
> non-legacy device.

Agreed. The test for non-legacy SoC is necessary.
So I'll remove 'is_legacy' and related coded, and rewrite this driver
to support only legacy device.

And I'll remember [1] when adding non-legacy support.

> > +static int uniphier_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	/* assert INTx */
> > +	val = readl(priv->base + PCL_APP_INTX);
> > +	val |= PCL_APP_INTX_SYS_INT;
> > +	writel(val, priv->base + PCL_APP_INTX);
> > +
> > +	udelay(PCL_INTX_WIDTH_USEC);
> > +
> > +	/* deassert INTx */
> > +	val = readl(priv->base + PCL_APP_INTX);
> 
> Why do you need to read PCL_APP_INTX again here?

Indeed. This 'readl' isn't unnecessary.

> > +	val &= ~PCL_APP_INTX_SYS_INT;
> > +	writel(val, priv->base + PCL_APP_INTX);
> > +
> > +	return 0;
> > +}
> 
> > +	ret = dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to initialize endpoint (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> This is equivalent to:
> 
>   ret = dw_pcie_ep_init(ep);
>   if (ret)
>     dev_err(dev, "Failed to initialize endpoint (%d)\n", ret);
> 
>   return ret;

Agreed. I'll rewrite it next.

> 
> > +}
> 
> [1] https://lore.kernel.org/linux-fsdevel/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com/

Thank you,

---
Best Regards,
Kunihiko Hayashi

