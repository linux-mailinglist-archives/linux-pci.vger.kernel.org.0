Return-Path: <linux-pci+bounces-22749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63654A4BBF5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E06A164ECE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA51F30A9;
	Mon,  3 Mar 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNt3uvV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6F1F193D
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997391; cv=none; b=e6TKoemOqU3eS+g+zncOFYKX2SDsYrs/iYbi/SHXSlX5+TR8csgJNvr5zF9+p4x0pLxYE24XD2AqczMWdT4OZqfbRN6LEpW8aCOBtQ740ae7pWYO7cYCyCFL6wZUyOb5HfL8jfoqy7SpUXoOJiMh3vS/zMKLa0Q+JFQpNb17sYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997391; c=relaxed/simple;
	bh=45N3CTCQyFNYATVodSXBAL+a94s2+Sf5PekV0GfAnzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNOI8gvz38VyuZ9RiPA1gtCzKBA29Ma8BovzZ0aicaDcY571X6ljq0/kKFgbnyutE2vFa0wPXchhIrYWB4Pn+ylfAZN9LAVP27NVc0weMWMI+EsaDy7xtnt8i7jnBwuPUMBcZ0w6fD8Q+loEGFgtKWAOOlgA2JFGPhN5XG0mcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNt3uvV1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52300fmi001154
	for <linux-pci@vger.kernel.org>; Mon, 3 Mar 2025 10:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GKhAMHMv9Qj1+aCKv/F3rYQfkqyHFXlh7B6Upy8lJ2c=; b=VNt3uvV1VYM+zOhx
	a4GpvWlv3sWQkm9TJqOKwNqZ21pPhTc+0p2ybbNPcXQqSWPwMR/N1SUM6kBK5C+W
	4wsvzev9/nqhbmeRPRnkpdCtTmw8yIs36ATAe3oO1VTqXZ8TdZhEY0IqLV8fyshG
	Tm6Ko65Qls5jIOuy7M3HhgPzJd2N6On87zDsizwEggbGu9AtqPKTq0jfIl5RSCdJ
	9QCEWRvj8s+sSdeHpTPkiRK6qWorTEqHe0A9NOn6KaAC06BtdmRON4P335xXO4Z8
	bE0Sqb6S564E88peQ3qg3HO6uyMQ3ymjW/Jw5cuFpK8JRcIhcHGupaCavVDG+8lD
	IJ3XGw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tascktr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 10:23:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223878ae339so24503815ad.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 02:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997387; x=1741602187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKhAMHMv9Qj1+aCKv/F3rYQfkqyHFXlh7B6Upy8lJ2c=;
        b=NtRUuvMvgNDlzsRSQX5mJTOG6mSCs+yZt7qxXS4ifV1RqfcbHq53mWGU3EtU8lUguu
         CkrU7EYwX3Q1fC6haSgqCB3k7rU8/z7uimq2dKNFizNPubpF6KBQj9jnli1XVVE8CkSm
         O0d+NYXaIbqlmw9CBd10EBi9g6lN6AZn5O4HsSwdkIsBkFLE1xt6v+SChJ5T5LvoiSe6
         QYWBHTQT37f/7D5P7sNsJAaffKvsQJXQQMWfTcBKftce9gwjM4JiwUS+I4d4Y+GpwNWv
         Vrhd/+DaNfuCHb1KhyfKtdO5NeqxpqujNrVG4rfcz8s6Hf4m5DCo2fPuCeR4hrDgfdqf
         owSg==
X-Forwarded-Encrypted: i=1; AJvYcCUZaYYLixoDWH0DxRMn9C6MbHFt90aoCi3yRW7ANsCgG2smEhzPC1baEfTlIN7VNs5p03ynqca+SNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgurrnSarGw1oGx4X9HaoOBNylPW1ohbgRaoCDbL3KCBlRP4G
	1+pMjj2brZihdHkj5kYsdjOyVrZT1HK+S7EUNocvmimy/sxXgVcWI2DEkQCUlibLKduFH9rpFjB
	ECY3sxlC+ey1DzmaRhZcawuPfSfgA0POnTImgCdLmPGuwKNRzrYEr/HjFy3zK2dJn2/W+9A==
X-Gm-Gg: ASbGncsQ7J5iiWFw3URIJhuWED+xn//218hH4njVew0qDv1HEWPm7Ktf/vYY21TBdon
	2eCjVjTwzw5rKBv/soLA5QcKD42vF9IY04yyzqtGhunqy0Sjls9RIQGv1eEltShbQagsHct+ikK
	MmbE5DnYbj5dOEGu/3Psds5FfUZVVteRK7bjCKrpP/y8PFXKqNaixFyoRDvXX2QMk5ImDLbRc+R
	fktBa3Sz/xkqgM6zuNGJwRknDBsIaGXnUpBXyVrUfI9dP4qCpIwXx+usmPQ98MlHZhUbL2DpVw+
	jYXMtAJ5tn3J/Im2EIpD37pEc74rhb1O8T5i2CkzCdSh2s7x+jWFQLDw/cA=
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr206373545ad.35.1740997386637;
        Mon, 03 Mar 2025 02:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzewlI+MdkavpK5IxUd9OuTeDDFG7whKIl5HH92YgygrrZJJ+26+G+Xae6Q3us5qqTy1cWBA==
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr206373175ad.35.1740997386280;
        Mon, 03 Mar 2025 02:23:06 -0800 (PST)
Received: from [192.168.1.35] ([117.236.245.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm73795215ad.229.2025.03.03.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:23:05 -0800 (PST)
Message-ID: <8dda7af4-b318-4e39-b79d-738b6084feb3@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 15:53:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] arm64: dts: qcom: ipq6018: Add missing MSI and
 'global' IRQs
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QM7WJ_eZEaUcMt5mJF_TiUGJltOxyciM
X-Proofpoint-ORIG-GUID: QM7WJ_eZEaUcMt5mJF_TiUGJltOxyciM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=601 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080

On 2/27/2025 7:11 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> IPQ6018 has 8 MSI SPI interrupts and one 'global' interrupt.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>


