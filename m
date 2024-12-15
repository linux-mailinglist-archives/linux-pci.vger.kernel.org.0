Return-Path: <linux-pci+bounces-18448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D628F9F21B5
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595B165387
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F879322A;
	Sun, 15 Dec 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGTkSeMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFF8F40;
	Sun, 15 Dec 2024 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734228593; cv=none; b=lAw/dbUaO5nMvlq1uAAbclQc3EgEipbyVK6RWk3ZO4dihCq7CwuIssM96zXhh7KytRt8uka6a1m64kgBgAKXkY1TVtwHyoGAW3NPHHpkjJgZRIHpvDVbQgYjMc6snQ5/lhT8Ypa/bBJI4A+ShHb/arwt0Pwv1Uvt22Qgl0xR/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734228593; c=relaxed/simple;
	bh=AnUjQngOmObm+Df0ucitlnHpXQSa+tKYhKijlSRANgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYcLptxtngdYYWQTk0Nlm4Y6WgzE4H2HhIgTQza0FH2S/owu6i4L/P1YQDWYHzIDGM6v0OhIps4GZfp8XU1JxqV+ZsMUAdLUD3M32db52tWumaWFdGDgBpHeBTgYiwUQb4AHshcmaTC3hW2VrhHhm5QSL3NbwtD7sCUptixFVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGTkSeMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71473C4CED1;
	Sun, 15 Dec 2024 02:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734228592;
	bh=AnUjQngOmObm+Df0ucitlnHpXQSa+tKYhKijlSRANgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HGTkSeMTVYJUTMjZdazPa7rlP1Z7bECigdjamULP6SI0MePGQ1XXsg+lOOfGoVioQ
	 WY4BPczqsjW/uKHWCkRsuyuNUw03x1rGBQftYX1CrplPFiBTM6gsy353jp9uWnG9LG
	 K3/fCSN9lspPboGpiYrcnhKSvH0rZLJSCA6LlIvcp9gqpvAeN8rrgZr7a0cX4o1iV0
	 FwjhFvrVeCVglrXdjLdSk7fUpf6Xl8ZxHEMFgBE0f73AvQZ0rj8D4BEJ6kGqKJ5Pe+
	 F5f+m8BEJ9JNYC7FjLrcPpniMedMc84U03Q/g2+gAl8QIZMQL/YMeXxe7zOuSnC/1G
	 BSnK0RhUwXqdA==
Message-ID: <35282804-9a4a-4272-9f39-e5ba443a0cbb@kernel.org>
Date: Sun, 15 Dec 2024 11:09:49 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241215001313.GA3482864@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241215001313.GA3482864@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/24 09:13, Bjorn Helgaas wrote:
> On Thu, Oct 17, 2024 at 10:58:48AM +0900, Damien Le Moal wrote:
>> Currently, the Rockchip PCIe endpoint controller driver does not handle
>> the PERST# signal, which prevents detecting when link training should
>> actually be started or if the host resets the device. This however can
>> be supported using the controller reset_gpios property set as an input
>> GPIO for endpoint mode.
> 
>> @@ -50,6 +51,9 @@ struct rockchip_pcie_ep {
>>  	u64			irq_pci_addr;
>>  	u8			irq_pci_fn;
>>  	u8			irq_pending;
>> +	int			perst_irq;
>> +	bool			perst_asserted;
>> +	bool			link_up;
>>  	struct delayed_work	link_training;
>>  };
> 
> I should have caught this last cycle, but just noticed this:
> 
>   $ make W=1 -k drivers/pci/ drivers/misc/pci_*
>   ...
>     CC      drivers/pci/controller/pcie-rockchip-ep.o
>   drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
>   drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
>   drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
>   drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'

Oops... Sending a fix.

-- 
Damien Le Moal
Western Digital Research

