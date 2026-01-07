Return-Path: <linux-pci+bounces-44155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D680CFCC4C
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 955DD3000DED
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A22E7165;
	Wed,  7 Jan 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="S25RtDC1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com [45.254.49.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3A221FBD;
	Wed,  7 Jan 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777235; cv=none; b=WvQgCeZIliU3Xao1SdgYlwW0eahrtAfVuD3KZCqCtzdLFIsKEjBcU308Wc6XFa5u6ULC+NJQsts2ydg/fEcFGIJzHzVbaVHaeLjdnw14HSC5CGPTPE4jLjHblkNGdzFfJn5NeuKpdA3msQLAQiFSY8/W9eFUIIdoleCEFvGQz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777235; c=relaxed/simple;
	bh=9+sabqTAKXVR8KuD20UJ7DsKZ16mPbrKjHmf1lZrq8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=msWHtKtG+TC0EYBNySZKNM0kRTeAW1CK4AOvvPk3C+o9FhqH+E68J3Otxs7059GWPQwi4yxuzAYWD9mFSKXJK++jH/BnTRsY0Y5PhI26AHHJIF5YOwkpTdN5o49jJdR63xB/XJdeGZWKk9FStY5BNzx5jgn4vxyLcEh3C83FswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=S25RtDC1; arc=none smtp.client-ip=45.254.49.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc712cd;
	Wed, 7 Jan 2026 16:38:15 +0800 (GMT+08:00)
Message-ID: <af7be4b3-93a0-4fb0-aa36-cf62d13c0579@rock-chips.com>
Date: Wed, 7 Jan 2026 16:38:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 3/6] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-3-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-3-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b979b4abe09cckunm9d739e2a8da29e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpJH1ZPGR1DQktNHUhNS0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=S25RtDC1T5vJVt0cKdxYZWFw8a6VRMKjMFdwabYQ87Ghxsq7mDgIhvubTQzZ5/lGhlsP9ab1mm+aYxKKmr7/HSzA1Ul2X7yLJvf1jLQ+S4C2SMq8KUAhUvYYX3BTbjh8ySoVh7znwoSd6MhIBftK1LaziyzTr/Yno25U7aa397E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=e/6Z10cVcegjp3tE+yfoBahMZjBikogOt93G++cVhkA=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> If the link fails to come up even after detecting the device on the bus
> i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
> dw_pcie_wait_for_link() should log it as an error.
> 
> So promote dev_info() to dev_err(), reword the error log to make it clear
> and also print the LTSSM state to aid debugging.

LTSSM might still be changing, so not sure how much value it would be
to print it at a singal moment, but anyway

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 87f2ebc134d6..c2dfadc53d04 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -776,7 +776,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   			return -ENODEV;
>   		}
>   
> -		dev_info(pci->dev, "Phy link never came up\n");
> +		dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",
> +			dw_pcie_ltssm_status_string(ltssm));
>   		return -ETIMEDOUT;
>   	}
>   
> 


