Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25E365729
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhDTLJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhDTLJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1D86135F;
        Tue, 20 Apr 2021 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618916914;
        bh=tXNrVitqe9y0c4Nre12+HdYi0aoTIvIA9p8ok75STd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJT5uKEZWaLIAkjrQec3Kjt2ltJrVRIvQG7xBxcfY2hLdBOPOQ7Khc8DHxndVE+Na
         5IM+xOPitZ7Fk0NrjEc8Ij23WEXGyh7E//elp6fExjfi0KEVKiDoAVLkUt3NQAOH2+
         82zHkS4yWt6w/11jtKN6cKbgNOdIXh51BbOmGg+MgUwIIMq0kgdpq+zSs+AzkPGb/P
         SDfyjb7U20ih6qyOKSgiPvX6c5AWZdJceGc7DvYka5aIBkzeJreqJC8Hauvh2nFPQo
         Tzc8Tfy6uyHuIr7BJ803PdhZ8SKiMiOi1Gxfs03cpOtBRvpCMa+7NpUXskc+xDadSL
         /5i1hOiMnEq/Q==
Received: by pali.im (Postfix)
        id 31C55A2D; Tue, 20 Apr 2021 13:08:32 +0200 (CEST)
Date:   Tue, 20 Apr 2021 13:08:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20210420110832.iyjck2m2s5jlit26@pali>
References: <20210420061723.989-1-jianjun.wang@mediatek.com>
 <20210420061723.989-6-jianjun.wang@mediatek.com>
 <20210420094402.hwdkbspl5wu4rtex@pali>
 <87bla9qky1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bla9qky1.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 20 April 2021 12:01:10 Marc Zyngier wrote:
> On Tue, 20 Apr 2021 10:44:02 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > Hello!
> > 
> > On Tuesday 20 April 2021 14:17:21 Jianjun Wang wrote:
> > > +static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > > +{
> > > +	int i;
> > > +	u32 val;
> > > +
> > > +	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
> > > +		struct mtk_msi_set *msi_set = &port->msi_sets[i];
> > > +
> > > +		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
> > > +				i * PCIE_MSI_SET_OFFSET;
> > > +		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
> > > +				    i * PCIE_MSI_SET_OFFSET;
> > > +
> > > +		/* Configure the MSI capture address */
> > > +		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
> > > +		writel_relaxed(upper_32_bits(msi_set->msg_addr),
> > > +			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
> > > +			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
> > 
> > This looks like as setting MSI doorbell address to MSI doorbell address.
> > 
> > > +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > > +{
> > > +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
> > > +	struct mtk_pcie_port *port = data->domain->host_data;
> > > +	unsigned long hwirq;
> > > +
> > > +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
> > > +
> > > +	msg->address_hi = upper_32_bits(msi_set->msg_addr);
> > > +	msg->address_lo = lower_32_bits(msi_set->msg_addr);
> > > +	msg->data = hwirq;
> > > +	dev_dbg(port->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
> > > +		hwirq, msg->address_hi, msg->address_lo, msg->data);
> > 
> > ... which is later used in compose_msi_msg().
> > 
> > Marc in some other patches for other pci controller drivers changed this
> > address to just main "port" structure. It simplified implementations and
> > also avoided need to declare additional member "msg_addr".
> > 
> > Marc, would it be possible to simplify it also for this driver and just
> > set msg_addr to virt_to_phys(port)?
> 
> Maybe. It really depends on what range the HW accepts, and the sole
> requirement is to use an address that the endpoint cannot DMA
> to. Here, the driver seems to be using something based on the port
> base address, which is good enough as far as I am concerned (the thing
> I usually object to is the allocation of memory just for the sake of
> getting a capture address).
> 
> If you want to further simplify it, you could simply use port.reg_base
> as the MSI address for all sets, as I don't think they have to be
> distinct. But someone with access to the TRM for this should go and
> check it.
> 
> I don't believe this should gate the merging od this driver though.

Of course! I'm just asking details to understand best practises and how
it works. So thanks for information!

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
