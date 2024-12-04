Return-Path: <linux-pci+bounces-17618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF79E3146
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EE416806D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FB175AB;
	Wed,  4 Dec 2024 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lyWyNyFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FB944E;
	Wed,  4 Dec 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278554; cv=none; b=AZ93CRgswaWLEN5DsxLA7Qhjp3azuMe1du1JyXxjWvD4M3q2o6Rzemq3TsWqWunUKm31hrF0qSGH71G5U0FBBKLaQpEXIpMF6nwcJQWVApRw8BManqkE3nc/axnBr+it2kkJXRq+sSat6UlgCOGAmaUf798ADOvaZEX2ntjrd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278554; c=relaxed/simple;
	bh=OlHHrgP4UplwfyoIXDphhR2ghnkX9MTPH5x6SWstMFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KL2cjF2Qhq7yx4OlDu7t6zN7et/oSbhax5EVQLY5DP7p0adTmpXDolu5O/h/JHvcmb/40PupL7Oj/c/6UVFNSB9qkoULohW3EkK5ygbTEn2Leskt5UjNpVJj3BfHJ7GcZPONC1zjkoFDvKZcDdyLWSk++cy1Zyb36nUx90Ic7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lyWyNyFq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3DMQMl001285;
	Wed, 4 Dec 2024 02:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ts4Njp90c68ZwdyOqQwSIi/UZ2klvbHWWrBIP09mKUE=; b=lyWyNyFqjOm1pqWy
	d9YY71DDPXxBIEr4e2jTEUNz2a3rAm9+2uFYt4B8AebRXoiBAM0NNffTqxZBPQZy
	budvROV/b0bUnmuq5N2+rGaysQag9gtlzrjMNk0r51H9e9nOpIzFma39bOZ7DM7k
	Shu9CMGuFKMwh2xyqEpibrpHbZ+TqZfRo4x17WMzrOvqN9EtsHifQ0PNv/vWp7gQ
	vZNrmambHvnomLbMMOU3E6RXPmnR+MraoY4+RErqDLDvBE+V+B+0ieT1jSvChqO0
	Is16BOQvkbVZlLGmJPHyt3fOq/iuHQy58onu1nnpzeUa1obkSn4V4wzlLogWBOwV
	jBJZhA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439trbk627-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 02:15:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B42FfJn000307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 02:15:42 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 18:15:33 -0800
Message-ID: <b42e1ec7-11a0-ab6b-c552-86d204dcb041@quicinc.com>
Date: Wed, 4 Dec 2024 07:45:29 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
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
References: <20241203185534.GA2910014@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241203185534.GA2910014@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CPnu4dIKNOho9qE0pdApt9yBJ8mIhRzr
X-Proofpoint-ORIG-GUID: CPnu4dIKNOho9qE0pdApt9yBJ8mIhRzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040018



On 12/4/2024 12:25 AM, Bjorn Helgaas wrote:
> On Sun, Nov 17, 2024 at 03:30:19AM +0530, Krishna chaitanya chundru wrote:
>> The current implementation requires iATU for every configuration
>> space access which increases latency & cpu utilization.
>>
>> Configuring iATU in config shift mode enables ECAM feature to access the
>> config space, which avoids iATU configuration for every config access.
>>
>> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift mode.
>>
>> As DBI comes under config space, this avoids remapping of DBI space
>> separately. Instead, it uses the mapped config space address returned from
>> ECAM initialization. Change the order of dw_pcie_get_resources() execution
>> to acheive this.
> 
> s/acheive/achieve/
> 
>> Introduce new ecam_init() function op for the clients to configure after
>> ecam window creation has been done.
>>
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
> 
> s/atu/ATU/ (initialism, looks like "iATU" might be appropriate here?)
> 
> I'm confused about the bus numbering; you refer to "bus 1" and "bus
> 2".  Is bus 1 the root bus, i.e., the primary bus of a Root Port?
> 
> The root bus number would typically be 0, not 1, and is sometimes
> programmable.  I don't know how the DesignWare core works, but since
> you have "bus" here, referring to "bus 1" and "bus 2" here seems
> overly specific.
> 
root bus is bus 0 and we don't need any iATU configuration for it as
its config space is accessible from the system memory, for usp port of
the switch or the direct the endpoint i.e bus 1 we need to send
Configuration Type 0 requests and for other buses we need to send
Configuration Type 1 requests this is as per PCIe spec, I will try to
include PCIe spec details in next patch.
>> +	 */
>> +	atu.index = 0;
>> +	atu.type = PCIE_ATU_TYPE_CFG0;
>> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;
>> +	atu.size = SZ_1M;
>> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	bus_range_max = bus->res->end - bus->res->start + 1;
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
> 
> .ecam_init() is defined to return int, but you ignore the return value.
> If it's practical, I think it would be nicer if you could manage to:
> 
>    - Drop .enable_ecam.
> 
>    - Have .ecam_init() return failure if there's not enough ECAM space
>      or whatever, i.e., move the qcom_pcie_check_ecam_support() code
>      there.
> 
>    - Handle .ecam_init() failure here by doing whatever we did before.
> 
> If there's no useful return value from .ecam_init(), make it void.
> 
In controller driver we need to skip few thing if we want to enable
this feature before calling dw_pcie_host_init, better to have this way
>> +	return 0;
>> +}
> 
>> @@ -454,6 +499,30 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   
>>   	pp->bridge = bridge;
>>   
>> +	pp->cfg0_size = resource_size(res);
>> +	pp->cfg0_base = res->start;
>> +
>> +	if (!pp->enable_ecam) {
> 
> If you can't get rid of .enable_ecam, reverse order so this uses
> positive logic:
> 
>    if (pp->enable_ecam) {
>      ...
>    } else {
>      ...
>    }
> 
ack.

- Krishna Chaitanya.
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
>> +	}
> 

