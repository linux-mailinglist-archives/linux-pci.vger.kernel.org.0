Return-Path: <linux-pci+bounces-27675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6453AB6321
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ADE1625CA
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFD1FDA6A;
	Wed, 14 May 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drMN6nqj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EC1F6667
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204225; cv=none; b=dR3utnjoaihurDFZuNRIuP+WR0XewW3l6tTLoT3Hrlw+Scjx097/X8G0ouUD8zF2lNSmLnnXa40n04bxU0o2o253T4jgheB284kTTz6q1Q7mehIBvcvdy/cAB9t4YExNonJj/SDMvt+2fXohloqzkWIzhweGjcIz/fRZryzFACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204225; c=relaxed/simple;
	bh=4Fu/RdYe0cD2vuBPZ6g0OA+NwElbWIiLpI6udKPtunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cji+fzCGX37BVDbYhf334gDMnkhHOM9mdbJZX6ie0Df1v8X0tT1szwz+myxryl20xzQAPAWjhuVOVc1mkKzRenORNOYM8C6INPBSXFGKe9H8Gv5NHgMuBjgttStkIqZZIz4XlX315Q1wsvgdhVx3v1pjJ/+TfW7BTPo9zc2jXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drMN6nqj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2HWbp029401
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3OYdEv51QzKfvKyl8ZgwIQYfMr0WzoPUqWedNGx4V8o=; b=drMN6nqjFRSig3yV
	lDvbbLMYcz3VTLwBtALpmrmgjWr5A7C2sAmiLc0n9G9J3Cb9gZRrbvt2OA9MSndH
	8kEPalU6Wrlkl7vGymmxcj69V074a1+ztfi8sgZbIuVT6J52RKRzv7D9yprM6hxK
	i2NCka/ruOjlQH8AHhLBokDsg5dvMvZ71aB1sQ35yFnbdGx9tSFLLhRJno5g8/4i
	5uahPUKstKk8F+r1jupge0AQ1Xp6E785gcp39Y9lE7KE6+mSyIFMVN5J+xMcyZan
	aws38upccg/H3Eu5bdD3y4N4o4xsBLielPV3xSj6TOoOlAdoPaUzKxiWO2DXlWQ2
	oz5gFQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnhmns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:30:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7425ba8300aso2886662b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 23:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204220; x=1747809020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OYdEv51QzKfvKyl8ZgwIQYfMr0WzoPUqWedNGx4V8o=;
        b=omufJAyuq7BZsFlQkKwOcdUttMNKRhrbeID045Ks3V+A9CfDpNhhK5DZLL7tqBMG7/
         cMYenmjjVL7eUReHpDALOiItvFZNvprnwTZlhRYzLz42pQ7BqjyHrGyTB+qhcILE9gtU
         cSlviM6gEOPDC0wE753q7hTVRn21WDLv9wYver/mTs2IpoGO2IA+C2MY0mKXz+v8/107
         HK0Ha0Z17JMKndRR8rMa37nDgD3hztssvWkQSWbxA4+Z442aC/B+juSGktY7FochDOD0
         H9wbitVqV9Tjc3wAp6uN9Noo93u9G10m6vuU4cbkv13yOUuIMVJc2qMLyyD8Lxw1LJcb
         ieLw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9B2g1/EptP8snxSeIQsFL7KLiUONlsaMpFiIRjA1fywEwfIGORyvXbI2GVAbFTq9C9WGpnipBIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHKq485m+gl8sw0W98Rxl//UDLBc9wiFWif8gqVBqsamApci1
	s3s3krjWf73B/WufQXlYSovYcaYkmDUGi0Dn/wd/lb2/53NsZCic/a7vfX67zk7i/HxKwPnRTFh
	QkVpZM8A7AE8eg+s4fAPQ57k//Xhh298mqDy6hiSADvcJy7cspPUAYAjgJx4=
X-Gm-Gg: ASbGncssEu9wKrJ82lHSvZVgyGjw8gLU9iYjxXXWy3Itv1xx4khAqBsjNDZdgt16BgE
	y2rM2z8kQ2Wt4hysYR2/sNCx7GvHGgyPlpSTylB2X+OlHB3jz9hisq/zppfqH0QnoVCbKVokHUo
	mkO/hy2URIPmH0NSgw0w2L2Ru4OMlLc/OyhxW/gAPoSbLvr6bURD4KjUtqjBp7jOSpEDLTpTG1/
	apYQWjGI6fVu3ElTW2FpArcJoVIV81h4XJ2ODo8qG4X9IbfEQQ1fbV2aP6IubVPsp578Q8LnBSa
	+ksHVTUGbgylT401+szNgMyEVUvnSoXt2fPV2G8cPA==
X-Received: by 2002:a05:6a00:849:b0:740:6f69:dce9 with SMTP id d2e1a72fcca58-7428915208cmr2991299b3a.0.1747204220390;
        Tue, 13 May 2025 23:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo6KctwAue9F+Vx18ACg2bqMflRXZkaB6cash8mo/C9AGwxsZu65dw2flirVj1uPaGevYVIQ==
X-Received: by 2002:a05:6a00:849:b0:740:6f69:dce9 with SMTP id d2e1a72fcca58-7428915208cmr2991254b3a.0.1747204219961;
        Tue, 13 May 2025 23:30:19 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704ba3sm8811721b3a.31.2025.05.13.23.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 23:30:19 -0700 (PDT)
Message-ID: <8006a0ae-b45d-d22f-65a9-20a65f3224b0@oss.qualcomm.com>
Date: Wed, 14 May 2025 12:00:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -_w2uUv29hwNGbwoGxAy19Y_rpTw2CfJ
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=6824387d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=WP6hIalcOMfy4p2eL3AA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -_w2uUv29hwNGbwoGxAy19Y_rpTw2CfJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1NSBTYWx0ZWRfX65qsAbnAavbZ
 3trRQjEE+D0bxjmx45XlrgdUGDXPDXFSh4TwW1rhKO9hx+bze+qkmKbU0pLpGGT6v7vDPPhpo12
 a8GJBZTGRWfiIipsSTX673o2XMS313G5Xz2Lmzvqr47X45AwPuX2awzYRWc8VH5imtADKpmlEOk
 YNnTAqK7AX++uv5Wq+eGKOJo8raKfVBP9GgeGXgics6vVZJWFctFjXctGoWqCoOJkUevc49kfjB
 KnKe4S6C4xhK41ReO+H5pdGQOATRl9nUvxhTNlNRzHHzd76stncNt5dxAtT/hPM/0BuMzWzZSlY
 yrAtvkxx3pE2ImZKIW/Aju60fjD3wNGROIRPqvGSy54GEOwA3t+7geOwwZOmSsTJYtrvKvCMRHz
 xGugZcJwbrUhwpm8xsYDAZ+KzPrhFNNWqtzp+OhN33vzaAhPFGpdlMeZRObRHdsEzi9a65zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140055



On 5/8/2025 12:40 PM, Manivannan Sadhasivam wrote:
> The PCI link, when down, needs to be recovered to bring it back. But that
> cannot be done in a generic way as link recovery procedure is specific to
> host bridges. So add a new API pci_host_handle_link_down() that could be
> called by the host bridge drivers when the link goes down.
> 
> The API will iterate through all the slots and calls the pcie_do_recovery()
> function with 'pci_channel_io_frozen' as the state. This will result in the
> execution of the AER Fatal error handling code. Since the link down
> recovery is pretty much the same as AER Fatal error handling,
> pcie_do_recovery() helper is reused here. First the AER error_detected
> callback will be triggered for the bridge and the downstream devices. Then,
> pci_host_reset_slot() will be called for the slot, which will reset the
> slot using 'reset_slot' callback to recover the link. Once that's done,
> resume message will be broadcasted to the bridge and the downstream devices
> indicating successful link recovery.
> 
> In case if the AER support is not enabled in the kernel, only
> pci_bus_error_reset() will be called for each slots as there is no way we
> could inform the drivers about link recovery.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++++++++++
>   drivers/pci/controller/pci-host-common.h |  1 +
>   drivers/pci/pci.c                        |  1 +
>   drivers/pci/pcie/err.c                   |  1 +
>   4 files changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index f93bc7034e697250711833a5151f7ef177cd62a0..f916f0a874a61ddfbfd99f96975c00fb66dd224c 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -12,9 +12,11 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_pci.h>
> +#include <linux/pci.h>
>   #include <linux/pci-ecam.h>
>   #include <linux/platform_device.h>
>   
> +#include "../pci.h"
>   #include "pci-host-common.h"
>   
>   static void gen_pci_unmap_cfg(void *ptr)
> @@ -96,5 +98,61 @@ void pci_host_common_remove(struct platform_device *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_host_common_remove);
>   
> +#if IS_ENABLED(CONFIG_PCIEAER)
> +static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	ret = pci_bus_error_reset(dev);
> +	if (ret) {
> +		pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	pci_info(dev, "Slot has been reset\n");
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void pci_host_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (!pci_is_root_bus(bus))
bus here is always constant here, we may need to have check
for dev here like if (!pci_is_root_bus(dev->bus))
> +			continue;
> +
> +		pcie_do_recovery(dev, pci_channel_io_frozen,
> +				 pci_host_reset_slot);
> +	}
> +}
> +#else
> +static void pci_host_recover_slots(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host->bus;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		if (!pci_is_root_bus(bus))Same comment as above.

- Krishna Chaitanya.
> +			continue;
> +
> +		ret = pci_bus_error_reset(dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		else
> +			pci_info(dev, "Slot has been reset\n");
> +	}
> +}
> +#endif
> +
> +void pci_host_handle_link_down(struct pci_host_bridge *bridge)
> +{
> +	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
> +	pci_host_recover_slots(bridge);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
> +
>   MODULE_DESCRIPTION("Common library for PCI host controller drivers");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index d8be024ca68d43afb147fd9104d632b907277144..904698c1a2695888a0fc9c2fac360e456116eb1d 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -12,5 +12,6 @@
>   
>   int pci_host_common_probe(struct platform_device *pdev);
>   void pci_host_common_remove(struct platform_device *pdev);
> +void pci_host_handle_link_down(struct pci_host_bridge *bridge);
>   
>   #endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13709bb898a967968540826a2b7ee8ade6b7e082..4d396bbab4a8f33cae0ffe8982da120a9f1d92c9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5781,6 +5781,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
>   	mutex_unlock(&pci_slot_mutex);
>   	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
>   }
> +EXPORT_SYMBOL_GPL(pci_bus_error_reset);
>   
>   /**
>    * pci_probe_reset_bus - probe whether a PCI bus can be reset
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b834fc0d705938540d3d7d3d8739770c09fe7cf1..3e3084bb7cb7fa06b526e6fab60e77927aba0ad0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -270,3 +270,4 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	return status;
>   }
> +EXPORT_SYMBOL_GPL(pcie_do_recovery);
> 

