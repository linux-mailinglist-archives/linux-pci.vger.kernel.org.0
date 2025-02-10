Return-Path: <linux-pci+bounces-21072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9015A2E7F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1301E7A23B5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD31C3C0A;
	Mon, 10 Feb 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iosz2nIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C018CC1D;
	Mon, 10 Feb 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180273; cv=none; b=tyb2FiBUGsjsV9zo4bCJ+lQA8FOGjIUyeVtJzyp3m7K1cQLi8VI2/94UEweSF0ZXrdcNWfqer84/gv1h+kVFnzdXb6aopmjooRqz8IqpOgYi2yLwA+NB9agoesjrRCV/jsQpIDu1EJHh+vKWc1da9oPgJOmWT5Vp0ta2WYVzq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180273; c=relaxed/simple;
	bh=feChQ7b1XlDiChAu2MJdKTO3BZhdbzuTbOlf6cK7C5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gCormys4ECZocXqvNPDONQ9rbelQ8hbPtVbecHpK1ttWLRZbDEVPkr8O0hwUUdXiBqd/jMcjIr7AhkorI72b/woeGh0lFg6+gYAoIIojFVA5dFLOaXxTfha74cCGCJH0Cbzq8cEAvDEgrDYv2+ymflclax55vN5fqxCQPwN0Vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iosz2nIk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9NAsZ032157;
	Mon, 10 Feb 2025 09:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LboHLYRgoVqWg16aE7qjaVarz9z54wk9WcqClhtan8A=; b=iosz2nIkFJ8rRKWv
	0yPaX/V0w1OcAetxvQbTK0RcoNJI0PdICl2DpPoQv89D1kzzLux4BFL4dmsfajbQ
	nLvZwHmjZKXD5kfAih8jfRPhi4fCQ5hSHE1veJm7fKBPrZR8YguPg1HDUs+T4up+
	OHJDbs7ED4QKOoXI0DB8bscZY5GirDl68l6dczDZVOH8/KLWBWjBMcVyyYYZ9F6O
	S9JJQMqjq3yILQB+8a0/gSR9b4dBFI6PEPVtdSmYSrP9PRoEHLfF3Sk7cEpFiScD
	7lLeeS4P482JjQl4IRL47hDfuU0nW1E9GIhOQpWlMC9ELEblHmBNFaoq8CzBa4Yz
	BV4qLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0esbvtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:37:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51A9bgtx020056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 09:37:42 GMT
Received: from [10.216.26.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 01:37:36 -0800
Message-ID: <5ab133b4-0146-0b14-04be-20ef4cfeef1b@quicinc.com>
Date: Mon, 10 Feb 2025 15:07:32 +0530
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
 <83337e51-6554-6543-059d-c71a50601b09@quicinc.com>
 <20250210075155.ka3fy3xiptyy3w6i@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250210075155.ka3fy3xiptyy3w6i@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g47RO5YYqt1hGfWxVER7VC32gpn00-pq
X-Proofpoint-ORIG-GUID: g47RO5YYqt1hGfWxVER7VC32gpn00-pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=703
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100080



On 2/10/2025 1:21 PM, Manivannan Sadhasivam wrote:
> On Wed, Dec 04, 2024 at 02:19:56PM +0530, Krishna Chaitanya Chundru wrote:
> 
> [...]
> 
>>>>> +                pcie@3,0 {
>>>>> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
>>>>> +                    #address-cells = <3>;
>>>>> +                    #size-cells = <2>;
>>>>> +                    device_type = "pci";
>>>>> +                    ranges;
>>>>> +                    bus-range = <0x05 0xff>;
>>>>> +
>>>>> +                    qcom,tx-amplitude-millivolt = <10>;
>>>>> +                    pcie@0,0 {
>>>>> +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
>>>>> +                        #address-cells = <3>;
>>>>> +                        #size-cells = <2>;
>>>>> +                        device_type = "pci";
>>>>
>>>> There's a 2nd PCI-PCI bridge?
>>> This the embedded ethernet port which is as part of DSP3.
>>>
>> Hi Rob,
>>
>> Can you please check my response on your queries, if you need
>> any extra information, we can provide to sort this out.
>>
> 
> I believe Rob was pointing the 'device_type' property which is not needed for
> PCI device nodes but only for nodes implementing PCI bus (like host bridge, PCI
> bridge).
> 
Got it, I will remove device_type in the next patch series.

- Krishna Chaitanya.
> - Mani
> 

