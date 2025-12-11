Return-Path: <linux-pci+bounces-42928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58B7CB4B71
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82582300CCE2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91714231830;
	Thu, 11 Dec 2025 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OsXE4wgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45E22D785
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429859; cv=none; b=u2pjR9PThEid8WdWHvTAS0BxFp99pIA6RzRwZ0/G68RHGEhpTp2pEC5PkxP1JFHgH5jb8GdOJ/S33rwJUiAfWyQFLI+OCDV7MPjAaLz7b4wadPyiZ7wjhCCjdVde+5o5D3Xq6+KiOSWLCGWMhq4PtzOVxcphsB3LXRaFYf5M88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429859; c=relaxed/simple;
	bh=L3kBCkR6bz7xB/GBmqxDm9ykN8Ka4gzIISa5U8ODASM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbxSodeStiqiHtbsqkvTJDwzmaO012zGImAdGnS0knMGhviVsexipbJe09zpE5cT17QkCbwFrWV8R8N1MY2TW568aVLu7PivEjd2Glcy9dAIi/hvQosEH8u/iDMXM/zIaBXQ49ArE09jCZv+0Gb6ywRB+jS6UTqpz9HzshHWy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OsXE4wgv; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2cc697844;
	Thu, 11 Dec 2025 09:41:37 +0800 (GMT+08:00)
Message-ID: <a35cdd13-0d34-458f-a298-4ed0625a3cae@rock-chips.com>
Date: Thu, 11 Dec 2025 09:41:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add L1ss context to ltssm_status of debugfs
To: Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1764035632-180821-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b0b12262f09cckunm1b35ac283f825
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpDH1YdQ0NCSBoYSxgaTR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OsXE4wgvIWz0QX0b4VkoZB8JfzHbqDeyCC8mOb4rGHRtOvDMePd+vpVDx85shn8KQxKQk4ANcK4pk40RaTGKkvZlgTiPLGHivpX/dJu/9uLY9/Y3dB+fftVBZkluOFuBjSv7IUWbSJieLg00fkU4yQF7QruZ+K28GTUL+xMTkyg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=XlDfFGFtAFZVLp+msSqrCU/WCcfPH09u01tgS94bf7I=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/25 星期二 9:53, Shawn Lin 写道:
> dwc core couldn't distinguish ltssm status among L1.0, L1.1 and L1.2.
> But the variant driver may implement additional register to tell them
> apart. So this patch adds two pseudo definitions for variant drivers to
> transltae their internal L1 substates for debugfs to show.
> 

Gentle ping... :)

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> This patch is based on latest pci controller/dwc branch given that L1ss support
> for Rockchip has been applied.
> 
>   drivers/pci/controller/dwc/pcie-designware-debugfs.c | 2 ++
>   drivers/pci/controller/dwc/pcie-designware.h         | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 0fbf86c0b97e..df98fee69892 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -485,6 +485,8 @@ static const char *ltssm_status_string(enum dw_pcie_ltssm ltssm)
>   	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
>   	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
>   	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
>   	default:
>   		str = "DW_PCIE_LTSSM_UNKNOWN";
>   		break;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index d3dc0cd8e7b5..3f4611882e29 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -380,6 +380,10 @@ enum dw_pcie_ltssm {
>   	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
>   	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
>   
> +	/* Variant drivers provide pseudo L1 substates from get_ltssm()*/
> +	DW_PCIE_LTSSM_L1_1 = 0x141,
> +	DW_PCIE_LTSSM_L1_2 = 0x142,
> +
>   	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>   };
>   


