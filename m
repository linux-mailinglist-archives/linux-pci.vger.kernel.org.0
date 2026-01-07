Return-Path: <linux-pci+bounces-44160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE7CFD023
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BDE3124302
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51D322B9F;
	Wed,  7 Jan 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ehust4Hh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com [101.71.155.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F993218B3;
	Wed,  7 Jan 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779017; cv=none; b=OFWIdvrw4ql9e/KLjxLHC5DH+UODey4g4zRbcIAPfGivBUpmV+Z7mKChSnCU8Zpsqd09w7z3mA/BwdQagSh/Fn/cLhIiQKhqqRnNTFN3ruhIUQtXamjp+J76t/dkiNRzL/uzaFwP/bQ2SO81S43e8Jb5n4OpSdekSulM5f82tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779017; c=relaxed/simple;
	bh=v6H8Q+5HtRkfi3hLhA2BhgTp5Lo+cHV7DGN0At2ttvQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SafDOtOOsbAyjt4m/yxdSoLvXOwXV1HyxbMhJsehREAbw11muBjM2+3tcleU0lvyYLJJLzNXMnj9Pbv2/MF8dNkQSbhXsFVIkdjJa08qWbZjvLk52/Fg6OxjxhVzpF1okeS8WCC2nfNrgLdFSj38+fdrjhIrt1R2NohsVZUtuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ehust4Hh; arc=none smtp.client-ip=101.71.155.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fce93f02;
	Wed, 7 Jan 2026 17:28:08 +0800 (GMT+08:00)
Message-ID: <6662785c-7912-4e58-a5b2-613ddac419c0@rock-chips.com>
Date: Wed, 7 Jan 2026 17:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, manivannan.sadhasivam@oss.qualcomm.com,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 3/6] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
To: Manivannan Sadhasivam <mani@kernel.org>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-3-9b5f3c72df0a@oss.qualcomm.com>
 <af7be4b3-93a0-4fb0-aa36-cf62d13c0579@rock-chips.com>
 <gtgvh7bxfsm7xoigg7tiqs7n42gnfbxsa4aqxtupqnr6ihxswn@gk7dcw2zbh7x>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <gtgvh7bxfsm7xoigg7tiqs7n42gnfbxsa4aqxtupqnr6ihxswn@gk7dcw2zbh7x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b97c8f75409cckunm330a1c758e8aac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgaHlZKGhhMT09IGR5NHk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ehust4HhZ8llb3eboDU8IIqDSzji5gyIlzeR7tIMboQwqjO2egvmvB4f7XuPSW+EPDHa5wfHpT/5CEoycg7yGjytlXPyDdhIAaNWUq4YvUFJBiFumGDprtYTnYyZE1tZBMN2hNI4hEa024Z1Zx5Z93NYOuNy+RkZoLBKkcOTORc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VIvMs1i/cn5NY2UPQsH2LMVuLFVSxHC/a7b87moHzDg=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/07 星期三 17:09, Manivannan Sadhasivam 写道:
> On Wed, Jan 07, 2026 at 04:38:14PM +0800, Shawn Lin wrote:
>> 在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> If the link fails to come up even after detecting the device on the bus
>>> i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
>>> dw_pcie_wait_for_link() should log it as an error.
>>>
>>> So promote dev_info() to dev_err(), reword the error log to make it clear
>>> and also print the LTSSM state to aid debugging.
>>
>> LTSSM might still be changing, so not sure how much value it would be
>> to print it at a singal moment, but anyway
>>
> 
> It is very unlikely that the LTSSM would be changing after the 1s timeout.
> Printing the state will allow debugging the link up failure.
> 

Most cases, yes. But I saw some reports that the LTSSM is stiling
changing between RCVRY_* and CFG_* when supporting customers. Especially
a buggy card I remembered, which sends some hot reset immediately after
link comes up. If it misses the first 1s wait for link check, then we
could see ltssm changing here. But better than nothing, keeps a log here
isn't a big deal I think. :)


> - Mani
> 
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 87f2ebc134d6..c2dfadc53d04 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -776,7 +776,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>    			return -ENODEV;
>>>    		}
>>> -		dev_info(pci->dev, "Phy link never came up\n");
>>> +		dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",
>>> +			dw_pcie_ltssm_status_string(ltssm));
>>>    		return -ETIMEDOUT;
>>>    	}
>>>
>>
> 


