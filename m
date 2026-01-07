Return-Path: <linux-pci+bounces-44149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30639CFCA75
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4E0301A1BA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730E28E579;
	Wed,  7 Jan 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XcaBWMai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com [220.197.32.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1D26ACC;
	Wed,  7 Jan 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775134; cv=none; b=E9zA8LRLJvi4Th1N3qEE7NY2uU9f6Gau68nQ/tGdJnym86L9+0e3J8yu+i165i92QPAWSssNgyakehQiT3d/quMBLdgsgsDCmFdWXrJK0EyZH8qniGhBYi5SnGOApbV+Hjl020Pwm2Az0qhbqhQ/GYiBldLgvGDPiy4XspiKEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775134; c=relaxed/simple;
	bh=oGgzhkStGE6grw1QAIzYewmE5RHjXzSoNJNLxe4XKzo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EPPxceybJM+Y8bV71uSPBweaf1xPFUEsGkKPi50seEv1l+HY8RK9D3ptyaB+mgkj/HmWtxnvMXXiQetvr7iU0jmPP4aWPr/bIc8Q2x+SC2qctIJfdfpsoMSvt+upwZA4qKAsyI4a8rO9dE9R+YQAlz8Jp7mDECd7DgZr4fP/UYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XcaBWMai; arc=none smtp.client-ip=220.197.32.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc71390;
	Wed, 7 Jan 2026 16:38:41 +0800 (GMT+08:00)
Message-ID: <069fdf2e-7674-4443-9ecb-849793cb0ecd@rock-chips.com>
Date: Wed, 7 Jan 2026 16:38:39 +0800
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
Subject: Re: [PATCH v4 4/6] PCI: dwc: Only skip the dw_pcie_wait_for_link()
 failure if it returns -ENODEV
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-4-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-4-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b979baedc09cckunmf59944ae8da6ac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIaGVZLHx4YHklJSU5OGB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XcaBWMaiZpmRWgm4lunZnVXx8E+V3gW8z27rq+4rUdjDTEfH5S+ApUrSFF/yB/0zf+TnQtjJn1NKB2F31/stssx/RVMdCxVE8OZuFCYqaUGhs1+/GFCHu0N3i/WMc7Jvrhlr2hL3+jUGwoTVrUt9+7XlkcpceHm+xyE6EXRBqlA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=pdgoHY34rOjMsyYznpirJLK8jp6JSz00Yg53ZBTd8wI=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> dw_pcie_wait_for_link() now returns -ENODEV if the device is not found on
> the bus and -ETIMEDOUT if the link fails to come up for any other reasons.
> And it is incorrect to skip the link up failures other than device not
> found. So only skip the failure for device not found case and handle
> failure for other reasons.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index fad0cbedefbc..ccde12b85463 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -675,8 +675,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   			goto err_remove_edma;
>   	}
>   
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +	/* Skip failure if the device is not found as it may show up later */
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret && ret != -ENODEV)
> +		goto err_stop_link;
>   
>   	ret = pci_host_probe(bridge);
>   	if (ret)
> 


