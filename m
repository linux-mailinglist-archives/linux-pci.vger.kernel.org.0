Return-Path: <linux-pci+bounces-42234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1AC90781
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 02:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21B8634B0F7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 01:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882221CC5C;
	Fri, 28 Nov 2025 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KWtPd9Tk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EF1A9F9D;
	Fri, 28 Nov 2025 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292158; cv=none; b=qa7SlJAna2/3d9tN3dBb4Bp+RgfAVizfqb1QIda8LPS4JEI306OOp+W9Rlm1kj77icXTpzgvxBZcPUSlKnPwSraAZxmlSd8jd15sJL8eJncsazgJLsz0pybLHvlrffnc6VBtbrfEvgwx+mtjhXM5jSDMBx2OaHKl9sCY0gHSFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292158; c=relaxed/simple;
	bh=g9ZBThi+XNu/ViU1HkBvkomkDdQeigxQ/QTvaFlI7Pk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KoP5cQBi62s/qCIDO8ptpksv231LidVuYH/g+ga0486O8ZbzuPJwAyc/o4Y+SInnGObuo/HRIskNlF1MI3/QyGM6ua9PTefTshvAvjM2b5lgkF+9aeDQ02K+7NY0RbeNRk+0z+Pg3H3a2KU+relSNLQWor/fohF2hRyhtux9Rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KWtPd9Tk; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2b2e9237e;
	Fri, 28 Nov 2025 09:03:56 +0800 (GMT+08:00)
Message-ID: <09aed728-51ca-42dd-b680-f6597e0ac00a@rock-chips.com>
Date: Fri, 28 Nov 2025 09:03:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Program device-id
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
 <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ac7fcf84c09cckunma2bff526693f46
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9PH1YZSU9KHh5PGkodGB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KWtPd9Tk8o/15mVxcrXi6kjy/rSGzCH9tyJgy3FXvt6mrM+qs+KwycnK4Eg9qzw/m72nyKlskHraSrBLaHYWb1wV1DGEm2gWzjPaE+Uqi5joNxt/1N/RvTT1LOdlt9q6OdieiOWeKQbesx65DDNSwN/rhLZtjZN4Pv/+gvTCUD0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XMS+KJ5HUPJOKP519mm/6YRXCethP2LMIjLGg+exrR8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/27 星期四 23:30, Sushrut Shree Trivedi 写道:
> For some controllers, HW doesn't program the correct device-id
> leading to incorrect identification in lspci. For ex, QCOM
> controller SC7280 uses same device id as SM8250. This would
> cause issues while applying controller specific quirks.
> 
> So, program the correct device-id after reading it from the
> devicetree.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>   drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..e8b975044b22 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   		}
>   	}
>   
> +	pp->device_id = 0xffff;
> +	of_property_read_u32(np, "device-id", &pp->device_id);
> +
>   	dw_pcie_version_detect(pci);
>   
>   	dw_pcie_iatu_detect(pci);
> @@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   
>   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>   
> +	/* Program correct device id */
> +	if (pp->device_id != 0xffff)
> +		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
> +
>   	/* Program correct class for RC */
>   	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..eff6da9438c4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -431,6 +431,8 @@ struct dw_pcie_rp {
>   	struct pci_config_window *cfg;
>   	bool			ecam_enabled;
>   	bool			native_ecam;
> +	u32			vendor_id;

I don't see where vendor_id is used.
And why should dwc core take care of per HW bugs, could someone else
will argue their HW doesn't program correct vender id/class code, then
we add more into dw_pcie_rp to fix these?

How about do it in the defective HW drivers?


> +	u32			device_id;
>   };
>   
>   struct dw_pcie_ep_ops {
> 


