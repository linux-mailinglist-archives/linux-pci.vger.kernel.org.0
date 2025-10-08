Return-Path: <linux-pci+bounces-37697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA09BC3BDF
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 10:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C84D1352313
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6432F261F;
	Wed,  8 Oct 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RccIbxiO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB311F4CB3
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910433; cv=none; b=dJJtb+ADTiA2cNj46B5rftqdfq7ZkA+fMQasx11h0R1LREFkFvT3zeNAToee2wJE4NSTWwS7O6sPNut7fpB1h/ro0Mgwoi/UkwFp6THMIqupxMa+lKzL94WnsGeH8rsAhFijFP1vyRTMiJjLsJPgWtLPIEobHDDhyiMkTKUDXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910433; c=relaxed/simple;
	bh=/5xitTXiQ5eDNNCs1sAfErPkBv/6ZwwQcRGoSXhHsn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQvmciZxpASbDIQ+mO5J2Xbl7p2cu6DN6mz5qdPi5CNL2lTdm9vqZiqZTcvIARzssbNL//ns5yt7LZskQODhW20ptmHAxCTTcSgfGopVNuJP8bo9zUBfg+5I/2ZahToIliASWGFIfWRSCt9mZ2KGi/ftJzTL2VAtsO/mCttSmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RccIbxiO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987b2TK010701
	for <linux-pci@vger.kernel.org>; Wed, 8 Oct 2025 08:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OFBsMtCW5P8eEthAK5JuEKPN/rQgShEl32y8lMaMUYM=; b=RccIbxiO+wSUrXG7
	riqHQZmZIfzrflvAq8w10eOLfSbRctyQIO8oJIp77PiBK7lL5oh9R58DALB7pqPB
	L4TeCUX42QRRomR5XzSxnjtrIAiPpN7u6cQ07cftrynrZMR6olXl3BTPW4DYR+Ho
	4L5E5vY8rcnz4+vNi//Q88dh/lKKovR0AEHa2o2ftO0CoR7hlLSM4sqoKi81uA4/
	nhktj/GYKZcw/AuwfOoJIb0gRrUjTMQqKDmMpL7v0RHopgPx3MGWnpFdsMLV1Yi/
	mFz4Zh1qEg3OUJu96jaZgEK9emn0uok6n9Mu53c09fMBl/J1M37sAQAB0DadNPwC
	taV/zA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9qxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 08:00:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-879826c55c8so15211086d6.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 01:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910430; x=1760515230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFBsMtCW5P8eEthAK5JuEKPN/rQgShEl32y8lMaMUYM=;
        b=RW5YhcCluSPlKLkXC3aC0U8ZDmuW3pttZuuxsDiDgUTcQtzQwq0RV0NQaooPS0PDs0
         eqRTkqitsfYu6MwAiBQtXTyi/QOfmujiM0y2U4utBu6LK2tFnaxyPmVvS+RAgXDxgfAB
         4kdwqJJiyj5a2zKKt6X1iYeGxq9z4EilKRdhSmbMa8OssfKftqf5b2NX30g98DZVqiyT
         cbFMTK+Q4fZANrjN5MF+/Ymp73UWBySqkVaWTCKMBKeoTg7D5LfYZNarLCdIcm42p3Mi
         KFjliNk0MjB3XLk7bIoqrBvvwid/n+FOGOrRMmQ3PWTvbTuHHvSrk6SGf5vTSDekEMn1
         eRJg==
X-Forwarded-Encrypted: i=1; AJvYcCVavASYJ5SqHMHUvRIS+VwGIK6RLgAI5Zc6a8ETdqJYctjv95IKtu3sPFCXPnvHf3y5mY6+DQqxmxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFY3jtHT0JPcllyJZvk535QJsTxXuZP6DmohTDURc9guJ9Mw1A
	qv2Ldi2KjOhplB6afOiTIjwmErgumrnso5vhhiRnNI0Tuc1Dpqzy0hcZ3lueAlomEFVbOfGBgqL
	y8L65QoUQKXE/pwiLhUGHyWqANAF46WTCk43SK9UmBG2IpC4PZUSqjA/mV47ovc0=
X-Gm-Gg: ASbGnct+xRrVkmLXtZM+vgSCNWk9zxsI/VhR4/1huAHfRQyuxjHqgA7DoTzPubuClIB
	oH4ox69qY3e90ZiyZ3PB1nuUPPN316YI+Zxj9NgwVAamMEMp389D8pBBOp0i8m84I3UQGfrPQ7E
	524H0C/GevrGgHx+dsRf8iCFjCr2HuxoYWi9r9u+CrIwB0ZDifUPZ1tXk/XZ0dqslKzUTnwR9qa
	vJDirXhrtIaf0leUjQl/Owm7m8cnomeS/0goCYqULCLWi9LPk385yduOpawvyH4OcTGK/ic3ArZ
	mueuX5PdpvI7O2d20vSn5Mb0qvzFLi5/mlTl/VPjz4MwRMsLMEwxZ96G/Lu26RMPeCuiGymjTXy
	oHL3kqB5bAb9XZkb0H/niKAWrrcc=
X-Received: by 2002:a05:6214:240c:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87b2ef94b05mr19467786d6.8.1759910429970;
        Wed, 08 Oct 2025 01:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI7CFIzMjiswdfQ2gg99EIIpUQZ3va0hQlGmy6utcIOqmtXbh7OWljL6IiZ8lPAjtXu1zVkQ==
X-Received: by 2002:a05:6214:240c:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87b2ef94b05mr19467286d6.8.1759910429070;
        Wed, 08 Oct 2025 01:00:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788112bbdsm14092770a12.41.2025.10.08.01.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:00:28 -0700 (PDT)
Message-ID: <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: r3-aQwP-6NXZrZtasVKda1hVbi_IYTxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX4NLHeOVpTnow
 1MROr51+a9wuRGoFe+LgVuDynizbOOR805f6pwl3Cr+SN6TBxhhGL8jZIZqaZ2boDo1wc8ozYIA
 QwrvPzRIMG9JE1IZAIXKNbwqdPuZmDJG3gFB9pPAsO+LiG1U5AgLNhGh5eoWvu8mOTnTEyfF4Qo
 TmSnpPNqscaU+4lCtthe6xuWS8g/kiRjadRMloNjvctqlWzhq8dbxFk+886Wqyn5OK/IsAIziyj
 wRD8b6gdI0KqXZkC+KkhSlFM6TvossL+FnANJ7QUHHFmqORlr0nA4Bs0XRp+AHpWU4eKKNQRuNF
 fT70sDzQwXAM4PjPOqdpCUxcGHRpZqJbRGeq1ho939uFldLFTYlvUPF6uQF5//0BUWcLvIEFog3
 WNY+FT7jPKhjkTt7mNRJwpLU7tsOoQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e61a1e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=w91pQayDMOQRg3Yv5IMA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: r3-aQwP-6NXZrZtasVKda1hVbi_IYTxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
>>> and x2 lane.
>>>
>>
>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
>> is crashing during boot as PCIe is being probed.
>>
>> Is this a known problem? Is there any workaround/changes in flight that
>> I'm missing?
>>
> Hi Bjorn,
> 
> we need this fix for the PCIe to work properly. Please try it once.
> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/

This surely shouldn't cause/fix any issues, no?

Konrad

