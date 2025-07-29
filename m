Return-Path: <linux-pci+bounces-33115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4DB14E6E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309C05453DF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7810A1E;
	Tue, 29 Jul 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaCvraAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741A4438B
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795960; cv=none; b=UsZoKbDiUqbyw7uHvy96sXoCKyoxCgNZUyOajAcNmXIYSTScTTScmC5AYGUSKFdpG0T5j2ZjzNBAs3MjLI2gtPFUcW/ypqhoiQZgDIaj7Zc0KEOvQn3cBy5cj+5SVJUd8BT6xJlrfizp02dcPaWsa4WRfr2X+r7wG4LcyDae0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795960; c=relaxed/simple;
	bh=v+DsZl55yzDRDRu9Ri3laxrorOzZ5AU7QR5AaTILLx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxUDqS2F9lNRnwFpJPvGIeo6iiVbon01kRU3J8gU0Ud4dbwIs3p4iPx9sEVDvlHVhJL5pISgyhlNzH/Cx8Z/diuB2VJVXnKkIYafyvH6iuprHWSWczaNGZXh4VdTBQS2cBPUJjKUqOagwBSrzihZvmc17DfAUNWepds+OwGMQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaCvraAQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TA3GIO016447
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jM+V99Ir0I4XA3k8O6hCYfIKJXhqtYGbn0EBhNXPZOU=; b=TaCvraAQDvDry/Q6
	kTfpgjYD/P7HKtjUt+4z87gF0bV9VVsUZ8FCMNFQTgWwPkIpsHjVnZLfZaZtivnu
	RXE8oTxJm5wioaO3pwUBUAUWFA0bvB1bmM3xmOO3/b5Ho+w+zsarLPUl2rew3WrG
	EfVc2YQD37k8uo8mPkwK7z4O3iwDcEgZ7GRT8/jinb5zMP46vRzmA8nrtLR9swbH
	ZjhhaL3nX+WBNenF8+6k+3X8dN3KBRu7gW5COqviUNBj8fcFxZY+s/twNc2mTels
	VmZ6TBmsW1D49CCIq//epE938ohQEXhDezDk10wAjRbe/yIokqnGC7/XgyI6YEbM
	79WJkg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 486v6y0k2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33e133f42so114573985a.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795957; x=1754400757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM+V99Ir0I4XA3k8O6hCYfIKJXhqtYGbn0EBhNXPZOU=;
        b=v5jCC1DKVsVF52FnzbKx9edPA8gKMRk8BwgObRTG3zPTWirkC0kk9wFrCqvvKh8LXV
         YqxKtLaJasA0c3M2R5fYvWYr6sZ16fvRNpLkmLk+5klRFq08QYDt+wHISM2TfGTjkmGv
         JiCi7t4bm+DFmpSyt8zRh0kHPtM43cwluC54RiVgalRJWc0IZUymfq147fk4RuLgg97e
         hQBkLJ/QQ1ljg8rOkt+NTXpUpXsEeYw2hWZnVA5e+XtcH5uG3O370iFC3EudgB0Q/3KV
         vZEq3YQtShgfK9XJVk4nfyignjQnt3hGdWRt/CJruM0A/fKPK4+B0cgasvCe4cOgF8mz
         33Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVt+/AXXn36KhJcMXGCvzYt1iMB8vWERj339Z8Tmpgm0MT8qIoL8Q5CbM2KQSIRhnh4sdaFLj5/1n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTE4h0CJw9vjew+v8dRIBKN4FOgRLavksxDHmes7vC3V8ODBK
	FJuLE2h660pVZIOGoUGTZmU1eMMEnIDZFJkQfhFaRNs9ifhplaZ/dz+iPbz8QztmblHnF3nUXs3
	mfalhtzAQq/k1aZ8PozCOWDAriEM65cCoNt7xTRtPEtnLokxp2saPAwUQI+rDGn4=
X-Gm-Gg: ASbGnctNr+X8JfQFzpoA0ZerOgmPbkr0ioEqLKpfdj/6B9Y0/7b3wC4TyymDtljAgNS
	GISyVyEPtcgqSCRzWbjiiiJ+QUrtiT4/0H4wg8WJtMFtpcpgsTKWyd+ZwTwGNygGtlRCBuWyYZY
	4Jq1IR3t5t/zEIBkdA2yONJGI2lyWlPObq9JYuU0n3dneWaIMIhYWiZ7m8Sqw055qvMNPzt3iV4
	aCj0mKxK9ZsnTEXBz03qOs70e9mByg3oYgfWcQE/M+O+zQc3CjQthrL23ViQqWXySWKsQv4rsns
	TcHoMtOJTPvYpeEasIiv30BJKzxFZPIpAkduTYG5o00VKOA1NVdUgvieo3fbvM/Zg9YcuYbluwz
	MMnx5+K2Lkpgo6cszKA==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr1041285a.3.1753795956707;
        Tue, 29 Jul 2025 06:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGAOzJT3QZrBy02ECSykHzkvGf3IwWCyjkvsQ1hFqKmBvEZUJqnoAyRjkdmzAO0gfMk6N25A==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr1036885a.3.1753795956019;
        Tue, 29 Jul 2025 06:32:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635adb093sm590411066b.124.2025.07.29.06.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:32:35 -0700 (PDT)
Message-ID: <39be83ee-9aa3-4c87-b76b-b6dcaf50a239@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNCBTYWx0ZWRfX7dvrutkUDvjy
 w/15vEpSnLW9o4Ws1hgoWbXM1xzGpg6aKw0van2z02eoHWmmZlZULzeO9ol2EqciGAAxIZSjXuG
 C8OYGbECJBrKDuFFo9qqCQRG6aiyVZEDaV9LNuy3uKhqZELcas623nRXIcuq3hglikS3vOWhxCE
 waLSq3EHSFZ3XTTlKwuO5E1pR/qmaJDrzAvB4KK0s1fau/H/TZQwDhBvja7CbT2NwFs6a0LHjQ0
 7CTfu3zmEVaQOUvutMKRsUzuE+BnF3puDmMvwChRIoRDNJ7HolxZQ5uTXJMWG0oSE/+9JUd0wfi
 eeGK59Dip/jAmht0R3Tisw/VvIWEm+Tvsk8Nj/UvlOmlfWv7bdI2tuT+L073yiMQ+DpZhB30q9k
 +F16mRxiadggOd9MhrmTS+G/tUOChJ4OAOUJpCi9jBh4TUgEBvWxGTPUmMJ5894tIR/gPTTN
X-Proofpoint-GUID: vwnAJcHrCFF3jN4oFqiaLWxGNiF4Tf-M
X-Proofpoint-ORIG-GUID: vwnAJcHrCFF3jN4oFqiaLWxGNiF4Tf-M
X-Authority-Analysis: v=2.4 cv=QYlmvtbv c=1 sm=1 tr=0 ts=6888cd76 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8Yr4R-HfXjpLVZqX0moA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290104

On 7/25/25 12:22 PM, Ziyue Zhang wrote:
> The gcc_aux_clk is used by the PCIe Root Complex (RC) and is not required
> by the PHY. The correct clock for the PHY is gcc_phy_aux_clk, which this
> patch uses to replace the incorrect reference.
> 
> The distinction between AUX_CLK and PHY_AUX_CLK is important: AUX_CLK is
> typically used by the controller, while PHY_AUX_CLK is required by certain
> PHYs—particularly Gen4 QMP PHYs—for internal operations such as clock
> gating and power management. Some non-Gen4 Qualcomm PHYs also use
> PHY_AUX_CLK, but they do not require AUX_CLK.
> 
> This change ensures proper clock configuration and avoids unnecessary
> dependencies.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---

Fixes: 489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")

Konrad

