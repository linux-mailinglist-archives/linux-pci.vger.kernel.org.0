Return-Path: <linux-pci+bounces-14264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4C999F07
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E5B21505
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309C20B1FC;
	Fri, 11 Oct 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoqlzMfP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC219CC08;
	Fri, 11 Oct 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635405; cv=none; b=qNoi9F5ndG5CJXiAMyohDGnP8oVCpp5y2SzxLL4Z/Q8QNXUwuWaztF6KPShZNnKA8yr5Z1cB7Z8XE9TQyGKR0dOi9j7hgMpUdj8YS1kTAo0N+YI41PC4Y7Cz6igpnRUkL5xVe5LgNMvJIWPwGF5Eiw7fvJwwFRnzbMsCouMIivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635405; c=relaxed/simple;
	bh=NQrTiZByneHIXcuPUCaVgQWb9k85uwMIf+r+Fo/+4/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0BMWPjFOjSCxAnuLrX/gCuZZreMuPa0lW+/hhAxUl3c5juiBl1TrNYaPSs7tZi7nBRcpxHRrm/5DcrifDYPqATI6n4+OzhJ2vaztCdOEsCE0a12L+V5rGSHdTJyD01HhNEXO1qv+kqXWgNkE+jLIzygfuJtvf5ugFeN4EZSpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoqlzMfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376F6C4CEC3;
	Fri, 11 Oct 2024 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728635404;
	bh=NQrTiZByneHIXcuPUCaVgQWb9k85uwMIf+r+Fo/+4/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WoqlzMfP0obsncPCD3Xqb/kPiEGFecyNh6JImInOWRPVbZFVkNMnA53lsRxumaI27
	 pyNp2LnF9ibG5bYHFq4W860C8bvffIYr80u06R4TrBLljdi5amzEDLv4oNTZMb/cYK
	 vxS+nJOasXOwZPgEv5CWwOP7mN5guLjuCDC5/dWXJdYj9GFdnC/f+T9wMBLhNVg2Ta
	 hNhiG1Ig7Igv51G6MhhwyRPZ+lYFLHzl9LXchRb8uEDoYWdYyXqk1j0TH5piZwX15o
	 0dL4ll7INRrvoFLkpy0ysMpKqPhXf0UqtEcpBXkaMZplkPsOX0i765SRHu4Semi62D
	 tHZQIFyLkwZ7A==
Message-ID: <bafe2763-8aac-4051-a2d2-d94a0deae04e@kernel.org>
Date: Fri, 11 Oct 2024 17:30:00 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] PCI: rockchip-ep: Refactor
 rockchip_pcie_ep_probe() MSI-X hiding
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
 <20241007041218.157516-8-dlemoal@kernel.org>
 <20241010072512.f7e4kdqcfe5okcvg@thinkpad>
 <20241010080956.z3cw2mxxlgrjafhs@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010080956.z3cw2mxxlgrjafhs@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 17:09, Manivannan Sadhasivam wrote:
> On Thu, Oct 10, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Oct 07, 2024 at 01:12:13PM +0900, Damien Le Moal wrote:
>>> Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
>>> to its own function, rockchip_pcie_ep_hide_msix_cap(). No functional
>>> changes.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Btw, can someone from Rockchip confirm if this hiding is necessary for all the
>> SoCs? It looks to me like an SoC quirk.
>>
>> - Mani
>>
>>> ---
>>>  drivers/pci/controller/pcie-rockchip-ep.c | 54 +++++++++++++----------
>>>  1 file changed, 30 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>>> index 523e9cdfd241..7a1798fcc2ad 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>>> @@ -581,6 +581,34 @@ static void rockchip_pcie_ep_release_resources(struct rockchip_pcie_ep *ep)
>>>  	pci_epc_mem_exit(ep->epc);
>>>  }
>>>  
>>> +static void rockchip_pcie_ep_hide_msix_cap(struct rockchip_pcie *rockchip)
> 
> Perhaps a better name would be rockchip_pcie_disable_broken_msix()? As the
> function essentially disables MSIx which is broken. Again, it'd be good to know
> if this applies to all SoCs or just a few.

The function does not disable anything but *really* simply hides the capability
in the capability list so that the host does not see it. So I think the better
name is:

rockchip_pcie_ep_hide_broken_msix_cap()

-- 
Damien Le Moal
Western Digital Research

