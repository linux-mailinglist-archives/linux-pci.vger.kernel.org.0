Return-Path: <linux-pci+bounces-13534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D8986B34
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76171F2328A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 03:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A15170A3A;
	Thu, 26 Sep 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CYDMfuPb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41351E86F;
	Thu, 26 Sep 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320566; cv=none; b=JOp3XI8YdISZGlUKAO2E4dXErQdLNLT36wpMwBwTfBb21z8klMzMrwsps1YPLDMf9Tx5zb27n/kze57ErJ51EfeeDQJw17ygqaUvGN6+tUJF/IWLMYCxNXao2d1Tg6OWqK6Js1McfzvWRBYLujVKiBn2zhjFvQ7dEO2Cf1pGjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320566; c=relaxed/simple;
	bh=+W2smmZP2TE11XEh0NI+zTe9OLlYjqH0F7I22285p4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NW2di3wA+CIwVAzWRMNb62lNo9qR80yzftzLDV6GKiAVvG/2bOVWA4+5RP3P5AhbEQ9dmSBKdsGOBltp5I5UdFAVY1P/35ZVwUPWr8m02v2GVh/IrcE/a8ORCGNOyqu3aLJCLjLBEGZnXovyTo1iPgSaNtVD8Owc8JbrfI3NQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CYDMfuPb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH579S013184;
	Thu, 26 Sep 2024 03:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CzfN0rwmVw6/7b8Y2EWgGLi8n8HdqtF7GPY1P+QEZYQ=; b=CYDMfuPb7CtLsMDq
	ODEbR5C2Aez6Nlga6qukQj9LQmOO5uW78/5quXHoPus3XfPZoIQgCbO0g0+/CdPy
	wNUySMtvql7VSrY5uCwWI31d2XU83iQ1gEDO47N18uoIERnxB4s5P1gF+uSWY9RH
	j8TUhsij4wUQvEjknCBYrooby3Rz/09TplIVqnn27LJ2Aya0jX83gFDHt0WCDaTc
	F74HGMsR5K7A4GMaU/lK8MHUbjFFywT48XqMcgxiV5De4UV90ABTU5wreB9PDFqr
	QuV2NGnoqW/TtIZ2LVDjOmaIXeUMCxKQNMZ36qJZeghBhLDsDgHR1wdJBkmwzgcx
	TiWpZQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snqyp5w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 03:15:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q3FiEr003271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 03:15:44 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Sep
 2024 20:15:39 -0700
Message-ID: <1c6bf1a9-a781-4152-a7a1-7992c6f15829@quicinc.com>
Date: Thu, 26 Sep 2024 11:15:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Johan Hovold <johan+linaro@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
 <20240925080522.qwjeyrpjtz64pccx@thinkpad>
 <4ee4d016-9d68-4925-9f49-e73a4e7fa794@kernel.org>
 <2731e17d-c1ad-4fb4-ab60-82ceafeffbaf@kernel.org>
 <20240925125224.53g6rw46qufxsw6m@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240925125224.53g6rw46qufxsw6m@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qi2jcvq2zChZ5GtIcAm04MQlgpYr8sDZ
X-Proofpoint-ORIG-GUID: qi2jcvq2zChZ5GtIcAm04MQlgpYr8sDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260020


On 9/25/2024 8:52 PM, Manivannan Sadhasivam wrote:
> On Wed, Sep 25, 2024 at 11:46:35AM +0200, Konrad Dybcio wrote:
>> On 25.09.2024 11:30 AM, Konrad Dybcio wrote:
>>> On 25.09.2024 10:05 AM, Manivannan Sadhasivam wrote:
>>>> On Tue, Sep 24, 2024 at 04:26:34PM +0200, Konrad Dybcio wrote:
>>>>> On 24.09.2024 12:14 PM, Qiang Yu wrote:
>>>>>> Describe PCIe3 controller and PHY. Also add required system resources like
>>>>>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>>>>>
>>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> ---
>>>>> Qiang, Mani
>>>>>
>>>>> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
>>>> Is it based on x1e80100?
>>> You would think so :P
>>>
>>>>> Adding the global irq breaks sdcard detection (the chip still comes
>>>>> up fine) somehow. Removing the irq makes it work again :|
>>>>>
>>>>> I've confirmed that the irq number is correct
>>>>>
>>>> Yeah, I did see some issues with MSI on SM8250 (RB5) when global interrupts are
>>>> enabled and I'm working with the hw folks to understand what is going on. But
>>>> I didn't see the same issues on newer platforms (sa8775p etc...).
>>>>
>>>> Can you please confirm if the issue is due to MSI not being received from the
>>>> device? Checking the /proc/interrutps is enough.
>>> There's no msi-map for PCIe3. I recall +Johan talking about some sort of
>>> a bug that prevents us from adding it?
> Yeah, that's for using GIC-ITS to receive MSIs. But the default one is the
> internal MSI controller in DWC.
>
>> Unless you just meant the msi0..=7 interrupts, then yeah, I only get one irq
>> event with "global" in place and it seems to never get more
>>
> Ok. Then most likely the same issue I saw on SM8250 as well. But I'm confused
> why Qiang didn't see the issue. I specifically asked him to add the global
> interrupt and test it with the endpoint to check if the issue arises or not.
>
> Qiang, can you please confirm?
Sorry, I misunderstood what you mean. I only verified if link was up but 
ignored the status of ep device
driver.

But look like this issue is because snpsys MSI irq is msked during probe.
Can you please also unmask BIT(23) - BIT(30) when unmask 
PARF_INT_ALL_LINK_UP,
like this

@@ -1772,7 +1772,8 @@ static int qcom_pcie_probe(struct platform_device 
*pdev)
                         goto err_host_deinit;
                 }

-               writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + 
PARF_INT_ALL_MASK);
+               writel_relaxed(PARF_INT_ALL_LINK_UP | GENMASK(30, 23), 
pcie->parf + PARF_INT_ALL_MASK);
+               dev_err(dev, "INT_ALL_MASK: 0x%x\n", 
readl_relaxed(pcie->parf + PARF_INT_ALL_MASK));
         }

After that, this issue is fixed on my setup.

Thanks,
Qiang
>
> - Mani
>

