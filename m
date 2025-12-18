Return-Path: <linux-pci+bounces-43300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA7CCBF42
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 970C43046229
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3933B6DA;
	Thu, 18 Dec 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAa6BbXe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dj7WLHyU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BE262808
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063391; cv=none; b=Te85BR1OveVAYHOn3x2u+p5XI385wgX72PA+3RdIrI4Sdpco/Y69FeP+aREpcNr1XEGfprBuHKAHbvO2dSRUAJK1rpYl+/D2clcDYQ4MnGxBzuW61avmgKMx6kfgYdWJuLzz68P+b5yCGPgU0L7QAQtlSGngVirMzGRsX5qRkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063391; c=relaxed/simple;
	bh=OdTqxaTUUaHsMZeemtiMxEPH9x3NZVTqJ0XbWB7J1CA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mVlmK70W2v+NW2e/fMJVulpGDnByTrQff6qP8Jc+rVAChjQyyYK/+le+Mh0DeXwdhyhRqWpsAmwAr2BfyHB+w599wipbYOQ4xMrY8u1TRyLmE09lpYl+suCdUwjk/5EBmJFhruHRc1aTOovAKHrvW+9WOzEJ7zIQp6HqH1uQHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAa6BbXe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dj7WLHyU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI8rBNP3447056
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NQErT9sAJwRxDBRqxQQxdVkJiZQn71inS4qFqv6AUho=; b=SAa6BbXeGetMW2/6
	NpGeA/giqFnf31QMMgp/N9h2EI22Wxs9nUZZ2KYrzGGhI2XsSdUOaZ/kS14i44rP
	47lTgM04Kk4XBDrHy2PebGkqoaDMOHAHi6TSDtcThwfkDQ7OxJSSe8eyLxMk1VBh
	m8/SH+laId6miqbaVFja2SEUlXdw8XHeXd93qUKjTCOmWGp6R2mn6k+PUREwDEUi
	5r6c9tHlMPzvNKXtepAmP4C3IdgvWWyUYczNfd2hthmaIrqkBYqyviiZvF5lcXTd
	AFwKlncfttRdzByhej55V8ecscSrpiCdfpHegRkQghfMwl8l2zqLMzihGiyYHsDa
	oU7bgg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4egb8vff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:09:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bb1192cbso12895255ad.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766063389; x=1766668189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQErT9sAJwRxDBRqxQQxdVkJiZQn71inS4qFqv6AUho=;
        b=Dj7WLHyUvmIilYP1srM+2jksS/+jPIRVQ/5ZrzmjqUtHE28stigHItRAk83vBO8l7S
         bL1xGgPSmq0qC0MQXTEf6k6+w51uq5QznX2BLJ/417S+cSZlF0LXB71w+8coWkgaSzqL
         h+4zG3wsS+N0MjjOiH/wNdETI70zjbObaazrdCrDdtEr9TZIps8BHKHQKsu5bJNBJ2EO
         oEyL+f9tDwZNu+9YANZKuU0IyZ0EQu/59AHmOfKlMV2b+DC5U3uaOXt/PMEO49y+DmgC
         lWLyxDHeGgUm8ZBUPghbB1nn9BANyP5u90jcjckxnDbO5WnGdgScigZG6XPqnUhD7In8
         ZiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063389; x=1766668189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQErT9sAJwRxDBRqxQQxdVkJiZQn71inS4qFqv6AUho=;
        b=pyrE65RRuSp/424/Gjo+QmL7NjJkpdKjKfdzFqRVODyZlKH/DR5oId/eXVOD4S1mps
         lk5ipSjJCJ5uwkywdZiT27KGMVvTQf7qsAVmnD91qSTzNw/D1OpMP9dMn86roW9qE5qW
         7r9gd15HF4NSWXj6RTlc/9MdKsldrGwBAQFNig5Gwb2dOO0Dkjz6aGvQu6DTrt9/d23f
         a+4IKJ1gaADGtJXQ5w2RjOZ6Y7Q+dTzzd/65zXtbQEaeGqUT/SwLRNJzgj2CWbrGf4zs
         vE39TftqeSOgfTEd8cCOOF8kIaXpMD3VqQAS8jahtIrsOE8Nny5m8+iQgBkPpif0GdTu
         BQLw==
X-Gm-Message-State: AOJu0YwEZA+QwkHaGKzlS+X/GjTUQjZ30H9lwlcewXpVp049ET7pq5sj
	FiXt0s+xN1yJ9yY0T6gfbPuYLuhMbt9XS1BbvQZ1c+ktxZoRdsdoFV90U9I7TGdO0pZY0PxPiww
	QSYC25DsKAoVeyaNdiXC+XU27jCo1HqCsxj0Y/RfpE70XEpTc7Y2vK6sNp0gGcxw=
X-Gm-Gg: AY/fxX53b2FukpM2r5suOvogvWgUq5MeatBy4KpjBB8skBLwVEZc2lQPePi1F2D0fin
	9cAD853x/RspAkGXKM6Di0LqeVAm1IdspQwJDWMYvIi0f4MTwXaCGzQi8lZRLlqAT0hh/FSVRmU
	0yKugKtILIw1Xvako+ktZ4XcCa+nm0MIV47I7BxXGf1GTDeqJ5FflkJnv1n4Hyzh87PNHIdi5u+
	6MQpCT9FlAVAbxOpl7bDJWZ1bXTTn+56W7gdyGTqw/YaaUSBwH5HPaVabUTptKK/KN1yB6tDd/Z
	FtZyKAGNd1HatqN/Tz1vkutamPyRza5emsdsGeAKPHM7rJJwG2LY5vVWbrTKXbrY6yjbX+tbJaf
	5ywYu4oioVw==
X-Received: by 2002:a17:902:cf42:b0:29f:2944:9774 with SMTP id d9443c01a7336-29f29449818mr187070845ad.33.1766063389016;
        Thu, 18 Dec 2025 05:09:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlzVuYojiZF9pSo5mWCtHLe9bUE0PMuq87ca+wgRgiWHeHXqs/R/PQ3ZLm5n2M6upxzDEbmw==
X-Received: by 2002:a17:902:cf42:b0:29f:2944:9774 with SMTP id d9443c01a7336-29f29449818mr187070425ad.33.1766063388495;
        Thu, 18 Dec 2025 05:09:48 -0800 (PST)
Received: from [192.168.1.102] ([120.56.198.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d0888c89sm25758565ad.22.2025.12.18.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:09:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
        Frank Li <Frank.Li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/2] PCI: dwc: Suspend/resume rework
Message-Id: <176606338499.520109.15893427341689041404.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 18:39:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwOCBTYWx0ZWRfXxTTOPeNL8Ipy
 HRAHmnWvff8c9y/r70I8XEb1MuPnKLusBHlz6BqUYdEM/i444GZrYT3HYLIihG2R7rIqiULV3Pn
 THysTTdcwmva+iXFEm1GFhW78g5FDZ+y6tpojLSNbPVKhU5SweduJMRgTlqt7ll5acrLPsr/kyc
 biZ0RLpTnWxn9+MH4Rh8twhlgx41hM1IVehAYfjhu2UWP88A5eKjjXuWuvIe5ZskP39Bw+qqhBr
 ZZHNiX4BzRKfRWF0/kfL/2kavPoJs28gPutGXnvhv+sbUEE4Rxs13SWcHN2Z9VYPJOe/XiLa3S4
 xrurbcLwHVGLEbbtD4HN0qtZaBryY85VCLG+rE/3bJ1YewxKaIoXpuPdyXiPeZ2phV8ru6zYQ0D
 uUbWe+1q7KgQ8ilulMOnImkyAtvcMg==
X-Authority-Analysis: v=2.4 cv=M9tA6iws c=1 sm=1 tr=0 ts=6943fd1d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Jss8lKBzqReWyizlocwcSQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QCoiG7nKStv1neEybPwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: n6FfVcHYwDe1TgSwebXkWz7hpnHTM3vI
X-Proofpoint-ORIG-GUID: n6FfVcHYwDe1TgSwebXkWz7hpnHTM3vI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180108


On Thu, 18 Dec 2025 17:34:51 +0530, Manivannan Sadhasivam wrote:
> This series is a rework of [1] to allow DWC vendor glue drivers to use the
> dw_pcie_suspend_noirq() and dw_pcie_resume_noirq() APIs without failures as
> reported in [2][3].
> 
> Currently, both of these APIs will fail if there is no device connected to the
> bus. This is not fair as suspend/resume should continue even if there is no
> device. Hence, this series tries to address this limitation.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
      commit: c4a86e6600fa082d6646044fcce2183ad5e52283

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


