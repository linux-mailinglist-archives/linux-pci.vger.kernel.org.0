Return-Path: <linux-pci+bounces-20319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABEA1B1B1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0857A57D9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB3219A63;
	Fri, 24 Jan 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7Nw/TS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D166218E99;
	Fri, 24 Jan 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707204; cv=none; b=vBL/NMcsiTjXiKg+4E+AINPcpyOTO0aNbh9ilQiCHRzMBSHauCKPSFlBb0DyGCjw9exUibF8ziWBpSSNDiwk4VUvdHZEwu0KladOKG+yZxLFtSRlgQ4b3nemqsKsD8heozf4JpKyJo6Lz5Z2Uw5Vr8KXvVdd7/Fz/08P6Rx7fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707204; c=relaxed/simple;
	bh=Dv1vAXZI8vsRs4O+g2BpElnnLuNaKougAOdum6jfCUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vBUDV3m/8AlswjZQ1tcYxg00LIbbDop3hCa20hRc2+KW5EUzBd3P8qMwei+0bv+Qzzs9TSMf2XWwce1W6bTeRCHEtjAIVz2gZyPlyZPYNkqUBH/Dv8B/egThLVzfJwFX6WAJknq1FP29WETznf78SnIicgh9egZzXQ7VWkxLt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y7Nw/TS3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O82bLg032689;
	Fri, 24 Jan 2025 08:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sjbcESiU6USB4wlS8JMciyTQKB0lub0M2yPt8IZm/AE=; b=Y7Nw/TS3DMnI+06k
	x4URVuBACUMf9aV7YXw1RbWp0ZWUuqR4gLMPgH5KFdEZC78k3DSetBSHmxSY8HZy
	2GA5Id98KD5tdDHoDuSm8a7ndTMpkt6TYylrtN3gVH7imyt5X+QJ8R5JzSocLaF1
	h+we/IkMWCHbYFWLOEHhmGFj526bawBOotijqztYrLMpSLzciniFq9ryxijR4mjQ
	gjgofZV9AF9P4XnxOVSKroMEKD2jw2jRmQL7O+nhnLyuOpC9/8CMsR4sEheRzOlm
	8JuAEM9hA+LmaazcM1QGO9p792efJX3OdQdRRCP/QaBFqJIr8j1+6Pwhi/POZNt/
	Qr4kfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c70ng21w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:26:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O8QYYr015205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 08:26:34 GMT
Received: from [10.216.14.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 Jan
 2025 00:26:28 -0800
Message-ID: <6e35eea5-2c7b-5d71-f39d-f9196a3c1b76@quicinc.com>
Date: Fri, 24 Jan 2025 13:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/4] PCI: dwc: Reduce DT reads by allocating host
 bridge via DWC glue driver
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_vpernami@quicinc.com>,
        <quic_mrana@quicinc.com>, <mmareddy@quicinc.com>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-3-cd84d3b2a7ba@oss.qualcomm.com>
 <20250124061828.ncycdpxqd6fqpjib@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250124061828.ncycdpxqd6fqpjib@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KzrbjIr4tr0Nq9uV4eq3G75CKKG6k1P0
X-Proofpoint-ORIG-GUID: KzrbjIr4tr0Nq9uV4eq3G75CKKG6k1P0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=984 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240060



On 1/24/2025 11:48 AM, Manivannan Sadhasivam wrote:
> On Tue, Jan 21, 2025 at 02:32:21PM +0530, Krishna Chaitanya Chundru wrote:
>> Allow DWC glue drivers to allocate the host bridge, avoiding redundant
>> device tree reads primarily in dw_pcie_ecam_supported().
>>
> 
> I don't understand what you mean by 'redundant device tree reads'. Please
> explain.
> 
In dw_pcie_ecam_supported () we are trying to read bus-range to find
maximum bus range value. devm_pci_alloc_host_bridge() is already reading
bus range it. If we move devm_pci_alloc_host_bridge() to start of the
controller probe we can avoid reading the dt and use values stored in 
the host bridge.
This was recommended by bjorn in the v2.

I will update the commit text in the next series.
> - Mani
> 
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 3888f9fe5af1..0acf9db44f2c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -484,8 +484,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	struct device *dev = pci->dev;
>>   	struct device_node *np = dev->of_node;
>>   	struct platform_device *pdev = to_platform_device(dev);
>> +	struct pci_host_bridge *bridge = pp->bridge;
>>   	struct resource_entry *win;
>> -	struct pci_host_bridge *bridge;
>>   	struct resource *res;
>>   	int ret;
>>   
>> @@ -497,11 +497,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   		return -ENODEV;
>>   	}
>>   
>> -	bridge = devm_pci_alloc_host_bridge(dev, 0);
>> -	if (!bridge)
>> -		return -ENOMEM;
>> -
>> -	pp->bridge = bridge;
>> +	if (!pp->bridge) {
>> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
>> +		if (!bridge)
>> +			return -ENOMEM;
>> +		pp->bridge = bridge;
>> +	}
>>   
>>   	pp->cfg0_size = resource_size(res);
>>   	pp->cfg0_base = res->start;
>>
>> -- 
>> 2.34.1
>>
> 

