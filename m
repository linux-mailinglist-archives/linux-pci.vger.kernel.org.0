Return-Path: <linux-pci+bounces-16621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5809C6ABC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3C4B2355E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBEE18A6C4;
	Wed, 13 Nov 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MYamTXmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E046189F33;
	Wed, 13 Nov 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487296; cv=none; b=EF0caYKcMtgshcz8v/Ij77irA5zbMPTut4UXiJ41Zjpji9J91FSFwuYUfURGy6B1Qd6wN4RnvkO55CcqkhPdSRxU9+QYH5jTw3INaUyouUHP1t61L3BY2hOJlGtSIIsq/dinP3uOhrLvpI83ZgCWfo5YcptOADNracOn2S8RLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487296; c=relaxed/simple;
	bh=3Xy7RmvnJhjsInhzwzGEhO79cRYr2kKRCLd3jTQyV4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iMAVeB3CDJjpMMSU9M8fFTDre8LEO8e+RN5sgYSNUKj8TyInTg75jvMJjU1mAkC5PEQsGRBfLX9BIr30ktaZQTM0GIU+uCZIXj3qZSXsQ6oa6+6ZWGrVUI4SKZvUywXokotZdocWOSe4tjdljsc8CIWMUqoxPx1HpmAOsuXuaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MYamTXmc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMUEOP011057;
	Wed, 13 Nov 2024 08:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JIiSOxCsrV9+my02m4jm+bEu5NWrTHZZqCu+q0C1YYQ=; b=MYamTXmcO2HxjNEm
	Kf3v4EXSr/w4gsxRKaOXnwcftRLAGI7ldXKy91u+BC9QEvZ+kgxxCM19/5bI67yx
	ZVUlxb1YhKI29bTuqb/cdkHdsmT5cTI7l+aO007jn5Hbiy+cadUkMZmd0gnFvllZ
	8LMoFa2w2V/wnCF8fTBXoZFthF9YIHwlTRy6PeWMlpJXhzY293lMwzzG6vahxDz4
	MvX/yLF6EJ5/FiVfjijRpWOZgpZY+g3a5nkCjQuKxBY4GiMfVvU/nirhJuWYdqNp
	q25Ito7xfsw+Y/LverX7vI8Hedg2zBesew5+ONsPxNEYoAC11lZrB2aULhrYNyGe
	wufXSg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxpqj7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 08:41:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD8fOx1012940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 08:41:24 GMT
Received: from [10.216.46.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 00:41:19 -0800
Message-ID: <02ddd6d3-283c-6e3d-ed00-37f18925c5f5@quicinc.com>
Date: Wed, 13 Nov 2024 14:11:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/6] PCI: Add new start_link() & stop_link function ops
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112234149.GA1868239@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241112234149.GA1868239@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z2rNPFeWvzQUYEJU5qxjA7hy-0nxWiCC
X-Proofpoint-ORIG-GUID: Z2rNPFeWvzQUYEJU5qxjA7hy-0nxWiCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=654 phishscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130076



On 11/13/2024 5:11 AM, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 08:31:35PM +0530, Krishna chaitanya chundru wrote:
>> Certain devices like QPS615 which uses PCI pwrctl framework
>> needs to configure the device before PCI link is up.
>>
>> If the controller driver already enables link training as part of
>> its probe, after the device is powered on, controller and device
>> participates in the link training and link can come up immediately
>> and maynot have time to configure the device.
>>
>> So we need to stop the link training by using stop_link() and enable
>> them back after device is configured by using start_link().
> 
> s/maynot/may not/
> 
> I think I'm missing the point here.  My assumption is this:
> 
>    - device starts as powered off
>    - pwrctl turns on the power
>    - link trains automatically
>    - qcom driver claims device
>    - qcom needs to configure things that need to happen before link
>      train
> The flow is this way
      - device starts as powered off
      - qcom controller driver probes
      - qcom controller driver enables resources and starts link training
      - As device is powered off link will not be up
      - qcom/dwc driver starts enumeration even if the link is not up
      - pci detects root complex device and creates pci_dev for it
      - As part of pci_dev creation pwrctl frameworks comes into picture
      - pwrctl turns on the power.

The pwrctl driver is coming up only after qcom driver enables link
training. Due to this flow we are trying add these stop_link() &
start_link() so that before powering on the device stop the link
training so that hw will not participate in the link training.
Then power on the device do the required configurations and again start
the link training.

- Krishna Chaitanya.
> but that can't be quite right because you wouldn't be able to fix it
> by changing the qcom driver because it's not in the picture until the
> link is already trained.
> 
> So maybe you can add a little more context here?
>  >> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   include/linux/pci.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 573b4c4c2be6..fe6a9b4b22ee 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -806,6 +806,8 @@ struct pci_ops {
>>   	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>>   	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>>   	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
>> +	int (*start_link)(struct pci_bus *bus);
>> +	void (*stop_link)(struct pci_bus *bus);
>>   };
>>   
>>   /*
>>
>> -- 
>> 2.34.1
>>

