Return-Path: <linux-pci+bounces-42255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59770C91C03
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05C69341EF7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0430BF70;
	Fri, 28 Nov 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p65ySBDR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eeg6Yqxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC779306D54
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327957; cv=none; b=dd39crj79QPvjCYBrN4YbKVJtNF0ZE2xJZSKD6tAda+C6m1q21bPRlNJbeGHG5pmRb0qRCrvDE1+haWkFSX3UaG5iYGYuDRw4zBa1fgSMo129d0xN/v4zi8MG2ZY7Ezyc4/nUb1GlYR7QWrRcXDCjf6uwbYgK6BhxC/6Y+edO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327957; c=relaxed/simple;
	bh=xpMRi3j2bo+6PObhQvvVYEgu5zJQHQXFCO4C/9f1XI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZBmSTHvu3gzUkIEzerHa3Q7YSBzyXO1KTZs8v/SlwU+hO3HxfxAiNRBH2sm8mu/lfJTrUvNphrryuDCEsLXCmegxRr0q+Vu+kcjqxfdOoIHQaQblTHzaVXBiMYd0nx1znifbAqvjORn/xMs80Oq32CVZqoKYFVaSxbwoO9EVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p65ySBDR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eeg6Yqxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8PB1E3919383
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 11:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpMRi3j2bo+6PObhQvvVYEgu5zJQHQXFCO4C/9f1XI0=; b=p65ySBDRBxdx/4nx
	v+adkex0rLbitO0baa6I495xKd9q62gkDn4YtgKAe8XC+pBmcD+WNiko0zNd2pEI
	TtlNBHrAO+vfPFdUt7LRF1VhFtkmhPxgc8OfC23tj8Znt8pllph3NktjTX1h1WZi
	Hhuoa4kb3ePJlb02xK6rMRlU1qjIzmT73WgCF20kDtf4ajmd7i82sIHctXYAg/Gg
	seNdOzPeQVvlPKfBGXgXDtSTg+tEV96Hl3/5bQ25HdRgRGTkUzAyWKLVlZ8QlYFX
	je8eiALIjhMW0UFwIFu2q0cI2bBiXBddXm65ZK9CHZxTZvySn3XxySdZrr7gRFik
	SXsUzQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apq66jpp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 11:05:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5e167b739d8so165472137.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764327954; x=1764932754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpMRi3j2bo+6PObhQvvVYEgu5zJQHQXFCO4C/9f1XI0=;
        b=Eeg6YqxdJWVfgO7WZ7WJoWb37DrcRHCz5WhsJW4dbF9WlkqJdAHkM2FG/6eakiAeCQ
         XOve2rG6GGrLdRWPhBhbgl09zcp+4nkQr00sbxpPSibTj/QJInlWYC8Vf1z5SQDotWRU
         92nsm4FAUBJw9svAX7lpRTINXe3G4Wim03vCFTXq6MRxCUCMI20iwD9UTpkuQ5N9vVGO
         xFKFIBd2mdFQ9I3xhG0ESyezpf4TqfXNwi2e/dpi8yIdem/PblG8jfXkJd7JIE4dl9sX
         Wzqts2RLoy8F+McEPWRZybT6c+iw/K9P0kjogHENyuSzoYPQHacPL2EaT9FzKZTElhlq
         2REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764327954; x=1764932754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpMRi3j2bo+6PObhQvvVYEgu5zJQHQXFCO4C/9f1XI0=;
        b=n50Mzo89bK3fk7TvQMFI6jcSM8wSt6TNu0XUnMq7r52UueILHms15YHb4wEFlSMwmi
         /HG6lsdOMc3Zwi7Ao9bCwkokWS25BJxQVeb0qzsZK9ZX7UMmTtzmup0uHeNjHrQWBfT6
         sNAOIeFRqJ2csCJhxLsPz5/fhpeEtxpVdiO1AEchEktSSQsAnH0md1xMjZelgg1pSU6M
         6Qls+yUL9snv9NU5BVOE+O1rEkHEXaRmsoo5Zzod7rM8PrtACO6w373tZ07gpX5GYS0U
         IIBwuucmiTr9kDxt+kjNHDzRkOIcdYsb9/DmTwxf36kIUrpxGzVbKAzmYjYvvhbSeRLm
         OAPw==
X-Gm-Message-State: AOJu0YxXqWv2wMOLwi6lcLcgQJtt48WAhRgJZ3m5mdtCfLu98tdP413i
	gC9Z+QGlCIOKPiDfH/3da1OSFR7dAcaLhZbMqmr/tnZLuYztEN7nxAlObAnV2TMrqkM4r4eEs8g
	XzJaX94+I4VIbE8aT9rmoMVf5fIfYW+wrdxKzL+gFy1oRTHaPgLEE26wknbB8i6Y=
X-Gm-Gg: ASbGncuT9BEEtLpP44I3dt90ev4j4rPbrRs5wk5PtVQiJKyYTcSNF6yrAMh5yq7Y+T5
	neE4+6SEok17Fr8dwuYYUavsI8wA42prHVtseuVZkVYajciETq9hm6Tl64+YQii5dLj9Ur6dFbF
	qrEOpRZSfR++87uBwQXGgzyPC0UeG3HR823pI3PCg63rp4nloMtDJBuAx4iVf3U10YYTSb4Zaz9
	+TYRu8jkLNrW28YpXlHd9pEuKxRKpL14cKh9semrtXpJ0W5Mst4ajQazgMojiCa1Op73UTnXsNG
	keqKmy0nA9+AQ21AHQrB+3VIEQBa3UfCvvVTisbORh/JOC85H4oAZPGEHvJlMgL3e492rZRvnDP
	cY11BYRohOUPOtc7Il8yjp8bxCh9I7S5DrPkXVV3Np8p0+/KUYqagN9Heee5MHPYmyTs=
X-Received: by 2002:a05:6122:91c:b0:559:9663:bfb1 with SMTP id 71dfb90a1353d-55b8d5c2d79mr5412225e0c.0.1764327953621;
        Fri, 28 Nov 2025 03:05:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGudpexyP0X/zmv3p9rERNMQ3AtObJtIj9hiMLbTfiCUjH3F9QaQCnekNYVsLOEWZ9Br6ffvA==
X-Received: by 2002:a05:6122:91c:b0:559:9663:bfb1 with SMTP id 71dfb90a1353d-55b8d5c2d79mr5412178e0c.0.1764327953221;
        Fri, 28 Nov 2025 03:05:53 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062709sm3981675a12.35.2025.11.28.03.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 03:05:52 -0800 (PST)
Message-ID: <b85c25f1-65b3-4277-82b1-402daef6fe8d@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 12:05:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: dwc: Program device-id
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kOvhGZ7Ya0tqYF3JJ7d108H9lDmoXPvH
X-Proofpoint-ORIG-GUID: kOvhGZ7Ya0tqYF3JJ7d108H9lDmoXPvH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4MSBTYWx0ZWRfX19I6fzPRn47L
 yZsYG+aRqNe9+3baa9qXeAx4RJGRiotCIUtTKdRmzLqTF0DPrzd7Fn8JU7gXNMobN0HYdLLT8tn
 WyE1oqEebfaL6ydeldUi4b9s/OZSyUOOePaZEt3Bdxg8T/fc38MPEXQ9F1uYu68W1bHugkeEpYq
 VbF6Qn0OZnjyD1ZjGznhbvz4SKyZw2iZzlpPwkPMrIU+nkawJBrzNGgxe8cvtBUTWP3kk5vDwQM
 oWAKkiDeCn2aiDLzNHR96ax4jfD2Py9EoPLQ83RHmGa14S1YMqFFDVeUDPXY9EsqLaiBJ5fc7HZ
 I/LMTxzPPxNz+Sq2yY24Jyq8I5Yyu98pNu6Xb2dMOAW8/WoGF/bGD7bbh9173Zuy741YrO50C2/
 RjJQPPYdxZWOLL3k5kkWJUf6bOf+SQ==
X-Authority-Analysis: v=2.4 cv=BYHVE7t2 c=1 sm=1 tr=0 ts=69298212 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Oti8CWU9ByRd_oxdf28A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280081

On 11/27/25 4:30 PM, Sushrut Shree Trivedi wrote:
> For some controllers, HW doesn't program the correct device-id
> leading to incorrect identification in lspci. For ex, QCOM
> controller SC7280 uses same device id as SM8250. This would
> cause issues while applying controller specific quirks.

Is this the only instance where this happened?

Konrad

