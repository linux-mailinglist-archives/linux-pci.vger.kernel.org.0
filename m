Return-Path: <linux-pci+bounces-10055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A092CF55
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75201C21441
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639A192B6B;
	Wed, 10 Jul 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VPAsbDCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79138190065;
	Wed, 10 Jul 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607570; cv=none; b=d9eCLe8JOURHjG3byiX7yzUrPlAoIpYZBPW62JrcCzyb+g7qPTO1Tj2Xk71cbfHoItPqs4EeiEzjd1mqHx7PDtQLg4f/30Y+okS3BO146QJ1voRk1ILUTTZimhAjEaikFsBbNBEyQawfJfrVNUeF5ZfXDA89mkdS5Iemt8vUcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607570; c=relaxed/simple;
	bh=GtPqLH122YgjqgF69TVvAppi2h6zg9IU9emM4Tzc250=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qwsV2dVFFM1h2z9kIePrCUwtLQg7VAtb1sSEOaa6KBOB5RIw2jYiMRZmlZrWzUU0oRs/lqZpNCgJ5qp6xULO6nd+mcrETmQ5oxk4nSW1AA6JkBv0sflKDrNWdicQYjdzIMqD7Bnc+W9dCNUJuaPLZcrl8ZLDZfGO1jM9B7ykYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VPAsbDCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A3fjw3003747;
	Wed, 10 Jul 2024 10:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XExWwft4m5iQfH/7ODHt9hnjXEKAS2TbNGnSurKGohs=; b=VPAsbDCS9EPO/xol
	dWWx7Q1rIL6x+xk6lsNIV5g+5+7XOtMkTh+/actDBJIomoayN7gKsnvN/czht+03
	3cAtqangqC/DAdS0pwzBQjxb9XDBfVfJJL8d2scBpP7O0WlxFOGDYULBrpAteTUw
	bUr/oxzg+y/S9yGdChGiereKYNdzXai25oZB4nUYBDr+efnffRYbkfVaEDzZk4hu
	B/g2HdiM5PXGr2bgBTm01y+SyCtc4d3n5N3NCyKC9zoPVlFRoqQ1lB+ZrSwmzRAC
	PvhaBmZCcsA7Eci9I8oynQlwt+TI54yHCSGkZNR99e/6bA/UvkpfBfLykD9xsfKg
	3vQr8A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rbvdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:32:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AAW7GV003609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:32:07 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 03:32:01 -0700
Message-ID: <8caad754-0fa2-4158-86cd-b04101618638@quicinc.com>
Date: Wed, 10 Jul 2024 18:31:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom-ep: Add support for QCS9100
 SoC
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
References: <20240709162831.GA176079@bhelgaas>
Content-Language: en-US
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <20240709162831.GA176079@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HNumWH53y7d5tM552AkK3NtSI1ADf3VW
X-Proofpoint-GUID: HNumWH53y7d5tM552AkK3NtSI1ADf3VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100072



On 7/10/2024 12:28 AM, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 10:53:43PM +0800, Tengfei Fan wrote:
>> Add devicetree bindings support for QCS9100 SoC. It has DMA register
>> space and dma interrupt to support HDMA.
> 
> s/dma/DMA/ above for consistency.
> 
> Add blank line here if this is a paragraph break.
> 
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to describe non-SCMI
>> based PCIe.
> 
> s/drived/derived/
> 
> This patch doesn't add anything related to SCMI, so this paragraph
> seems like a distraction.

The paragraph can be removed from the commit message in next patchsets.
Let me know if others looks good to you or not.
> 
> The first paragraph seems a bit of a distraction too, since the patch
> doesn't say anything about DMA register space or interrupt.

agree. Suggest to remove the first paragraph as well.
> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> index 46802f7d9482..8012663e7efc 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>> @@ -13,6 +13,7 @@ properties:
>>    compatible:
>>      oneOf:
>>        - enum:
>> +          - qcom,qcs9100-pcie-ep
>>            - qcom,sa8775p-pcie-ep
>>            - qcom,sdx55-pcie-ep
>>            - qcom,sm8450-pcie-ep
>> @@ -203,6 +204,7 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> +              - qcom,qcs9100-pcie-ep
>>                - qcom,sa8775p-pcie-ep
>>      then:
>>        properties:
>>
>> -- 
>> 2.25.1
>>

-- 
Thx and BRs,
Aiqun(Maria) Yu

