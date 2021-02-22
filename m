Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E42321015
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 05:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVE6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 23:58:20 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:44376 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBVE6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 23:58:19 -0500
Received: from localhost (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id 92E8D1D4E;
        Mon, 22 Feb 2021 12:52:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31654T140708696835840S1613969534586218_;
        Mon, 22 Feb 2021 12:52:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2a94f6a5a32cf46005af8d15dccf1c05>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: shawn.lin@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_2/2=5d_PCI=3a_rockchip=3a_add_DesignWar?=
 =?UTF-8?B?ZSBiYXNlZCBQQ0llIGNvbnRyb2xsZXLjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFr?=
 =?UTF-8?B?c3dpbGN6eW5za2lAZ21haWwuY29t5Luj5Y+R44CR?=
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20210127022406.820975-1-xxm@rock-chips.com>
 <20210127022519.821025-1-xxm@rock-chips.com> <YDMW6OmnnrIgt1RR@rocinante>
From:   xxm <xxm@rock-chips.com>
Message-ID: <29259d39-7b46-6ce3-0b13-98840f1ad0bb@rock-chips.com>
Date:   Mon, 22 Feb 2021 12:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDMW6OmnnrIgt1RR@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

All your comments will be fixed in next patch, thanks for your review.

在 2021/2/22 10:28, Krzysztof Wilczyński 写道:
> Hi Simon,
>
> The subject should start with a capital letter.
>
> [...]
>> pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
>> is Rockchip designed IP which is only used for RK3399. So all the following
>> non-RK3399 SoCs should use this driver.
> You might need to wrap the long line in the above.
>
> The commit message above could use some polish in terms of wording and
> adding more context - what are you adding, what is this driver going to
> support.  For example, what are the "all the following" SoCs?  Should
> there be a list?  Or did you mean "all the other (...)", etc.
>
> [...]
>> +config PCIE_ROCKCHIP_DW_HOST
>> +	bool "Rockchip DesignWare PCIe controller"
>> +	select PCIE_DW
>> +	select PCIE_DW_HOST
>> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>> +	depends on OF
>> +	help
>> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
> Perhaps replacing "DW" with "DesignWare" would be better.  Also, do you
> want to mention here - for the sake of the future user - that this not
> intended to support RK3399 as per the commit message.
>
> [...]
>> +/*
>> + * PCIe host controller driver for Rockchip SoCs
> A nitpick.  Missing period at the end of the sentence.
>
> [...]
>> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
>> +
>> +	if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == 0x30000 &&
> [...]
>
> A suggestion.  Would it make sense to add a definition for this
> open-coded value of 0x30000 above?
>
>> +static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
>> +{
>> +	u32 val;
>> +
>> +	/* LTSSM EN ctrl mode */
> [...]
>
> Does this comment above stands for "LTSSM enable control mode"?
>
>> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>> +{
>> +	int ret;
>> +	struct device *dev = rockchip->pci.dev;
> These two variables should swap place to keep order of use, and to match
> how it has been done everywhere else in this drivers.
>
>> +
>> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
>> +	if (IS_ERR(rockchip->phy))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
>> +				     "missing phy\n");
> I would be "PHY" here.
>
>> +	ret = phy_init(rockchip->phy);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	phy_power_on(rockchip->phy);
> [...]
>
> We should probably check phy_power_on() for a possible failure.  Some
> platforms also clean up on a failure from phy_init() and phy_power_on(),
> but I am not sure if this particular platform would require anything.
>
> [...]
>> +	/* DON'T MOVE ME: must be enable before phy init */
> It would be "PHY" here.
>
>> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>> +	if (IS_ERR(rockchip->vpcie3v3))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
>> +				     "failed to get vpcie3v3 regulator\n");
>> +
>> +	if (rockchip->vpcie3v3) {
>> +		ret = regulator_enable(rockchip->vpcie3v3);
>> +		if (ret) {
>> +			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
> It would be "failed" here.
>
> [...]
>> +static const struct of_device_id rockchip_pcie_of_match[] = {
>> +	{ .compatible = "rockchip,rk3568-pcie", },
>> +	{ /* sentinel */ },
>> +};
> We could probably drop the comment about the "sentinel" from the above.
>
> Krzysztof
>
>


