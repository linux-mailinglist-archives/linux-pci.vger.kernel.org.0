Return-Path: <linux-pci+bounces-10056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B2792D004
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FE3B27F74
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543518FDDE;
	Wed, 10 Jul 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n9CArpfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877917FD;
	Wed, 10 Jul 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608066; cv=none; b=o/NI7uMCHl6SzSWzvrMa8woDvVKWLMQjPWVH1O7nMwV5CVUaCSClYcdwNohBIB7Wp4BygJbNsUi0VmY/uqdvV4W0CGsr5OelcV3nLRWHLQP31tMrWQTy7sjlyxcMmdxzL+zBKRs+UrX8Lrl7gj6etHOGKTerrYPz+IS+LZhmBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608066; c=relaxed/simple;
	bh=V+Xzd4T8gRHtE5SIGX6HgfmhzyhFHWBnKG0fpEpyF48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VdRSP2ueO9nx8AsP6EGs/OAGbPo8eKKMqYtZyyTdacc8o2X/NXgb/Vz/VYOXG72B84jJned7wXUyq98weSaZWuUbjd6Bs81bOBn5Uv1obpJv5oie4GRfJdD/veSSOTQF8gkdILhcykX+JaOKnbJDAlO48uMXlTjP/la6Hxgx4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n9CArpfZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4qgDF017922;
	Wed, 10 Jul 2024 10:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0uvwgFO82mJjVzpSSxqWkoUibs3dI6vEoYgSRG6/zZo=; b=n9CArpfZ39PQbIyt
	u5L0TatN7z80chW8lcN/st22rc4bEEupT0bUoxHan64lkcnnmTUg63Q2gO6C6ovR
	JbjpJfx/uMg3Mkslsy86gHr04dKpHjMVk4llFbBLsyBIkuINeGDd7776jnobfNa6
	6wPJqHkB525GC/8ie+PsxcaZCfrHB8dnlkt5aGYO1qJehCfgvM4vdqcVhBJ4up64
	r7S+VXQQjsNhubW1VH9Hg9BDxdf/eYeAvHgi3zGBN0wWettNBiOqFWg4g6yxlFez
	g2REvUwSMIktu6NZ1XLUO3/o+PMKdE1lAPDRi+zi9jF/PJB7iHlehVu4P1RMfm8N
	3mqiYQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xpdrshp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:40:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AAeklg017907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:40:46 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 03:40:40 -0700
Message-ID: <6ddf2c14-c8f6-4440-a8ac-93bdbdd6d08c@quicinc.com>
Date: Wed, 10 Jul 2024 18:40:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom-ep: Add HDMA support for QCS9100 SoC
To: Bjorn Helgaas <helgaas@kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <kernel@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709162621.GA175973@bhelgaas>
Content-Language: en-US
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20240709162621.GA175973@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r7Ma-t8_NhOdj2fuFRGGglFshNBXaM5P
X-Proofpoint-ORIG-GUID: r7Ma-t8_NhOdj2fuFRGGglFshNBXaM5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100073



On 7/10/2024 12:26 AM, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 10:53:44PM +0800, Tengfei Fan wrote:
>> QCS9100 SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP,
>> so add support for it by passing the mapping format and the number of
>> read/write channels count.
>>
>> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
>> config struct is introduced for the sake of enabling HDMA conditionally.
> 
> This patch doesn't add a new config struct.
> 
>> It should be noted that for the eDMA support (predecessor of HDMA), there
>> are no mapping format and channels count specified. That is because eDMA
>> supports auto detection of both parameters, whereas HDMA doesn't.
>>
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to the PCIe device
>> match table.
> 
> This series doesn't add the new SCMI stuff you mention.  It sounds
> like this should be deferred and added when you actually move to using
> SCMI resources.

We can rename "sa8775p" to "qcs9100" compatible name in next patchset
for this driver. Let's know if this is reasonable from your point of view?

SCMI resource solution will come in a later point, and at that time it
can have scmi related resource operations in this driver and add
"sa8775p" compatible with correct resources ops at that time.

More background:
We want to make QCS9100 non-SCMI resources not blocking by current SCMI
resources changes, since SCMI changes are also pending to merge in order
to not blocking non-scmi resource platforms like current QCS9100
project. So the splitting base device trees are pending here. Don't want
to have a circular dependency loop. :)
> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 236229f66c80..e2775f4ca7ee 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -904,6 +904,7 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>>  };
>>  
>>  static const struct of_device_id qcom_pcie_ep_match[] = {
>> +	{ .compatible = "qcom,qcs9100-pcie-ep", .data = &cfg_1_34_0},
>>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>>  	{ .compatible = "qcom,sm8450-pcie-ep", },
>>
>> -- 
>> 2.25.1
>>

-- 
Thx and BRs,
Aiqun(Maria) Yu

