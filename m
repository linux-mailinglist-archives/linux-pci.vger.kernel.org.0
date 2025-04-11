Return-Path: <linux-pci+bounces-25642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1CA8515F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB0E4C0199
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394A157E88;
	Fri, 11 Apr 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCfNojOj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149C79FE
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744336975; cv=none; b=QS6jtgaIJBEQSHgHF5vswLFRSQ17obrh4ydQKuBL6dZg9gk1SzhTaJOq2eWCM/TjB5AqtYxogCt40cZ6jWqA0nRp8qb9AcyGu+Wo2mujbrwX0zweVJRGh6LNsQfsqPrhsxD/rT9Gp2JeJmlnPnnfqnJpQJlP2AbF3f2o2GMphyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744336975; c=relaxed/simple;
	bh=Acg9Hfn4b/PSQ6cmDkGrkw0ePaZ/J1DOlFYH4WXtrv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1nUqYMbAJl9G5+ImnZ74+gdk9KgukV1zhuLm1hhNGeoprtaaqLIuY1UM/usbPC22evgzTlO/4EXsUoAArgapSUKKxXCatGRrxyNvDljt7AV1ST1qmlbAZdyO3Py8N4kRnSn25pu6Jvr/hcCIKNXj5IODnfcdldq5lIBq2WmITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCfNojOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFCFC4CEDD;
	Fri, 11 Apr 2025 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744336974;
	bh=Acg9Hfn4b/PSQ6cmDkGrkw0ePaZ/J1DOlFYH4WXtrv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WCfNojOjjmMmHVc5nimxBhsY4+iuU+fgnukEeRNNKhEpr7/sW31JDP3MlSbuMc9tH
	 E1vC9s1zp9Nijvn5FKDSmfaZpgHGZEHNSNbGSj7eNQ0bgiXdBNmhv7agxhsd4YwmaW
	 EbwodyKTMPVsWGt0XEAVLuJagqvQZxbd1wIvr16E7Vj9rtrwm0hbWEKmG1M+SS4P6A
	 bKMPZIlaIsp6Z6cU1fTHXKiASIhY2ds90B58b/o+DmCgV07iwzuUcjmukQ7jEeFNJ7
	 5l+mBNcIWeP96++WJeNDobe2Zt+/VK2H6hRj3bdDLhbBEFCgZiU7CSHWYpR76al7Qw
	 Svk0G4ZoxGP6Q==
Message-ID: <ac2760c1-e876-493f-8a44-4af16093423f@kernel.org>
Date: Fri, 11 Apr 2025 11:02:52 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Add system PM support
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1744267805-119602-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 15:50, Shawn Lin wrote:
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	ret = dw_pcie_suspend_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend\n");
> +		return ret;
> +	}
> +
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +
> +	return 0;
> +}

This function needs a __maybe_unused in its declaration, otherwise, you get a
compilation warning when PM is not enabled.

static int __maybe_unused rockchip_pcie_suspend(struct device *dev)


> +static int rockchip_pcie_resume(struct device *dev)

Same here too.


-- 
Damien Le Moal
Western Digital Research

