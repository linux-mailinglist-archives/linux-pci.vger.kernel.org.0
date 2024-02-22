Return-Path: <linux-pci+bounces-3876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5085FA34
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2251C2889F9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC83134CCC;
	Thu, 22 Feb 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U6N5STPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEE36AE9;
	Thu, 22 Feb 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609674; cv=none; b=LyLvomeID34jrcQQybtU8Hn5mBr6LbbRGm7rNqppQVPPAAPEdcCLgh3Lw9ZfjZLSKLD13/za+XhRCxJIvj7zLa9Hg5G3F893+0BCutuUBIAG8BoS5VGkVQIcfuYjWx1Vi7tMhcknN/rY/QJP2eKvyGa+v2orf7rvv8am7DibEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609674; c=relaxed/simple;
	bh=xpTyLut7uzB3vkJ2gcm33YHNDw83yuMWLvrYsu1nfoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1pSyJmaFYFnElo7nt94zncKiAlqX9sw+D3gSZdur+V9MWr4HIP7K1QUUrueNv7EYMp6yHuF2C1NJpzOxdBk1SuBRDfMaPBcvty7Y0n9J166VguMw3EezKnMBNZ7207vfFjoLFvoJKRNbg0I6uUYJYECt2HsM4csSPVyLa6EPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U6N5STPX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M666qZ013576;
	Thu, 22 Feb 2024 13:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WWXqOKm9Rw4fMWd5UNR5Tj3My/z0kfVSuwv2vQRG2ck=; b=U6
	N5STPXnAg89/ojevzmmhA3+3622S7WVyE16A5Ea4zOPBsH108lSPXRSHg9t02ts0
	uYv24O8EKyEmEOvZpiQzmqfe42x2xF/HxNallovDoz/TwWE/g1HFkpY48aM90sMJ
	xggYuSuIot4BWGbFtvzNjC0y2H23kLEpNa/TA09kmrne2lKllcwsRzFMnC0JNg06
	GOtGI2FjL4P8srMdaJI4oVuhtDMs8P780JxmqtQ0+niMiAlvv9HlNBkkt1vk1yzR
	mDoz9T7dbyp+wLURKYRTIbU8z6PGA3xCBRNPC7PwK8pTn4E4bTDoCZHuFdXFXlBQ
	XdZx5Kk82krK9h/PmJXg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpe6thku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 13:47:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MDlfug003432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 13:47:41 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 05:47:34 -0800
Message-ID: <51ffdd0f-d3a1-7f19-2033-264baf71394e@quicinc.com>
Date: Thu, 22 Feb 2024 19:16:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: qcom: Add global irq support for
 SA8775p
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        root <root@hu-msarkar-hyd.qualcomm.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <manivannan.sadhasivam@linaro.org>,
        <conor+dt@kernel.org>, <quic_nitegupt@quicinc.com>
CC: <quic_shazhuss@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
 <08ca89da-d6a1-440c-8347-f2e31222bede@linaro.org>
 <a0677780-d013-44f7-94bf-ea7e23aab019@linaro.org>
 <88d8fea5-2b11-4d01-816c-dbe822ac8d19@linaro.org>
Content-Language: en-US
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <88d8fea5-2b11-4d01-816c-dbe822ac8d19@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UxfVJvt56qmyIe1xNXBsqw84ytiah0AC
X-Proofpoint-ORIG-GUID: UxfVJvt56qmyIe1xNXBsqw84ytiah0AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=990 clxscore=1011 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220109


On 2/21/2024 8:03 PM, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:31, Konrad Dybcio wrote:
>> On 21.02.2024 15:28, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 15:04, root wrote:
>>>> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>
>>>> Add global interrupt support in dt-bindings for SA8775p RC platform.
>>> What is this global interrupt? Why wasn't it there before?
>>>
>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++--
>>>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index a93ab3b54066..d86fb63a2d2c 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -63,7 +63,7 @@ properties:
>>>>   
>>>>     interrupt-names:
>>>>       minItems: 1
>>>> -    maxItems: 8
>>>> +    maxItems: 9
>>>>   
>>>>     iommu-map:
>>>>       minItems: 1
>>>> @@ -873,8 +873,30 @@ allOf:
>>>>           compatible:
>>>>             contains:
>>>>               enum:
>>>> -              - qcom,pcie-msm8996
>>>>                 - qcom,pcie-sa8775p
>>>> +    then:
>>>> +      oneOf:
>>> No need, drop.
>> Moreover, I think this global irq should be present on all qc platforms
> Heh, this will anyway conflict with my series:
> https://lore.kernel.org/all/90a50ab4-a513-48af-b13a-bba082e49540@linaro.org/
>
> https://lore.kernel.org/all/20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org/

Thanks for sharing the series. will make change top of your series on v2.

Thanks,
Mrinmay

> Best regards,
> Krzysztof
>

