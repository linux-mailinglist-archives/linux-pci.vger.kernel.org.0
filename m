Return-Path: <linux-pci+bounces-42006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F74C83664
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BFCC34BE23
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4320FA81;
	Tue, 25 Nov 2025 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSvLUA2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZzrZEyig"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157E1A5B84
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048999; cv=none; b=dB85tStAlGLLML7u8P70DT9PxJdB3v1aAwbTAQcSlQ8VcqdpEbIM4HdGWU57Yj8v2xs7PNGJXn7M0vLvCLlKsZP2+t032MBx+2h9EQIWEMHumLaQ1EdZe2j6QBcQexuu9yJDw5Rkmdq6B0r2oTNExxG2ZU8rgDyQhoi++Hyv6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048999; c=relaxed/simple;
	bh=h+VdoSv+Z2zrctSEadB3eFcSmZdj23PbErSScnq1rEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O0g+wA530fe+GQJA4Suh6v7IXbB7zeCWUNuA/jwuxx/q7VLhGkS5wFU+Gxloe4NqscMEAMQf7ZAkS8hjhS1k+Y76XFX89GY1PxRxikmVTy5/V97LU25Vy3oH9DQ8TwOYhtxgVzn9CMJ6X1ZFItpLdvePAcZ+TldPY46xlUlIlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSvLUA2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZzrZEyig; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2hdQ61980503
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K2IEBOcA/PnX0xEHWPoSAZx6P5pC0fIMY/puI/SdMtU=; b=ZSvLUA2rl4UZu1SH
	mZrIGQYwS5dZaWRh9xzy4HXt/hDHQscVl0c4elvWZmNGRQKXMngaHdI4BJefE7Uy
	RLBeuj4OoyKT9sX9XuH0r9tBTKR+4M4psYo8pXIsve0ADnFOW0XYfFXSe1ybFfkX
	0TR395KUIX28faoc0epgemvVRoGf+bpbgFec6GaIQ3BlhUItACv4Y9Z/1kJl8lan
	THc5h+faNJABnlX5sPDgJMJJuOWEJKcWJ4sWHUzrDzAVtW8QNNycCJbrHzY/VHXZ
	zNi4LfawLifPDrpyighABVuYSlkCuOMxXebUwfFI84h9TKt547/SWdD/jTIjg1Te
	X/Q/tg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amw9gsc45-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 05:36:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso4784219a91.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 21:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764048996; x=1764653796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2IEBOcA/PnX0xEHWPoSAZx6P5pC0fIMY/puI/SdMtU=;
        b=ZzrZEyigQ4n2kKkXZxEaYRNy6MjYwu3ryqI4aY6i/K/C39+K2zylmD7a5zoRWB6p2t
         1axSQKKaocwrgosJG686w3yfxEB5fqSf/saJzhdW5w9XSKtE/vJV0+5gXz6hWEKbvpFP
         hzuobiOnUGkGLf+7ACRjHmIJ3x/FC1bnZLdbK6PCiCzkD9sqJypCEevWOEYynHFTmuSe
         fLhc/DcFlPcCctKPGG9vpAxlhifL06HgG2Pim5DPIVrOTm/UJJDauWBsO2WtD3pClT+t
         PjM0jh87Su62xnAyYUG8Fd5Sbp3vTimk5aGgZ3o+8UkpaMdQgHCflKj+eT5+9RPYxrOz
         A2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764048996; x=1764653796;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2IEBOcA/PnX0xEHWPoSAZx6P5pC0fIMY/puI/SdMtU=;
        b=m+KGj3KrQECw3HBwVtA3p1ecKNcJMkYwHhyAMutLNJN+4WoIw4uQkwL7oprGu6sJ2s
         Aj4vAhqF5dGnQOgNHHp7vs5L21TGbucmxqHE0EsDuzeggLaAkMsXK8xZmXvYGZw520Eu
         UWlRCJ72tVjCBA5AKWCbjP0hqLdTLECWLux/w6y572yKwCdA9FBUsbdcZSzdMcGCwEkz
         HJzcb4YyvngrROqMvYTBk76Ao6aGfbTeHIsQ89z9gtmkCKZ9kRMQ9mY7icp4lQrWXK54
         ShxSsYPHqHvQm6/CeVvzZ99f+kJ6Mpy1GeHdNy0EuiYAoNwW5K2O8skGPDXQbBbh8yzW
         bP1w==
X-Forwarded-Encrypted: i=1; AJvYcCULrgiE8gIx/cnOnTPgf9wcjjnzkBvQgTntTMAzzd92UmskQJlSkPV1h8zduIh9c2h3DoMGMlNR6Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmOE9F+HW6YYeDuSJkpJKazAur55qGBxahCtghupN8ZEe+VJ0
	yKPIibEyy9MZQJYL1ffzuIIt6nhPQBH06+AmBkZmd6ZI0e6xq6nDfyWmTorIIl2aefefq4P400h
	tRW2LmYcaZUob2XUo/cy/C7t4c13+9mcqlJhQFflBRVe37QpzCo8YIQKysSybFYM=
X-Gm-Gg: ASbGncsUHCoZtmrTklT9NG9QMWX+UHJBWSqPHiqMCdwqHbsVQeaHSZD28LfahDB75su
	FPURhfqDKffd8f5JF2CWf/APomz28aIsVmEsNVJOh/vHj2K/yTtpq0mHULGSIFmD9EpVNVj/TXF
	dOgOF1tNkgN/xbTn/idRTvbuLlgbVwmnxeHINktd6TMmqw+9UQ/KCP8LyO3g9H5h36hCwjXTMGG
	Z0MmkFS5V4e+Ytxh6iMuAk/6EmZmZKx3TfiBD+B7Dyrk0lvvQsJOwj5Cpj4wDyNle1FV1SZEvAJ
	xkz+fctYuq3PJlzG3cV2CkChlTc3Cw00bdDWDvz+1JlzuEAP0FiXI4xTg1FIn5eBovUWlg5Pa8y
	c0KCS9c6ANw==
X-Received: by 2002:a17:90b:280a:b0:343:43bf:bcd7 with SMTP id 98e67ed59e1d1-3473345bdffmr13896328a91.13.1764048995906;
        Mon, 24 Nov 2025 21:36:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxgaDNdfNEfhXZPwt2DNVay84SPTVRR5ocAbrQwMZt47vcF3pJ96a4PxRWzhqq/3ZJlT+etw==
X-Received: by 2002:a17:90b:280a:b0:343:43bf:bcd7 with SMTP id 98e67ed59e1d1-3473345bdffmr13896310a91.13.1764048995405;
        Mon, 24 Nov 2025 21:36:35 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88e8:55c:808f:7bd5:9774:52e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ea6d780sm452943a91.6.2025.11.24.21.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 21:36:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com,
        s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
        larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
        ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, Vincent Guittot <vincent.guittot@linaro.org>
Cc: cassel@kernel.org
In-Reply-To: <20251121164920.2008569-1-vincent.guittot@linaro.org>
References: <20251121164920.2008569-1-vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/4 v6] PCI: s32g: Add support for PCIe controller
Message-Id: <176404898659.18373.12076537585341452677.b4-ty@kernel.org>
Date: Tue, 25 Nov 2025 11:06:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0NCBTYWx0ZWRfX8AZ5exlWDted
 E29ezhKBNef1J8TU8vN3AqG56aXeEueuzuTFS9W9xsJqr/tpcivRZwy12bGEYWFZq91qK14feiR
 QI0wyv1mnRVuBgCRkbl6YYYSJaC+75BOYTPlBCJSQX4OHODir2Eq1ihAKq7yq8dnNS/m+FP85/5
 aSkw4XMnYRGVDC1kaJr+f/EfzyAoVPwoXugw5H4oca+NdcztHHnO3a6O2E9ZijcZx/zPYRNkH7J
 eAtXo0n+oQKCjT1fln0xjPRwhI0oa8eLV0uxefezt173Jl5m4N/gOjZD7bx/AvSn+UX6Dw+5c0b
 QyIPjQGrH2odEPnniFUuy3dbI2AeIvcWuoz+GRzg3GXqVqmJsvP/RY4urmUFXbMTp8DWgQGGYq3
 pRMgkn1X9BkdeDIlbGcwY5PSTEXoaQ==
X-Authority-Analysis: v=2.4 cv=H53WAuYi c=1 sm=1 tr=0 ts=69254064 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1z36L96dY_S6Ah6j7mkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: _JOKRVpGz1ZoODiFMvEWEOokTnk2GMs-
X-Proofpoint-GUID: _JOKRVpGz1ZoODiFMvEWEOokTnk2GMs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250044


On Fri, 21 Nov 2025 17:49:16 +0100, Vincent Guittot wrote:
> The S32G SoC family has 2 PCIe controllers based on Designware IP.
> 
> Add the support for Host mode.
> 
> Change since v5:
> 
> - Removed relocatable bit in yaml
> - Dropped pcie-nxp-s32g-regs.h and moved reg definition in pcie-nxp-s32g.c
> - Removed a useless ret
> - Change kconfig from tri to bool because of memblock_start_of_DRAM()
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: PCI: s32g: Add NXP PCIe controller
      commit: dd17ec3df57b7bd0d23f3a17124d59b2740d81e4
[2/4] PCI: dw: Add more registers and bitfield definition
      commit: bd1be33651b21ce15eee8fa2f080109e3eaa8e29
[3/4] PCI: s32g: Add initial PCIe support (RC)
      commit: c403d6d7282b72fe1a0812c99beeeefb1a7e1f4b
[4/4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
      commit: 58fc675c34c583771d412aa89fb364c750fadacf

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


