Return-Path: <linux-pci+bounces-11222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4372946712
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747E9281C15
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA5F9E8;
	Sat,  3 Aug 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ccWNSm/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A60B67E;
	Sat,  3 Aug 2024 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655663; cv=none; b=fVCbg5oa8cZjjMBCe17WPged4UVpR6MPzTG3U/RBvRPWcPxZiO4smkKOIbNjBwPBAyyqv2ucpPLFi/FtK/NINwRlDVyOJV21SNWZCLOPZleRf8FvRcyFHuZMOH/jq9jEJecpvAEjrcpVpfxwSEqDlig/S6s5h6raT66IrJar/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655663; c=relaxed/simple;
	bh=AlC9MevRlL/TpTiYxQDUa1iezmoZv+bELpKfSQiVj6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dsAJsoQa1w8rUgDWWj0mQpXTfmvXUz4zpwmm5Qu4Cj8zmZOYI804ZAQ21LX2lar6tJEwjNy7lcRnm6HyWGGvm9qIS7zWiZAYqbBgcyO2Wfi+3XnXgWYnmx3HU+cnrO/NS+DFxxkaPfU0P+1/3GSJQGgoioFMTuGtL3A66Jz3iE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ccWNSm/x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4731rZF1025815;
	Sat, 3 Aug 2024 03:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fjwKW05/13jU/CIRlXQR2IzH+1VEj7F1lgkKNlQ3dHI=; b=ccWNSm/xVfqqxfPq
	2+kr36O7S1UwLVgC4w4jLp4pJHnvpenODHoYoylwzuoCsjccxIY9weLUZAgwy7GC
	1g9eBdf7jz7toMmaAtYMKN+GCjpZKgSEPuNNUorpg8HHdZpg+wueVusPIvv3yt40
	+YmHtPouDZ77B+eXeN4s1YNLiD7GhB7Ah0NSnn6ELm3QoR+55NyUZADf3VZHEmSY
	pCTuu7UycVqHIYCeKXT7xfjvZe1oEDCX9yS9cEzl1FkeOC64Tw7vZ7AP/ZriMPYP
	4DuuKEKz0KZ2x1o38a5GPdXzHsKg4nJgMzREUf+dgSr3+x8q3F2lGKmTd8TdFiKn
	Z6A1+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rjecb068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:18:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733IXiN022877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:18:33 GMT
Received: from [10.216.38.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 Aug 2024
 20:18:26 -0700
Message-ID: <75dd875c-bc08-3f18-2f94-5d4c1851aff3@quicinc.com>
Date: Sat, 3 Aug 2024 08:48:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>
 <0b60cd30-3337-46a0-87ca-4c75b7f1ef29@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <0b60cd30-3337-46a0-87ca-4c75b7f1ef29@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v7YbLd4pW3ZL2gk_MpPo07BjRYI0ZBIc
X-Proofpoint-ORIG-GUID: v7YbLd4pW3ZL2gk_MpPo07BjRYI0ZBIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408030020



On 6/26/2024 9:07 PM, Konrad Dybcio wrote:
> On 26.06.2024 2:37 PM, Krishna chaitanya chundru wrote:
>> QPS615 switch needs to configured after powering on and before
>> PCIe link was up.
>>
>> As the PCIe controller driver already enables the PCIe link training
>> at the host side, stop the link training.
>> Otherwise the moment we turn on the switch it will participate in
>> the link training and link may come before switch is configured through
>> i2c.
>>
>> The switch can be configured different ways like changing de-emphasis
>> settings of the switch, disabling unused ports etc and these settings
>> can vary from board to board, for that reason the sequence is taken
>> from the firmware file which contains the address of the slave, to address
>> and data to be written to the switch. The driver reads the firmware file
>> and parses them to apply those configurations to the switch.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
> 
> [...]
> 
>> +static int qcom_qps615_pwrctl_init(struct qcom_qps615_pwrctl_ctx *ctx)
>> +{
>> +	struct device *dev = ctx->pwrctl.dev;
>> +	struct qcom_qps615_pwrctl_i2c_setting *set;
>> +	const struct firmware *fw;
>> +	const u8 *pos, *eof;
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = request_firmware(&fw, "qcom/qps615.bin", dev);
> 
> Is this driver only going to serve one model of the device, that will use
> this specific firmware file, ever?
> 
> In other words, is QPS615 super special and no other chip like it will be
> ever made?
> 
> [...]
> 
>> +
>> +	bridge->ops->stop_link(bus);
> 
> This is turbo intrusive. What if there are more devices on this bus?
> 
The expectation of this API from the controller driver is to stop link
training only when the link is not up.

- krishna chaitanya.
> Konrad

