Return-Path: <linux-pci+bounces-14471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBC99CB51
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059DA281D60
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FC1C1AD8;
	Mon, 14 Oct 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLkNruy3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F91BE86E;
	Mon, 14 Oct 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911591; cv=none; b=apVAjZ/1+5yjmVdLjBg2wi9rztFKz9CTvPLVimpWWbsCZTo5IBDl2s7YX9GQ8NCLwjtyOt1bL60yKJLOHbtutsRE5D2GoaRYTDjCAtYU8JPn7n9MtiAcTz0HFJzInc+e0+UAfsxVonCwXlO0XHUB0akwaIwLdW+9HX9u+s10hXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911591; c=relaxed/simple;
	bh=ndee/AFgnLGg95ixYYKZU3dpuR3s81+9MlGalzVSh2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ern4kqmXUKPLVIT7egBdwUsd8fVz7bsrHzCXbgyWj42PAprFM9FgrCECwFBNWGeT6IY9tryBovSozxZjqOYxj1ACoHQdCXM3p8VQtaWF0qIq4LfhXNVn1CVQ43cF5Rq+0n2MB//zqvgNRRU0GtnOgpMiIsbRwP9EJcY9MWeYaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aLkNruy3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EBNHqF013174;
	Mon, 14 Oct 2024 13:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e3SuHs/ftC65uHNR5RtQxXpgy6EP0Kdb+DVlw9heaHw=; b=aLkNruy32o9al6hE
	DqbGEVYCJzkp37+vUikjWfQbj7t1dQdy719I/LLEXEdDkOyr5WPwXuNT+bkeKW91
	ZxA1/xjs3ZFDPZeYq2Jgn1cpfT7RS2lHCEylEQPtTfEs8U9BqkDntLpn1VDW9fXL
	40p4egZENfl6Gy7CMwpDz8iBDGQCzlhJWa0fi1GrE92makb4zyd8anSqITUoB0tO
	EbZmuDqJ7ZdOSoYzN7ZaoVJiwxkyBGY97cocWcoLjXnCCLK9/953tDIqFWTsnOwV
	6dimCu2Blvs1UJ1b4/PHtTH2siyyCxIjzMhEMXC/0Y2BvR1nHGXqxjvysgksR3aO
	irKFfw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hvfvbet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:09:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49ED9RDx032375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:09:27 GMT
Received: from [10.253.10.174] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 06:09:21 -0700
Message-ID: <75b22700-e4de-43fd-8e16-1961703bb708@quicinc.com>
Date: Mon, 14 Oct 2024 21:09:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] dt-bindings: PCI: qcom,pcie-x1e80100: Add 'global'
 interrupt
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Krzysztof
 Kozlowski" <krzk@kernel.org>
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
 <20241014090251.r4sfaaxtasokv4oi@thinkpad>
 <ea7c1390-7ead-4c17-9ae3-cdcc9866332a@kernel.org>
 <B716D0B8-2B9C-4FA2-94F3-038F1C634244@linaro.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <B716D0B8-2B9C-4FA2-94F3-038F1C634244@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LfnxdWDOyju9HWf5eiUdlaFtkSZPqfEW
X-Proofpoint-ORIG-GUID: LfnxdWDOyju9HWf5eiUdlaFtkSZPqfEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=832 malwarescore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140095


On 10/14/2024 5:41 PM, Manivannan Sadhasivam wrote:
>
> On October 14, 2024 2:56:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 14/10/2024 11:02, Manivannan Sadhasivam wrote:
>>> On Fri, Oct 11, 2024 at 06:06:02PM +0200, Krzysztof Kozlowski wrote:
>>>> On 11/10/2024 17:51, Manivannan Sadhasivam wrote:
>>>>>
>>>>> On October 11, 2024 9:14:31 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>> On 11/10/2024 17:42, Manivannan Sadhasivam wrote:
>>>>>>>
>>>>>>> On October 11, 2024 8:03:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>>> On Fri, Oct 11, 2024 at 03:41:37AM -0700, Qiang Yu wrote:
>>>>>>>>> Document 'global' SPI interrupt along with the existing MSI interrupts so
>>>>>>>>> that QCOM PCIe RC driver can make use of it to get events such as PCIe
>>>>>>>>> link specific events, safety events, etc.
>>>>>>>> Describe the hardware, not what the driver will do.
>>>>>>>>
>>>>>>>>> Though adding a new interrupt will break the ABI, it is required to
>>>>>>>>> accurately describe the hardware.
>>>>>>>> That's poor reason. Hardware was described and missing optional piece
>>>>>>>> (because according to your description above everything was working
>>>>>>>> fine) is not needed to break ABI.
>>>>>>>>
>>>>>>> Hardware was described but not completely. 'global' IRQ let's the controller driver to handle PCIe link specific events like Link up, Link down etc... They improve user experience like the driver can use those interrupts to start bus enumeration on its own. So breaking the ABI for good in this case.
>>>>>>>
>>>>>>>> Sorry, if your driver changes the ABI for this poor reason.
>>>>>>>>
>>>>>>> Is the above reasoning sufficient?
>>>>>> I tried to look for corresponding driver change, but could not, so maybe
>>>>>> there is no ABI break in the first place.
>>>>> Here it is:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4581403f67929d02c197cb187c4e1e811c9e762a
>>>>>
>>>>>   Above explanation is good, but
>>>>>> still feels like improvement and device could work without global clock.
>>>> So there is no ABI break in the first place... Commit is misleading.
>>>>
>>> It increases the 'minItems' to 9 from 8, how come it is not an ABI break?
>> Interface changed but all known users are still working, right? "Break"
>> means something does not work, something is affected.
> Hmm. I thought you were referring to the DTS warnings (for old DTS) that come out of these changes. But for kernel ABI, yes there is no breakage.
I really see dts warning after dtbs checking and since global irq is to
improve user experience and device could still work without it, will
keep the 'minItems' as 8 and set 'maxItems' as 9.

Thanks
Qiang
>
> Sorry for the confusion.
>
> - Mani
>
>> I might be missing
>> here something, of course, but I simply do not see any affected user here.
>>
>> Best regards,
>> Krzysztof
>>
>>
> மணிவண்ணன் சதாசிவம்

