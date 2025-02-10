Return-Path: <linux-pci+bounces-21076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5CA2E8C9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB133A2453
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96D1C5D6F;
	Mon, 10 Feb 2025 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FUE5Mw8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F814F70;
	Mon, 10 Feb 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182415; cv=none; b=QSfYEA5nZ/5MxJ41kUXFERZtv3HYNJUxWpfYNECAi2ex8v2z0GzZvOSBtay5EjqAXiA6ScgW8k8il++ZxfN0tYvmS9ADVXVXl3aBekrg8EQuLoSS6Mh1g/Rnatwp3JXoteZ0Dr+ZQXr/+BXPTLp84FQlEBjlNFofOVQMkSFuWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182415; c=relaxed/simple;
	bh=x9kOMHXYbCi+8ky9+AUdixtNJKZjwinJuuuzMQJGFcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jQ8MSOCy5huZVkIm3pxWNBSiLQXrZ2TPp9jo6Vc3WVzfqa5KEsaQBtoxi5fh2eJ8k5nOsIqm13ha18Y4KpAipa4/cRciq+T9WdRuYBPncWr14dPwBgSNFy13kENJB9h5tGNQ6rRmFEDMj3H+ZK2mfbVAzwN1J0g7l/Ck+ucHSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FUE5Mw8J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9HxNM001544;
	Mon, 10 Feb 2025 10:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xkH7gwWUcxGs2AWsOE+9+MIUaHbyvxYGoZVLa1YSbs=; b=FUE5Mw8JSPNYtYv5
	D5MwMot8GdOScYmKeYbGsuYy4OgknsS7Wv7OsHQ+Wj/yT5WvEWTZFycp21pW2BWw
	z2s67N/wzrGrYIi9RgCY60hYu+iwSRyCaxEMi6S4rwmN4N1ztIShTx7gnOS4aJNa
	iPp8LJlV2Vc7th+Z1wwXT35YHuM2qoQIhTKDGLquHwQPiH+8lkqjDZIpzUK93PYE
	uwn3K2+ZWBMRgZDVVRhdTjNgMO091jnNY7W6qhC1RhEwFLEPQx/BqcwAkrQfNhPJ
	yveQj+jB3DXBFpTExZxhwvWOKHymsk6oSJOZS6f/Ribu5Sf47sXwBRQ07WBlngsK
	gh/OxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qepxg54b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:13:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51AADOKp022275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:13:24 GMT
Received: from [10.216.26.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 02:13:18 -0800
Message-ID: <c234188e-a5a5-229c-53e8-bf7f7cfc8567@quicinc.com>
Date: Mon, 10 Feb 2025 15:43:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Rob Herring <robh@kernel.org>, <andersson@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
 <20241230182201.4nem2dvg4lg5vdjv@thinkpad>
 <d4019981-1df2-0946-d093-7dc97c2d0ffe@quicinc.com>
 <20250210075813.c2wvr3bozndi2ice@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250210075813.c2wvr3bozndi2ice@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2QZrSnxWI7_LdWZoltvBcoP337si-E-c
X-Proofpoint-ORIG-GUID: 2QZrSnxWI7_LdWZoltvBcoP337si-E-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=918 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100085



On 2/10/2025 1:28 PM, Manivannan Sadhasivam wrote:
> On Tue, Jan 07, 2025 at 07:58:17PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 12/30/2024 11:52 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Dec 23, 2024 at 08:57:37PM +0200, Dmitry Baryshkov wrote:
>>>
>>> [...]
>>>
>>>>> This switch allows us to configure both upstream, downstream ports and
>>>>> also embedded Ethernet port which is internal to the switch. These
>>>>> properties are applicable for all of those.
>>>>>>> +
>>>>>>> +    allOf:
>>>>>>> +      - $ref: /schemas/pci/pci-bus.yaml#
>>>>>>
>>>>>> pci-pci-bridge.yaml is more specific and closer to what this device is.
>>>>>>
>>>>> I tried this now, I was getting warning saying the compatible
>>>>> /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
>>>>> pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
>>>>> given schema
>>>>>           from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>>>>> /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
>>>>> pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
>>>>> '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
>>>>>
>>>>> I think pci-pci-bridge is expecting the compatible string in this format
>>>>> only "pciclass,0604".
>>>>
>>>> I think the pci-pci-bridge schema requires to have "pciclass,0604" among
>>>> other compatibles. So you should be able to do something like:
>>>>
>>>> compatible = "pci1179,0623", "pciclass,0604";
>>>>
>>>
>>> Even though a PCIe switch is supposed to be a network of PCI bridges, using
>>> PCI bridge fallback for this switch is not technically correct IMO. Mostly
>>> because, this switch requires other configurations which are not applicable to
>>> PCI bridges. So the drivers matching against the bridge compatible won't be able
>>> to use this switch.
>>>
>>> - Mani
>> Rob,
>>
>> Using pci-pci-bridge expects to use compatible as pciclass,0604, we
>> can't  use as this switch is doing other configurations which are
>> applicable to PCI bridges. can we continue to use pci-bus.yaml.
>>
> 
> Let's put it the other way. What are the blockers in using the
> pci-pci-bridge.yaml other than the fallback compatible? If the compatible is the
> only blocker, you can add it even though the drivers cannot make use of it
> (that's one of the reason why I was against adding it).
> 
> - Mani
> 
Compatible is the only blocking thing here.
If I use pci-pci-bridge.yaml I was getting fallowing warning
pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching 
the given schema

can we use this way compatible = "pci1179,0623", "pciclass,0604"; to
avoid warnings.

- Krishna Chaitanya.

