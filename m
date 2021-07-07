Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752C23BE6FD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGGLVe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 07:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhGGLVd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 07:21:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4904261C88;
        Wed,  7 Jul 2021 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625656733;
        bh=WFxE9mATNj48CuNnGhTUn+U9RiyA/laRYp2AbugPi+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixQqGZTBpI5YHaidaB8LZKWBGxJsZzdxuyO7anyAwFNlJ7W9TnxJD80EYZL/JzcQE
         5qbBCahgc2QxALqeibiN54mDobbIBnTxsAybGPUgXwS1nE/BPF65DiyXU9k3cwKdQw
         wdQTEg5wfJzFe/fVak/97npmFR/WnfdYPhJVXODoBidr1ls+CoKfTFhKbCRH3IKBnn
         vfzuqZPAUDISFu3EPo8/gSJ4IViMN3uaeIDK94FWpwrdkfpukwjJdkttYdqc5fVh43
         kIWgmKBZ17HctAG5wCG3ZVutz/8hiB7+pjDN8wtgtVd0U/VOGcGe9eiZ41eVA8Tk0K
         DN4C8v5KqGTvw==
Date:   Wed, 7 Jul 2021 13:18:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>, linuxarm@huawei.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com
Subject: Re: Possible issue at the kirin-pcie driver
Message-ID: <20210707131848.597bdfe8@coco.lan>
In-Reply-To: <20210707105425.GA10578@workstation>
References: <20210706113503.66091e94@coco.lan>
        <20210707105425.GA10578@workstation>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 7 Jul 2021 16:24:25 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> Hi Mauro,
> 
> On Tue, Jul 06, 2021 at 11:35:03AM +0200, Mauro Carvalho Chehab wrote:
> > Hi,
> > 
> > I was asked by Rob Herring to convert the kiring-pcie driver on two parts,
> > splitting the PHY logic from it, in order to be able to add PHY support 
> > for Hikey 970 at drivers/pci/controller/dwc/pcie-kirin.c.
> > 
> > While doing so, I noticed something weird issue at the driver, with regards
> > to a certain register (PCIE_APB_PHY_STATUS0), as shown below:
> > 
> > ...
> > 
> > 	#define PCIE_APB_PHY_STATUS0	0x400
> > ...
> > 	static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> > 	{
> > 		return readl(kirin_pcie->apb_base + reg);
> > 	}
> > ...
> > 	static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> > 	{
> > 		return readl(kirin_pcie->phy_base + reg);
> > 	}
> > ...
> > 	static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> > 	{
> > ...
> > 		reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
> > 		if (reg_val & PIPE_CLK_STABLE) {
> >                 	dev_err(dev, "PIPE clk is not stable\n");
> > 			return -EINVAL;
> > 		}
> > 	}
> > ...
> > 	static int kirin_pcie_link_up(struct dw_pcie *pci)
> > 	{
> > 		struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> > 		u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
> > 	
> > 		if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
> > 			return 1;
> > 
> > 		return 0;
> > 
> > 		u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
> > 
> > 		if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
> > 			return 1;
> > 
> > Basically, the code at kirin_pcie_phy_init() use this register as if it is 
> > part of the PHY memory region (0xf3f20000 + 0x400), while the code at 
> > kirin_pcie_link_up() considers is as belonging to the APB memory
> > region (0xff3fe000 + 0x400).
> > 
> > It sounds to me that there's a mistake somewhere. I mean, either:
> > 
> > 1. there is a cut-and-paste error, caused it to access the wrong memory
> >    region, e.g. at kirin_pcie_link_up() the logic should be:
> > 
> > 	u32 val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
> > 
> >    instead of:
> > 
> > 	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
> > 
> >    (or the reverse)
> > 
> > 2. Both memory regions have a register at address 0x400 with similar
> >    names that ended being merged into the same macro;
> > 
> > 3. the register for APB PHY status0 is duplicated on both regions and,
> >    on both, they are at region_base + 0x400.
> >  
> 
> I don't have the datasheet for Kirin970 but...
> 
> I think 2 & 3 are the possible ones as I've seen register duplications
> across multiple vendors.

Yeah, it is possible that the register is duplicated on different
regions.

> > I suspect that it is (1), but, as I don't have any datasheets or
> > register map, I can't tell for sure.
> >   
> 
> If it is 1, then I don't think the driver can work reliably.

Looking at discuss.96boards.org, I saw some comments that seem
to indicate that the M.2 slot with NVMe devices is not reliable:
it sounds that it works with some models only, but this could
be due to an old PCIe driver, or to some other problem.

Hard to tell without the datasheets. I'll need to wait for a
NVMe card to arrive here in order to test. It will take a couple
of weeks.

> Anyway, I think you can still move forward with the splitting provided
> that you can access this register in both drivers.

I'm working right now on moving Hikey 970 to PHY as well. It seems
it is doable, although it is trickier, as both the PHY and the PCIe
driver need to access the APB memory region[1]. I'll probably need to
use a named regmap, in order to allow both to access the same
memory region.

[1] kirin970_pcie_natural_cfg() needs that at the PHY driver, while
    kirin_pcie_read_dbi() and kirin_pcie_write_dbi() needs it at the
    PCIe side.

Thanks,
Mauro
