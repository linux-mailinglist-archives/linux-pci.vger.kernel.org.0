Return-Path: <linux-pci+bounces-19093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DA9FE76D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 16:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995561882452
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CD1AA786;
	Mon, 30 Dec 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnyF1cUI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D61AA781
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571184; cv=none; b=pLcVNdVxrHWX+swIqXnWFeWQhk6+0EZ/kJlMxsUz4VZ0CD1bZOovL6HezFge5kAnaRy18xU7xdxhJYUrrN62Zr/WaqEXsysUDWByqhhUDmuxTgMtrgGR9m5NRAjJyNOp8M7h7uRv/+quVS3ZYX15aQo4t0nB96ce9MBXQhzvIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571184; c=relaxed/simple;
	bh=nN1W85zwDq/ShkqSI0U4OdnKxr9P9jD8Z+riWcYYDVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtjDIDTaBOkdiHsfvqcyt8JbeekvP7MkaXbY6AblaOp6hF7v+XOdP88y4nLhK/+gqkVtfTgzTJKSE3SA9PJSfzAWKgWrF5cy/msb15vfEFoSQFl4yfW4RxwaNojoPS2WlPuS/DlWE8LOu/G0erAk2Qz5O+lWz0mAyckdHXGXDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnyF1cUI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU80ghd011736
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uysLAB4kIbOi62HACEt8X95euE254gr1EcZr73msbi8=; b=nnyF1cUI+dAMaILh
	iGdy87BuisoCaiWsOVB6I87ZJMCXqSt4UyzDdytbqB+8XafSQg1WyhnJtb0MZreh
	ac3NnBCZm9LOW1iNk/70VM3Ma2kkC17quuh4BDfKOyWQQ5xfQohBa7RzCJhWcRgm
	/W2DRpML3l57OVUwmMSIhI2Bfl5M58F8di17FmoOTAUOD/TfmA9RMHacyupmsTzz
	3zxKc8CAVS7GN8NYrxbocZtR82v7+CVdwNh417DSLmsmyy3DwyXxRTeiMPvnbi1o
	8Bx1uZn5a7/jLdUX3C/ZwjQrNPTLOq9xQL8LAC8ofdLoVKwLqXXM7uRy3dTvKErm
	yQRXyQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43uqmqgvkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 15:06:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6ea8fc9acso96045585a.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 07:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571180; x=1736175980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uysLAB4kIbOi62HACEt8X95euE254gr1EcZr73msbi8=;
        b=vy52LVMqrJoYqTjUEJhXtzDvgIZJ3kEVhsY9zFyEeDMDg1sy7WbGZgBCrtvUxOEXXL
         9LHPwSUapmTSNOSUluNfuQSf+So8vaVLYiI4Gj6Cgbb65rqnkHMb8ryfLEL+XqaoEoSA
         6KarUnd7roPa9wNGND86Y7s/ngkuxYDZg5u6GbXcZ+2YxWfZtnrsMFDG/bIRBiOJPZD7
         +1Re1nFyYa+yomflCfHtEdIHntEEm6mKCu62+TI6muTOlT15DyQVs6iLCUT7FDStdUWg
         ctZvGaUxKz+ibuGQRMjUDhBuBMyR1HZ/mshB1TJChHhDEKu00GeR7k7W3I7/fyAm2gQR
         u6BA==
X-Forwarded-Encrypted: i=1; AJvYcCUoY4au979JglAuEyf/exCiRTOEczaNLwIF+fomUoU7ZCoLu7Uh4yLd0QlF9B7hgnuvoEVWQA9wpUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNIhFC5zMmP09htLiPm8JHD7pjzH/RS85I/hn24Zrg3rdcyn2
	YBJ0UucGpC0ufmYXCeBBBIpLU6D0hwbUxWvnt3XS6+H0O3Y93J+Spl03uUQahg17TcowTXENuD1
	pi7g+ZJ4m7hcYEWGjchRlxo5YGy88MfqGtqo8vBsv9cT3JDXShqUMKfjwPz0=
X-Gm-Gg: ASbGncs1eL3+191ADMtJXyZAwKIK+T1mb7hOlh4S4ObUEem6Cm21Srj+UWSou1PKDbI
	/TgEc7poEMPdA8x+bLoeKTFj8iVhsGx3bbEIWM7kC5XfMhx2Gfq+k/rUSSTlvXjuY1pINWdcUvF
	E1/ZYhZcZ8FsCKWct6ni69J63cHE5KRZ47X/6R6eIH0coUtPbVXVj5MPDDFkC99b4HNURzocHml
	EDGKsM/IkLSxoXk4RcLohDg6JUrKIuZCNcEsNYAlOV5o4XSLyYrZha1jiYmj2jDPnXZ6QjGf0eL
	r1tktK4C2ZzmJoc5y8MEFxFPbjUuYc5guEc=
X-Received: by 2002:a05:620a:8806:b0:7a9:bd93:ac0e with SMTP id af79cd13be357-7b9ba757033mr2202889285a.8.1735571179820;
        Mon, 30 Dec 2024 07:06:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQa8kYJJdyOArVpHbym2A4jB7jAdPnezroVmJ0WtNlVtB3JleiUGwiEV/ej6VnyJpOsZf1Yg==
X-Received: by 2002:a05:620a:8806:b0:7a9:bd93:ac0e with SMTP id af79cd13be357-7b9ba757033mr2202887585a.8.1735571179405;
        Mon, 30 Dec 2024 07:06:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8dbsm14771746a12.40.2024.12.30.07.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 07:06:18 -0800 (PST)
Message-ID: <ec69f87d-1161-420d-bca9-d3314a3a1a23@oss.qualcomm.com>
Date: Mon, 30 Dec 2024 16:06:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys
 and controllers
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241226102432.3193366-1-quic_varada@quicinc.com>
 <20241226102432.3193366-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241226102432.3193366-6-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Pcb4_tZj7dvqNPelS_JUHOtmE-zOdaLB
X-Proofpoint-ORIG-GUID: Pcb4_tZj7dvqNPelS_JUHOtmE-zOdaLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=655 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300131

On 26.12.2024 11:24 AM, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 441.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

