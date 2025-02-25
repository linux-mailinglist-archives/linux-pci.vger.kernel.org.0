Return-Path: <linux-pci+bounces-22337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4DA43EB9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70F81886A77
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663FC267B9C;
	Tue, 25 Feb 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9aruR45"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADD29CF0
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485039; cv=none; b=ARr3zoTgcPcMH0VCupUUUiT8fxxbFdjn0V+ECQAa7CgDaCHUmcdlY2n5OAfUrhgfzV5vZMaw4+WydKkrpF24gtohocwwhOW/ggl2cI+rj9IvNU1EVM6XWNGhIopVwBmhoqNn87250T2f6sOJ43WFfmWvaZCwPKc9OpxhTmNMVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485039; c=relaxed/simple;
	bh=PxLJGOEsujYyXLOA1LVdxbe3bKtuHrxa6NSwWd3npKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTVBpCqt1XapLy8VZKeWlVu3xadQ0scnb9M9iDANZm+AZrDW9P85DsiCS47DXUiOUWc4QU62enWEJ+4ExyDmjTQrORJT9IOgqqFFt1bEUx1JMd7rsmjl2XKjRFy1wDY64B79brcAJXTSbRB3og+K3NvG3XhrbNP3i9AZmVO0Qrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9aruR45; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P88b4c017259
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ILy8Rs3qH0JOfr3SxVmZK4zquSUgVqlPsIwHGwC4KZ0=; b=N9aruR45cP/DOpvi
	loWHxaKn4ePOFa5gdIDZx2TwWjST524P0OwQOQ1kwsX6gOZm+n9FIWPdsVzTxz5M
	dFoUk83/bUN/Az1sTSJJQRpWIJcTJNZQBGR9IwOdQDAv7Rckv6ecfaTHjAXiQdqG
	huLvyzMT547cB+MAOwJGjkPBDD3NHFVkMUh+D1qzkPpnnsdPNJvYNJTwfEHv3Xmb
	WNG1rA1F3Hmf+rl43oYZipdbzgpXdDXp68i4AutlIgNWQiMz43AhF5Pc9a23Ke7W
	IZ50Hr3DW5Pq9XXedl+iswVQPD6OtJpm2oeb4ppULALnCAER3V30O++nRlQ+6onc
	I0lSSw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k68vv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:03:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e662a02f30so16283226d6.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 04:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485036; x=1741089836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILy8Rs3qH0JOfr3SxVmZK4zquSUgVqlPsIwHGwC4KZ0=;
        b=EZVrxFAkgz0H4azVBbVZMa3MxLWehUYRfF13695X0oSfqMwkuLqWIHpoqes9/q4GnJ
         5zaCBTmabRVkfd9ua46fh14gPNlxVjM5xv95gBtZaQuYm7uAi8qFZLIzmd2qN3nqtkhL
         qHqabTqGjavUV7izrZHtBcX2jzItvfr6C1mizJpn0P0Z0cdNm4GxLE5Q2P7krWvYQRmd
         Y/hF9kqMIgOtnaT3u0GNIKLdQRwKSFFIt1zr6mq1x+hmLY1vLfftfoZul6HlmLON6ma/
         ClgSD+JgXWY3424IPHzP+/xxBidV2EDxBSHt2EhTgdzL9rolkCZU7m68XOn4R+oRdBRi
         BsaA==
X-Forwarded-Encrypted: i=1; AJvYcCW9F9+qk0TT0ooBh7YJvXzcG5+sGm1HecSoA0oBT0OKSms74QYq7QaL8J5ZHKZpsxHyiRfRmZDCHJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkyBJF34Z8we7+5A540SiINLoBxywhtNmt7VlQk+rmeU+8osG
	h6+Vw6JaR0ACt8plpOlcmDVaVODoMMv+kSQr4yZykvO6jRnEyZV1UAEMALcmRkeExqgqZ1gsVZh
	TMaXqhjQYrV26L9GWJpCurLRhqXuznHe1Ykqx57KgUIfxoFSge4THm6wcMH8=
X-Gm-Gg: ASbGncvJnE11ObdS4+g3wB+n1wXqZDKjJqa6wUZzivJAYIzN5YfaJ/WEfNqQELr3odu
	T5apxIXiXROYQ4XDQ3RRPUWtLdqT/seWBigtMHt+JqGGmc9QsOkxPrzgmCnDmzkPve2aBNjAJ0T
	6HzCzOkQSP45A9vuEn3hMmZzyhmMHic1ZbaqZJabDod6ZuCaQYxAa7NJsjxVd2O9OmuIptKVuxK
	vFAM+avfd7Bw7ZyAmnH323dC4vx6yoLVvQtFa0IEC7ouGjsuvdzKFjJ2U+BstZA4GLUz71czyFs
	3knp2WthADEObpMRbgH6lCaa1rGdKZ0Ag7dV1SxJi2aMJKv3jSOYn6O1wDYRY5iIlvC2xQ==
X-Received: by 2002:a05:6214:d69:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6e6ae98a192mr78484996d6.7.1740485035905;
        Tue, 25 Feb 2025 04:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEORbqQZ5sf+h6IgcIpi2Q5Xp1o/awXYkrpeSM8AjuI7e7HoyV8DchTL7Kt5TZdBaioRlIlXg==
X-Received: by 2002:a05:6214:d69:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6e6ae98a192mr78484826d6.7.1740485035581;
        Tue, 25 Feb 2025 04:03:55 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8b48sm1123522a12.20.2025.02.25.04.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 04:03:55 -0800 (PST)
Message-ID: <afe5ba99-81fa-41c2-9ce5-0f8e2fec427b@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 13:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: dts: qcom: sc7280: Add 'global' interrupt
 to the PCIe RC nodes
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-10-e08633a7bdf8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-10-e08633a7bdf8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Rcwyn41DDPxFcO8MF8GZXVD5ivCqfdiR
X-Proofpoint-GUID: Rcwyn41DDPxFcO8MF8GZXVD5ivCqfdiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=560 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250084

On 25.02.2025 10:34 AM, Krishna Chaitanya Chundru wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

The computer tells me this one is wakeup-capable - is this something we
are interested in describing for link up?

Konrad

