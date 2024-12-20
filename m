Return-Path: <linux-pci+bounces-18901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E239F915A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572E116C920
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1EC2AE96;
	Fri, 20 Dec 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lARRes2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0731C5496;
	Fri, 20 Dec 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694159; cv=none; b=iLPtKH6yFrzTVQppZJYcWAjeo08t7atx9vdFsy9MrYpjL1wnc7G61h0f1JWjhcpg1Prxr2Gb2PVA+GEKh2YOyzpy5I+HIr+FwmwwP5YKYlsSl5U8fmkjIolUYbELphETluXsiGX3MBe3je7g3c0xWbTkaS0oPsgUMchlvZfYoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694159; c=relaxed/simple;
	bh=e6RRTNZKSVTO862lwIFBvL5ei0oT+HVqaOxrltcfMNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J5jR+4S/4pNFjam69uV6IkPY//HVBUc/23hCN0i8cLH//xaZD54nBpZcHmWpSgNl4xY6nEkylNgdkO8nkRaMKiG6qkQe0XpAWMUlTfug39cXNTPh4nrAa7vJg5w55bAA4v7I6UGrFtfqwRncC9NbCPZ9SAOA+izOHUUGB9A3+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lARRes2y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6n0EH028591;
	Fri, 20 Dec 2024 11:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MPWkcTcIYJFDpVK5XdmX72WZWvyJATmGLKiYjjvUxyk=; b=lARRes2yO1cckMn/
	aRJcXX9jFE0TYkSR2jsIi3ipcd3yWcOs8FnTtucriIVxt/YDdnzYrbb2q7yQZqim
	3OiEVBH0zAOspaKs9M+Yj+XDZfoSRCpYLv4X8tnZZOvQ3dUL9n0+nj5VffpyV3zV
	IGv0KlYE1NmCR1/OqouguBN68Gr9BBNCMvjybpaV96gkpa9THUFhCMSTKohqmcK2
	iJQD9SNCkM+cm5rvUVp8rdzkBHSpNYf6EckYIIORC51/cPqOTRTHf5u8Lf/4dJvy
	sRDHLCT1ir8WP2Osn6zQGyCCAQRnhgq7MBiJnA3ZmLbgZqbtI3fwQeRqclX6lnXK
	08aMrQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n3mxrr0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:29:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKBT46d028128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:29:04 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 20 Dec
 2024 03:28:56 -0800
Message-ID: <0c7c1979-6fc3-4059-bf08-c94f6424b1dd@quicinc.com>
Date: Fri, 20 Dec 2024 16:58:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-4-quic_mmanikan@quicinc.com>
 <69dffe54-939d-47c3-b951-4a4dea11eae0@oss.qualcomm.com>
 <08fbde92-a827-4270-a143-cca56a274e6c@quicinc.com>
 <71d2135f-664a-465d-bc1f-051cc07c8537@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <71d2135f-664a-465d-bc1f-051cc07c8537@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZzBnjh2nN8OwLgERvuK6_pJLmUbpRQ1g
X-Proofpoint-ORIG-GUID: ZzBnjh2nN8OwLgERvuK6_pJLmUbpRQ1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200095



On 12/20/2024 3:18 PM, Konrad Dybcio wrote:
> On 20.12.2024 7:42 AM, Manikanta Mylavarapu wrote:
>>
>>
>> On 12/13/2024 8:36 PM, Konrad Dybcio wrote:
>>> On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
>>>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>>>> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>>>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>>>
>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>> ---
> 
> [...]
> 
>>>>  		tlmm: pinctrl@1000000 {
>>>>  			compatible = "qcom,ipq5424-tlmm";
>>>> @@ -168,11 +261,11 @@ gcc: clock-controller@1800000 {
>>>>  			reg = <0 0x01800000 0 0x40000>;
>>>>  			clocks = <&xo_board>,
>>>>  				 <&sleep_clk>,
>>>> +				 <&pcie0_phy>,
>>>> +				 <&pcie1_phy>,
>>>>  				 <0>,
>>>
>>> This leftover zero needs to be removed too, currently the wrong
>>> clocks are used as parents
>>>
>>
>> Hi Konrad,
>>
>> The '<0>' entry is for "USB PCIE wrapper pipe clock source".
>> And, will update the pcie entries as follows
>> 	<&pcie0_phy GCC_PCIE0_PIPE_CLK>
>> 	<&pcie1_phy GCC_PCIE1_PIPE_CLK>
>> 	<&pcie2_phy GCC_PCIE2_PIPE_CLK>
>> 	<&pcie3_phy GCC_PCIE3_PIPE_CLK>
>>
>> Please correct me if i am wrong.
> 
> The order of these is fixed by the first enum in
> drivers/clk/qcom/gcc-ipq5424.c. The <0> entry must be at the end of
> the clocks list for it to do what you want it to.
> 

I understand your point. I will move the <0> entry to the end and 
incorporate this change in the next version.

Thanks & Regards,
Manikanta.

