Return-Path: <linux-pci+bounces-18025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705B9EB060
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C6168FF3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F81A2653;
	Tue, 10 Dec 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XoEkw6lP"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5D23DEBA;
	Tue, 10 Dec 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832267; cv=none; b=k2Fp4FLgHJsDqVgbsQeuC+P+3GeCzWZPCB4e8fJ9GovtXZwHk4Zw8J+Q7vE16uyXfAAHrdqOQUABTZOaVAjCOftqNWZJ2hUgl6tYk8EXEJelFFlVq47eQBORblnaWwfCHDvRy8q/Ej+4fV3Dlvpai3uxv2dVbF5F7+Gxz8liNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832267; c=relaxed/simple;
	bh=zHIvZOeg5xy93LPPKuXKxIiMOA8gdaqFCgrklSYixNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrWVj5FAi6R92yTKI5QztfciGyoxyeswAEqSIcxWieTAdoydwLz52YHHMtgTj7McnzkaQtKXreEW8KrkXFOwjToRt0ElWBxF0HQOXiY8zoUUPGWctRdr2pU37ha4OyNfdDc8qQVDp/rrnpzTlXkxSI1J1Lsxa3d9PU2Yk70HeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XoEkw6lP; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733832260; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AzdJuUPXgsd+8k2HSMzcMHGonlQsEgs1Lrm1CL/U2eQ=;
	b=XoEkw6lPCWuSOPsRq+O6FKO9m2gnHxIMrDSNAQZLK3uxFMZLtaTz69wPXglArLJRpYRq254ERRmcwbSjA3Rzy6t2KFnSHxdVjnWtPKEAs6wRlr/Ew6+bN0F2L7zZLpF/IA42wm2ZOQXvXDrLRVxWjeIRgG2zTcCirFUczDdVvm0=
Received: from 30.166.1.177(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLEroS4_1733832258 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 20:04:19 +0800
Message-ID: <5a1ef0d2-be24-4865-8e23-159d001ac6d6@linux.alibaba.com>
Date: Tue, 10 Dec 2024 20:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor,
 Revision
To: Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20241209222938.3219364-1-helgaas@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241209222938.3219364-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Bjorn,

在 2024/12/10 06:29, Bjorn Helgaas 写道:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
> Devices from different vendors may advertise a VSEC Capability with the DWC
> RAS DES functionality, but the vendors may assign different VSEC IDs.
> 
> Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
> chosen by the vendor.
> 
> This does not fix a current problem because Alibaba, Ampere, and Qualcomm
> all assigned the same VSEC ID and VSEC Rev for the DWC RAS DES Capability.
> 
> The potential issue is that we may add support for a device from another
> vendor, where the vendor has already assigned DWC_PCIE_VSEC_RAS_DES_ID
> (0x02) for an unrelated VSEC.  In that event, dwc_pcie_des_cap() would find
> the unrelated VSEC and mistakenly assume it was a DWC RAS DES Capability.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> Sample devices that advertise VSEC Capabilities with VSEC ID=0x02 that are
> unrelated to the DWC RAS DES functionality:
> 
>    https://community.nxp.com/t5/S32G/S32G3-PCIe-compliance-mode-set-speed-to-5-8Gbit-s/m-p/1875346#M7024
>      00:00.0 PCI bridge: Freescale Semiconductor Inc Device 4300 (prog-if 00 [Normal decode])
>        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>        Capabilities: [158 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
> 
>    https://github.com/google-coral/edgetpu/issues/743
>      0000:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1) (prog-if 00 [Normal decode])
>        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>        Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100
> 
>    https://www.linuxquestions.org/questions/linux-kernel-70/differences-in-'lspci-v'-output-4175495550/
>      00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 13) (prog-if 00 [Normal decode])
>        Capabilities: [90] Express Root Port (Slot+), MSI 00
>        Capabilities: [160] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 
>    https://www.reddit.com/r/linuxhardware/comments/187u87b/the_correct_way_to_identify_the_kernel_driver/
>      04:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c852 (rev 01)
>        Capabilities: [70] Express Endpoint, MSI 00
>        Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 68 ++++++++++++++++++++-----------------
>   1 file changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 9cbea9675e21..d022f498fa1a 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -20,7 +20,6 @@
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
>   
> -#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
>   #define DWC_PCIE_EVENT_CNT_CTL			0x8
>   
>   /*
> @@ -100,14 +99,23 @@ struct dwc_pcie_dev_info {
>   	struct list_head dev_node;
>   };
>   
> -struct dwc_pcie_vendor_id {
> -	int vendor_id;
> +struct dwc_pcie_pmu_vsec_id {
> +	u16 vendor_id;
> +	u16 vsec_id;
> +	u8 vsec_rev;
>   };
>   
> -static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> -	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> -	{.vendor_id = PCI_VENDOR_ID_AMPERE },
> -	{.vendor_id = PCI_VENDOR_ID_QCOM },
> +/*
> + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> + */
> +static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> +	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>   	{} /* terminator */
>   };
>   
> @@ -519,31 +527,28 @@ static void dwc_pcie_unregister_pmu(void *data)
>   	perf_pmu_unregister(&pcie_pmu->pmu);
>   }
>   
> -static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
> +static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>   {
> -	const struct dwc_pcie_vendor_id *vid;
> -	u16 vsec = 0;
> +	const struct dwc_pcie_pmu_vsec_id *vid;
> +	u16 vsec;
>   	u32 val;
>   
>   	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> -		return false;
> +		return 0;
>   
> -	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> +	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {

How about checking the pdev->vendor with vid->vendor_id before search the vesc cap?

+		if (pdev->vendor != vid->vendor_id)
+			continue;

>   		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> -						DWC_PCIE_VSEC_RAS_DES_ID);
> -		if (vsec)
> -			break;
> +						vid->vsec_id);
> +		if (vsec) {
> +			pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER,
> +					      &val);
> +			if (PCI_VNDR_HEADER_REV(val) == vid->vsec_rev) {
> +				pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +				return vsec;
> +			}
> +		}
>   	}
> -	if (!vsec)
> -		return false;
> -
> -	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> -	if (PCI_VNDR_HEADER_REV(val) != 0x04)
> -		return false;
> -
> -	pci_dbg(pdev,
> -		"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> -	return true;
> +	return 0;
>   }

Best Regards,
Shuai

