Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64F1336856
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCKAG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhCKAF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 19:05:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC3064E33;
        Thu, 11 Mar 2021 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615421158;
        bh=iFxVJgMoDpJ44jsE4Fuo7YkLXTeRvt9qHwXirR8S6SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHbUatCvju/H17C/5K/sXqE3GC74q+fVaVWePgzCGPEelm8i6fAHWz7kps59DplLz
         rl8g4mlo7ESlnxn/xVc/ow7B1sTyAa92MPRjY/MNPbjODF0ndY5jAMoWs9UhvruzzF
         pbRgOgVPXwajI2R6qhkbtG469UMo5Vt3Conr7vGybjMfgOyMsHqGydidarB/nUqtte
         x4bln9KOuq+PyFRDgZ1vH3TCOzJ92D9mEtph5qIxTfFsaDe9ZqyixECTwwRCaB0ise
         0Vc2O5Xib/wPG/mDsEVfXTteHQGUWLD2sx6M0MVavI3kUxpsoSFPiecKAXA5hEMwgY
         qOpr7+u2Ha48Q==
Received: by pali.im (Postfix)
        id 00BD9A83; Thu, 11 Mar 2021 01:05:55 +0100 (CET)
Date:   Thu, 11 Mar 2021 01:05:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,5/7] PCI: mediatek-gen3: Add MSI support
Message-ID: <20210311000555.epypouwxdbql2aqx@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-6-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-6-jianjun.wang@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 24 February 2021 14:11:30 Jianjun Wang wrote:
> +static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs,
> +				       void *arg)
> +{
> +	struct mtk_pcie_port *port = domain->host_data;
> +	struct mtk_msi_set *msi_set;
> +	int i, hwirq, set_idx;
> +
> +	mutex_lock(&port->lock);
> +
> +	hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
> +					order_base_2(nr_irqs));
> +
> +	mutex_unlock(&port->lock);
> +
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
> +	set_idx = hwirq / PCIE_MSI_IRQS_PER_SET;
> +	msi_set = &port->msi_sets[set_idx];
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &mtk_msi_bottom_irq_chip, msi_set,
> +				    handle_edge_irq, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static void mtk_msi_bottom_domain_free(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct mtk_pcie_port *port = domain->host_data;
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +
> +	mutex_lock(&port->lock);
> +
> +	bitmap_clear(port->msi_irq_in_use, data->hwirq, nr_irqs);

Marc, should not be there bitmap_release_region() with order_base_2()?

bitmap_release_region(port->msi_irq_in_use, data->hwirq, order_base_2(nr_irqs));

Because mtk_msi_bottom_domain_alloc() is allocating
order_base_2(nr_irqs) interrupts, not only nr_irqs.

> +
> +	mutex_unlock(&port->lock);
> +
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +}
