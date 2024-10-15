Return-Path: <linux-pci+bounces-14514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913499DE37
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDCC1F23328
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE22189B8A;
	Tue, 15 Oct 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p85FOT8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023B189B88;
	Tue, 15 Oct 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973473; cv=none; b=hBj16XX98pGsu/kSyndtDGLOV4YfhFYxlWRl2dbZbyIJLF8T7uZWq+DYm6oPRInA2uzGDhshL++RW756Z9KBI9oUfLotrBa78nloPrqfawZaZ8gmQTHSG5cdXh7RAjjgGTGQ8TXz+xwVGJjkAIHGhYmTOe7TKjb7P/HdKNermyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973473; c=relaxed/simple;
	bh=vsXOOA5ANMXEDreUY4REBTLChawkE5C8ea8kSRyDtmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5gIsWV3tTsbY+9BpH6iA5QGT5Do2zCmBgdlS1ekAkwzoqUhceNBg2nieq7JtvjV6gPixxpiwJvWSdk5jTrHs2a/Igm6MYQzw7MZ3RuIjrWyQ5hb0VAvOj2WiWoP3462ZScuiF4+63Z+eJASoSxvfzxIz2TpWqjYiMCQLMyLB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p85FOT8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52347C4CEC7;
	Tue, 15 Oct 2024 06:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728973473;
	bh=vsXOOA5ANMXEDreUY4REBTLChawkE5C8ea8kSRyDtmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p85FOT8cZgvfLGCc1nlifVmk6Mi8WDsF9W8hMsGffKM4EA/8w2Su3ZQGJHMiolj0H
	 W8zezNObIX0jzBcZBwFR50fZ9tIv46OeeTrYsFdHIEWeupFqXD4qRo9uDPeru7bTFE
	 w0g5mWyfHRp7olfKZk1KZoM25aHTbRmNMxghlpogYHhzLfigL9XcbXCzNoIdtqXpdE
	 Pko92kAN8yMAYTY9Y1NPj7hhanQMK9zrLShWXEBzpQcHpHRvJaHqiOAp2NW+mS7Sfh
	 RMOlMws/3+CUa0kTE8/6R0X8yCqEPM6aymRyKEtaKl34pQw141zEX5XYvqRql4C9RB
	 zVxHBjvRkEs9w==
Message-ID: <b4e4718e-d601-4ea2-b5e6-e4e1e778afe3@kernel.org>
Date: Tue, 15 Oct 2024 15:24:30 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
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
 <20241007041218.157516-13-dlemoal@kernel.org>
 <20241010104932.gfrunorhpnhan5wp@thinkpad>
 <b525abc8-4066-4097-9a36-558b84144228@kernel.org>
 <20241012123111.bg6rzxotabkxfchc@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241012123111.bg6rzxotabkxfchc@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/24 21:31, Manivannan Sadhasivam wrote:
> On Fri, Oct 11, 2024 at 06:30:31PM +0900, Damien Le Moal wrote:
>> On 10/10/24 19:49, Manivannan Sadhasivam wrote:
>>>> +static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
>>>> +{
>>>> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>>>> +	struct rockchip_pcie *rockchip = &ep->rockchip;
>>>> +	struct device *dev = rockchip->dev;
>>>> +	int ret;
>>>> +
>>>> +	if (!rockchip->ep_gpio)
>>>> +		return 0;
>>>> +
>>>> +	/* PCIe reset interrupt */
>>>> +	ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
>>>> +	if (ep->perst_irq < 0) {
>>>> +		dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
>>>> +		return ep->perst_irq;
>>>> +	}
>>>> +
>>>> +	ep->perst_asserted = true;
>>>
>>> How come?
>>
>> Yeah, a bit confusing. This is because the gpio active low / inactive high, so
>> as soon as we enable the IRQ, we are going to get one IRQ even though perst gpio
>> signal has not changed yet.
> 
> Which means you are looking for a wrong level! What is the polarity of the
> PERST# gpio in DT?

It is not defined in the default DT with the kernel. I added an overlay file to
define it together with the EP mode. And as I said above, the gpio is active
low. If I reverse that to active high, it does not work.


-- 
Damien Le Moal
Western Digital Research

