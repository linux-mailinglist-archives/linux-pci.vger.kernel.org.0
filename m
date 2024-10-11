Return-Path: <linux-pci+bounces-14269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6F99A029
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 11:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893D61C225A4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941A1CF7B8;
	Fri, 11 Oct 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN4F+R+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18E26AFC;
	Fri, 11 Oct 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639037; cv=none; b=mh1BKn4WlIg6ZVkaJsSx5g8zavXVIvhsJzYT6grl29aY3nuCbqdkYggFoB3y47yQSy+jbd4NfGe8ie7u1S94qf6iDMZbAdqvX022OuaRJ506htzZQr+JLSueSyizsMJxAvEihT0j+y4EdWjM/CC45+B1QqVCfQC4nQbkm1BoDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639037; c=relaxed/simple;
	bh=xmy/FIF2bNPrHgMiOMzGpFp51iyvrygVT77VNtOhai0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3pvPJmcZhANKOZhdoBLtiqlqt4hgly9KahZARpbga2iRO21rPMbu+FVVsQAKzBeULX6ql3nF+ecjDxmyFPZuF0kCdWNLEHTcl3PcnOlIGuhlHz0eL6yJ8VdN6044E6dQT8ktzPj0LwLSVpdbd5M40gBlhI3MzO5XdDZFbhWiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN4F+R+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ECBC4CEC3;
	Fri, 11 Oct 2024 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728639037;
	bh=xmy/FIF2bNPrHgMiOMzGpFp51iyvrygVT77VNtOhai0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LN4F+R+fqKvX3pkQUcFu92iXL+0gwbMLNpqJUBHhNVWXbV3QhxcKoU0YEwm5fkCqY
	 ohsFY8/wISR7m9Fl4rrrJ/v1WWI4bUXTz84N4c8TkTLZhgVU9WK3bnCP/nZ0tc9o+P
	 +gCW9do1QGs61xwBc6Hlu+efy++QKzeBQjTKp31MBtxMgM/hLR6ZXCIF03ABuUotnp
	 xWBkkldGZeO1BDoYW/XMSRkE2bOU6GYHRBRUxeaDt0gxl2RmVpC2iKZuU1VWsgwcEx
	 NjUfEWTWNxbYfxxWykdc1VZNMJbIvrzGwiBKgjpJHJvFm5a/6xN8FVYdHVQemMck+u
	 PmdTQQc3BC6EA==
Message-ID: <b525abc8-4066-4097-9a36-558b84144228@kernel.org>
Date: Fri, 11 Oct 2024 18:30:31 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010104932.gfrunorhpnhan5wp@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 19:49, Manivannan Sadhasivam wrote:
>> +static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
>> +{
>> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct rockchip_pcie *rockchip = &ep->rockchip;
>> +	struct device *dev = rockchip->dev;
>> +	int ret;
>> +
>> +	if (!rockchip->ep_gpio)
>> +		return 0;
>> +
>> +	/* PCIe reset interrupt */
>> +	ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
>> +	if (ep->perst_irq < 0) {
>> +		dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
>> +		return ep->perst_irq;
>> +	}
>> +
>> +	ep->perst_asserted = true;
> 
> How come?

Yeah, a bit confusing. This is because the gpio active low / inactive high, so
as soon as we enable the IRQ, we are going to get one IRQ even though perst gpio
signal has not changed yet. So to be consistent with this, perst_asserted is
initialized to true so that on the first shot of
rockchip_pcie_ep_perst_irq_thread() we end up calling
rockchip_pcie_ep_perst_assert() as if we got an assert from the host (we have
not yet). I will add a comment clarifying that.



-- 
Damien Le Moal
Western Digital Research

