Return-Path: <linux-pci+bounces-31914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADDB015F4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FA65A5099
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2221127D;
	Fri, 11 Jul 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TbTHVDSl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DC201033;
	Fri, 11 Jul 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222395; cv=none; b=DhGU2GTutGR+TWitOoSrqMdWM6utgNyc8K8EFHq9uskBWHB6pJYZUqllT9Wq1j/uExy1hi82j9LW1OYKj4XENfGbfYYuoGdJywzjwREstfvYA+C876eZODB6SmNZg7x+CKaMnN4sD9nVgWQeLKNxLftoDho+xKQXLJx2aaQvWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222395; c=relaxed/simple;
	bh=kxzoflC2PyKGhcEfEIOuEh5rgftPwliDdjfw5NgFuU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JuerB3jquLGUI1f3Wh1aPCautEx2znOIXLPGKqO3uAk6m/9WTCpcyTFu3UG6EEEJi+ZFrrdywW5RlwTNWGKXyEXsldmvT9lTfZ1qA1hNsIUBTrOxsdD56iKcrgUmkmT3Mw8O3ddoGeN7W4mLsh9JTqsHt5Cka8SIwkpoONIE104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TbTHVDSl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XMje030881;
	Fri, 11 Jul 2025 08:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kxzoflC2PyKGhcEfEIOuEh5rgftPwliDdjfw5NgFuU4=; b=TbTHVDSlVIdL0pOS
	A1tajtm+R98duCnbPURH8uGzs0Pdylf8dGmzrCMxjFOQzH71IzKhEY/Pv5bRLgMq
	bceHEsRdAj10hgLelKdc6Aaj8itTfuFn3ePvBcOLFudR+fFJkBr0OUAO6kJFrl8G
	4DHzfHxfq4GcpgVzeJdvDt9J+bQUTHojYnBeSJPD1ibLvlHBS7v8Sf9jqlwFfnXk
	IxcwrZ6xui0y7bt0Uyf2HvZlMoy1KjRmc52O3UkQXWeY/YoB4xpOHGyK7/CEpR/8
	bJHzQ2ZbF3bim/t+gS1hV5WXuEZMZc7KIOCWg7QFHreJHSvmm8frxAuhX0Ja6yPo
	39vHig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbeqwh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 08:26:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56B8QOIR030866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 08:26:24 GMT
Received: from [10.253.32.112] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 01:26:17 -0700
Message-ID: <ff2fb737-a833-474d-b402-120d4ed68d39@quicinc.com>
Date: Fri, 11 Jul 2025 16:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <johan+linaro@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <qiang.yu@oss.qualcomm.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>
 <20250627-flashy-flounder-of-hurricane-d4c8d8@krzk-bin>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250627-flashy-flounder-of-hurricane-d4c8d8@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA1OCBTYWx0ZWRfX+z+r8++6epTR
 gw99rxcdGSc64xZ+vTz1TjkJ8/bMBlMR8RtYJV9glCN8JaGMcFNpxYiRE/cGXzSuNOYL271vkr9
 6l32XhIM2SZrS1i1cDEjrs8LPgTOOdQrEY6NfxOHC7n6MNBKNiguGzSr+Uy7jY68YgQAQDoNaAu
 UL+qOZIdqZ3joE9rh2T28dJlGE2Hzoid0MVomtBPikdH4GY1U/vQG9qwdvKP0XKIuGbBtGwpBPw
 5hCCvrJjgOiuWgNzsWK8HiT1UDbZY5fhmdREzp/9EEzBeYWx6pbUfBsv1UG9z4oeEkfr3r9brTV
 JQrkA7ZzssGzP8saM47QMJD3/OscFocDJdThKDu58UHSzH5la3CFWhvuxW44kWrHsbkrqsjaUNE
 JxF0CQpIT1ZIQJbN0jTnyBqXUNgCIky3ZNHV3PzWQ6jUQOcEmEE3ZYMZf4KGdj8FUnPQqhjo
X-Proofpoint-GUID: SSkEo2SFQtZoMRhJ0ZK5FHDxqCxz770l
X-Proofpoint-ORIG-GUID: SSkEo2SFQtZoMRhJ0ZK5FHDxqCxz770l
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6870cab1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=u5fknsGAV_5u-2U6WwMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=678 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110058


On 6/27/2025 3:08 PM, Krzysztof Kozlowski wrote:
> On Wed, Jun 25, 2025 at 05:00:46PM +0800, Ziyue Zhang wrote:
>> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
>> document it.
> This is an ABI break, so you need to clearly express it and explain the
> impact. Following previous Qualcomm feedback we cannot give review to
> imperfect commits, because this would be precedent to accept such
> imperfectness in the future.
>
> Therefore follow all standard rules about ABI.
>
> Best regards,
> Krzysztof

Hi Krzysztof


This does not break the ABI. In the Qualcomm PCIe driver, we use the APIs
devm_reset_control_array_get_exclusive, reset_control_assert, and
reset_control_deassert to handle the resets defined in the device tree.
Regardless of how many resets are provided in the DTS, these three APIs
treat them as an array and operate on all of them collectively.
Therefore, adding a new reset does not affect the existing ABI behavior.

BRs
Ziyue


