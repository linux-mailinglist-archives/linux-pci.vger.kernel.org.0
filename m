Return-Path: <linux-pci+bounces-25643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0CA8518D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DE18A42E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08A27BF83;
	Fri, 11 Apr 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZV2DIa4A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6A27BF7F
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338451; cv=none; b=BLFCEsBu4eRXh5rai4Fa2Y3cOgogfsasgw1BZeDkWlI+62B6FDa9c+g/GxSSELDdofayq7axfJc2gsTYb4cpjLnwU/9iuBtM+4UVwBIr0WwwCq0yRuVSELFr1pWHl+Og7/aLKEql9jc5gIo26toS5E4zGDhM35i5aM3Rd2N9rZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338451; c=relaxed/simple;
	bh=FQ51mte+sll+5wI2wcdctFLhSBrES3w5kJIj4Iz8dVU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NrkCZlw+S6SgTLwF+t2fp+0L91Yv2kwVGLHH8eJjdJ6LEcM+RtFANkfpZo6L0b60+9U/L3WG35Eo0il4YJpK9STeVJNLAKBvdEnX+hpUk6BFi7FWJyGC3vRilpEp9Z5rXytprF2B11xsx2Ji/W1U4MlHzQ1bwdlOGmh5PnigYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZV2DIa4A; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11774021d;
	Fri, 11 Apr 2025 10:27:17 +0800 (GMT+08:00)
Message-ID: <b7c48a0e-650c-aa9b-3748-f8bd168984b3@rock-chips.com>
Date: Fri, 11 Apr 2025 10:26:56 +0800
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
Subject: Re: [PATCH] PCI: dw-rockchip: Add system PM support
To: Damien Le Moal <dlemoal@kernel.org>
References: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>
 <ac2760c1-e876-493f-8a44-4af16093423f@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <ac2760c1-e876-493f-8a44-4af16093423f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0aGVZIQkhMGRgZGRpNQkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9622ac465d09cckunm11774021d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6CCo5GjJLCjU8OhcKUSEJ
	EDQaCj1VSlVKTE9PSEhDT0hDTU9CVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJSEs3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZV2DIa4A7n0KhgwS+/J0KRNOA/dvaFtpeWR3ZROYZgrRLIeG4Yjc8hAM/xPXIenM3Ocnp7Gw9kzF90ruGA0OqW8Ajkrep/wlxMscJ4JdKYZJve7PpCFkH45kqgnDEll2nYahdEyKfJcE8/37zH0G0Yz0xnW0vEotGUNU5vC+tQc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=C9JKHI/yKt7GnPOl00gdyeRH9b05ywfPa3LGarSh5oo=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/11 星期五 10:02, Damien Le Moal 写道:
> On 4/10/25 15:50, Shawn Lin wrote:
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
>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>> +	reset_control_assert(rockchip->rst);
>> +	if (rockchip->vpcie3v3)
>> +		regulator_disable(rockchip->vpcie3v3);
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>> +
>> +	return 0;
>> +}
> 
> This function needs a __maybe_unused in its declaration, otherwise, you get a
> compilation warning when PM is not enabled.
> 
> static int __maybe_unused rockchip_pcie_suspend(struct device *dev)
> 
> 

Emm.. I don't see any host drivers with system PM support under
drivers/pci/controller/ adds these :)

#grep suspend drivers/pci/controller/ -rn | grep __maybe_unused  | wc -l
0

Anyway, will fix it.

>> +static int rockchip_pcie_resume(struct device *dev)
> 
> Same here too.
> 
> 

