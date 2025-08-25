Return-Path: <linux-pci+bounces-34679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5EB349BD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B823B6449
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AACE3093A7;
	Mon, 25 Aug 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LMgPx6M/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F2307AF9
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145142; cv=none; b=Jdih9Ef5OKPqFVS2PFIYsRu9wJEEjK3gDUBwJf1RcYABEz5GmdCfkpyRJd+CdbBAOq64DH9nwYl/OQgGgXpMHXKls5FjWlFB57SUPwhax1mFrt7A8F1gP+nr9gtVElB8CGKMpnShBlQVFfz+7G5eH4OeWBnbX9WmIhpMTo0gW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145142; c=relaxed/simple;
	bh=cvUm6zxQrVlFZAWEO8Grh3hyegMPEmfg+le2PJ3EYtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX51zZkWkTfX8JUHGcPCTeqTsQRSIsuQYB+jjpmxjsF2neSH+FQKampuU47NPBYCV2w6w6JhL/G4+GyEdoE6ilCrXijt3IQ0OLsBDxU0SY3FjqI1SzyqWCgOZjfuOej+82sFPzv8dyhDiASPE3Y+CA9nY6bFn6ebf3r3i1WhlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LMgPx6M/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGcCLl018809
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 18:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6A280ECCuxHYYu+C8Aygeam4jG3GMOZao8i9RHRtO9E=; b=LMgPx6M/2qQjGSQI
	jbshBnr+jFTyfx2qPnDvuaL7Mg+i5LVZV97IMzRZlhRKMwULeZgqrnOJTvKZDYxQ
	62Qu9kVNC/FXdCgY17SxXTF/oMFmNVmz5aXJzZZWqZdWct8OMq/g85a2/NYqJY3h
	8WMi3CjAYsa32PqmRv0JQy6Z7STM3XvWrwJd1YyGPHOGjxKegml7bKpc51B2rDqq
	LCKCmu8qjn4TyEVNn/nqHYMzANHPILOaLfJwhEae1PZc+2/xO5EKlTJTbO2GFA1O
	aAeGgSJje5UYd24b+7FWDupCoQ29WRtBBpVRVE2WuGkoQmkjeCSFnYORA/cmVgqd
	Wmw0Mw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfe1r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 18:05:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771f1645e31so392811b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 11:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145138; x=1756749938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A280ECCuxHYYu+C8Aygeam4jG3GMOZao8i9RHRtO9E=;
        b=Z8INJL6/v4FqZXrUa3ji3ToGqONSWCIIkddEPN4YncdHNkkiw/b2zWPxwaFz2OdFTv
         VDHjiiB3R0Z3e8LrII5eZ44IdQ3qb/RRE5mjDQOP3IIpOJIsisxubkveSYGASuoOSV3B
         cANUrwZ05OWsJ2cRCYpI8n9G1oh52aazyK4JtOMinYbZml7CMTCfYdFMMo24HdFu/8Ed
         87MdUVcqwZmV6pKDhcaChVA0MgJszRt/SlbQEZnUDC6yISN+7UOEAz8rtQkqYjhkyeP0
         p426sDGju334CDP6XejWRUQGItcubxDrrhFnU9i566FsdpaJXibbkc2cDkLXfB8WbzG3
         Wf8g==
X-Forwarded-Encrypted: i=1; AJvYcCXzvL4oSd2UrUOxLnNgsA0hRT7nPl3lkiTxI/GJGp08bgGnwI5ODz8n2xglhCOXzlI//Ief/ZFTJ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUxohRNHLbbLQCPRbEGvvoLqAsS/I+15dMq39NL6RT6i4BWky
	IBDTSzZmpGGw2nl1HB/3Y6mg6WA2vmg/+vm7Kscyavt8qM+yQDFeTWmAl9v955IG9OimgbPhKIu
	zcYDDBvdbwUvqI/52c5smvbukh3Izf2Kx6OpFDQJ2BFQVOUAvNsfI5yB9Ipe8cLI=
X-Gm-Gg: ASbGncvBljWxUGZZ/K9T7QOD/iM+r6rJhODbxjCF0Lfp3tkvvzPGKyWWevJaAvGhL0V
	VwqcawpS6qL1S6rhRJPDvhiv1HhMM33AQS5CxRH3MF5KpQ09TvSHfPmci1ev8ZWwJia+ZHh2eAR
	NDHmhK8hFWdhVehiB/dw+XRwnjmxG2LuuCK0P01fHcvfhA/jRC3gB0xiUJLkoZLWAYKc0ifeDMM
	pPeOcs0UhBkFAfgrFBFA9WktR8uyZWuLt3OGkIAPczgg3AESZQvg50XYuxubeQBD/VMqSt5L9nh
	dIu95w6o3RGbQvRAJG6J+BXextebUTOqvzsZXl0Pk/AmtWeRDflr48/b3yq9h8gTWPNT+urV1Gh
	zBIFfuhE2NA==
X-Received: by 2002:a05:6a00:2308:b0:771:e341:ce68 with SMTP id d2e1a72fcca58-771f58c7a6emr524801b3a.5.1756145138092;
        Mon, 25 Aug 2025 11:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiC+VUxQlXfaub6eJUtfnQK6RBJAo0sZiKzpd3PEppU3iLl0+ZO4/IxMGo0jI3sAsAcOM3sA==
X-Received: by 2002:a05:6a00:2308:b0:771:e341:ce68 with SMTP id d2e1a72fcca58-771f58c7a6emr524754b3a.5.1756145137517;
        Mon, 25 Aug 2025 11:05:37 -0700 (PDT)
Received: from [10.73.115.24] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e10d8446sm3676694b3a.78.2025.08.25.11.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:05:37 -0700 (PDT)
Message-ID: <a158c4f5-e9c3-48c2-b440-fa9dc281b276@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:05:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] PCI: dwc: Add ECAM support with iATU configuration
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
 <20250822-ecam_v4-v7-4-098fb4ca77c1@oss.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20250822-ecam_v4-v7-4-098fb4ca77c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2vbBZizHd5Ym
 5/YdzoAcFVCZ7dzgYkRNdMXbYuaZ+mn9dhpP39yUysvPsHsItk24Acjq2m7S35Q86FtpjafHQKy
 8HRoyehamjdmAgQY6flAALGqdDqW1n+skD0oCYSe7gqRVtkS7/euQJXuxNspCHf7UNteOXPdTtl
 9hsMt+GThAgyVbP8T9Vo19IdG03ICAF9qJtpjmHav840bHLIuBL1Pukljlr6YXkC2wLMPDzQGXu
 2aS5qfIEy84DiYxTeMw/GwJK9mjMEylj21k2QkPaO6KiOWLGIXSo0ceQCn89UxkM7HYPtcJxJrh
 yKGZfVJ++N+mZ5JGuJM2aahBfz0lrl1Iiu3dkI6HdDblKgezEJ5IrNYa8sp1johjcQwMr3zeuGF
 Ow3jIJ2O
X-Proofpoint-GUID: TtBpo7TXZlWtmdECXFa51rat89NaWp9y
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68aca5f3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8YObFgqK2cPrU_DjqCAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: TtBpo7TXZlWtmdECXFa51rat89NaWp9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Hi Krishna

On 8/22/2025 2:27 AM, Krishna Chaitanya Chundru wrote:
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
> to represent number of buses in the bus range property.

Also add 256 MB alignment requirement for using iATU config shift mode here.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/Kconfig                |   1 +
>   drivers/pci/controller/dwc/pcie-designware-host.c | 131 +++++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>   drivers/pci/controller/dwc/pcie-designware.h      |   5 +
>   4 files changed, 124 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -20,6 +20,7 @@ config PCIE_DW_HOST
>   	bool
>   	select PCIE_DW
>   	select IRQ_MSI_LIB
> +	select PCI_HOST_COMMON
>   
>   config PCIE_DW_EP
>   	bool
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..abb93265a19fd62d3fecc64f29f37baf67291b40 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -413,6 +413,81 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>   	}
>   }
>   
> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = {0};
> +	resource_size_t bus_range_max;
> +	struct resource_entry *bus;
> +	int ret;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +
> +	/*
> +	 * Root bus under the host bridge doesn't require any iATU configuration
> +	 * as DBI region will be used to access root bus config space.
> +	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * remaining buses need type 1 iATU configuration.
> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
> +	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
> +	atu.size = SZ_1M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	bus_range_max = resource_size(bus->res);
> +
> +	if (bus_range_max < 2)
> +		return 0;
> +
> +	/* Configure remaining buses in type 1 iATU configuration */
> +	atu.index = 1;
> +	atu.type = PCIE_ATU_TYPE_CFG1;
> +	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +
> +	return dw_pcie_prog_outbound_atu(pci, &atu);
> +}
> +
> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct resource_entry *bus;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pp->cfg))
> +		return PTR_ERR(pp->cfg);
> +
> +	pci->dbi_base = pp->cfg->win;
> +	pci->dbi_phys_addr = res->start;
> +
> +	return 0;
> +}
> +
> +static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct resource *config_res)
> +{
> +	struct resource *bus_range;
> +	u64 nr_buses;

As change is using Synopsis IP based iATU config shift mode 
functionality, it is must that ECAM/DBI base address has to be 256 MB 
aligned. Hence add change to check against alignment.

#define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)

if (!IS_256MB_ALIGNED(config_res->start))
           return false;

> +
> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +	if (!bus_range)
> +		return false;
> +
> +	nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
> +
> +	return !!(nr_buses >= resource_size(bus_range));
> +}
> +
>   static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -422,10 +497,6 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   	struct resource *res;
>   	int ret;
>   
> -	ret = dw_pcie_get_resources(pci);
> -	if (ret)
> -		return ret;
> -
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>   	if (!res) {
>   		dev_err(dev, "Missing \"config\" reg space\n");
> @@ -435,9 +506,32 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   	pp->cfg0_size = resource_size(res);
>   	pp->cfg0_base = res->start;
>   
> -	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pp->va_cfg0_base))
> -		return PTR_ERR(pp->va_cfg0_base);
> +	pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
> +	if (pp->ecam_enabled) {
> +		ret = dw_pcie_create_ecam_window(pp, res);
> +		if (ret)
> +			return ret;
> +
> +		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->sysdata = pp->cfg;
> +		pp->cfg->priv = pp;
> +	} else {
> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> +		if (IS_ERR(pp->va_cfg0_base))
> +			return PTR_ERR(pp->va_cfg0_base);
> +
> +		/* Set default bus ops */
> +		pp->bridge->ops = &dw_pcie_ops;
> +		pp->bridge->child_ops = &dw_child_pcie_ops;
> +		pp->bridge->sysdata = pp;
> +	}
> +
> +	ret = dw_pcie_get_resources(pci);
> +	if (ret) {
> +		if (pp->cfg)
> +			pci_ecam_free(pp->cfg);
> +		return ret;
> +	}
>   
>   	/* Get the I/O range from DT */
>   	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
> @@ -476,14 +570,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (ret)
>   		return ret;
>   
> -	/* Set default bus ops */
> -	bridge->ops = &dw_pcie_ops;
> -	bridge->child_ops = &dw_child_pcie_ops;
> -
>   	if (pp->ops->init) {
>   		ret = pp->ops->init(pp);
>   		if (ret)
> -			return ret;
> +			goto err_free_ecam;
>   	}
>   
>   	if (pci_msi_enabled()) {
> @@ -525,6 +615,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (ret)
>   		goto err_free_msi;
>   
> +	if (pp->ecam_enabled) {
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> +			goto err_free_msi;
> +		}
> +	}
> +
>   	/*
>   	 * Allocate the resource for MSG TLP before programming the iATU
>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -560,8 +658,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   		/* Ignore errors, the link may come up later */
>   		dw_pcie_wait_for_link(pci);
>   
> -	bridge->sysdata = pp;
> -
>   	ret = pci_host_probe(bridge);
>   	if (ret)
>   		goto err_stop_link;
> @@ -587,6 +683,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (pp->ops->deinit)
>   		pp->ops->deinit(pp);
>   
> +err_free_ecam:
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> @@ -609,6 +709,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>   
>   	if (pp->ops->deinit)
>   		pp->ops->deinit(pp);
> +
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4684c671a81bee468f686a83cc992433b38af59d..6826ddb9478d41227fa011018cffa8d2242336a9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -576,7 +576,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>   		val = dw_pcie_enable_ecrc(val);
>   	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>   
> -	val = PCIE_ATU_ENABLE;
> +	val = PCIE_ATU_ENABLE | atu->ctrl2;
>   	if (atu->type == PCIE_ATU_TYPE_MSG) {
>   		/* The data-less messages only for now */
>   		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ceb022506c3191cd8fe580411526e20cc3758fed..f770e160ce7c538e0835e7cf80bae9ed099f906c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -20,6 +20,7 @@
>   #include <linux/irq.h>
>   #include <linux/msi.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>   #include <linux/reset.h>
>   
>   #include <linux/pci-epc.h>
> @@ -169,6 +170,7 @@
>   #define PCIE_ATU_REGION_CTRL2		0x004
>   #define PCIE_ATU_ENABLE			BIT(31)
>   #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
>   #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
>   #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>   #define PCIE_ATU_LOWER_BASE		0x008
> @@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
>   	u8 func_no;
>   	u8 code;
>   	u8 routing;
> +	u32 ctrl2;
>   	u64 parent_bus_addr;
>   	u64 pci_addr;
>   	u64 size;
> @@ -425,6 +428,8 @@ struct dw_pcie_rp {
>   	struct resource		*msg_res;
>   	bool			use_linkup_irq;
>   	struct pci_eq_presets	presets;
> +	bool			ecam_enabled;
> +	struct pci_config_window *cfg;
>   };
>   
>   struct dw_pcie_ep_ops {
> 
Regards,
Mayank

