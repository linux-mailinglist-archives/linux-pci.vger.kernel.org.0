Return-Path: <linux-pci+bounces-5873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71889BAF0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E781C21C5D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143939FC1;
	Mon,  8 Apr 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GT4tbcib"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79B3C47D;
	Mon,  8 Apr 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566455; cv=none; b=QqcGvFf2rhJOYIk0Oq7+tbJr4dlxsbCV49QKPQkdVND1VmYGRDvC2JacQ9G0wePJQ07ZrXgGCGOMWLIQYgR9rXbYGU69oVXR5qfn6zDlWurG9FrSApWRrpt2q9+dTkAh0hRsPg1lgN9ItfEynNAlBaZuLlO2ws6Pie0kS7kFVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566455; c=relaxed/simple;
	bh=hcvbPjCew43t9UhfecUGg/FJNEitg4pAy4+vnKk8h4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IsFEdDYFbqMnfuZAnCFWZ4dcU5DnyvcDyU1sF5w8aB7ayngICCfrhLyPNS5zhhRhs9ouK2zejZfiCLGO7T5vomFKB/PgCvyU/edd4g+6jYbCHtzvOVAN1jrC2b77bFlE4ABwaFziUy9N6/GLbXWJrM5E8bS8age7+V4P7sZ5Zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GT4tbcib; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386dLYb011755;
	Mon, 8 Apr 2024 08:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=l9bkOl54FLJ/y558SuedQw5a33GKs+cjk4IG7XYx52M=; b=GT
	4tbcib2au95gnLKRKsv7anIJyYaVgGPQnpU01JSZIRtbs7OBcmPdL2vBvjJJven6
	112ODdsxpdsPLkaKdZrswzOC3qIjOhN8bCBu1Kg748uGzCfw3cjKpTIfQEfGWbbA
	J6n8uAd13apbaIq08FU7DUgvVziovBqXlXfz4a+NUjFydfvfjCPSwB2i/dPgePKy
	rDsM1pT8ZbWLO0B9TQUxzmNGdscKOX4WVOXZOCMYG80FleVjb4EoehKtOAlSESmB
	LcMC2qo5F1p6BvYmCpWk5AZDlMZClhtbl7/H7XHt3eA7/ueC1y+ANeRRQgp8b/Da
	hzrO6FK8UaABHLqW4JtA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbfyg8d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 08:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4388s3v8002658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 08:54:03 GMT
Received: from [10.216.26.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 01:53:55 -0700
Message-ID: <1093dace-3de9-4a13-c118-fffd49678622@quicinc.com>
Date: Mon, 8 Apr 2024 14:23:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 3/6] dt-bindings: pci: qcom: Add opp table
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-3-496184dc45d7@quicinc.com>
 <20240407144227.GC2679@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240407144227.GC2679@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wie7NdtPzyH7wckslzDsF4TpvnpQFKCj
X-Proofpoint-GUID: wie7NdtPzyH7wckslzDsF4TpvnpQFKCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080068

Ack to all the comments. I will modify them in next patch series.

- Krishna Chaitanya.

On 4/7/2024 8:12 PM, Manivannan Sadhasivam wrote:
> On Sun, Apr 07, 2024 at 10:07:36AM +0530, Krishna chaitanya chundru wrote:
> 
> s/opp/OPP
> 
>> PCIe needs to choose the appropriate performance state of RPMH power
> 
> s/RPMH/RPMh
> 
>> domain based upon the PCIe gen speed.
>>
> 
> s/upon/on
> 
>> Adding the Operating Performance Points table allows to adjust power
>> domain performance state and icc peak bw, depending on the PCIe gen
> 
> s/icc/ICC
> 
> s/PCIe gen speed/PCIe data rate
> 
>> speed and width.
>>
> 
> s/width/link width
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> With above changes,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
>> index 1496d6993ab4..d8c0afaa4b19 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
>> @@ -69,6 +69,10 @@ properties:
>>         - const: msi6
>>         - const: msi7
>>   
>> +  operating-points-v2: true
>> +  opp-table:
>> +    type: object
>> +
>>     resets:
>>       maxItems: 1
>>   
>>
>> -- 
>> 2.42.0
>>
> 

