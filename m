Return-Path: <linux-pci+bounces-2078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90982BA47
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 05:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99371C24974
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 04:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891111B28E;
	Fri, 12 Jan 2024 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SQQwR1yA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFFFC0D;
	Fri, 12 Jan 2024 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C2SIND003610;
	Fri, 12 Jan 2024 04:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vdQ3SBthWJ9UerVtsClpTKpnG/NXR359dvcDFj9NHb0=; b=SQ
	QwR1yAQ0Om6szc6ZSv7WMUlOL9EpZVfdZg55wDxs4XbG3UJmqEApsxpHGrJcNAU0
	tpBb1/2p/eHsku/Y8szzLtuYXPfH5Lnxl49A/6P/4GGTpQiSx///xFBXdXLW2bjP
	eKaF1srAfsgIJu4O47E3xYPBwaErc6gamNVRO8CCjOd9Q65vX0CnQEa/7GA16BV9
	NiGxkumk3lcJp3rfMpBLDuyWh6Bt5Qox1/r31rk9wmFNLT0yiGxiepDANJqGzbTQ
	HjkEMj/ajPUzraiMaJ1U2hBYXnhNbtfr6iGy28xt2bk1b0P4mnEZWy1rE8gqS6hP
	h92Q8WvvloTqEjoJvqgg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcvjtdhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 04:16:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C4GqoD025732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 04:16:52 GMT
Received: from [10.216.55.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 20:16:47 -0800
Message-ID: <f4805d04-9514-6a41-b39e-aa8a4577ce90@quicinc.com>
Date: Fri, 12 Jan 2024 09:46:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Proposal for QCOM PCIe switch power and configuration driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Veerabhadrarao
 Badiganti" <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM"
	<linux-arm-msm@vger.kernel.org>,
        <p.zabel@pengutronix.de>, Bjorn Helgaas
	<bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM"
	<linux-pci@vger.kernel.org>
References: <413d612f-0e31-6281-64e3-6484b85afe06@quicinc.com>
 <036823ce-9815-4884-aa3a-9c3831cea9bb@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <036823ce-9815-4884-aa3a-9c3831cea9bb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HaVysU1oa21CgZEQkn-NMHhH0utbtCPj
X-Proofpoint-ORIG-GUID: HaVysU1oa21CgZEQkn-NMHhH0utbtCPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120027

++CC   Philipp Zabel ( reset controller maintainer)  & Bjorn & PCI list 
from PCIe subsytem.

On 1/11/2024 11:20 PM, Krzysztof Kozlowski wrote:
> On 11/01/2024 18:38, Krishna Chaitanya Chundru wrote:
>> Hi DT maintainers,
>>
>> We are trying to upstream the QCOM PCIe switch which has I2C interface
>> to configure the switch.
>>
>> In generic a PCIe switch is a device that allows expansion of PCI
>> Express hierarchy, which allows more devices(PCIe endpoints) to be
>> connected to a single PCIe port.
>>
>> We need to configure the QCOM switch like L0s, L1ss entry times, Tx
>> amplitudes etc.. through I2C interface before PCIe link is established
>> as these settings can affect link stability if we don't configure them.
>>
>> Once PCIe switch is configured, PCIe link between the PCIe switch and
>> PCIe port connected should be established by the QCOM PCIe controller
>> driver to enumerate the PCIe endpoints connected to the PCIe switch.
>>
>> We had a QCOM switch driver which powers on the switch and do the I2C
>> configurations.
>>
>> This is how the flow goes.
>> -->Power on the switch
>>       -->Do Switch configuration (over i2c) with qcom switch driver
>>           -->PCIe link training and enumeration.
> 
> And where is the PCI controller in this? Why isn't this represented like
> I2C or GPIO expander? You need to describe what exactly the switch is doing.
>
The PCIe link training and enumeration is handled by PCIe controller driver.
Usually a single endpoint will be connected to PCIe port, using a switch
we can connect multiple endpoints like WLAN, NVME, PCIe to ethernet
bridge etc. So in single instance of PCIe multiple endpoints are
connected and enumerated.
Like I2C or GPIO expander we don't want to configure any endpoints, here
we are trying to solve the initialization part of the switch power to
the switch and configuration of the switch before PCIe controller starts
link training and enumeration.

> Also, how about using existing solutions? Aren't there any? I am not
> going to look for them for you...
> 
As of I know we don't have any solutions exiting now, we are trying to
explore different ways for it.
> Anyway, you should ask (means Cc) reset controller maintainers if they
> are happy for such usage of reset framework for something not being a
> reset. For similar reasons you should Cc PCI maintainers. If you ask me,
> then no, PCI switch does not look like reset line so, you should not use
> reset lines.
> 
I added both maintainers now. sorry for the miss.
We want to use reset line because I2c driver has to power on the device
and configure the switch only before PCIe controller driver probes.
This is how reset controller operates(correct me if I was wrong).


Thanks & Regards,
Krishna Chaitanya.
> Best regards,
> Krzysztof
> 

