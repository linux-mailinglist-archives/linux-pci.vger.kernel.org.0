Return-Path: <linux-pci+bounces-14266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294999F66
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EB7287CFA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40B20B216;
	Fri, 11 Oct 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCnyouQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300020ADD4;
	Fri, 11 Oct 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636929; cv=none; b=qwGsKatIEzlcWDV5aY2XXMzVViJLIhy88mirD3wfzRDcq80/FChbaNegcWt06nbtWLmUAvL3U5Q84yFTAdCmss4bcSXbNCS8rL3vtXeFKVLXChvFZ3+UNtedbV1ZInqifItYLAyqQjcb5C6LiQlmGYjFt+VCt0RLHgntiPDDOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636929; c=relaxed/simple;
	bh=TM7wSSesHKlnFGC0qSeniGMPWLlPft7VpoxJkrXmJac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPAuPDxPvr82p3fNO+aVUF2ocfDMJ3DhFCn5M+4hdlgBhb9PC6M/JQc8M46UpikHJ4Pt1Y0Id9kYKamBny3YhmSjw53wrtbydX/cVEI88VhFPtSoYCYrXvPw5ikPLJdm54U9aNZ5oFBNfv6P0hctJsqv0N0rJ+rgHMc+bhenxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCnyouQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9894C4CEC3;
	Fri, 11 Oct 2024 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728636929;
	bh=TM7wSSesHKlnFGC0qSeniGMPWLlPft7VpoxJkrXmJac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WCnyouQQ93Px4D/Kw71I4zkZsG4Xsrk0vJcX2jrUgv16T3xpNOIVYnTnocq7PNH4U
	 4tib8ZZazDBNRIYf3GkgQe4gLwk47kLFJAjbDuu7D7+ZcgzlvoTdZfPye2eSnozLqM
	 SJ2xGqzeHOzFvxDYG+XbQJXjWlia0ShQy2FKVkz5rogott1PZRXKW2RpfWU7cdkYe0
	 F+3DsywZxSIZ1jw0R7ykuAPLuaro3M+3BxWRN1sfEXjJ/xqAGstXVOhxiu1aflfVGT
	 txml2rOuG5PBtOFiEsO5lpIZsNyoplAbNXf8++JAuMo4aJeQZ2tWdY2zfZg8/Nguvf
	 U6Dy4w87VWYrA==
Message-ID: <84efa346-c1de-44d5-8b27-2481043e9102@kernel.org>
Date: Fri, 11 Oct 2024 17:55:25 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010103550.elwd2k35t4k4cypu@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 19:35, Manivannan Sadhasivam wrote:
>> +static void rockchip_pcie_ep_link_training(struct work_struct *work)
>> +{
>> +	struct rockchip_pcie_ep *ep =
>> +		container_of(work, struct rockchip_pcie_ep, link_training.work);
>> +	struct rockchip_pcie *rockchip = &ep->rockchip;
>> +	struct device *dev = rockchip->dev;
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Enable Gen1 training and wait for its completion */
>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
>> +				 val, PCIE_LINK_TRAINING_DONE(val), 50,
>> +				 LINK_TRAIN_TIMEOUT);
>> +	if (ret)
>> +		goto again;
>> +
>> +	/* Make sure that the link is up */
>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>> +				 val, PCIE_LINK_UP(val), 50,
>> +				 LINK_TRAIN_TIMEOUT);
>> +	if (ret)
>> +		goto again;
>> +
>> +	/* Check the current speed */
>> +	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
>> +	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
> 
> PCIE_LINK_IS_GEN2()?

This is defined in drivers/pci/controller/pcie-rockchip.h. What is it exactly
you would like to know about this ?

> 
>> +		/* Enable retrain for gen2 */
>> +		rockchip_pcie_ep_retrain_link(rockchip);
>> +		readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
>> +				   val, PCIE_LINK_IS_GEN2(val), 50,
>> +				   LINK_TRAIN_TIMEOUT);
>> +	}
>> +
>> +	/* Check again that the link is up */
>> +	if (!rockchip_pcie_ep_link_up(rockchip))
>> +		goto again;
> 
> TRM doesn't mention this check. Is this really necessary?

I think so, to check the result of the second training for gen2.
Even though the TRM does not say so, I prefer checking that the result is what
we expect: the link is up.

-- 
Damien Le Moal
Western Digital Research

