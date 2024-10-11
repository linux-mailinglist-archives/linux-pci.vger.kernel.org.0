Return-Path: <linux-pci+bounces-14262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BC999EE8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1261F21E43
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE7209F58;
	Fri, 11 Oct 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSJpoRnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0C1CB334;
	Fri, 11 Oct 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634967; cv=none; b=XCAN+szfassfvQbNsyhn8CEr1ZtV40FXZIndJqKmfwr4BG7JBgOxqNtfLnHZJ981JmkrxRMwQzZZGo2qQxUP2/yT0iF69nJsLKTmcMWyOS+fuzOPAOU+AH+S8XkL2RAv+s0480ycLsPc6uGMF8IhtNkfsV60cwu5XcqCTcZNs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634967; c=relaxed/simple;
	bh=0seMzSwNBuFkRvs9M5p5d+Tp1hKCYdfJloejRQWx454=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3Ozh3KLx0Tv8WToyGx4i7pVU9cPH7BEkz6gmJKGf3WXv4lAGmsej/94ygO2oU+rO3How/UlAvjDMRrKuaRq2K+8rCmMLft5bRk0bpYt6+N3MelmisKSO4+Uyx7EcKukcmBNfIuLJFDTusAcom2NCsaxpezOBsAY/8Ro5C1UyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSJpoRnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A887C4CEC3;
	Fri, 11 Oct 2024 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728634966;
	bh=0seMzSwNBuFkRvs9M5p5d+Tp1hKCYdfJloejRQWx454=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSJpoRnp5hAYYFhn+kLKJMNTepTbXj0b1EE+z9hTxpyo33rs7pfC0XwX3Jt5/T3l4
	 wzTythEhnUGceZud55GQrBTU4nxAJ2ddshMpAR8lhOYFGYBHTx0xeTavj7rwthSCnL
	 DxvcCmbG2gCD35yh03QEzAQ9vfA7iD7NnuPvFmZzFgpJ1kJ1xhuEdF2ifeGZ+5zK3N
	 opGuAqbvV1+yT/ZG33nYqgrX/7HLssbi51TKHMgfM9tMHjntr7gAsL9Z4Fk7vKs4+G
	 JVcN1bV/5fz/Ic84z+imCjgYU0uTxWyRr3UzwIAFkn4lmUL7eUFJdPLYAphew0SAfz
	 z3AI25X1bIcVQ==
Message-ID: <902d1e4e-3c4e-4590-a810-77a1d11ce57d@kernel.org>
Date: Fri, 11 Oct 2024 17:22:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] PCI: rockchip-ep: Improve
 rockchip_pcie_ep_unmap_addr()
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
 <20241007041218.157516-4-dlemoal@kernel.org>
 <20241010070911.ozwrpho3wddb4ezf@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010070911.ozwrpho3wddb4ezf@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 16:09, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:09PM +0900, Damien Le Moal wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>
>> There is no need to loop over all regions to find the memory window used
>> to map an address. We can use rockchip_ob_region() to determine the
>> region index, together with a check that the address passed as argument
>> is the address used to create the mapping. Furthermore, the
>> ob_region_map bitmap should also be checked to ensure that we are not
>> attempting to unmap an address that is not mapped.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/controller/pcie-rockchip-ep.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>> index 5a07084fb7c4..89ebdf3e4737 100644
>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>> @@ -256,13 +256,9 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>>  {
>>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>> -	u32 r;
>> -
>> -	for (r = 0; r < ep->max_regions; r++)
>> -		if (ep->ob_addr[r] == addr)
>> -			break;
>> +	u32 r = rockchip_ob_region(addr);
>>  
>> -	if (r == ep->max_regions)
>> +	if (addr != ep->ob_addr[r] || !test_bit(r, &ep->ob_region_map))
> 
> Having these two checks looks redundant to me. Is it possible that an address
> could pass only one check?

Yes, if the wrong address is passed to rockchip_pcie_ep_unmap_addr() but that
address still correspond to an ob_region that is being used.

We could do add a WARN_ON_ONCE() around that if condition as calling that
function with an invalid address would mean that either the epc core or the
function driver is buggy.




-- 
Damien Le Moal
Western Digital Research

