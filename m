Return-Path: <linux-pci+bounces-26110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B159A91F38
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B22419E6F0C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744D22A7EF;
	Thu, 17 Apr 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fXcpdtld"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com [220.197.32.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADE1E49F
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899265; cv=none; b=acAesmOg5zEEf+ZWXHX3deS+Qc0ofayrLck3fq/lIXZMXXY3lfaZ/EOr01MIXNnZLtYSq7Q4tGHZgBZDSPES+ZLQPXc63yUKDGjtJRKw4tb+xsE+200NuMqGuIFPwe4qcuERVLgGZS0TZHedX6dHfumv5/bbWSrbPEmgemywZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899265; c=relaxed/simple;
	bh=JfrFZDOc4jS9z63qhs7Z+v6K1+qWosjcV0kSwnK2UFs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QFEOUubSImjIQWtUXMb1/9Z6H7Nq1kFSdBfFlrAVaX7s6UTlGJ/91OlCieTnAADFOSSfTV7Ay6w8PyxLfLFIOOHZYBXxLrKZpRPfsbq02dLiBrCfkfZJnKX0FhSDwDbxfVb9VMuXKaVN5iY4/XWur97Pptckr/XmNiXXIF5Ekxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fXcpdtld; arc=none smtp.client-ip=220.197.32.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12364a00c;
	Thu, 17 Apr 2025 16:30:10 +0800 (GMT+08:00)
Message-ID: <0b32129e-ecb6-983f-636c-4e9177117ed4@rock-chips.com>
Date: Thu, 17 Apr 2025 16:29:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
To: Diederik de Haas <didi.debian@cknow.org>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
 <D98RKO927TBG.8ZRWD3GCLSXH@cknow.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <D98RKO927TBG.8ZRWD3GCLSXH@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JCTVZIQh1LSkxDSh9ISxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9642dea85f09cckunm12364a00c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6NCo*QjJOHhdCUS5CTEsT
	MylPCRpVSlVKTE9PQ0xDTUpKQ0JNVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5PT003Bg++
DKIM-Signature:a=rsa-sha256;
	b=fXcpdtldBkct5Q0UGczBnZiBub9JeaeyjjJQFJkuCni0HQT90ebH+Z2wGvv9bkAB9j3nuJTkB6IIPvmNancfcRGVBVgXJsO2zGvQJSft1Dp5jpiRbv2+SnlB9xspqkOK9nD6wsRULovJpTpZJD8NMUltD6ej02YRM5/1oDkXaNY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xUO20yjM3syRm0eudoJRNM0C2UHrIwarJ4XhrgyfRPM=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/17 星期四 16:17, Diederik de Haas 写道:
> Hi,
> 
> On Fri Apr 11, 2025 at 8:14 AM CEST, Shawn Lin wrote:
>> This patch adds system PM support for Rockchip platforms by adding .pme_turn_off
>> and .get_ltssm hook and tries to reuse possible exist code.
> 
> s/exist/existing/ ?
> 
>> ...
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - Use NOIRQ_SYSTEM_SLEEP_PM_OPS
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 185 +++++++++++++++++++++++---
>>   1 file changed, 169 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 56acfea..7246a49 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>>   
>> +#include "../../pci.h"
>>   #include "pcie-designware.h"
>>   ...
>>   
>> +static int rockchip_pcie_suspend(struct device *dev)
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +	struct dw_pcie *pci = &rockchip->pci;
>> +	int ret;
>> +
>> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
>> +
>> +	ret = dw_pcie_suspend_noirq(pci);
>> +	if (ret) {
>> +		dev_err(dev, "failed to suspend\n");
>> +		return ret;
>> +	}
>> +
>> +	rockchip_pcie_phy_deinit(rockchip);
> 
> You're using ``rockchip_pcie_phy_deinit(rockchip)`` here ...
> 
>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>> +	reset_control_assert(rockchip->rst);
>> +	if (rockchip->vpcie3v3)
>> +		regulator_disable(rockchip->vpcie3v3);
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_resume(struct device *dev)
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +	struct dw_pcie *pci = &rockchip->pci;
>> +	int ret;
>> +
>> +	reset_control_assert(rockchip->rst);
>> +
>> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
>> +	if (ret) {
>> +		dev_err(dev, "clock init failed\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	if (rockchip->vpcie3v3) {
>> +		ret = regulator_enable(rockchip->vpcie3v3);
>> +		if (ret)
>> +			goto err_power;
>> +	}
>> +
>> +	ret = phy_init(rockchip->phy);
>> +	if (ret) {
>> +		dev_err(dev, "fail to init phy\n");
>> +		goto err_phy_init;
>> +	}
>> +
>> +	ret = phy_power_on(rockchip->phy);
>> +	if (ret) {
>> +		dev_err(dev, "fail to power on phy\n");
>> +		goto err_phy_on;
>> +	}
> 
> ... would it be possible to reuse ``rockchip_pcie_phy_init(rockchip)``
> here ?
> 

yeah, will do.

> otherwise, ``s/fail/failed/`` in the error messages
> 
>> +
>> +	reset_control_deassert(rockchip->rst);
>> +
>> +	rockchip_pcie_writel_apb(rockchip, HIWORD_UPDATE(0xffff, rockchip->intx),
>> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
>> +
>> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
>> +	rockchip_pcie_unmask_dll_indicator(rockchip);
>> +
>> +	ret = dw_pcie_resume_noirq(pci);
>> +	if (ret) {
>> +		dev_err(dev, "fail to resume\n");
>> +		goto err_resume;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_resume:
>> +	phy_power_off(rockchip->phy);
>> +err_phy_on:
>> +	phy_exit(rockchip->phy);
> 
> I initially thought this sequence was incorrect as I looked at the
> ``rockchip_pcie_phy_deinit`` function:
> 
> 	phy_exit(rockchip->phy);
> 	phy_power_off(rockchip->phy);
> 
> https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L411
> 
> But the ``phy_exit`` function docs says "Must be called after phy_power_off()."
> https://elixir.bootlin.com/linux/v6.15-rc1/source/drivers/phy/phy-core.c#L264
> 
> So it seems the code/sequence in this patch is correct, but
> ``rockchip_pcie_phy_deinit`` has it wrong?

Right, it's wrong in rockchip_pcie_phy_deinit() although it doesn't
matter, as the PHY drivers used by Rockchip PCIe actually don't provide
.power_off callback. :)


> 
>> +err_phy_init:
>> +	if (rockchip->vpcie3v3)
>> +		regulator_disable(rockchip->vpcie3v3);
>> +err_power:
>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>> +err_clk:
>> +	reset_control_deassert(rockchip->rst);
>> +	return ret;
>> +}
>> +
>>   static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
>>   	.mode = DW_PCIE_RC_TYPE,
>>   };
> 
> Cheers,
>    Diederik

