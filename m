Return-Path: <linux-pci+bounces-30930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF071AEBA60
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E444E178675
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245732E7F08;
	Fri, 27 Jun 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="epyDyZSz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090A2E54D5
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035869; cv=none; b=ecGasyGF9otBZBeBeGQjt1fjDYTDllHtEUAdbvOV/YHvv21tPIFFVuNuF2u34eFnhKpQncflN4YkN6wnGVfjWLSQHTn+58t6sMz58tp/J0Q4ZVoYHSWSyknTqMFZIRuZ5QamG433vOTrML9e7qVqPLp/LqSiOiplSzXEULRCvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035869; c=relaxed/simple;
	bh=7rtraUnuZEglIw9bM3jvt7JTU0MMScfXHqqtKcchIKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqKY1y5pbKWNOkdzVS5M3hR3BXW73qcPdpMYTax1fZm6C16qGH7htKyM0c8qKySsCFgW5c7lvZEPq7m7jIfBS7N9PUL1LC4p5sZFk8biJKbLRbHpE51FTCu0110aqWBQe38SdAwoZdhC3Yu1tBCXI0Wqti2ombR6/ej3CuNSUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=epyDyZSz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBr7Z9001063
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 14:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7rtraUnuZEglIw9bM3jvt7JTU0MMScfXHqqtKcchIKk=; b=epyDyZSzyFl+MJZf
	VvTrWRZwWi+CJrg4dBLVr8AGET00Udrlwr5ChES4CENzsHTPyZdBKPD4JsXXglmR
	/AfeHOHbg3nAmIBV60ucOmyWysINbAAXOUgbzaqM6duhGmOnqvL+wdCyG4Y2Q8ca
	pSHmEJk8SB6igGgoCBHNAx/E2cUHluoxLCpq3i+XjGSdhv6AkpLSmFfkl/cV4zwz
	eA7jJgsde/V/c0JrgcIqqtXogfhc4gmStUQl0mIxDgeGYa1S4OtPIvuMkmneYunO
	GnIDkBuG3WaVPtHMK/oYmOGt17T5FQRzBeTK34DC5nIvdiC4L9W2y+bfMWDgXFTx
	Eu7mQA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7tdh78v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 14:51:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3ba561898so24400585a.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 07:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035865; x=1751640665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rtraUnuZEglIw9bM3jvt7JTU0MMScfXHqqtKcchIKk=;
        b=JgdrMRiCXPGxTgmUDFgJb1/DX2amr58PECidVtIuDVMDy6KJAKxh8gOGoBaAG4s2or
         p+Ru8mgM5lP409ua/UBcud2w+3VdjcgbKc50v4FIldVXQ702FgCI3ClpwlKCGC6fE8wo
         iPprKklwv1lnTEw4w4qB9SVLX95TcQ34xoLn/xSLuJU1bkVxbE0jTdROqSA7tJRVl3Ud
         zF46Ay2HNPq6NJuhhbOBQVV+jA9AA+TJ22MnEHtS9hr4go/4QOXG/tQ/+DXSNGEz0s0w
         xr7O3FHaSZx2VdhhOUcPtV/KH21g6nH+0yOCAitJ1UFSgEH2s6GPQir3vtj1D42Yx7J8
         J8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7wECHGh7t6hwqTdJfOUsI5xVc5DPW48r6yrNPO87wdojT6iDt9dOhAUoUVitmzUCPB5aF2cNh6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBEVHcW38QCsplWkbFsmHo1ld1wtdUgzjwOmuK3TR7ce7ta4R
	YsQI+ohq3RZTgSp/fpcar6j1hBZSkoDvdHlsODrg60GCNsLS4EUXQXoFwOuhjzddRDJcN0umXY6
	GqRp9Qk6YL4SWqFPXvfPGTBAJxdOCKvVyGU26pbe6a/KJnCMuc9ewQu98OYFFync=
X-Gm-Gg: ASbGncuF76HP/CueGK86O85PPduH/Ka6fXQrhKp7WdYMHv6IUiTAQ0NK+8Nj2z71Hgi
	jGLR9MgWYNeMQJVZ4jMsZ3n78Orf/1etZYC+9BjdWQlGIq9lbc0dwRjRifBdA7L0FHYLOlpWbR5
	b3E7y/bQ3W/px1+mrWytkxsHXa+jsYpOv2PvHNGT7wlZx/i7N+TseKZPBWuFFNHAmAZzOxIQnLt
	pi5+hGk3KGo8xk+XcKWEqt6UfG1qGuQ58JbJUnVmmMu8zSSNweO6ilaUQZBqZPw1lwyT8733HCa
	DuUJGw7QQcJwSxVurcRIq4XPzNY46U0BP5HHGDT4YnuJD8f4V+LgXQxwiQ0OV7KTiPlQdRX70bO
	BbP4=
X-Received: by 2002:a05:620a:4390:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d4438a5772mr187162685a.0.1751035865310;
        Fri, 27 Jun 2025 07:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBrqmMSfnZF56yQ8HHV8zsPd591TqWYeI7+RBqNhUzZBbf8gF6QKBgxQqjSPo5Eech9fVsg==
X-Received: by 2002:a05:620a:4390:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d4438a5772mr187150585a.0.1751035861886;
        Fri, 27 Jun 2025 07:51:01 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c011desm137341766b.101.2025.06.27.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:51:01 -0700 (PDT)
Message-ID: <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 16:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685eafda cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=flLoF9dUt9D-64fZ2z0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMSBTYWx0ZWRfX64jl4xSeoNrP
 Z+1BruA90p2yXq+UhrtX+b5JfOTt3I4IJoXedJYvFO1zXqwZeQoCEWzM5xZ/c+mEYIf8UXdLtAu
 Vo8JfXsrCojpIWnYWnMtaGXJWpex398U5PB5HErxpJ2KjbH/rSMJ3KY1ueeMj1jrGP4aQ7n6cyH
 qCEIE38Az+ZcpQupjvXnZc0RVFuvqXTH1NJiprod3CLj1Ga24uoEMO6uPQz7BGvctb58wZ3v6Yl
 It9iPMjEDtzJNwm4y2dxPrACTee9nsQBx/lzP7gCbnGoZVkD3+Kw1nwjL2fJICwKqf8x1ykW7qo
 /5a0QRQw7faaJHhJvsrql9luWX5/qpV+utz7GZkpEBe0JqPSkAy/CSm3AYqBMw9AbLFRGf7KPs1
 VfZEtR8kkU0iWndtMGTmFlGwTYSNzpEkZ8hSt2xLPXMq20JfUPH5geIhFUuC0mzjy+sZORiC
X-Proofpoint-GUID: WKq_jLzLLhXiea_h9eyXq73GgwtlGr-k
X-Proofpoint-ORIG-GUID: WKq_jLzLLhXiea_h9eyXq73GgwtlGr-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270121

On 6/25/25 11:00 AM, Ziyue Zhang wrote:
> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
> replace it with gcc_phy_aux_clk.

GCC_PCIE_n_PHY_AUX_CLK is a downstream of the PHY's output..
are you sure the PHY should be **consuming** it too?

Konrad

