Return-Path: <linux-pci+bounces-25646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9ECA85245
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 05:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C34A739F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 03:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FA27C16C;
	Fri, 11 Apr 2025 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLS8/Dip"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C309279338
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744343799; cv=none; b=osJM/nlq9KHKIQDZjv4Tw4fsMYDCD7PN/EX2LpVBar2I7CYCpzoRwHy4LVFGQHwZUGtjXI6AHEH6A6l1Vi9d+X/iiqrVg3Yb4orIPXpzPW/E4kr56Qa6cvjC5hEA7VRfyNXX1ZeSM8W0CrcEzJWMEpufz8ZRquQlnhlcVetTexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744343799; c=relaxed/simple;
	bh=bJWBa2uv5b4aK1qceLv5Kv04rsNGQ07S4xvrzdlLjQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZnjLDYcN1xh6tWWAK1tZH5P1AkbpD2Z9vpYXh9/J6YBUrhEhdfVs9XmUd414ibmobA62e4lm/BMhdH0yNzpwZc8nqjzNuL0j2noxDMklqPO/Q8NyQgFR+adSZBJSF6TLGgVAlBJb0FC8mHTnRwBgZ565Num99drQgv9tF/egnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLS8/Dip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E8C4CEE2;
	Fri, 11 Apr 2025 03:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744343798;
	bh=bJWBa2uv5b4aK1qceLv5Kv04rsNGQ07S4xvrzdlLjQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XLS8/Dipx4fBpvTLV8avF/ndT9Ls+fuQzLmdgfWGOsFA3Q+9haQCQosMICR/fUDZ3
	 G0r5mzxtp77uI3geqKxxMKEM3e8gXR9QQKwei9GbkgaRm4ECHBBBryLBSVx+xvjpEe
	 6s4dWnXvh8uvRoyfBR3P0hU14rQ/tmB9trFrVNMAGaBruFIRNkoGiPG7R6HbHwISvm
	 xkRh919g50Ul/1htH23ApxADy7czk5h0YuG2bmMe+Ck0ezmy8avhjr49HgR3RvSpav
	 NEDNBlFavUnBVIfLH2MUOEc+TV5JgeKAlDhBSq3d4FURTBzvCHLPljh+AUprs1SWzK
	 IOuFG92D1KlRg==
Message-ID: <c9c68772-01ce-49a1-8fc2-02294209bbcc@kernel.org>
Date: Fri, 11 Apr 2025 12:56:36 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Add system PM support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
References: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>
 <ac2760c1-e876-493f-8a44-4af16093423f@kernel.org>
 <b7c48a0e-650c-aa9b-3748-f8bd168984b3@rock-chips.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b7c48a0e-650c-aa9b-3748-f8bd168984b3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/25 11:26, Shawn Lin wrote:
> 在 2025/04/11 星期五 10:02, Damien Le Moal 写道:
>> On 4/10/25 15:50, Shawn Lin wrote:
>>> +static int rockchip_pcie_suspend(struct device *dev)
>>> +{
>>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>>> +	struct dw_pcie *pci = &rockchip->pci;
>>> +	int ret;
>>> +
>>> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
>>> +
>>> +	ret = dw_pcie_suspend_noirq(pci);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to suspend\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	rockchip_pcie_phy_deinit(rockchip);
>>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>>> +	reset_control_assert(rockchip->rst);
>>> +	if (rockchip->vpcie3v3)
>>> +		regulator_disable(rockchip->vpcie3v3);
>>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>>> +
>>> +	return 0;
>>> +}
>>
>> This function needs a __maybe_unused in its declaration, otherwise, you get a
>> compilation warning when PM is not enabled.
>>
>> static int __maybe_unused rockchip_pcie_suspend(struct device *dev)
>>
>>
> 
> Emm.. I don't see any host drivers with system PM support under
> drivers/pci/controller/ adds these :)
> 
> #grep suspend drivers/pci/controller/ -rn | grep __maybe_unused  | wc -l
> 0
> 
> Anyway, will fix it.

If you do not add __maybe_unused, you get:

  CC      drivers/pci/controller/dwc/pcie-dw-rockchip.o
drivers/pci/controller/dwc/pcie-dw-rockchip.c:761:12: warning:
‘rockchip_pcie_resume’ defined but not used [-Wunused-function]
  761 | static int rockchip_pcie_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pcie-dw-rockchip.c:737:12: warning:
‘rockchip_pcie_suspend’ defined but not used [-Wunused-function]
  737 | static int rockchip_pcie_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

You do not get this for other controllers because they use
NOIRQ_SYSTEM_SLEEP_PM_OPS() to set the PM ops. Your patch uses
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() which is defined as:

#ifdef CONFIG_PM_SLEEP
#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
	NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#else
#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

So unlike using directly NOIRQ_SYSTEM_SLEEP_PM_OPS(), the functions names are
actually never used when CONFIG_PM_SLEEP is not enabled.

So the fix is to do like other controllers and use NOIRQ_SYSTEM_SLEEP_PM_OPS()
or use __maybe_unused.

-- 
Damien Le Moal
Western Digital Research

