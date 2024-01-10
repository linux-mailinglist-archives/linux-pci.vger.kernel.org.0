Return-Path: <linux-pci+bounces-1975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CAC82940C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6EBB216FF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BBB381B9;
	Wed, 10 Jan 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RR/bSlbn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AC37157;
	Wed, 10 Jan 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A78hQH004452;
	Wed, 10 Jan 2024 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JkC93Duz+dQLaLxeZV30vVIGEX7V8zJCsoU1MJ9U23A=; b=RR
	/bSlbnCNc+BO8UEEjACClki5uhQcGDDtA1RJivmXfCGkpkzXMJS9+IHiZZ/MGUIQ
	fCPGQ1a5iS5Mbv0uXeQh99fIv0BCIVg5bT4p06573UMZCqTyCgnnQQ4HZAuDfn0+
	hcnVknE29bxHPAHVrXq0DYN9LgoZIEWcqw4WiKc/5/jZpIgAofonu+cu3LT/9Vsy
	rqSbmsfYOcHYTgUjQyQjGG7kDG5qhhYdkVSpB7HC3Qt3wDkhFXPFiUk8aBC+JyJM
	AmbLMq8+uGnz2Vx519No8hFXcWsYq9htE5untnXtLMeUc5S+vXY1hYOVlLUvvmaO
	BA/DJFdWt5yZQNZNJdZw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2rfum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 07:12:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A7CRDU012537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 07:12:27 GMT
Received: from [10.216.48.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 23:12:19 -0800
Message-ID: <376b3716-46ff-2324-73fc-f3afa3f7af1c@quicinc.com>
Date: Wed, 10 Jan 2024 12:42:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>
References: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
 <20231102120950.GA115288@bhelgaas>
 <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
 <15a98ec0-214b-218b-1e3c-c09f770fce2e@quicinc.com>
 <0ba9f2af-169e-a9a2-9ae4-4c6a70b0a94e@quicinc.com>
 <20240110065757.xde2nvpr3z7c4isu@vireshk-i7>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240110065757.xde2nvpr3z7c4isu@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yYh0l1X4ohFRbY2psqlYJ0PXxn0-oiA3
X-Proofpoint-GUID: yYh0l1X4ohFRbY2psqlYJ0PXxn0-oiA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=867 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100058


On 1/10/2024 12:27 PM, Viresh Kumar wrote:
> On 08-01-24, 18:49, Krishna Chaitanya Chundru wrote:
>> We calculate ICC BW voting based up on PCIe speed and PCIe width.
>>
>> Right now we are adding the opp table based up on PCIe speed.
>>
>> Each PCIe controller can support multiple lane configurations like x1, x2,
>> x4, x8, x16 based up on controller capability.
>>
>> So for each GEN speed we need  up to 5 entries in OPP table. This will make
>> OPP table very long.
>>
>> It is best to calculate the ICC BW voting in the driver itself and apply
>> them through ICC driver.
> I see. Are the lane configurations fixed for a platform ? I mean, do you change
> those configurations at runtime or is that something that never changes, but the
> driver can end up getting used on a hardware that supports any one of them ?
>
> If they are fixed (second case), then you can use dev_pm_opp_set_prop_name() to
> make that easier for you. With that you will only need 5 OPP entries, but each
> of them will have five values of bw:
>
> bw-x1, bw-x2, ....  and you can select one of them during initialization.

Hi Viresh,

At present we are not changing the link width after link is initialized, 
but we have plans to

add support change link width dynamically at runtime.

So, I think it is better to have ICC BW voting in the driver itself.

Thanks & Regards,

Krishna Chaitanya.


