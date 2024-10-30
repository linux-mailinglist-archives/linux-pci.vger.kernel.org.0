Return-Path: <linux-pci+bounces-15561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875E9B5B7C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 06:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3401C20D85
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27891D0E19;
	Wed, 30 Oct 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHGcqmDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7A199949;
	Wed, 30 Oct 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267727; cv=none; b=XsCF36D7IlXjum8RxcGo2bkBvDXSN/fnZXrtx41JbZaVDR/XQHPa2IDZUtmKcjWI3JB/JBVftkmdcmvlPfpvo1dc/qcf8zOIBMbyDJCbX3wjosHUks9IQ2Lnsp9nxL2+/l1YlbbyULd4aaNcB9hNSaCofkMa4bn/eSSBh4ZYBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267727; c=relaxed/simple;
	bh=NWD+81n0gt6UiKT+LFWmdI5wMpW4m6OsIQWgMh29+1E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Z7zHBmwZi7vu3m2NL3+Ut20rTPThxu+LAyPtAVZ5BfRCqZX82ddBlGqKoZphPCgnbyv0BCKENLpRPMyw9+M6K7yLY4nl/S/cPW2NJdcCT7zX+vV2E/meHvVaSRbi4O6nd3nuWnFfqVM54sXMB7wLsu2m2ONubjwjp3DQSmw3l9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHGcqmDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLjetW025437;
	Wed, 30 Oct 2024 05:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EdzhGzA2id7A/ZpD+TWeWQODIXZxwAyvIC+fzDbNVrU=; b=kHGcqmDRTeCjoT4b
	r5fNCONUTqK/BQjTXBoZTCLwd2XhTNzbYNN5OGodWzUiv4xjttmChJ2fSkald0r5
	EWH/ijF0P/GDZcvAt60vPTGAOssWU0A3Znro7jH0Kt4Ni+8IitI2SE6IyUrkEDVg
	l81khw2do4GCt7MSmmp/6myN8Ca+hjU1RM50fFyt/NHkfeFHmGEG/HILdT67BXGw
	l6KUw3+IbDmWW7BN6XLfECInnMzcijP/wmJzSK7cr3x5j8600kelk8I7BCfWW+YJ
	Ir3yMib1iTdlXRoY1bRIKdh1QA0S04ys9wWMD/ZSDJrMGiooI3fdC6o2PTVRh2dT
	nVRBSQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8jsgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 05:55:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U5t7io027161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 05:55:08 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 22:55:02 -0700
Message-ID: <250bce05-a095-4eb3-a445-70bbf4366526@quicinc.com>
Date: Wed, 30 Oct 2024 13:54:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
From: Qiang Yu <quic_qianyu@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <johan+linaro@kernel.org>,
        <stable@vger.kernel.org>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
 <ZxJrUQDGMDw3wI3Q@hovoldconsulting.com>
 <91395c5e-22a0-4117-a4b5-4985284289ab@quicinc.com>
Content-Language: en-US
In-Reply-To: <91395c5e-22a0-4117-a4b5-4985284289ab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6otyPrzF45iN6J6U6RMBnPJR0HbuqtmZ
X-Proofpoint-ORIG-GUID: 6otyPrzF45iN6J6U6RMBnPJR0HbuqtmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=659 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410300045


On 10/24/2024 2:42 PM, Qiang Yu wrote:
>
> On 10/18/2024 10:06 PM, Johan Hovold wrote:
>> Please use a more concise subject (e.g. try to stay within 72 chars)
>> than:
>>
>>     PCI: qcom: Disable ASPM L0s and remove BDF2SID mapping config for 
>> X1E80100 SoC
>>
>> Here you could drop "SoC", maybe "ASPM" and "config" for example.
>>
>> On Wed, Oct 16, 2024 at 08:04:11PM -0700, Qiang Yu wrote:
>>> Currently, the cfg_1_9_0 which is being used for X1E80100 has 
>>> config_sid
>>> callback in its ops and doesn't disable ASPM L0s. However, as same as
>>> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3, hence 
>>> don't
>>> need config_sid() callback and hardware team has recommended to disable
>>> L0s as it is broken in the controller. Hence reuse cfg_sc8280xp for
>>> X1E80100.
>> Since the x1e80100 dtsi, like sc8280xp, do not specify an iommu-map,
>> that bit is effectively just a cleanup and all this patch does is to
>> disable L0s.
>>
>> Please rephrase to make this clear. This will also allow you to make the
>> Subject even shorter (no need to mention the SID bit in Subject).
>>
>> Also say something about how L0s is broken so that it is more clear what
>> the effect of this patch is. On sc8280xp enabling L0s lead to
>> correctable errors for example.
> Need more time to confirm the exact reason about disabling L0s.
> Will update if get any progress
Hi Johan Hovold

I confirmed with HW team and SW team. L0s is not supported on X1E80100, 
it is not fully verified. So we don't want to enable it.

Thanks,
Qiang Yu
>
> Thanks,
> Qiang
>>
>>> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
>>> Cc: stable@vger.kernel.org
>> Johan

