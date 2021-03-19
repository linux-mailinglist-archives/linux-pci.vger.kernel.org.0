Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67F341440
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 05:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhCSEiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 00:38:10 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:42521 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCSEiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 00:38:02 -0400
Received: by mail-ed1-f48.google.com with SMTP id l18so1043258edc.9;
        Thu, 18 Mar 2021 21:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JBj2UN2uQeOtTh3wtXdg/hjMvqwljwZZ1QrLxONTaQo=;
        b=LrwhLsSTdL/FLCb26VdAWTjhxdTmIEFMA0a0vtyjClf6LjkFPJw+/Aw19F40P8jzbL
         UN7idIbAIsel1qL43Qe1BKl55NDjmnKJlS8RULtNs8vlU+7wcjlNRLc7CNZjAM8BqW9x
         PfnGRuODh0dxQ+VVy6tOMeALD5T/mKE4RtaLd/sWZohZVzKmm+pjBLScZiQQZhjkp8lY
         60UjCtWwqrLeNT03NXFPJj2uA0HhkY02Lkps10pZo9ENi1/E+BAhDBotcbQ/7tjdwSUI
         9QrD2l/rtDeZoJ37D4iX3w+/bY5uv5y64J2UjcWi0ecdWfEOIOp5VgFbJikdd0vSpw/p
         XR+w==
X-Gm-Message-State: AOAM533Z8OUlHwqgnZIBakH251eXu21d7sjxC1OsDUc/nehOdQDXnwVM
        h7HmiDZGKe+UxNSo4yedLPQ=
X-Google-Smtp-Source: ABdhPJz63lSyBqfKhnaTLrwU10m6AdwJSQqRVOX+01TzOi9uwdOBbDXQoiwlpZ7vAZkBK52YUPlzXA==
X-Received: by 2002:aa7:d1cd:: with SMTP id g13mr7400468edp.369.1616128680675;
        Thu, 18 Mar 2021 21:38:00 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r4sm3027217ejd.125.2021.03.18.21.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:38:00 -0700 (PDT)
Date:   Fri, 19 Mar 2021 05:37:58 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH v2 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <YFQqpojmJyX0l6lx@rocinante>
References: <cover.1615954045.git.greentime.hu@sifive.com>
 <27f491c113e1bb369d25aca02571b34422986142.1615954046.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27f491c113e1bb369d25aca02571b34422986142.1615954046.git.greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> +static void fu740_phyregwrite(const uint8_t phy, const uint16_t addr,
> +			      const uint16_t wrdata, struct fu740_pcie *afp)
> +{
> +	struct device *dev = afp->pci.dev;
> +	void __iomem *phy_cr_para_addr;
> +	void __iomem *phy_cr_para_wr_data;
> +	void __iomem *phy_cr_para_wr_en;
> +	void __iomem *phy_cr_para_ack;
> +	int ret, val;
> +
> +	/* Setup */
> +	if (phy) {
> +		phy_cr_para_addr = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ADDR;
> +		phy_cr_para_wr_data = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_DATA;
> +		phy_cr_para_wr_en = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_EN;
> +		phy_cr_para_ack = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ACK;
> +	} else {
> +		phy_cr_para_addr = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ADDR;
> +		phy_cr_para_wr_data = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_DATA;
> +		phy_cr_para_wr_en = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_EN;
> +		phy_cr_para_ack = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ACK;
> +	}
> +
> +	writel_relaxed(addr, phy_cr_para_addr);
> +	writel_relaxed(wrdata, phy_cr_para_wr_data);
> +	writel_relaxed(1, phy_cr_para_wr_en);
> +
> +	/* Wait for wait_idle */
> +	ret = readl_poll_timeout(phy_cr_para_ack, val, val, 10, 5000);
> +	if (ret)
> +		dev_err(dev, "Wait for wait_ilde state failed!\n");

It would be "wait_idle" rather than "wait_idle".

[...]
> +	/* Wait for ~wait_idle */
> +	ret = readl_poll_timeout(phy_cr_para_ack, val, !val, 10, 5000);
> +	if (ret)
> +		dev_err(dev, "Wait for !wait_ilde state failed!\n");
[...]

Same as above, it would be "wait_idle" in the above.

> +static void fu740_pcie_ltssm_enable(struct device *dev)
> +{
> +	struct fu740_pcie *afp = dev_get_drvdata(dev);
> +
> +	/* Enable LTSSM */
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
> +}
> +
> +static int fu740_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +
> +	/* Start LTSSM. */

Nitpick.  No need for a dot in this comment to keep it consistent with
the comment in the function above this one.

> +static int fu740_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct fu740_pcie *afp = to_fu740_pcie(pci);
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	/* Power on reset */
> +	fu740_pcie_drive_perstn(afp);
> +
> +	/* Enable pcieauxclk */
> +	ret = clk_prepare_enable(afp->pcie_aux);
> +	if (ret)
> +		dev_err(dev, "unable to enable pcie_aux clock\n");
> +
> +	/*
> +	 * Assert hold_phy_rst (hold the controller LTSSM in reset after
> +	 * power_up_rst_n for register programming with cr_para)
> +	 */
> +	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
> +
> +	/* Deassert power_up_rst_n */
> +	ret = reset_control_deassert(afp->rst);
> +	if (ret)
> +		dev_err(dev, "unable to deassert pcie_power_up_rst_n\n");
> +
> +	fu740_pcie_init_phy(afp);
> +
> +	/* Disable pcieauxclk */
> +	clk_disable_unprepare(afp->pcie_aux);
> +	/* Clear hold_phy_rst */
> +	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
> +	/* Enable pcieauxclk */
> +	ret = clk_prepare_enable(afp->pcie_aux);
> +	/* Set RC mode */
> +	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);
> +
> +	return 0;
> +}
[...]

It seems that the error handling is somewhat broken in the above
function, especially when you look at how the "ret" variables does not
seem to be used for anything once there was an error.

Krzysztof
