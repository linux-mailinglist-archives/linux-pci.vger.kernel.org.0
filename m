Return-Path: <linux-pci+bounces-26451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857EA97D2E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0828F189ED20
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB426461D;
	Wed, 23 Apr 2025 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="McQeihew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223C21504E
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377868; cv=none; b=GVkIPENLz8U1u2MGSPEUI+vwi4u3WyTPILXrqKtfjd0Updkq0/yGTE9SsphycRhod9/wAskq3taxaudgfYqk3HRaE//daJnAcw8f4IDdblBVI0/9qkgZ5taVkqZipXuuhcOuc1RyP3yKwvVOnWJFTbgyN7szXl77ZoPl6XBUesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377868; c=relaxed/simple;
	bh=gNDyOiqvvJnSJH9LoREom7MMlXsJ1YgY/lC4EhEpN/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXUZ8S1lFGPu7ZiCywg69qiVfTe+WLC/B+b92CQ/61YSC3WUseiihQt4eQYeXCsxUEJHWNfMhaCiVl9ewikN9jSIuyc4HwBgpIP/tt+6vBhlmhpyYEWoxlG71APVZhLm3+PXLHIs1grUSAiGwA/XW5ih42bkXm5qxP7Mwva7JsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=McQeihew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0iHJu016970
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 03:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AUzM1IQQBSoW4Yzoz+0un0e1UZB9NVH9M6aYGCfVdkg=; b=McQeihewsgL9ZGYk
	hvNAa1i78p6iRXk7f/FwnMreYxzUpj2qVSssrdqA1h7coGU1vlzvd8D6F7fIqDM7
	ex9WWgUPu0swBXETxRZk8fk5Q6NFopc8beq7y+OuJ7NWj269NrhcGAMa46iVGz6z
	c0NGDdV/uFtmAeHvIV9TnIhYYgfuYIVPN8Veu4b2YVumjfwRWS8R4x0tfB++U4fb
	3T3Vx/eTaZPVahcSAfm9qcWgPpxX7FXc15dNKGQCVX8W0vBhtFccBh3y1znBfoWt
	fxz2g+Qc/gzWWVhPUe+6JJf819aLdBiGQW7Z09pU/zGfvkMPtF4C5kQG1X0soIoE
	752Q4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3gp5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 03:11:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff68033070so5139804a91.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 20:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377864; x=1745982664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUzM1IQQBSoW4Yzoz+0un0e1UZB9NVH9M6aYGCfVdkg=;
        b=W4Vy0P2u6tiHAQs5VMNsI0OVne/igWWtHxET3kekksKufr6sAUtPfZck1tOxpMj+dh
         dW7OChQZRhDfu5DMUQ4utijg4N47CcErTM86BY3JhK8wCkOHyGGgQxYyo91nKvM26SQC
         X2H+f/vGSAqxkganS41UKA0uOZqIiP1cf/ekOvhDMXXaDCmMUqHAKlfniheen55m08jN
         xmF9DTa3L6d49ayKf0MiKAgX/y71LezuF348GuzkVYibQVCpugacfY53bO8q/s0TJdQK
         D1/uRHcKaSvA+6XfaC8ErFFwckxJY6+Rd1QFfkJH7GfUW4xm/ECM3ikScs7vDhW31SYv
         Vhag==
X-Forwarded-Encrypted: i=1; AJvYcCUsgPVTe/eB2fFiQRdF6P2eVeQ4IuV0HZ8RtTHsnMJ5hG0JPiyS3AdCAyFdZ0cO9gYvKBDsUK3UmuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjhKYRciZLVc7v618qrY8yveOXoGd5Epbt8qnc8JoK1tpH1JD
	5AijN7M3J3pu9MsysQUu1nxw7ucLrnB/4cPBe/jE5VC34qMk2T1ZVY4f75jaX38KZkmvWaR90LN
	cKc++vYDnFDkKrHXlMMk1xTJWssFjr3wxMqFDfbJ8Hz5dZLfo7nxJx8P68ns=
X-Gm-Gg: ASbGncuGnStjnFtbSgjWDvFj0Sz5ufHmqdnYmVgl0DAv8qiQl6N0g99LTHGkj5UE7Kf
	J2JTUiIrksT6Li2RNNH0PvX8DgCPsppB7YPkVr0siOEOfuoJDyZGJtkyN6l7QOF1o8VLtKHhyNg
	+2XAIJiD/mRe9Tt9e7zX3u4NQ835DU1eto1MPtPEFhT9vj6aIQxfkjyM17qoW/DJWrC4r6ce78l
	d7oxihxDK8O7Dn610BZVXQqwx0p+j5vpMOGg2JjmegrbRpGn5V1yPDohbKMXLhKxkys47cBBc0h
	LIz4du7LFETCidbFgJPE/PnAmdFT6HC5SSFXgFS/Cg==
X-Received: by 2002:a17:90b:280b:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-3087bb48e31mr33085517a91.12.1745377863732;
        Tue, 22 Apr 2025 20:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqND8/PeqFUb5GQNFXy8yeKg5wopuUfA3/3IcqnNMYrM8oX9zPImajp1J92zZXyURB0FbG8w==
X-Received: by 2002:a17:90b:280b:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-3087bb48e31mr33085475a91.12.1745377863263;
        Tue, 22 Apr 2025 20:11:03 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb448esm93082285ad.152.2025.04.22.20.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 20:11:02 -0700 (PDT)
Message-ID: <347a7348-664f-3636-604e-8dc6429691b9@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 08:40:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] PCI: qcom: Add support for multi-root port
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-2-1afec3c4ea62@oss.qualcomm.com>
 <9be69535-08dd-4d60-b007-e9c50e706a58@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <9be69535-08dd-4d60-b007-e9c50e706a58@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NJ_JZrCjFO-bStbd5cgEwDmcjlkwlGtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAxOSBTYWx0ZWRfX6g/6RZOM9ufT P08C/J/Z26/Qe0rz3yJlV0kim/N6CW7mfmnlYLeh10ExADtnDHwWIWQQtIikRqzm4D2Aw3bGbmZ ns8/64kQeRjzlh+QKsgrLP8/GbCHrJu3SK3wzXyUpLWI+RHiLfQWJfjhSAIVtPb/UF8chlMEt2A
 hZ3Hwo3UClN/QX8p6kjZyjGfwiamkWjgEdrtVZF8pMLXG49WnAhVsS2JVCESaNIMt/C7J+XJMF0 A4Ggbgx5HrDej4NIb5sBxtLTUPDLObJ2Mn4+voypnXN8pPoZVyd8meqNipdZcloUhzpSsn5teAU Y2fT8Fl4C+cEe+yX8oHn6xfqhS88Q6xdIfx6qOJiBa+ZKvbokjagZMuRi0gig4kKz8ldv1WO4Ar
 Vloz7Obn8/QOgVX0fmDeIgk/iFf8v+Ia+UnRQ2sug5K31ET44c/Ked9ii3UaCSjFa0gtaX2W
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=68085a49 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=1RYYy9rr-L5vwPXD2fUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: NJ_JZrCjFO-bStbd5cgEwDmcjlkwlGtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_01,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230019



On 4/23/2025 2:15 AM, Konrad Dybcio wrote:
> On 4/19/25 7:19 AM, Krishna Chaitanya Chundru wrote:
>> Move phy, perst handling to root port and provide a way to have multi-port
>> logic.
>>
>> Currently, qcom controllers only support single port, and all properties
>> are present in the controller node itself. This is incorrect, as
>> properties like phy, perst, wake, etc. can vary per port and should be
>> present in the root port node.
>>
>> To maintain DT backwards compatibility, fallback to the legacy method of
>> parsing the controller node if the port parsing fails.
>>
>> pci-bus-common.yaml uses reset-gpios property for representing PERST, use
>> same property instead of perst-gpios.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> -static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>> +static void qcom_perst_assert_deassert(struct qcom_pcie *pcie, bool assert)
>>   {
>> -	gpiod_set_value_cansleep(pcie->reset, 1);
>> +	struct qcom_pcie_port *port, *tmp;
>> +	int val = assert ? 1 : 0;
> 
> assert is already a boolean - are some checkers complaining?
Ack, I will remove this in next patch.
> 
> [...]
> 
>> +	/*
>> +	 * In the case of failure in parsing the port nodes, fallback to the
>> +	 * legacy method of parsing the controller node. This is to maintain DT
>> +	 * backwards compatibility.
> 
> It'd be simpler to call qcom_pcie_parse_port on the PCIe controller's
> OF node, removing the need for the if-else-s throughout the patch
> 
There is difference in perst property name for controller's OF node and
the root port OF node. controller use perst-gpios, where as the root
port node uses the pci-bus-common.yaml defined way of perst i.e
reset-gpios.

It's better to have this way then having if else condition in the
qcom_pcie_parse_port.

- Krishna Chaitanya.
> Konrad
> 
> 

