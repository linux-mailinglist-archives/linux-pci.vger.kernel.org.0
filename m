Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693803BC88A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGFJht (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 05:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhGFJhs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 05:37:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4310061208;
        Tue,  6 Jul 2021 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625564110;
        bh=mQbkEf+ed0hVXdTImvG+dp6bEhg44Im5KM3W9AhPp3E=;
        h=Date:From:To:Cc:Subject:From;
        b=O8NktNF+kNCqJCzfOQluTZJcDj0kPCTMiWWkBdkkmVotyDcVQh74zKw/zdYyfTzPY
         8mYyhCEXjKSk0Ijr+z38h5EO3/RnCNA6UdMeHu5EHUSGpjAoaQ918nqkIF+hBSvHr7
         +9QvK4zUaOtwHpU5nQ23nSGjSvUej9K7TdAaWS1P+XgL9u1NSStnPZRJbCpDo8WDb3
         u6n6Ks28odV9ttXfoMAqPEuysgRAtZu6Wmvj7J5ek7jAqL5/Jn5UkaY4SBnId2YyYJ
         lOIByvzJkzj8rv1oLuSyc0d6VuGv/Kl522Gsjmi5/Qtux2/smRmfAjFq6GO0Yv6xYn
         lHU204HvTb1fQ==
Date:   Tue, 6 Jul 2021 11:35:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>, linuxarm@huawei.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com
Subject: Possible issue at the kirin-pcie driver
Message-ID: <20210706113503.66091e94@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I was asked by Rob Herring to convert the kiring-pcie driver on two parts,
splitting the PHY logic from it, in order to be able to add PHY support 
for Hikey 970 at drivers/pci/controller/dwc/pcie-kirin.c.

While doing so, I noticed something weird issue at the driver, with regards
to a certain register (PCIE_APB_PHY_STATUS0), as shown below:

...

	#define PCIE_APB_PHY_STATUS0	0x400
...
	static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
	{
		return readl(kirin_pcie->apb_base + reg);
	}
...
	static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie, u32 reg)
	{
		return readl(kirin_pcie->phy_base + reg);
	}
...
	static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
	{
...
		reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
		if (reg_val & PIPE_CLK_STABLE) {
                	dev_err(dev, "PIPE clk is not stable\n");
			return -EINVAL;
		}
	}
...
	static int kirin_pcie_link_up(struct dw_pcie *pci)
	{
		struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
		u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
	
		if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
			return 1;

		return 0;

		u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);

		if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
			return 1;

Basically, the code at kirin_pcie_phy_init() use this register as if it is 
part of the PHY memory region (0xf3f20000 + 0x400), while the code at 
kirin_pcie_link_up() considers is as belonging to the APB memory
region (0xff3fe000 + 0x400).

It sounds to me that there's a mistake somewhere. I mean, either:

1. there is a cut-and-paste error, caused it to access the wrong memory
   region, e.g. at kirin_pcie_link_up() the logic should be:

	u32 val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);

   instead of:

	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);

   (or the reverse)

2. Both memory regions have a register at address 0x400 with similar
   names that ended being merged into the same macro;

3. the register for APB PHY status0 is duplicated on both regions and,
   on both, they are at region_base + 0x400.

I suspect that it is (1), but, as I don't have any datasheets or
register map, I can't tell for sure.

Could someone with access to the datahseets shed the light?

Thanks,
Mauro
