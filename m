Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E318BD88
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgCSRHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 13:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgCSRHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 13:07:02 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D4C2072D;
        Thu, 19 Mar 2020 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584637621;
        bh=NdR6LVZ2cIsGAen/1ujzdrUs8tOtmmAvYQrgY/mLbXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fAsoMHdZ+CYuM4c3hgzSAXhoiZ3xbVbN8s2cz7P9jqZcY1HB2yJCvRtzAv8IouYHO
         LC3dp3VGJ75UAMS0WzOgKBLBc3qum4Xg8DyXU67qvbSw9FVQNq+jdccLoJUC4cY0Oe
         POScnOpP9mVL6PMYpSsyL0K3elHJk1q6Tes9R0s8=
Date:   Thu, 19 Mar 2020 12:06:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 2/2] PCI: uniphier: Add UniPhier PCIe endpoint
 controller support
Message-ID: <20200319170659.GA158868@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584604449-13461-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 19, 2020 at 04:54:09PM +0900, Kunihiko Hayashi wrote:
> This introduces specific glue layer for UniPhier platform to support
> PCIe controller that is based on the DesignWare PCIe core, and
> this driver supports endpoint mode. This supports for Pro5 SoC only.

Possible alternate text: ("specific glue layer" isn't the usual way to
describe a driver)

  PCI: uniphier: Add Socionext UniPhier Pro5 SoC endpoint controller driver

  Add driver for the Socionext UniPhier Pro5 SoC endpoint controller.
  This controller is based on the DesignWare PCIe core.

> +/* assertion time of intx in usec */

s/intx/INTx/ to match usage in spec (and in comments below :))

> +#define PCL_INTX_WIDTH_USEC		30

> +struct uniphier_pcie_ep_soc_data {
> +	bool is_legacy;

I'd prefer "unsigned int is_legacy:1".  See [1].

But AFAICT you actually don't need this at all (yet), since you only
have a single of_device_id, and it sets "is_legacy = true".  That
means the *not* legacy code is effectively dead and hasn't been
tested.

My preference would be to add "is_legacy" and the associated tests
when you actually *need* them, i.e., when you add support for a
non-legacy device.

> +static int uniphier_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
> +	u32 val;
> +
> +	/* assert INTx */
> +	val = readl(priv->base + PCL_APP_INTX);
> +	val |= PCL_APP_INTX_SYS_INT;
> +	writel(val, priv->base + PCL_APP_INTX);
> +
> +	udelay(PCL_INTX_WIDTH_USEC);
> +
> +	/* deassert INTx */
> +	val = readl(priv->base + PCL_APP_INTX);

Why do you need to read PCL_APP_INTX again here?

> +	val &= ~PCL_APP_INTX_SYS_INT;
> +	writel(val, priv->base + PCL_APP_INTX);
> +
> +	return 0;
> +}

> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;

This is equivalent to:

  ret = dw_pcie_ep_init(ep);
  if (ret)
    dev_err(dev, "Failed to initialize endpoint (%d)\n", ret);

  return ret;

> +}

[1] https://lore.kernel.org/linux-fsdevel/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com/
