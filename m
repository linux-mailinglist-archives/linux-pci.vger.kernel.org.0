Return-Path: <linux-pci+bounces-22872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2CA4E695
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0111042101A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCF280A3C;
	Tue,  4 Mar 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6qLtJnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8E280A26
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104808; cv=pass; b=fxLRZnn6QgsME/2CoVWgqf+3QvecdU2yP6yV2o6I4qPCAQWmG7qFMFEcY8s2SFJFbtCUQra7gxiwQ8P2McwEXhqm/mzp/w9su7USeJuQ/w40jwh2PEph+FUjX02Wtx0H/bjMrkaL6UFVEEmK8dZSsNbeiiwHQpCm6pgY8qSaNxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104808; c=relaxed/simple;
	bh=oNannqQPiN20GZ+BHfvaroWwQhuHDZI4eMqVKF/YwNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4FTZpkxzXLsIN/kOHlchUT3Dm5leKX45UKxPvkJc6LBB+CYb930N4IKgErfhA2ypo5pZR8mZyfahQRdWiEkyv2aFZQWVh4LRdT/tV4miK5tUyJxQtgAHsj+879q3lxO5duJLwcNV/MD6E0Yxh85Mex+lTtS0PCvOEjnUaBZVTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6qLtJnb; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id EA94040CECE0
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:13:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T6qLtJnb
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g7B32MtzG1WK
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:47:50 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id EC5E742728; Tue,  4 Mar 2025 18:47:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6qLtJnb
X-Envelope-From: <linux-kernel+bounces-541362-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6qLtJnb
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 93F0C431CB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:25:01 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 282862DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:25:00 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E694C3A762E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574C1F12EC;
	Mon,  3 Mar 2025 10:24:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B91F0E50
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997484; cv=none; b=seov4qU7gebbeqheKr+cRLRF1Hm04I7aYAMZThnfafRRlKpd/OZa8RWYrmrzNCoHlGyLc9JNIJWXUChqndNiu1AgA7vO+AkVGd4GMcUcc7VZS9wCZmEJCEniNv3L8ufd4Qqa16KTYAgQsZqVbm7wP9PQsjiUqLNZYo4JXVc+QCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997484; c=relaxed/simple;
	bh=oNannqQPiN20GZ+BHfvaroWwQhuHDZI4eMqVKF/YwNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urRmfbxD6MJl6de0OHjfvKweIkiM0w6pzs73q/mosgofom7C97TtrVFsjNr07NI9hjUeJmzNcQJckcOGvGZmd6hGoDFFBle9Ni5+yCvu/zQeOmg0eAnGzzKGJbjMGho5NAeFC2PGb9ZwmMgau3YRDda1WUDUtc1W6K1iGfiIigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6qLtJnb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522NTtni009143
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 10:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q5ahGViu7mWHfBE/U6LabXy74q9ltD+IEs/cbzuNlcM=; b=T6qLtJnbfCJhPlGv
	EkgU3kDNr6HKJCP4M5wBdVg4Yz9ZTmUqZ0yBItZAkrZkn98XAwouH7ZtlikkwPax
	GCEsRJMvhKRfmxzdDMLRpRtZdlXQJtUq7tOSgn2Ejld8dmcykaR8N/uLUEAdpleI
	fA39wVaq0nKIFHyWEtozFD12JNHxyGL4ynZzBk+nJrwrHrhPxAd4JFyPzo737jPW
	aAYFnQobvcEUXmhIOIoW35JMaT/Xn1/XJN5FsPvfPl09s829Dj4OwZjZcNGb7WpX
	vGiP0g9lMLw10YL+aC4Y87M5cre5/k3doIseW2/UDl4wc3dA6Z7PvvdikSL8SpJo
	8Vu/9Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t994esf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:24:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so4892278a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997482; x=1741602282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5ahGViu7mWHfBE/U6LabXy74q9ltD+IEs/cbzuNlcM=;
        b=q/YfnDd+GHKWSkEugfE5Sm3EIAx9U6SKkNGeiyVNBvPQeiHqc7kthLs1gGXVOhAz/R
         v76NBpg254O+4aBt1I1TD3XTRs/r+0uIAriD7AuIc7VkCh60JXbKKGnvFJeMnpgMB4NX
         8Zqd0CUbgwRgETJc/WS+7lLyNlGRiiZ5GVqh4jFuAUKLmKDmaTJeBPxGd5Lrbodc+qve
         rwT4VAJwAUV914yN4JFehJxT+4IcF3HyqwlpU8nd9LBu2FCwokb6yl3RhuVvVRrdK8qV
         Su1oorreE6jmKimjUoYcwoTQBSaJI6yu9h7S6n7B7zRsmt8Ir8EvCTftAWrwEKlmIFiP
         DkAg==
X-Forwarded-Encrypted: i=1; AJvYcCWFc+fSITqHnyodQCFNbQMQ8pbcY41wHFzGTMyMZHLX72iBLX3Z3Yj+MQYAtMnIJSwEz6h7Wni913dI0NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURTj4yCe1HyUtMWk1AJy2e5x2TNRJvwaXh8LuhKYRev4R370O
	4fjEYV5cc8FlFCjLPJUj6jQlbK091sSf3yrJntXk8fvt3iNqivuKtAZn6HraJQW/Di5DaclYvG2
	JB8h3IDOf++YdGiq3X1Qc82t5DsMUCNdxtLwNm30LKZlN2Ug9eID4QaDFQMGOoAQ=
X-Gm-Gg: ASbGncuNtyk6Cz1Mkbxrb78o5fZIZypOrsh8dsOt1PSp2hO16xcRjhSzrapQxOPPjyW
	UN7uEnU2opAqqqX7gmTL4lu+zHLqgnVG1F1qi6DbsjHiSQ/vJ5k4e4hmCcCrbDchferDp6kJh3c
	8UGHJhJb7nLI8wuP7Je8R0mnNAi2Y8QZsBq/rjZA/qZ8KfCPKGdDs6UNjQIaXBX6U5Zs/+WyJNK
	99YoT3M7NxzUeMfdh1Iu94vepiXlxEDyZ4wIq8UuubPE1pD5KRRl00skLpVIazMKqGx5fLkxLo5
	LkSmisL4K2reNw0yLPWdbqITDbXTNbmBOoT3qizfo6FQkpSlvlCiEYMYt4U=
X-Received: by 2002:a17:90b:4988:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2febabcb0c7mr21393582a91.24.1740997481660;
        Mon, 03 Mar 2025 02:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEALCniW+g8dNGDdCDI6uEm0eVuwQCKj33EnrSZUUlmNAZ/nXpTsx/74bSfs7XoeJdEM7XvHg==
X-Received: by 2002:a17:90b:4988:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2febabcb0c7mr21393547a91.24.1740997481289;
        Mon, 03 Mar 2025 02:24:41 -0800 (PST)
Received: from [192.168.1.35] ([117.236.245.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm73795215ad.229.2025.03.03.02.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 02:24:40 -0800 (PST)
Message-ID: <8c416213-8f46-40b0-aa04-a2a89d5dd0a3@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 15:54:37 +0530
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] arm64: dts: qcom: ipq8074: Add missing MSI and
 'global' IRQs
Content-Language: en-US
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
 <20250227-pcie-global-irq-v1-17-2b70a7819d1e@linaro.org>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-17-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EtZBDHae6-dH55vpYb6qDMBQV527iyTs
X-Proofpoint-GUID: EtZBDHae6-dH55vpYb6qDMBQV527iyTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=575
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g7B32MtzG1WK
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708132.79894@vzzsMVaK8p2vYCeP6uq9Ag
X-ITU-MailScanner-SpamCheck: not spam


On 2/27/2025 7:10 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> IPQ8074 has 8 MSI SPI interrupts and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 40 +++++++++++++++++++++++++++++++----
>   1 file changed, 36 insertions(+), 4 deletions(-)
> 

Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>


