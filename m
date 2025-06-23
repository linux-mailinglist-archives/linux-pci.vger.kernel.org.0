Return-Path: <linux-pci+bounces-30354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E004AE39B2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795C7189698B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52923505D;
	Mon, 23 Jun 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X4UinLTH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD612230268;
	Mon, 23 Jun 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670219; cv=none; b=try13JYjSdEM7a/C4eK7GWfwU3BZpC4u6gVORDHu3ZjD94VSkPH8FX1o5poahCmNiQKJGmqw7rEzwjuaW99haPAA1JDcQOBL1EIWyUBgeUA/bm7TRTGBivagmC7AiW415c3cr75RNxRNuEmNj0QD+4s3wJnb0b4OgoY21+VKILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670219; c=relaxed/simple;
	bh=7nhN+HsAr5iIie0UVBhaBGBNzsxt9D2zvCV6jEiVd9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ta1BE9vJrJpi8MK6nXIdj3mCkPwCUXgixUkpKK24M1sfpyMp+F/r8GaoDwR07FxHbbT9w7YFKAVxGdchGHXu1fOSlVKiqntkIY3+rvDmzqQ21yR4VXHKzlMRhLAsKMc4Wa82YFNfN/iyW0dzISvlEYW9Tg1xvdXGqhzqs7Go4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X4UinLTH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNt2WT013285;
	Mon, 23 Jun 2025 09:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7nhN+HsAr5iIie0UVBhaBGBNzsxt9D2zvCV6jEiVd9s=; b=X4UinLTHMEHwztFD
	DbkFiEWZc8EEpF6sOwhHiVu6Vrl+VdayDo6BrU8+tTcQcumBEcqe459OkyVG8TnZ
	Hqi/7pmpeE4fB+Ct2gsSIcRMPy43EJ5QdGhqqi2cqBYLDzZ54LWhRchdGXflYzXY
	GeYW/WfoW4OPxnd0yT+cpUGQJynjBoGr2pcdzy6T13j3zAyRKALSVJgs3oFBGNhR
	wsvuEOynHpCccHZ9HdNFPbNturDoK+T7FZyV4XwoaLuBWi1b1TrzN7RtOG+MzbrK
	1JDx88vmlM6+eRauh6T/2B/pJnPBBKHOB8oIoupLcuLt3jNJwOlzgHUuUegHdove
	y/su7w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eud0987j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:16:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55N9GkQf009583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:16:46 GMT
Received: from [10.253.12.224] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Jun
 2025 02:16:40 -0700
Message-ID: <1b74f11e-91f4-4aed-91eb-d54ef481eb7b@quicinc.com>
Date: Mon, 23 Jun 2025 17:16:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
To: Vinod Koul <vkoul@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_qianyu@quicinc.com>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
 <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com> <aFJYu_RV86GyrkiI@vaman>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <aFJYu_RV86GyrkiI@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PZWJZeS1DCoTOLjPkhKLGcvl4Rsdjaip
X-Proofpoint-ORIG-GUID: PZWJZeS1DCoTOLjPkhKLGcvl4Rsdjaip
X-Authority-Analysis: v=2.4 cv=eco9f6EH c=1 sm=1 tr=0 ts=68591b7f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=buFmA9CyAF0SDTxNqVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NCBTYWx0ZWRfX9QiW/Iftv1XD
 vLngcnCt4JAXW3XwkGk7Nr7xL6P3iuYcbYqNZT0fmeb54Pa/0NdzygcQ4L2zwrJs4JFMVs+YyYz
 ThLV+pHW32FhaNRxI1+97hXaZzBXlMiPzDHBBBpPcL1M6GEH2jKmZsapit8KJRdNJ1vjJuTT6y0
 SOBs584CabGA3cRrrs+mtSqfBEQsuM99sxFQ1fveg10/VYn17FQ9JePi6Cr2U7WDr7MTYFZAVnu
 BOBEt+9DNw2sM/ivEVYgBDcl7Vb5o5iP4xkGpz5D89RMzN212nRgRjDI5RHhkU45wETAUt8yNQA
 1K7qEiH+tfTGjU0SQNrS5G/WpBCcf8yPmnyKZ73XaXU8sfMPP/vinLhPDGOs0ByZ0nAeUMBEQ9u
 IFGY3MicNt+kIySVRxpP8iCHrSnEgnk+Qk3uOe8OCLoBBvQIdN+8k24YIC6RJ1oHAHPMHTmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230054


On 6/18/2025 2:12 PM, Vinod Koul wrote:
> On 29-05-25, 11:56, Ziyue Zhang wrote:
>> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
>> specified in the device tree node. Hence, move the qcs8300 phy
>> compatibility entry into the list of PHYs that require six clocks.
>>
>> As no compatible need the entry which require seven clocks, delete it.
> This fails to apply for me on phy/next, please rebase

Hi Vinod

This patch depens on sa8775p gcc_aux_clock and link_down reset change linked
in the cover letter.

BRs
Ziyue


