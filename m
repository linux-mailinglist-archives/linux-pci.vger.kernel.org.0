Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929513655A6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhDTJoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 05:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhDTJoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 05:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AF81610A1;
        Tue, 20 Apr 2021 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618911845;
        bh=amcldydssZ0SAWDeOp2/A7nVn5OVi/p4nIOw88gtbDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3faew728/ChhgCkd8dNWeWMB0T1xKZYqaoqNMLcvCxqfDeUfRVR6zNi7N0nMT5ov
         MrRKcW6YiniUq6RIRzGKEMWVooLThhb5HN26QqqsWKEwaJ0FASGRjorxYYiJ65hTEM
         HIKN70JWTC/YekCAqVvRPMOBkqi5Gm4TV7tFDeF8LLQaA3oOcyfXhYVNvXKWUYQe03
         GwfD+mMjjV/W6WZMVT5Dfv3ozFv3/ezvTSipYhKPFYOkym8R64SF7De+TvDp2WK2my
         56Wdp0FOI48/IXJ/wl2q0ridBMq4nx+fT0Ltyl/KpvkoAxmPQQj5iwWNRxFwDZu+A+
         IosE53sPB3P0Q==
Received: by pali.im (Postfix)
        id 849A4A2D; Tue, 20 Apr 2021 11:44:02 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:44:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>
Subject: Re: [PATCH v10 5/7] PCI: mediatek-gen3: Add MSI support
Message-ID: <20210420094402.hwdkbspl5wu4rtex@pali>
References: <20210420061723.989-1-jianjun.wang@mediatek.com>
 <20210420061723.989-6-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420061723.989-6-jianjun.wang@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 20 April 2021 14:17:21 Jianjun Wang wrote:
> +static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> +{
> +	int i;
> +	u32 val;
> +
> +	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
> +		struct mtk_msi_set *msi_set = &port->msi_sets[i];
> +
> +		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
> +				i * PCIE_MSI_SET_OFFSET;
> +		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
> +				    i * PCIE_MSI_SET_OFFSET;
> +
> +		/* Configure the MSI capture address */
> +		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
> +		writel_relaxed(upper_32_bits(msi_set->msg_addr),
> +			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
> +			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);

This looks like as setting MSI doorbell address to MSI doorbell address.

> +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
> +	struct mtk_pcie_port *port = data->domain->host_data;
> +	unsigned long hwirq;
> +
> +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
> +
> +	msg->address_hi = upper_32_bits(msi_set->msg_addr);
> +	msg->address_lo = lower_32_bits(msi_set->msg_addr);
> +	msg->data = hwirq;
> +	dev_dbg(port->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
> +		hwirq, msg->address_hi, msg->address_lo, msg->data);

... which is later used in compose_msi_msg().

Marc in some other patches for other pci controller drivers changed this
address to just main "port" structure. It simplified implementations and
also avoided need to declare additional member "msg_addr".

Marc, would it be possible to simplify it also for this driver and just
set msg_addr to virt_to_phys(port)?
