Return-Path: <linux-pci+bounces-18388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE09F105D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8942284403
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F51E571B;
	Fri, 13 Dec 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWWpQsi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909A1E47C5
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102463; cv=none; b=bI+FjH4uwRdvdSWFqiIKdo4+Hqcu1KHNimB1266Nlay2RdZXxI9ECWrSTEDL/FSq+Hb8icuHyY/JMAsOAwntZtzmTtde6OEMckyq92yVtR1lXu7BqJN3yyaZ7tYxYQh++Sxh9ZZFaQaUxnOJQVuGkwuRyKuhDva1e4HVYcFtDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102463; c=relaxed/simple;
	bh=EvnLuX3Bx2FDPW/YcM5AL70sefFb9B+4tGXFjH/nUlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX71+wCAwW2R5XefINvKlkGIp6hMMyFQ97FoRFi6LpjMrWI6K9ZXFfN19CU+sKSbf4dYVzXROIoOdoU6BY8PItbnJpEFM9S/A89GfEha9lIn5mA/+wv9Irdnyh5hVWBxo5OazRe/A3FlSUYUoLfTUXpi3B081+XJ227H+oiP63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWWpQsi3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhnU4018429
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8r2Z8bCSwIkqdnaknQhubkt9rni68kdTquLqBAwLVKs=; b=KWWpQsi3Ipfc0xaY
	9U3GoeVmEa7JXSY0slrLUJlnMQ7diyUWZqPr3vJSOpgylnpiLQKpfYeMOyJ6+cv+
	H43E5TBEPXKiVI3W5AG6+Jtb2c+WhFTnzW70W+Y7nNTXhmKE7f817NIZsRNu9ilk
	Bacjt8jMip7r25D+DzK8hOBSj4Z4hqg37Mby48573pS9n4KI2O3pP63k1kHfJmgz
	WsBfWGQDwHF1cV2mfvJFI0pGDujTk8iw0k7E5Ru6+MsNXudZ2jopFjC5J73FWJxM
	nkyEL5yBbUEn5EV2f3Po5b2j+HeHRIOQ8TTzzuTQDESziA4gdHnU29yZ/SG5Degf
	Bt404A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0hh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 15:07:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8824c96cdso5034536d6.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 07:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102458; x=1734707258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r2Z8bCSwIkqdnaknQhubkt9rni68kdTquLqBAwLVKs=;
        b=uw9tfib/SqcybZh+ydmLLNKFUcavna5d1OS30q95MHo+tedg2JHECsHJ5d8LmJO5On
         lPexbBZwMJiZt9ANm9KZPL2yfr1GSwb7DuMLIAwwPXgTIMQ3zgTGOznfXzOOXFx2+vZf
         JrPDK56dA7LO5isa/xdFRYNn1wN0pgyTvlGvi5HZWbAzebNdeoIphAkgNh0YVWEw3FPx
         xJMTMsXPHlAdv0eS0sO8B4tT4H1SgBI3reJXkpnoicByDua9ulyYfA7D7bGov7X310cl
         bT76MLvJccG/oZtqLnxcpTyX/YXpMNd2Ap3OAJ9Fk7LUHhOVeFsxY8P099oyUaexqzxt
         VmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6wEvkChU9dextKHVuQ5XH5DcSBBwbuW2GQmjPyTKH9D/Kc1tVV5axIqr1hrlz5scxRU7u/Ape7jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnAHAX/iprPSx5sFTQkGcY5egs/vWTsJjcfaqZsb9o68tGgkX
	8mqqJJZoBaGEtRF/D/zbqw2AtrhhhwE44P6SaAjPGwesIY+q/FO111Q4yeVXR7+a+tjuMWwIiHT
	DfIrQlbXcobHhXXgK3RZBRDufa1t9jKxlljb/T+AK4FMC6HTKaL2p3eXOM4E=
X-Gm-Gg: ASbGnctLj0Hy6Q0wb9fvoqtb3yZ2xxQbJnF7XOtFcODNNgr4uXcIMYMMHfChnaV4eZs
	jQDeKWkC4YCGv5vHhQfpqeVNAlV0OljAJJnZkrUuaqYvjh4SDTIQsvRB7gCTgxJ8WbjvGZ3v2M/
	E1a08GbkMbHj3Rac/7svrWl0fJa/WAqgkjCgA3iaErd9gsZ/7steJU13XpuJObojO2GKq4dnA41
	1Mp0EN4X/hPPTklAW6nx0ZClJrqfB79k/XhnX1GeQ7mtGuUqDuqEvkVJQPvA/p8Nl5aGloH3CMm
	G1/rYnZ0kpPXv7QX8e0v9mjLQcHRWp2zrL2/
X-Received: by 2002:a05:620a:31a1:b0:7b6:d2ca:15b6 with SMTP id af79cd13be357-7b6fbcef0d5mr137556485a.0.1734102458344;
        Fri, 13 Dec 2024 07:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvxEOdiM6Kc3kANPOO51vjQHbv5LbxQEL0AKmrLpKK+6Rv6vcqM8Ix+BZy6+K/I6LvS6psrA==
X-Received: by 2002:a05:620a:31a1:b0:7b6:d2ca:15b6 with SMTP id af79cd13be357-7b6fbcef0d5mr137553585a.0.1734102457956;
        Fri, 13 Dec 2024 07:07:37 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260a3832sm1237814966b.166.2024.12.13.07.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:07:37 -0800 (PST)
Message-ID: <e28773ef-12a4-4089-9c7b-1be5e5cc7aa5@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213134950.234946-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HQZG0C8EAoiPNJ4N0_OfkVVD4hdIsr8k
X-Proofpoint-GUID: HQZG0C8EAoiPNJ4N0_OfkVVD4hdIsr8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=927 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
> Enable the PCIe controller and PHY nodes corresponding to RDP466.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---


>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 43 +++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index d4d31026a026..8857b64df1be 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -45,6 +45,26 @@ data-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	pcie2_default_state: pcie2-default-state {
> +		perst-n-pins {
> +			pins = "gpio31";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +			output-low;
> +		};
> +	};

Drop the inner wrapper, in both definitions /\ \/

Konrad

> +
> +	pcie3_default_state: pcie3-default-state {
> +		perst-n-pins {
> +			pins = "gpio34";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +			output-low;
> +		};
> +	};
>  };
>  
>  &uart1 {
> @@ -57,3 +77,26 @@ &xo_board {
>  	clock-frequency = <24000000>;
>  };
>  
> +&pcie2_phy {
> +	status = "okay";
> +};
> +
> +&pcie2 {
> +	pinctrl-0 = <&pcie2_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	status = "okay";
> +};
> +
> +&pcie3 {
> +	pinctrl-0 = <&pcie3_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};

