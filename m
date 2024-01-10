Return-Path: <linux-pci+bounces-1994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8B829ACC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE59B2630D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10EB48789;
	Wed, 10 Jan 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HcyNoWgJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE348781;
	Wed, 10 Jan 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AA2mwO013795;
	Wed, 10 Jan 2024 12:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/vClWtu3HlYBCHjhqdD40ETyVbpVB8kO2AGNHZOK/lQ=; b=Hc
	yNoWgJbTUxXloJBbWm+gL+LkCAxj2pPEA398P9hwkFjniMuW/J6q/XwJc1RcCwhG
	uM6UBj38CiJd4a+tqSri87/pPsz4omqUHPoj89csGSTiZtBsqtPvQ7Ky6r028PY+
	zNL0SEtmBGb6sK+bfPTZf0plly1hSV9UVbn/KMaF/ssJTHYf5bfMGjhrdxeLLiPf
	pwgrP8r9q9W3mYTrvFNR1bCeDf1KOB+HxCiAQkH/2PbHt2FyHNdlYQT4XHjnw7Xw
	DTz9s3YY9EjMcd/OUzXQcFBCVn3v0/kO3aI81UaB1IowSbbFxabzpFtljuzG9tul
	VX8fWzONYFffncqiGR+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhs4mgf10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:58:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ACwUlG002890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:58:30 GMT
Received: from [10.216.48.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 04:58:22 -0800
Message-ID: <ba732b1c-223c-ee70-d25b-4c78b312402c@quicinc.com>
Date: Wed, 10 Jan 2024 18:28:19 +0530
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
 <376b3716-46ff-2324-73fc-f3afa3f7af1c@quicinc.com>
 <20240110073807.sqwmsyr6nmigg6zc@vireshk-i7>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240110073807.sqwmsyr6nmigg6zc@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ldLzFosc01dSUdg3R4AmVw9dR3hFeRMF
X-Proofpoint-ORIG-GUID: ldLzFosc01dSUdg3R4AmVw9dR3hFeRMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100106


On 1/10/2024 1:08 PM, Viresh Kumar wrote:
> On 10-01-24, 12:42, Krishna Chaitanya Chundru wrote:
>> At present we are not changing the link width after link is initialized, but
>> we have plans to
>>
>> add support change link width dynamically at runtime.
> Hmm okay.
>
>> So, I think it is better to have ICC BW voting in the driver itself.
> I guess it is better to have more entries in the OPP table then.. 15-20 OPPs
> isn't too many to be honest.
>
> Replicating code is the last thing I would like to do.
>
> Maybe you can show the different layouts of the OPP table if you are concerned.
> We can then see if it is getting too much or not.

Viresh,

it might be less only for now may be around 20 opp entries, but PCIe 
spec is being updated every few years and a new gen

gen speed will release, right now PCIe GEN6 is released but I don't we 
had any device in the market now and GEN7 is in process.

So in future it might become very big table. Either we need to come up 
with a framework in the OPP to select the BW based up on lane width

for particular speed or use the driver way.


Thanks & Regards,

Krishna Chaitanya.


