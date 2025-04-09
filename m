Return-Path: <linux-pci+bounces-25575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE628A82940
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55602906BDE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB162676CA;
	Wed,  9 Apr 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAwKdEvj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADA267391
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210188; cv=none; b=k+kWEJzXTFzU3RCelc0wczlcLs8tHdvaJMiD0PMuYGpW390f2FYV07qGvg1GIVkxXRX/G4+asJk1irs+/vmwq8HYiOwmDSxLi6L6iSWLn6lgJZ2unWjedLwTqXS/bNyr3KpJ7LckGh9aGa5R2Q4Tl7sfQ/8in7/8F+GD2gqwL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210188; c=relaxed/simple;
	bh=85+UIcf1eKLU/wNzZgNVq10Yo7Ip9fEDwLj2BK/wH0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZzy0UPBbUygBzFab3iv0TN6hW+6blElu2cFUk/Zm7LO1Po6uZeCLeaOt5g2JGtu9Lt9HgHH5fooOGN/KQTCypIlnLw+i3yh3JkDkel7NMO0A2REQzJ05q9cBPsPe3z2WV/SEh1Mj9RtXG/VynxGa4LVSiwNsh3LseKiE1puYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAwKdEvj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398i7GK032322
	for <linux-pci@vger.kernel.org>; Wed, 9 Apr 2025 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NAji33sbWftR/X6dZ2NUeyfjXLgktdVt707HtkxaLX0=; b=PAwKdEvjtewbtaba
	2V2qQjPJwGOamRfReF4UgYHmeMQPWAMYT6bC8e2TsfZzNn5hpIluqBIcCB2VD5gc
	oIcllz4ev5MxKTTUAPQFCQpXLI0okxFDYPb+0hqeu2guc4fWqE4WpMVWiqA6TDkm
	1Nu7jGCBtZabRfZRQHgLGTpe+6bNB7hC04kvxNiG7Z9fPjZTYfFWlXM+fBE5DMk5
	I2kHcg/lPeC1cHyJgoYwIdpDZgC0VDBBsw/tRTNrxw3Z0Zex0SaxodPfbAQHR5hd
	xUSYZLu71lvANyR44l+aMLnRsMs7iprErdrR2G9V117gWTJx0e8Eh89vuI4XbtaV
	qqfsaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbebsds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 14:49:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54734292aso162256985a.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 07:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210184; x=1744814984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAji33sbWftR/X6dZ2NUeyfjXLgktdVt707HtkxaLX0=;
        b=saIXYTa1TdCB0l5uTX2ifsC0ZOrQl5QQvpvf6jiRrqxZW+D30bNgET6QslK7XsMijo
         7mztkb539f2woiLCLg+WRBwnTDz7gpwxzcWkS4iOy4LfPgUImfB/cxIF9bB7yr2oWiGh
         tMBQkCFJaVidWKbj1WF2UUTYtcEKJzErFM6nKC9Gm3d5LzBuvEYfhJcXRTkdZA8uqfph
         aM+vqc5eSaPGogatjWjV2hicsUOozSLSdaGI/mFv3oyvNNMP95VWsdGj0lVcIxH457x0
         3rWlIgZkunH1BWlqfzUlbHlw4N1SMNhF+6R1bLe6oHJuxoW0/n20WhmPcUPL8u4qCF3U
         cN3A==
X-Forwarded-Encrypted: i=1; AJvYcCWZvI3NGpA+BkSFQOu01oc89igjOtvdFxUZtinGhdUOG9AwA5uS4OOcaCTBVXjO8xNjvvccKXM7CME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7LmpXMzivdP8vRxO6xMlBIJ5mBOdVawQTeWOOx2SEIHxq0BG
	QPDGMUmzQc2anZc7FEGOkj9vRYkret2lxaB+V4k10cLELiOrxiusbpY3/+xxe5qIU/yaGJsJIJM
	BZhIcliiqeUJXmv8GsTO9+6COS4Ii0rVwR9TWDueywT/WDPt0IiRs5m17bHU=
X-Gm-Gg: ASbGncvmlQ61YM2QBPUf4ocPu7nwRemiAqxX3ZAjfWlSlyyNf4eVuil8hoGVpvWCQ/W
	roDY6vJW4tOTYaoULQ8q0U9J6McLBHMrVl7Q+44IADE/6/62GQHofXeEqpjDpTpOS9yhbtOX+Fk
	zKQ+4YyhVaSH8mrNE1Q2g6gNwjkkTWs/dUyXGtGxzQNIRWYEinwTKymHNbz5gaizAZs5DV/64+6
	BVVSBdU9Y3awDHI8hihH3hpK4DQtHmImVXsvECj2t8mP+kDj35XbmGqQC7ZULB3KEXYTzUOX9ZT
	5tl3V6p0KPOB6fd8+KlK44w/vveAeVgLfAHzzxMeikRwJu/zqrByq2gZ2LF1pyAY7g==
X-Received: by 2002:a05:620a:1792:b0:7c3:c9d4:95e3 with SMTP id af79cd13be357-7c79cc382dcmr170872885a.10.1744210184459;
        Wed, 09 Apr 2025 07:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMm5nWNQB+SUuTMx8XfwA9o0yrLRkaTZP7ACAR3JyVEdTKjbhOMoZD8lRtbWW3IF+TISiTyg==
X-Received: by 2002:a05:620a:1792:b0:7c3:c9d4:95e3 with SMTP id af79cd13be357-7c79cc382dcmr170869385a.10.1744210183947;
        Wed, 09 Apr 2025 07:49:43 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd205sm108975966b.141.2025.04.09.07.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:49:43 -0700 (PDT)
Message-ID: <83713b15-d74d-4620-b9a0-9c57f216c6bc@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 16:49:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
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
 <a79eaaa9-0fe9-45d9-b55f-ba2c327eaaaf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a79eaaa9-0fe9-45d9-b55f-ba2c327eaaaf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 53HM1Tz_Uyf2ZNBHa8U9_a2BExd5WC-Y
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f68909 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3h54kFN3o8ui-8ShBWYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 53HM1Tz_Uyf2ZNBHa8U9_a2BExd5WC-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090093

On 4/9/25 3:22 PM, Konrad Dybcio wrote:
> On 4/1/25 7:52 AM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/25/2025 7:26 PM, Konrad Dybcio wrote:
>>> On 2/26/25 8:30 AM, Krzysztof Kozlowski wrote:
>>>> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>>>>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>
>>>>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>>>>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>>>>> downstream PCIe ports.
>>>>>
>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>>
>>>> Drop, file was named entirely different. I see other changes, altough
>>>> comparing with b4 is impossible.
>>>>
>>>> Why b4 does not work for this patch?
>>>>
>>>>    b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>>>>    Checking for older revisions
>>>>    Grabbing search results from lore.kernel.org
>>>>    Nothing matching that query.
>>>>
>>>> Looks like you use b4 but decide to not use b4 changesets/versions. Why
>>>> making it difficult for reviewers and for yourself?
>>>>
>>>>
>>>>> ---
>>>>>   .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>>>>   1 file changed, 178 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..ffed23004f0d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>>>
>>>> What is "x" here? Wildcard?
>>>
>>> Yes, an overly broad one. Let's use the actual name going forward.
>>>
>> ok I will update the next series the name from tc956x to tc9563 as
>> suggested.
> 
> As per internal discussions, 956*4* would be the correct name for this one

I misread. It's supposed to be 3. Sorry for the confusion.

Konrad

