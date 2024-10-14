Return-Path: <linux-pci+bounces-14472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA599CB57
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA221C22DAA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407F1C3F32;
	Mon, 14 Oct 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5DdR/3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBD1C3052;
	Mon, 14 Oct 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911598; cv=none; b=T7/1k2b1h/aH8x3dyxPFCbZfklN8Mfo1iubUWzp1I3PKREpZQ5lQGIQRa0CdJkjGgn7VThcyrRUb+RSpoSKmhYQ1lVA2EN4DdBvABObvkMeUQhCVBH7HRWyui+VGxQWOov66Su2Cwv/uHEmK/XAT2SJJLW66WjybIz5LK3Dh8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911598; c=relaxed/simple;
	bh=8rvFv72V/ATXidkPdPrUDPDXphy7QCZWWCwsoMM0z+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JLE88x6rW9OfcSWOTNCBvLn5P3NskQ8orXus5trzlkyPBL0SP3onrcPoikvqyN4D0Zt05lGDEp+BcNbvORCqeqtUvHLptqfrcFHfF05ygeVo91UIBhkHA5h/7KQNx97ciyknFr+GhTPt5vTw5CXKN3aRcEmNnotJdfGngHIVdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5DdR/3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EARqs6008690;
	Mon, 14 Oct 2024 13:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s7iw1fPo4g9lffSq8A0NeOVNnbxLfmxzqmRxicpKLX4=; b=g5DdR/3Vko8VnmGZ
	EbID4hoJO76FhJ1gE1hZ52ZCtRP3UetOOy4WXHu/1U2eTLLJ7nD52a9co9/s8FtA
	2LdTlZ61f+AU2RYg5Ek9FWC2zwd+tKq21Jin/lhV0t2b8F8v6LICZ1eAPsV8dOjh
	9jR5WMOpVQLTyn25nFTMJai5a2LOAEt3W1WWkzbUoKknrzFoGJ51DgVptm3jMnNU
	WLg61wPHFJilTRqPpjvPuT7ZIJLtB1uzn4rbJlTTv9klL5VE7nJN5Ou404pw/+9q
	gQ2JuGz/kC8fVePFhHq3GTLeibxFs4gLV/58bubxXJRynDilMkMBHfKUzTDY4xb7
	gymw3A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427gpxmf4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:10:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EDA13a022102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:10:01 GMT
Received: from [10.253.10.174] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 06:09:55 -0700
Message-ID: <62785e7d-86ea-4841-ae76-4afdd612dca4@quicinc.com>
Date: Mon, 14 Oct 2024 21:09:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] dt-bindings: PCI: qcom,pcie-x1e80100: Add 'global'
 interrupt
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-4-quic_qianyu@quicinc.com>
 <eyxkgcmgv5mejjifzsevkzm2yqdknilizrvhwryd745pkfalgk@kau4lq4cd7g3>
 <4802B12B-BAC1-4E99-BDFE-A2340F4A8F24@linaro.org>
 <3d1d0822-da66-44c8-a328-69804210123c@kernel.org>
 <65B34B14-76C3-491D-8A58-6D0887889018@linaro.org>
 <df6379c6-662a-4b35-a919-13c695a869c7@kernel.org>
 <96816abb-4e0d-4c60-8ae6-b5a5cd796e99@quicinc.com>
 <d16a2dca-5b96-4b72-bd79-6ad2960fdb5e@kernel.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <d16a2dca-5b96-4b72-bd79-6ad2960fdb5e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LNbswjoW0-pCJSDR8VSslzRLqzMEjKQF
X-Proofpoint-ORIG-GUID: LNbswjoW0-pCJSDR8VSslzRLqzMEjKQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=704 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140095


On 10/14/2024 4:25 PM, Krzysztof Kozlowski wrote:
> On 14/10/2024 09:50, Qiang Yu wrote:
>> On 10/12/2024 12:06 AM, Krzysztof Kozlowski wrote:
>>> On 11/10/2024 17:51, Manivannan Sadhasivam wrote:
>>>> On October 11, 2024 9:14:31 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>> On 11/10/2024 17:42, Manivannan Sadhasivam wrote:
>>>>>> On October 11, 2024 8:03:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>> On Fri, Oct 11, 2024 at 03:41:37AM -0700, Qiang Yu wrote:
>>>>>>>> Document 'global' SPI interrupt along with the existing MSI interrupts so
>>>>>>>> that QCOM PCIe RC driver can make use of it to get events such as PCIe
>>>>>>>> link specific events, safety events, etc.
>>>>>>> Describe the hardware, not what the driver will do.
>>>>>>>
>>>>>>>> Though adding a new interrupt will break the ABI, it is required to
>>>>>>>> accurately describe the hardware.
>>>>>>> That's poor reason. Hardware was described and missing optional piece
>>>>>>> (because according to your description above everything was working
>>>>>>> fine) is not needed to break ABI.
>>>>>>>
>>>>>> Hardware was described but not completely. 'global' IRQ let's the controller driver to handle PCIe link specific events like Link up, Link down etc... They improve user experience like the driver can use those interrupts to start bus enumeration on its own. So breaking the ABI for good in this case.
>>>>>>
>>>>>>> Sorry, if your driver changes the ABI for this poor reason.
>>>>>>>
>>>>>> Is the above reasoning sufficient?
>>>>> I tried to look for corresponding driver change, but could not, so maybe
>>>>> there is no ABI break in the first place.
>>>> Here it is:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4581403f67929d02c197cb187c4e1e811c9e762a
>>>>
>>>>    Above explanation is good, but
>>>>> still feels like improvement and device could work without global clock.
>>> So there is no ABI break in the first place... Commit is misleading.
>> OK, will remove the description about ABI break in commit message. But may
> Describe real effects. You got comments about ABI impact before, right?
> So if you remove this, how previous feedback is addressed?
Global interrupt is parsed as optional in driver, so there is
no ABI break, will write this in commit message.

Thanks
Qiang
>
>
>> I know in which case ABI will be broken by adding an interrupt in bingdings
>> and what ABI will be broken?
> Users of ABI stop working.
>
> Best regards,
> Krzysztof
>

