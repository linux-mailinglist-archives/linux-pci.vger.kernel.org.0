Return-Path: <linux-pci+bounces-25001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0AA76308
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 11:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10370164552
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E01DA62E;
	Mon, 31 Mar 2025 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G0X9+3mE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF751D5CEA;
	Mon, 31 Mar 2025 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412520; cv=none; b=G31Lj6Fdg9u2vmlWf04gvBgzpN4q3rJXq6jPoIiRH/+w0xEls7pevSK/KcUmPcnDy7VhZc5+L8yUjzR1osV/EDMBkwKtTZKrU5UBq6fOYrUUn+q7aAafAyJO+jRufv/QICLA6Hwdku1IBnkvT6OoBAAmwG/pcYnd7LvzWgLyrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412520; c=relaxed/simple;
	bh=KlrxH/fPLdOyko3ZuF/Ylr9/egR0t8CZiXQy3CK+cwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V7pT9lCfnA74HLXF+025UrzcC9mkrGyjBZETmAcQggul5lZW53GoRaXsMtQjwIEb9AN9AyKYyOEj8Hw3frgqo6q+Pzq550WTs+8tBIKSOs+uTW2+OGgdfgjZB/w1VdLdqZwylqKKA8MzB8Fsrs4wM6wTE7NY8a28CytGoZ/FXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G0X9+3mE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V6kbB4007189;
	Mon, 31 Mar 2025 09:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nEpx60HZ0imJLIebaYfsG4riJUfLcjjdp4ZTxj34Ops=; b=G0X9+3mEQ6PHzsh1
	4RMBt8idz1r4U0cMnVCWL1qCyhLKP1JeDYuparMA7bDty1jOzM8spA917zEwAwj+
	BDnquWPIg3D1NT24FyF/mGpEsxtz86NHL6U6oQRDQagecsuA5RAs5WkR0lLq6LGP
	/PSjQxFiO1YWN1poFH68PMW5WNtmYDlfDR4chb/KcI+9kS+tGo7ShDB/nf8B63Z1
	bA+TDT+2K0dUJcZiZtFlq/UZ5caSam3ZJGBVZQ7WtwP523ihNgf26IcxLWfkMTbA
	GcFDs8FljZuPGCkLXaJ/qhztsTv+yXY5qbyHxtzG6xrWM/1G1EgcvKhWmRvbqPKt
	WaQh9A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p989430v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 09:15:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52V9F8rE026506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 09:15:08 GMT
Received: from [10.233.19.224] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 31 Mar
 2025 02:15:04 -0700
Message-ID: <b9e0ab16-f17c-4880-af23-a4aa93f2da34@quicinc.com>
Date: Mon, 31 Mar 2025 17:15:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_cang@quicinc.com>, <mrana@quicinc.com>,
        yuqiang
	<quic_qianyu@quicinc.com>
References: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
In-Reply-To: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fIk53Yae c=1 sm=1 tr=0 ts=67ea5d1d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=T5eSNwPAh3uAPVkemP4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: logPyLmu-ybid1oRvkfAMx5K8wpO-kX0
X-Proofpoint-ORIG-GUID: logPyLmu-ybid1oRvkfAMx5K8wpO-kX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310065

On 12/12/2024 4:19 PM, Wenbin Yao (Consultant) wrote:
> PORT_LOGIC_LINK_WIDTH field of the PCIE_LINK_WIDTH_SPEED_CONTROL register
> indicates the number of lanes to check for exit from Electrical Idle in
> Polling.Active and L2.Idle. It is used to limit the effective link 
> width to
> ignore broken or unused lanes that detect a receiver to prevent one or 
> more
> bad Receivers or Transmitters from holding up a valid Link from being
> configured.
>
> In a PCIe link that support muiltiple lanes, setting 
> PORT_LOGIC_LINK_WIDTH
> to 1 will not affect the link width that is actually intended to be used.
> But setting it to a value other than 1 will lead to link training fail if
> one or more lanes are broken.
>
> Hence, always set PORT_LOGIC_LINK_WIDTH to 1 no matter how many lanes the
> port actually supports to make linking up more robust. Link can still be
> established with one lane at least if other lanes are broken.
>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d6cbc8b5b2c..d40afe74ddd1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -752,22 +752,19 @@ static void 
> dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>      /* Set link width speed control register */
>      lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>      lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +    lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>      switch (num_lanes) {
>      case 1:
>          plc |= PORT_LINK_MODE_1_LANES;
> -        lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>          break;
>      case 2:
>          plc |= PORT_LINK_MODE_2_LANES;
> -        lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
>          break;
>      case 4:
>          plc |= PORT_LINK_MODE_4_LANES;
> -        lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>          break;
>      case 8:
>          plc |= PORT_LINK_MODE_8_LANES;
> -        lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
>          break;
>      default:
>          dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);

Hello, do you have any futher comments?

-- 
With best wishes
Wenbin


