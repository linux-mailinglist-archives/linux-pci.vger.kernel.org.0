Return-Path: <linux-pci+bounces-2189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFC82E8EC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 06:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED339B235B9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8211184;
	Tue, 16 Jan 2024 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S5Ilz3IE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412B1EB41;
	Tue, 16 Jan 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G4d7wR003050;
	Tue, 16 Jan 2024 04:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ekRfnElQ5SP2PMw3QDmn8+FB0j9H41Ob685N6KWrRjI=; b=S5
	Ilz3IEGgOeeid3oYBUvEnQ5MJ3SHi957PWGh1InDL6PiVxN9vf4YdmxA4EXtZyt+
	/0edyjoYix+XRVV1mYz6rB8MVj38JJxhFIc/LOs8n/7C3OykG/B0RF6EUElc3dbt
	w3Z16J39XwyWsTzqCnOwvR+tNTPvjScXm6cw9NwoN1pn00tn7SDIunt4tvcFVqcV
	gYd0UggaaVsHud5N2DLHyoBgwNGiPFEUhn40xkFKZvlV144nZlieAtN6CAaEIPbl
	+sogt/XkJjPo7HNpSDjOJwC+SPlUJ/bpa5dzrhLU2EWM+TN+zeBHT2CCDXpqHeLZ
	BMTyy+dyXLjjJxZKQ/xQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnb300sxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:52:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G4qs1h006123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 04:52:54 GMT
Received: from [10.216.3.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 20:52:47 -0800
Message-ID: <1b7912c5-983c-b642-ca56-ae1e2def9633@quicinc.com>
Date: Tue, 16 Jan 2024 10:22:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pghQY40iUmtKbJFkO2Y2Zr7yPjkseDrw
X-Proofpoint-GUID: pghQY40iUmtKbJFkO2Y2Zr7yPjkseDrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=706
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401160035



On 1/12/2024 8:47 PM, Bryan O'Donoghue wrote:
> On 12/01/2024 14:22, Krishna chaitanya chundru wrote:
>> CPU-PCIe path consits for registers PCIe BAR space, config space.
>> As there is less access on this path compared to pcie to mem path
>> add minimum vote i.e GEN1x1 bandwidth always.
>>
>> In suspend remove the cpu vote after register space access is done.
>>
>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> 
> If this patch is a Fixes then don't you need the accompanying dts change 
> as a parallel Fixes too ?
> 
> i.e. without the dts update - you won't have the nodes in the dts to 
> consume => applying this code to the stable kernel absent the dts will 
> result in no functional change and therefore no bugfix.
> 
> I'm not sure if you are asked to put a Fixes here but it seems to be it 
> should either be dropped or require a parallel Fixes: tag for the dts 
> and yaml changes.
> 
> What is the bug this change fixes in the backport ?
> 
There is no change required in the dts because the cpu-pcie path is
already present in the dts.
So till now driver is ignoring that path, that's why we tagged with
fixed.

-Krishna Chaitanya
>> cc: stable@vger.kernel.org
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> ---
> bod

