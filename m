Return-Path: <linux-pci+bounces-19091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BBD9FE764
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5B16236D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789391A8417;
	Mon, 30 Dec 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpB6tEpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DDCA5A
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571054; cv=none; b=F8wWDpOiZeVLo3xI2vY8K38QAx4eMSIdrDVmXufc2cqK+cChm9diasdNfro9qHRGewBX6W4CS8NHUIifpnlJRBws70x2Hgkoukq4DGo9URFM77gB1YRS3/WjXxGCsKVaea5j88eR5dWbWaFz/s6i7/cE/kP2Ij5FpfWH8hW5TT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571054; c=relaxed/simple;
	bh=XD35P6k4H4YdSMUIGKnYdsnRKZ9J6Njp6z7u88h3q4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGt80ZtXgl21gHBy5Hwt80syDoke022vP74wM90FLZmUTdw7yQp937sLb5gQQ/q7mdleQWUKmWeiW/cef1x/OK/Zt7xfqDD/h0s5SGRycc5toRHgeBGu0I/J054FzRk8M0LRQUZROhS/XpwyfSxalABRm7i99mmAgwtu7xBpQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpB6tEpq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUBxtCb024433
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JyyKYsl7DFCLsbwMpwlajhYJ1z5ldXz7DIn7vZjoBGw=; b=EpB6tEpqABanlW7O
	d5cKFrfM7UPJP2z7aAEFJgpK4EZAXF9u3T6IokxxZtRfCu0hC0boahNjhPzUGr+v
	8sYucaWxil/SH6pFOiQru9VETPornlvdCR6THondlxj4BjoZ/fo307JKv3omjSRD
	djtq9Ft95Kg537zzQlUsu/ZsuNURSWbiPSh+C8PZh8PJ2eBJROrvtrXH8QGNreVF
	CMs2vgQj3OZxH2G82MITkFcPNVeiyIAJKyVW6w8lG1tWtUC5lQJMH3B8xpxxHgvk
	EfFPUsJ015d/KdigOeYV9AUoIQPeMH9kgsMCm9tFe13Ttm5IoLYfDOyNGEIgVPS8
	E2kchg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43uu4src8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:04:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6faf8b78aso98372685a.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 07:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571050; x=1736175850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyyKYsl7DFCLsbwMpwlajhYJ1z5ldXz7DIn7vZjoBGw=;
        b=YxCWd5Oq1rUm5fxuVima57rVp1w8g/H+JIzxRnRvzp2ZmFMouNmUSLPCwoi/M/rSZ5
         jaO93xYpZZVgSOTeJ1BmrxcvI7N1AUOcbFIvx4xi9JSNpoNl1UBJN3awE3HDwsV7LwfN
         aID3XMPz05UK8yxSqsFdRwkGO/ZLn0brLXRN7SieD2oYgA1KuViJDR5cCbPAEqGYQg9U
         vvje4ULDoT+KXKRtfQlDNotY/8zv9iJcgQHeqbiwfSPkUEDXZqYDgD84FAADzmz7D183
         fcwfEp3u3p9QICdpJYOmuRZJPLrh1upv0tCBwyoX/9QB8KQq5hkcUvE0rCNXVWJt1vAg
         GIZw==
X-Forwarded-Encrypted: i=1; AJvYcCWOEkgG324UA+Cnuprp3a4iEDScrfqtuc5YbeuLpvEj5G93oWUNPtat0vhaoNTid1mKqFjM446Dbig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvTMl450XOdSPCUUMNlbGUM3QfABjiDB4kB21qqf01Eq3YUFZ
	ZIQ5VJbZGVYBs+89izLPpLFY2Gxfviv98K8wkPNLKELEivAyJzalRSJa3tCg8+k9KFARyJ946SS
	eLFP5lMzaTn/CTXfVH8HvAZYB1ghiSTrsTiir3c3cefzT0ThAu4/QRm9vyVU=
X-Gm-Gg: ASbGnct5GB6Rf2M1bQAwTaUVKyX+XHXNrCGCmC6InMP6aydqvgjMbudUdi75o2t1ZEF
	KLWEJMsjIimvE+Azrtgq8l8SOiE3zdoPPZHpqIzm85gLmMumPkwV+amESTaHiCVpynWDdKXyE27
	YlJW78M5qV3zicOsxOhC8CFJjsn/dqikm80UK52VbKtpWkKUyvg3S1p6vtrRF9pfB0fyew8pgLq
	WhTa2+a+L11lox9jYcNjxKquZMvBAjaRbtA3ybiZd2rXng4r1g2dJuX+nSZP6Qz1lZ70VO1Mu6w
	aFfxzlXBeZEov6dALJYFhJinyVC90e7PAcM=
X-Received: by 2002:a05:620a:4096:b0:7b6:dae0:3eae with SMTP id af79cd13be357-7b9ba73a951mr1886676085a.6.1735571050319;
        Mon, 30 Dec 2024 07:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcq1jtuz/dIKh/1mtUNEnjT3/KVCp8sEhK2kgpaguEjtZFZkJbdzNhJrjAHHxyh6zu+viIkA==
X-Received: by 2002:a05:620a:4096:b0:7b6:dae0:3eae with SMTP id af79cd13be357-7b9ba73a951mr1886673085a.6.1735571049950;
        Mon, 30 Dec 2024 07:04:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f23bsm15251674a12.32.2024.12.30.07.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 07:04:09 -0800 (PST)
Message-ID: <12fb6164-fa53-46e7-9a22-bb9b373f9860@oss.qualcomm.com>
Date: Mon, 30 Dec 2024 16:04:07 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI: dwc: Add ECAM support with iATU configuration
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, mmareddy@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
 <20241224-enable_ecam-v2-2-43daef68a901@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241224-enable_ecam-v2-2-43daef68a901@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RP2tLFHklnnkdUdF-VsCVH_UcRY9flNF
X-Proofpoint-GUID: RP2tLFHklnnkdUdF-VsCVH_UcRY9flNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412300130

On 24.12.2024 3:10 PM, Krishna Chaitanya Chundru wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> Configuring iATU in config shift feature enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to achieve this.
> 
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property, add a function
> which checks this. The DWC glue drivers uses this function and decide to
> enable ECAM mode or not.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/Kconfig                |   1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 136 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  11 ++
>  4 files changed, 130 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..73c3aed6b60a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -9,6 +9,7 @@ config PCIE_DW
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> +	select PCI_HOST_COMMON
>  
>  config PCIE_DW_EP
>  	bool
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d2291c3ceb8b..4e07fefe12e1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,61 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = {0};
> +	struct resource_entry *bus;
> +	int ret, bus_range_max;

resource_size_t for bus_range_max since you feed it the ouput of
resource_size()

> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +
> +	/*
> +	 * Root bus under the root port doesn't require any iATU configuration
> +	 * as DBI space will represent Root bus configuration space.
> +	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * remaining buses need type 1 iATU configuration.
> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;
> +	atu.size = SZ_1M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	bus_range_max = resource_size(bus->res);
> +
> +	/* Configure remaining buses in type 1 iATU configuration */
> +	atu.index = 1;
> +	atu.type = PCIE_ATU_TYPE_CFG1;
> +	atu.cpu_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * (bus_range_max - 2));

This explodes badly with:

bus-range = <0 0>;


> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	return dw_pcie_prog_outbound_atu(pci, &atu);

A newline before the return statement would make it prettier

[...]

> +bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
> +	struct resource *config_res, *bus_range;
> +	u64 bus_config_space_count;
> +
> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +	if (!bus_range)
> +		return false;
> +
> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (!config_res)
> +		return false;
> +
> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
> +	if (resource_size(bus_range) > bus_config_space_count)
> +		return false;
> +
> +	return true;

return bus_config_space_count <= resource_size(bus_range);

Konrad

