Return-Path: <linux-pci+bounces-14167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756619980CA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF4B1F25143
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D971EF94E;
	Thu, 10 Oct 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8SkyaUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA21EF949;
	Thu, 10 Oct 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549484; cv=none; b=elma+WG8Zid79w/kbwgDzvAQgGs8mfR/FCml+7iTKNF6ze4kSBp0QIkwYhwrtdQTQyADba8SmdRDZ+MzRxAG0HZFVUHz6s/gcaIZLWuhk+Nmk8E4Ikr9fFTsgshQ7/udHcLhIMERxQgaK5VY90kbczgOxXG3tKfMiSJLAP8JuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549484; c=relaxed/simple;
	bh=93ri6kXjS04NlSJhVAtV+oc8pPS/l8+cSGguv6Oe0iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Tc2nVEJzQ+1AxCdmX7dm4WTeLbwuBZGhhkWDF1R/SyOr3BEMAtZmm7J1J1FAo5ZY8b3/yRe/qAZ8pV+xlL9MM4ipq+JWqHEWSoBD+fEzHgswqYpauPz87IOMmKf5xEXVUMinUGoBLV6BOBEyIV3iWtmHJe6dT0Jc8phLLGaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8SkyaUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E55C4CEC5;
	Thu, 10 Oct 2024 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728549484;
	bh=93ri6kXjS04NlSJhVAtV+oc8pPS/l8+cSGguv6Oe0iQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R8SkyaUac/+DdD9Fz8FlFbr4ogKpWYvEmil2TC/fGkkWhTdhVbFl9Ju/ImbGCHQ7I
	 PJEte9XrXEZb4i1Yi4agDZBNlkRbV3l5sA6jGw4rEiO/qrAaG2nMHGtQ3xQzkFB+Ob
	 ZLmaRqMk13BVhdpr8Yx/k2tMjQ5aCaeCWoxyA2NRbd9pHBwyTX3YFh91qxg+/1SPNJ
	 ZySiqfc52f9s8+1HVFMWTgfFIlTRrzZtRjoPHwKoT/s4NG9O/T4pfs2GBLCUZjKJfn
	 asjCyqt5Yf+6Q0NvJuXA9MvzItshHH0Y5JM11UoICZxs1ZQlOVx77M4Kg9QPPSIFhu
	 q9cJsVUnkGTaw==
Message-ID: <35339817-a768-49e8-9b64-c52edbeb4d13@kernel.org>
Date: Thu, 10 Oct 2024 17:37:58 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241010080956.z3cw2mxxlgrjafhs@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/10/10 17:09, Manivannan Sadhasivam wrote:
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

This is for the rk3399... I am not aware of multiple versions of that SoC.
The pcie_rockchip driver is for that SoC only as far as I know. This is unlike
the Designware IP block which is used in multiple SoCs.

> 
> - Mani
> 
>>> +{
>>> +	u32 cfg_msi, cfg_msix_cp;
>>> +
>>> +	/*
>>> +	 * MSI-X is not supported but the controller still advertises the MSI-X
>>> +	 * capability by default, which can lead to the Root Complex side
>>> +	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
>>> +	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
>>> +	 * the next pointer from the MSI-X entry and set that in the MSI
>>> +	 * capability entry (which is the previous entry). This way the MSI-X
>>> +	 * entry is skipped (left out of the linked-list) and not advertised.
>>> +	 */
>>> +	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
>>> +				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>>> +
>>> +	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
>>> +
>>> +	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
>>> +					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
>>> +					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
>>> +
>>> +	cfg_msi |= cfg_msix_cp;
>>> +
>>> +	rockchip_pcie_write(rockchip, cfg_msi,
>>> +			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>>> +}
>>> +
>>>  static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> @@ -588,7 +616,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>  	struct rockchip_pcie *rockchip;
>>>  	struct pci_epc *epc;
>>>  	int err;
>>> -	u32 cfg_msi, cfg_msix_cp;
>>>  
>>>  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
>>>  	if (!ep)
>>> @@ -619,6 +646,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>  	if (err)
>>>  		goto err_disable_clocks;
>>>  
>>> +	rockchip_pcie_ep_hide_msix_cap(rockchip);
>>> +
>>>  	/* Establish the link automatically */
>>>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>>>  			    PCIE_CLIENT_CONFIG);
>>> @@ -626,29 +655,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>>>  	/* Only enable function 0 by default */
>>>  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>>>  
>>> -	/*
>>> -	 * MSI-X is not supported but the controller still advertises the MSI-X
>>> -	 * capability by default, which can lead to the Root Complex side
>>> -	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
>>> -	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
>>> -	 * the next pointer from the MSI-X entry and set that in the MSI
>>> -	 * capability entry (which is the previous entry). This way the MSI-X
>>> -	 * entry is skipped (left out of the linked-list) and not advertised.
>>> -	 */
>>> -	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
>>> -				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>>> -
>>> -	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
>>> -
>>> -	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
>>> -					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
>>> -					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
>>> -
>>> -	cfg_msi |= cfg_msix_cp;
>>> -
>>> -	rockchip_pcie_write(rockchip, cfg_msi,
>>> -			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>>> -
>>>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
>>>  			    PCIE_CLIENT_CONFIG);
>>>  
>>> -- 
>>> 2.46.2
>>>
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
> 


-- 
Damien Le Moal
Western Digital Research

