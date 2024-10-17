Return-Path: <linux-pci+bounces-14702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D69A1755
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4ABB2112E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8D12E7F;
	Thu, 17 Oct 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlQ3f1PQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ECC10F2;
	Thu, 17 Oct 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126365; cv=none; b=tUFz+X2zljzOLwdM0/2qsva0ReZeIQ7wQC73ZyLstxuN/XazGM0o9GLqMLjiqRFPjpGoFd+eUhaFoDM5lQ96MbOcyKFSBHsBvLJVM/WCkhBC4xuKSUbBszE+p8vTo7+qoVEuY8zr2Xpu6Pz4VzyABuDXs8/OlLtJdixBydhJ9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126365; c=relaxed/simple;
	bh=XV5pdlUSFEp4A8UQmD5d4AG1BolLauc6GYZCxQjojrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCRu+zzv0rnmdNDWdcRPOR6pt5XE6ChAl4DgmkGbQoHOet2zKPOAzGDFlQdNYTU676KrqzVet4rP0i+5wC5EXLVEoB1e8ZKxU59nPQW18ArkDqtkIIGRAHV0RmTrY/d+iF6eAw4Ry5QalkFlzzLxZz8oiIacV0Snipqyz4jgrSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlQ3f1PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46208C4CEC5;
	Thu, 17 Oct 2024 00:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729126364;
	bh=XV5pdlUSFEp4A8UQmD5d4AG1BolLauc6GYZCxQjojrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JlQ3f1PQuv07sfNVGx2imhc4U6DbbRRj4v5lPNCQCteQ2xgVJQieISz+yYWjXsFMD
	 Cq5YEkaIe9SxKNY0RHiyhoT5cZ1NTA14Dmh86JryqWvwyc2ZhFhvLUQHEn/vXxA3X9
	 f+M2pPp63GPQoU/ytDvRTY435PNrZkABU9H2fq/LChL1N5lBWsgE21Z17uf3r4Wl9O
	 89ygcGjAceEHo4OXgIjOAtYRvkMdBV0ZvHGtQk0e9SoPFtyPDrazHbbikZ38qw92Ys
	 lnLUOaOE2GYhMHI3ZtFFaiqRj8vtI1lJtDgsdbM0vV16taqeA6w28pK+rppQDLRnv4
	 4Eb1t3iOqVGWw==
Message-ID: <b3640074-a8e5-4f1d-8e9d-78b508378990@kernel.org>
Date: Thu, 17 Oct 2024 09:52:41 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] PCI: rockchip-ep: Improve link training
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-11-dlemoal@kernel.org>
 <20241010103550.elwd2k35t4k4cypu@thinkpad>
 <84efa346-c1de-44d5-8b27-2481043e9102@kernel.org>
 <20241012121622.owkg5geqp5jqtjod@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241012121622.owkg5geqp5jqtjod@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/24 21:16, Manivannan Sadhasivam wrote:
> On Fri, Oct 11, 2024 at 05:55:25PM +0900, Damien Le Moal wrote:
>> On 10/10/24 19:35, Manivannan Sadhasivam wrote:
>>>> +static void rockchip_pcie_ep_link_training(struct work_struct *work)
>>>> +{
>>>> +	struct rockchip_pcie_ep *ep =
>>>> +		container_of(work, struct rockchip_pcie_ep, link_training.work);
>>>> +	struct rockchip_pcie *rockchip = &ep->rockchip;
>>>> +	struct device *dev = rockchip->dev;
>>>> +	u32 val;
>>>> +	int ret;
>>>> +
>>>> +	/* Enable Gen1 training and wait for its completion */
>>>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
>>>> +				 val, PCIE_LINK_TRAINING_DONE(val), 50,
>>>> +				 LINK_TRAIN_TIMEOUT);
>>>> +	if (ret)
>>>> +		goto again;
>>>> +
>>>> +	/* Make sure that the link is up */
>>>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>>>> +				 val, PCIE_LINK_UP(val), 50,
>>>> +				 LINK_TRAIN_TIMEOUT);
>>>> +	if (ret)
>>>> +		goto again;
>>>> +
>>>> +	/* Check the current speed */
>>>> +	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
>>>> +	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
>>>
>>> PCIE_LINK_IS_GEN2()?
>>
>> This is defined in drivers/pci/controller/pcie-rockchip.h. What is it exactly
>> you would like to know about this ?
>>
> 
> !PCIE_LINK_IS_GEN2 means check is for non-Gen2 mode, isn't it? I guess the check
> should be 'if (PCIE_LINK_IS_GEN2...)

Nope, the negative test is correct. The condition means: if we are not at GEN2
speed yet AND gen2 was requested, then initiate training again to get gen2.
So !PCIE_LINK_IS_GEN2() is correct.

-- 
Damien Le Moal
Western Digital Research

