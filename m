Return-Path: <linux-pci+bounces-17617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DEC9E3110
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88008B28C3E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1E17C79;
	Wed,  4 Dec 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TmfI/vLP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A18472;
	Wed,  4 Dec 2024 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277757; cv=none; b=CWhcHgFwgObvKnV8DQrC7f7X7SEzMlrn1Ld2KGrnr7z9A/xWFpq93Ua1DYMV5WU2YgS+AiBxUJEMkjmEynLnkzHLcqJGXXncZUJK54fdrIKUejbi29phwKF7C41opdDU+WX2Zs50PVJJvDwT01uUzDCno3fw0pAyQ9cvoBsBJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277757; c=relaxed/simple;
	bh=X/594UVv8At/F67BxPBvKeI8t44ig+FL9f3z6QJMHc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D0U7L/MfqKHKiq5UofwPb6faA21C/k0YXQkiY9ookQ6uvknQF9qLwUNZ5wugA6epseDSGP8eoLNWgMETI6XT6khj6Mcll/otGfamEkeTZgbDg/2jXwV4gufjmw1mZKjE1Qyjd49P6jr1MMg/GQjJU6Or5A8yTyXoSSjg366tzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TmfI/vLP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3MoMhd026143;
	Wed, 4 Dec 2024 02:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8Ku1g/x/Mq4t0L5AC61oMrp+GR8xfrfSiJEIU045Ws=; b=TmfI/vLPWfcTmyFY
	lnAgZOlUCXgSUFfIMR4jzvdvc3JJIGGzjaiH6xab0AJtxQyyfpSh0SjFJ790v7ww
	ESfMqP0f8gTXurtXKAAV5A+u/X13iX0r/YXNn0EnHdZbPUvKVDukAYNvPW59n6mx
	64eFRNdQcvl2amjCfV2ge1zfAa+ztc7ZSegFhm79BHg9ihsKkC2or3Zc12tVzWWr
	k3XjrxImkPDSlwJfRM5IPA00TV89KdJCZUXwvS3J1XSZqU0L9YdwTL06KdywM9Sw
	2dj+9Yvn59C93XSpCS/X3/AQmAorZXV3FIcNn/SqoFkxWSQOVToJfaA97ImVkvWP
	hC61XQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9j7rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 02:02:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B422MZo018134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 02:02:22 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 18:02:13 -0800
Message-ID: <cc98ec47-ce33-33a2-bbe3-c0da34d85d97@quicinc.com>
Date: Wed, 4 Dec 2024 07:32:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_vpernami@quicinc.com>,
        <quic_mrana@quicinc.com>, <mmareddy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
 <20241117-ecam-v1-2-6059faf38d07@quicinc.com>
 <20241202164203.tpjqqgq6hzzedudc@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241202164203.tpjqqgq6hzzedudc@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rq9UVEmxdr0v8pxd9FpiyESwbPFavCEN
X-Proofpoint-GUID: Rq9UVEmxdr0v8pxd9FpiyESwbPFavCEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040016



On 12/2/2024 10:12 PM, Manivannan Sadhasivam wrote:
> On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
>> The current implementation requires iATU for every configuration
>> space access which increases latency & cpu utilization.
>>
>> Configuring iATU in config shift mode enables ECAM feature to access the
> 
> Can you please elaborate 'config shift mode'? Quote relevant section in DWC
> databook for reference.
> 
>> config space, which avoids iATU configuration for every config access.
>>
>> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift mode.
>>
>> As DBI comes under config space, this avoids remapping of DBI space
>> separately. Instead, it uses the mapped config space address returned from
>> ECAM initialization. Change the order of dw_pcie_get_resources() execution
>> to acheive this.
>>
>> Introduce new ecam_init() function op for the clients to configure after
> 
> We use 'DWC glue drivers' to refer the 'clients' of this driver.
> 
>> ecam window creation has been done.
>>
> 
> Use 'ECAM' everywhere.
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 114 ++++++++++++++++++----
>>   drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>>   drivers/pci/controller/dwc/pcie-designware.h      |   6 ++
>>   3 files changed, 102 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 3e41865c7290..e98cc841a2a9 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -418,6 +418,62 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>>   	}
>>   }
>>   
>> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct dw_pcie_ob_atu_cfg atu = {0};
>> +	struct resource_entry *bus;
>> +	int ret, bus_range_max;
>> +
>> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
>> +
>> +	/*
>> +	 * Bus 1 config space needs type 0 atu configuration
>> +	 * Remaining buses need type 1 atu configuration
>> +	 */
>> +	atu.index = 0;
>> +	atu.type = PCIE_ATU_TYPE_CFG0;
>> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;
> 
> You didn't mention what occupies the first 1MB.
> 
>> +	atu.size = SZ_1M;
>> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	bus_range_max = bus->res->end - bus->res->start + 1;
> 
> resource_size(bus->res)
> 
>> +
>> +	/* Configure for bus 2 - bus_range_max in type 1 */
>> +	atu.index = 1;
>> +	atu.type = PCIE_ATU_TYPE_CFG1;
>> +	atu.cpu_addr = pp->cfg0_base + SZ_2M;
>> +	atu.size = (SZ_1M * (bus_range_max - 2));
>> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>> +	return dw_pcie_prog_outbound_atu(pci, &atu);
>> +}
>> +
>> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct device *dev = pci->dev;
>> +	struct resource_entry *bus;
>> +
>> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
>> +	if (!bus)
>> +		return -ENODEV;
>> +
>> +	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
>> +	if (IS_ERR(pp->cfg))
>> +		return PTR_ERR(pp->cfg);
>> +
>> +	pci->dbi_base = pp->cfg->win;
>> +	pci->dbi_phys_addr = res->start;
>> +
>> +	if (pp->ops->ecam_init)
>> +		pp->ops->ecam_init(pci, pp->cfg);
>> +
>> +	return 0;
>> +}
>> +
>>   int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -431,19 +487,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   
>>   	raw_spin_lock_init(&pp->lock);
>>   
>> -	ret = dw_pcie_get_resources(pci);
>> -	if (ret)
>> -		return ret;
>> -
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>> -	if (res) {
>> -		pp->cfg0_size = resource_size(res);
>> -		pp->cfg0_base = res->start;
>> -
>> -		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>> -		if (IS_ERR(pp->va_cfg0_base))
>> -			return PTR_ERR(pp->va_cfg0_base);
>> -	} else {
>> +	if (!res) {
>>   		dev_err(dev, "Missing *config* reg space\n");
>>   		return -ENODEV;
>>   	}
>> @@ -454,6 +499,30 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   
>>   	pp->bridge = bridge;
>>   
>> +	pp->cfg0_size = resource_size(res);
>> +	pp->cfg0_base = res->start;
>> +
>> +	if (!pp->enable_ecam) {
> 
> Why can't you just use the ECAM mode when there is enough memory defined in DT?
> Using this flag slightly defeats the purpose of the ECAM mode.
> 
>> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>> +		if (IS_ERR(pp->va_cfg0_base))
>> +			return PTR_ERR(pp->va_cfg0_base);
>> +
>> +		/* Set default bus ops */
>> +		bridge->ops = &dw_pcie_ops;
>> +		bridge->child_ops = &dw_child_pcie_ops;
>> +		bridge->sysdata = pp;
>> +	} else {
>> +		ret = dw_pcie_create_ecam_window(pp, res);
>> +		if (ret)
>> +			return ret;
>> +		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>> +		pp->bridge->sysdata = pp->cfg;
> 
> 'bridge->sysdata = pp->cfg'?
>
as we are using pci_generic_ecam_ops.pci_ops for config reads & writes
it expects cfg space as sysdata[1].

[1] https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/ecam.c#L170

- Krishna Chaitanya.

> - Mani
> 

