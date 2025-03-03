Return-Path: <linux-pci+bounces-22750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9443BA4BBFC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC233A58BC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B71E8338;
	Mon,  3 Mar 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6qLtJnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F21F0E2C
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 10:24:43 +0000 (UTC)
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
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522MKMOw026745
	for <linux-pci@vger.kernel.org>; Mon, 3 Mar 2025 10:24:42 GMT
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
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh749aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 10:24:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so8656423a91.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 02:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997482; x=1741602282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5ahGViu7mWHfBE/U6LabXy74q9ltD+IEs/cbzuNlcM=;
        b=EMsV9gsjXs/6MhsOtJaN3P6+6YGXcH0UcEmZvPqspL9iOoy2hvQWGY3dg9n0EJezss
         sYyElK8QkV7PbXw+Pz445nz2idR0c0k/kAyjgx/mKIgA5kLLVA6OTMMn6nO/ualfxYXG
         Lb3PUgPdqhnrmzPA+gMciFlyT/Wl+gXacsSKmjw1ySgHsYjG+jQ4QyupkXezDEo1WNHP
         iIOpdBosp4caWGzULqYFkwch57sPrTNriIRgGuDnO7L+ajvI5xVV/ej8D3aNsdn8EgR1
         LIs4WC/zWWi0e0zLVw+tzaVf6KDarPMN0misnZoxDw+B4sWgq4IBzjdKC8Wp53zM/Y47
         G2FA==
X-Forwarded-Encrypted: i=1; AJvYcCXDlJwEekzJkmQYta4qVGgdyB837NocczQKv4i45VH3Ru4xe373XExzTpkSwC+Bc7+sbOA+I+bGLf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIplP7ip712WMGwvhrEaGOyx0uw1+Dd0k53pJCs5XorKbtkw5U
	htAv4ziiUMYfLCnhLRxzcmAIdJ8Xdbirb+qyxIWahRhRZ2QDpbvTBtKtxfvTurYqBIZCfZQTY/C
	Cz26lPLYaJU6xDKueRrz2YZ9ms2D4sfxWXFWD1CUWHNS6ubCz3MbEHjZ0mW0=
X-Gm-Gg: ASbGncsqipHCmETd13EoVIDr5tM0JV7SjgfdSTMHOSmByx+meg04G2BVmLyvkQXuODh
	YiDWELhuL9Bnq/vQ7vOqqfkj4SqgYauImwhiFTKB6/PdxCXVA9RjqmtmuVbGfWXxUG0crqJ0Mdd
	aK+qLGT3fCJVpckpAoDBoCeQ/k1HHzwJ5je8ybparRLgUlorEjReTgZbRa4FE4pBVZuvhP4ZscD
	Pa2AB5q6tyXuRzZKs5XqIKgsgy6XhT2WeGG+6PflZGpFPnb+cPewLXCVSKoigO34uVZ1U2SXDTI
	oN/3Y7/wMWvDfqG5pM8mNVNb8NmHKc59bGrNevCDJJPgS/MT2v5t6YMGGBc=
X-Received: by 2002:a17:90b:4988:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2febabcb0c7mr21393573a91.24.1740997481650;
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
X-Proofpoint-GUID: EatnFpaBh4hgnySLsnP046FayNHfqf3e
X-Proofpoint-ORIG-GUID: EatnFpaBh4hgnySLsnP046FayNHfqf3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=575 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030080


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

