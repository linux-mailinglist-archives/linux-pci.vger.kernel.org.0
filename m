Return-Path: <linux-pci+bounces-1812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011D826F88
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373891C22805
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD84175C;
	Mon,  8 Jan 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gd/Ruo1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15445943;
	Mon,  8 Jan 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408D524j018278;
	Mon, 8 Jan 2024 13:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=H2WtjUKyrDFyRvmYxtHi0flzOw39axtvbwMoZpQyHzc=; b=Gd
	/Ruo1+QEbcM9hdtWRnrdNGmPhuA6+A4vfagA5qDAQCy53qRo+4fHmNDeHBqCa563
	Vaixck5wk12Y0A5rvdDHErbAtge6DKx6dZa1y8m7nSqVYoiY8VpfKT2C4Z+AKnzv
	EStE1ST3YOBgOJTFWGr5EX6D2ZGUGGJwaY0sormovvHXT+wsNULxyGNw4BtTKf3u
	SzEQyrJoGAjBOXuxmuhE5eTngQZT1QlaCBJLLzuO8okYvP1+6cXc4IzXr+x6jsYZ
	EQTanzP6L30b9Ih+guExcDhtEcqBqwDKYFxLrAn2kuQURSE8TwNkiht+li6vulVI
	SbUiu4t48auxdFF2R8Jg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8n094nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:19:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408DJRPt003498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 13:19:27 GMT
Received: from [10.216.40.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 05:19:17 -0800
Message-ID: <0ba9f2af-169e-a9a2-9ae4-4c6a70b0a94e@quicinc.com>
Date: Mon, 8 Jan 2024 18:49:13 +0530
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
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
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
In-Reply-To: <15a98ec0-214b-218b-1e3c-c09f770fce2e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WcI-mnAEpLNNAwM7I5H5sEnfy8E7_XqX
X-Proofpoint-ORIG-GUID: WcI-mnAEpLNNAwM7I5H5sEnfy8E7_XqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=749 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080114


On 11/8/2023 8:02 AM, Krishna Chaitanya Chundru wrote:
>
> On 11/3/2023 10:42 AM, Viresh Kumar wrote:
>> On 02-11-23, 07:09, Bjorn Helgaas wrote:
>>> On Thu, Nov 02, 2023 at 11:00:13AM +0530, Viresh Kumar wrote:
>>>> On 01-11-23, 17:17, Bjorn Helgaas wrote:
>>>>> Can you expand "OPP" somewhere so we know what it stands for?  I'm
>>>>> sure everybody knows except me :)
>>>> It is "Operating Performance Points", defined here:
>>>>
>>>> Documentation/power/opp.rst
>>> Thanks; I meant in the subject or commit log of the next revision, of
>>> course.
>> Yeah, I understood that. Krishna shall do it in next version I believe.
>>
> Hi All,
>
> I will do this in my next patch both commit message and ICC voting 
> through OPP
>
> got stuck in some other work, will try to send new series as soon as 
> possible.
>
> - Krishna Chaitanya.
>
Hi Viresh,

Sorry for late response.

We calculate ICC BW voting based up on PCIe speed and PCIe width.

Right now we are adding the opp table based up on PCIe speed.

Each PCIe controller can support multiple lane configurations like x1, 
x2, x4, x8, x16 based up on controller capability.

So for each GEN speed we need  up to 5 entries in OPP table. This will 
make OPP table very long.

It is best to calculate the ICC BW voting in the driver itself and apply 
them through ICC driver.

Let me know your opinion on this.

Thanks & Regards,

Krishna Chaitanya.


