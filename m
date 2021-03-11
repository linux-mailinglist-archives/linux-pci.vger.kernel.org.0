Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE40336DAC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCKITx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 03:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhCKITW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 03:19:22 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411B164EAE;
        Thu, 11 Mar 2021 08:19:21 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lKGXO-000waf-MQ; Thu, 11 Mar 2021 08:19:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 11 Mar 2021 08:19:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
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
In-Reply-To: <20210311000555.epypouwxdbql2aqx@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-6-jianjun.wang@mediatek.com>
 <20210311000555.epypouwxdbql2aqx@pali>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e6c53aa3863c3f5b0560ed65282fc5e2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pali@kernel.org, jianjun.wang@mediatek.com, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, ryder.lee@mediatek.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sj.huang@mediatek.com, youlin.pei@mediatek.com, chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com, sin_jieyang@mediatek.com, drinkcat@chromium.org, Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-11 00:05, Pali Rohár wrote:
> On Wednesday 24 February 2021 14:11:30 Jianjun Wang wrote:
>> +static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
>> +				       unsigned int virq, unsigned int nr_irqs,
>> +				       void *arg)
>> +{
>> +	struct mtk_pcie_port *port = domain->host_data;
>> +	struct mtk_msi_set *msi_set;
>> +	int i, hwirq, set_idx;
>> +
>> +	mutex_lock(&port->lock);
>> +
>> +	hwirq = bitmap_find_free_region(port->msi_irq_in_use, 
>> PCIE_MSI_IRQS_NUM,
>> +					order_base_2(nr_irqs));
>> +
>> +	mutex_unlock(&port->lock);
>> +
>> +	if (hwirq < 0)
>> +		return -ENOSPC;
>> +
>> +	set_idx = hwirq / PCIE_MSI_IRQS_PER_SET;
>> +	msi_set = &port->msi_sets[set_idx];
>> +
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_info(domain, virq + i, hwirq + i,
>> +				    &mtk_msi_bottom_irq_chip, msi_set,
>> +				    handle_edge_irq, NULL, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mtk_msi_bottom_domain_free(struct irq_domain *domain,
>> +				       unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	struct mtk_pcie_port *port = domain->host_data;
>> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
>> +
>> +	mutex_lock(&port->lock);
>> +
>> +	bitmap_clear(port->msi_irq_in_use, data->hwirq, nr_irqs);
> 
> Marc, should not be there bitmap_release_region() with order_base_2()?
> 
> bitmap_release_region(port->msi_irq_in_use, data->hwirq, 
> order_base_2(nr_irqs));
> 
> Because mtk_msi_bottom_domain_alloc() is allocating
> order_base_2(nr_irqs) interrupts, not only nr_irqs.

Indeed, good catch.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
