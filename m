Return-Path: <linux-pci+bounces-25562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD89A82636
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67463A9B38
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1A25E46A;
	Wed,  9 Apr 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcQzuWSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C5273F9
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204956; cv=none; b=tWvkv3JgUtOu9lmWZA2KtKE3aWmIgEiWYw84XNOT1RdCGaGwjq/v0czXhjLx/AuJWZNAMmsL85Ervv+uFK3Lqcav4ygs+stMhQvonX+fLjjEY9fDY1QFq6CripFTCl4DG0yRcPxVSKcc5PytEAYk988D51glzLxMTaBn5zqeOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204956; c=relaxed/simple;
	bh=zX4CYBgkdc29p/d5raDLjcdhkjA/VM+yjkA51ipJEMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABpVR/Yze4vjhmJ0m9p7cDVdlmZBM5NFRj+S45rpZUrFAe7bvTeAOZQOEh1YE+5zc4OTg1MmYGbdJre+CZ0U+SYhch0sCGQCZwEuYiam2AsNqoi3r47aTWg2nwSccO07hdk0/8xfGvoNub4CF+hHTDzddQIciHQjYVjPwShxMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcQzuWSU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398NdSL014999
	for <linux-pci@vger.kernel.org>; Wed, 9 Apr 2025 13:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oG97pdlG3/MhaV/Eh1XXDbmemJdCv3MUuOAbWpnlMxs=; b=JcQzuWSUjcAF3JAp
	j8DfR3LIJMa6R4pvXTY8dHvEHrvGHVohZC2mRyqD43hG/VyNm5hj6m3cTRrzZnit
	Q4auc9lcw8EI4HGQ/LWZOKGViH1GMS0XtoIPI8gvvaCiQ5/Ljjkhfmbv055i4wSH
	1JNNjPsn/QuF7Q5UU5BnwKefXWMYbjura/MQDDP4uxcr8aWAUcQhUfjrGk5NYvaK
	1l2Wl4CtHZHXzUrXewSZYz/vWxiYvfOWFmkdYVzcjnQ67oeFwWbQ7dVtD8a6cESS
	DJ6FjoL7UDTj9zEmSUhAv5UagQnafBbPLn0zgXMTLqU5T52U34sKia4W8+A8xM9V
	hQFZng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbukg0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 13:22:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4768b27fef3so11633701cf.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204952; x=1744809752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG97pdlG3/MhaV/Eh1XXDbmemJdCv3MUuOAbWpnlMxs=;
        b=g3tEjXQ99Rokk0zQILhsCJlqs/ixkTng31qh3I3GEQsiFozWU8ZFTPBhE6w9K369Zo
         dpmomgg5iLy69x3oSC3L+L0z0ordMomWvr4IOmS9nQ04Ks1tyj0s2HIPzrGVi9hGbgWE
         q1rkYUyMiTu2ldmymSYpFavrAX0uVTfm+H+FTzuwM2pP12TratDzoMgEJuaPgctzEqHL
         1rsZF2B0YSomIXPIKdN7P+ovY9cRoOnMT++PwP/Hi95cC+zB2LBsq1U2uuou1Gf5+7kf
         6hjCKaNpmuBY8BtEVQHhdI3TR4dJwIlSVxhkoPsq9tiLtWPZamV2lapRTJ+suQIjZzon
         GgOw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfp7TVK2B0gkAbKRgEjnqPZkDft2Y02ejsV2zg7FvCDKH9OeMqynFkzg8mDM7tlIqiDL+BAwgwME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4QlF8JHck6gcZUa+MMo6BudQt54h5Se0jraRFdWSmXigxQ7v
	hV/O296wtfBszwWyD+xyo0bv7WHy85tmxRUyvi948v/psVQ/YFJ/htGD1zL2seUPa8SnbDybULf
	/FWF+qBgBfzo1powx6BIHozcCQmTJMjVz7GqM6epwa0f7cYdqJkFqlCbalNc=
X-Gm-Gg: ASbGncstZyvAoreyCxt17hME3WMOxBDYcRaUcSlPt6IDStaKAHutRAQKJgwtrHMSNIK
	nZc0NUQv7YqQVkh8aqQlqRfdmTtpprNpLuu1VjXC6XR0Vi6OBEmtPYNWI09yf6iriY5WFprl9h/
	l44EVbcv5pYEZIxROL67pmhUtOWQTDdVKeZJpZdYr4d0181ToqixiXZ4fxCQPKcRweD5qDoLMsJ
	gIZjxPDJd+S5BHxjBI9ugw2+KcUCvgzupII2yWU07hrwCF2pjTiIBfV8mEZlBU+U5tIiUni9R5W
	zZ60skGgy7R2Og9ykWrmnzpyZot6AP8SnqIlaD06LZ6HQp9lBIRmfjxH4zB0GaYFIw==
X-Received: by 2002:a05:622a:19a7:b0:477:e9f:7530 with SMTP id d75a77b69052e-4795f35494amr14732591cf.12.1744204950990;
        Wed, 09 Apr 2025 06:22:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtvvTpAbOq+RwOTgPOW+p1fvx55yA5PRtcriKzpC7QJsbRuHC9EleyT/a6UkABJje5rKgAA==
X-Received: by 2002:a05:622a:19a7:b0:477:e9f:7530 with SMTP id d75a77b69052e-4795f35494amr14732121cf.12.1744204949672;
        Wed, 09 Apr 2025 06:22:29 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbc2cf69sm799686a12.37.2025.04.09.06.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 06:22:29 -0700 (PDT)
Message-ID: <a79eaaa9-0fe9-45d9-b55f-ba2c327eaaaf@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 15:22:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
 <8e301a7b-c475-4642-bf91-7a5176a00d1f@oss.qualcomm.com>
 <385c7c77-0cb7-f899-4934-dfa58328235a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <385c7c77-0cb7-f899-4934-dfa58328235a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZTkPDYB5UAEMcltgGja4hNkm08uO7RX0
X-Proofpoint-ORIG-GUID: ZTkPDYB5UAEMcltgGja4hNkm08uO7RX0
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f67499 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=o148c7v5wAakItcUyVIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090081

On 4/1/25 7:52 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/25/2025 7:26 PM, Konrad Dybcio wrote:
>> On 2/26/25 8:30 AM, Krzysztof Kozlowski wrote:
>>> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>>>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>
>>>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>>>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>>>> downstream PCIe ports.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>
>>> Drop, file was named entirely different. I see other changes, altough
>>> comparing with b4 is impossible.
>>>
>>> Why b4 does not work for this patch?
>>>
>>>    b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>>>    Checking for older revisions
>>>    Grabbing search results from lore.kernel.org
>>>    Nothing matching that query.
>>>
>>> Looks like you use b4 but decide to not use b4 changesets/versions. Why
>>> making it difficult for reviewers and for yourself?
>>>
>>>
>>>> ---
>>>>   .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>>>   1 file changed, 178 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>>> new file mode 100644
>>>> index 000000000000..ffed23004f0d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>>
>>> What is "x" here? Wildcard?
>>
>> Yes, an overly broad one. Let's use the actual name going forward.
>>
> ok I will update the next series the name from tc956x to tc9563 as
> suggested.

As per internal discussions, 956*4* would be the correct name for this one

Konrad

