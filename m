Return-Path: <linux-pci+bounces-24057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049AA678C4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39613B77CA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB52101BD;
	Tue, 18 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjgqsM2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06F20FABA
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314297; cv=none; b=erdo9zUkOfcyi7I3RGI/dpSyLN7xHBFfFD6JHl7Qh82+X/+jlqhNNk0J3ygQpNfMqvJjQkIvWh9iqm+tOTMHUj7irotZ01/aDcVHQ6rRFflX+hHL2ueqX3Jsp2di5xxdIFYuBpukKRjGiCR0eugegZq2SFI2WQz4Nsj/6MkC2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314297; c=relaxed/simple;
	bh=eyFDJE4YRl3b2EEj6y8xT7rbh/9hzJ7Y5/dRWTDk1b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVNEhshKXEz0Anvn3FD27lXGWpnv2s35zEvs3TL5o8CSi6KS942DV95CNVEk9gPDa6iLaDRa269C/9v4x0ZLxiYWsmioExQyJT7rdcEPjfKO3cL3ANkiWOj8GYbDP/AivuRESUelPIXN9VAAOxwJBYiXamO+6CjO0eGM+lobLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjgqsM2r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IBUTFi003334
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 16:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cM8AZCQm2iZ9HJ9wuCI4b2L0bxljhZ1yX+T89jHuzZQ=; b=RjgqsM2rFGN8p1tD
	DxdRLIoVkkaqG6ZgaIm2Mh7xMj8shM0hA75hwi6vy5Zh6Q9PIoCoyf/9PA6aBw3l
	eawJVpn/KwKbQpTcAwiWXxjAgLSnPJ8260Q07KKzl1JQNH+sHgE4sAIBgGwu86RD
	OJIHUwI1ZapnnJHgMXadRiXYTZSpN1nuVaY5US2eXSEMzEt/ftAN9VUN/0jvsg6i
	nRTI1Wwy00/zNY3vnz/uWB00eyJwY0B/TMB5rqn6aLcvPv8JbPQiLOeOcdsMTvLI
	5qbn+8ZCfG9zkOn3/VS8Igzr4nAisFqW1UXQ7QToFXyB+X9JezysHhcmp5B/KNFA
	hA/CPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010ja34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 16:11:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242ca2a4a5so79942525ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 09:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314293; x=1742919093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM8AZCQm2iZ9HJ9wuCI4b2L0bxljhZ1yX+T89jHuzZQ=;
        b=qPLnckuKegYCvLYRNrZG/GT/uXnP74ww761wmV1vzaMtqCcZW7p1WNrRyEGtGxOuG9
         zhwJWvAzLgV9+i0zQ5NWWUU8wLnwUnQbLVorwXXWbElX9OYV7B9fqG9mrnSCN7XqFE5N
         jbBEV4bBjVCOvyyY7qW+HX2mqnGulKTeuCwTU5rNYQhpXCBYdiBnm7C7sJWY3ZkRxgpw
         G77elRumzBtbxaO1RoWxm06kl13ptMhRVu203ReLl3L5L8VqDxO/F7PbBhs7KC+fEHgI
         Ccz6923t1pa+QyygYBhIg8UcyUNJvQ2UIG9Z0p/WHJyLkGADZOcw4z7gmw6LAJbKaZ6G
         VbNw==
X-Forwarded-Encrypted: i=1; AJvYcCUcGOZvvp3zKeX4fYojtF96NFQHeHVP2ulQAQQ36TBYZxdU6Cic4AL9frbOvg3WFBV8LHVMOEdaTdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2P5Xxy8XWrNCu+eU6l2TtRuXQSg/JI+wvdwTJXp+jak3HES8K
	WZAmWW2dboFJiwa4Md5b3NoDGS2x5wz64LcCZ/Kx+miIXMKt7UUHu15BOwhLV/jR4SS30+/5/ur
	Tw79riJnCtHEEVLdpmiuQ22Q1WkX2Hxh7eg19mVF2KahJAhqre8Hwieq74r0=
X-Gm-Gg: ASbGnctipWTCYKJLdVmAX51b4l4x6TEOAUkRux/pBDrpPhR0tWutE9b21L6SU2NZjIr
	A4UElSJ/mcvjpa4lpuQ9g8iWIHlU+2TVvk3+IGQsUndAkfch8F/ircQgjGAeVz9TKEKG8OEB1Sf
	qTvSe5Wtdfa+78lvw9ppsGNk4Uope1fWqcnb7wb6tTwM2SqOVq9MlyLY8il4dj2+xHGa16HIHWZ
	hhh0J42EV2hWmDTBN8EmawQsLfphvF9ft4V4nQMUjIRcW4VkGLUWOJlQoDmNe4c4sftzYq0Zgz+
	OTpQSLpuAe+gbxf2P0uEa3UaFzXTHOnDnZyi9+JNlXmq5w==
X-Received: by 2002:a17:903:40cb:b0:224:a74:28cd with SMTP id d9443c01a7336-225e0ab5216mr226833795ad.31.1742314292628;
        Tue, 18 Mar 2025 09:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWxl7Dn7VJ/dGBJeY8Nm/beDoadgREWVQ+bpzZHWe/2JguBoReZYgna/7NMPu2dIQzrTEQA==
X-Received: by 2002:a17:903:40cb:b0:224:a74:28cd with SMTP id d9443c01a7336-225e0ab5216mr226833365ad.31.1742314292246;
        Tue, 18 Mar 2025 09:11:32 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.228.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d0asm96645755ad.130.2025.03.18.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:11:31 -0700 (PDT)
Message-ID: <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 21:41:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k0zZCMXbsbOeQfj1eC6Aeyeljxt_5zA-
X-Proofpoint-GUID: k0zZCMXbsbOeQfj1eC6Aeyeljxt_5zA-
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67d99b35 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=gzHQz5DndFXDghOZWxpFUA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=WTmwj_6TxTBwwd-b0B4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180119



On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>> Two embedded Ethernet devices are present on one of the downstream ports.
>>
>> Power to the TC956x is supplied through two LDO regulators, controlled by
>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>> through I2C.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>   2 files changed, 117 insertions(+), 1 deletion(-)
>>
>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1_port {
>> +	pcie@0,0 {
>> +		compatible = "pci1179,0623", "pciclass,0604";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +		bus-range = <0x2 0xff>;
>> +
>> +		vddc-supply = <&vdd_ntn_0p9>;
>> +		vdd18-supply = <&vdd_ntn_1p8>;
>> +		vdd09-supply = <&vdd_ntn_0p9>;
>> +		vddio1-supply = <&vdd_ntn_1p8>;
>> +		vddio2-supply = <&vdd_ntn_1p8>;
>> +		vddio18-supply = <&vdd_ntn_1p8>;
>> +
>> +		i2c-parent = <&i2c0 0x77>;
>> +
>> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>> +
> 
> I think I've responded here, but I'm not sure where the message went:
> please add pinctrl entry for this pin.
>
Do we need to also add pinctrl property for this node and refer the
pinctrl entry for this pin?

- Krishna Chaitanya.


