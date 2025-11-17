Return-Path: <linux-pci+bounces-41435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F81C657D4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7684F0D96
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB95314B95;
	Mon, 17 Nov 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSKJsYvN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEaXqJ2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAF30AD0D
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399876; cv=none; b=pVKboKsfyW+JIiWbdwsIVpR8B4i4Xu8c/KKWPWrNPkRUg+yEjtCQVo3VYKHPUREI+MZrkrD75RVigRDI5fvS4RymQviJUDd02kEfiobTX6fkATHAAHR11FCIeT9rqCHSNnAoTlOjb5NA3rm/cgEmBAWTcj2L6t+F1coxYkrzdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399876; c=relaxed/simple;
	bh=9lfb5lbm13QVXVgmetI6YBA0WSluupetnJCZrVZJWug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cFm2qrweHQPHo0IMwnftQsNrnBH0NIGBHz5praZN38LhkdXk0YO8jGlZwH+F1rljJDHCKdYjDIrZ5U1p2fynSFaNDKjY3yDu/MnQX0BkxOC3xkk9gJDXLQLjPt32OQ3KPufNykohVDHzmn+ZBrN8Z53UE4j6Or59SvaOgAbD7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mSKJsYvN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SEaXqJ2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHGQ1pE4107143
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i93olX92WqAcMU2/NsjuIGXAvZ22y9Ah3If85Gfr8Ow=; b=mSKJsYvNcgJG2DO+
	S3tSss88S85wvJ3o7N7LILxkPDMEHZVJaKyjDJ1DucgTVWlrLjtZF5tRrL4Y7QZm
	nIoMyZ16FrhfHwgPiyC7T3Pu4KJ5xRIVWR7WazUT5RPZNiw/51VcxnE2BnSn1j1K
	dsJnghBkf4o7mttt7xjzcgVlZx9gvaAtezl6DXMJaPTYsBfKJiwshwJ1vMl4rIlL
	eIUzS/ZXD6wKoH2Yb+qXAh3e2VIlVobf4oHSXgcEVQWImqv33MAHcrFgi8T5uoka
	exxNKi5SEz0/FYMQkZmTcTRL8Gm4y5K7wPZcCvpcCcyOvpA7Kj6W8hxPn/9GnNIx
	L4dfQw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag773r5cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 17:17:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29557f43d56so56858435ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763399874; x=1764004674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i93olX92WqAcMU2/NsjuIGXAvZ22y9Ah3If85Gfr8Ow=;
        b=SEaXqJ2V9oT5vffVqMgIy+m0RfIvGwnCvc7yL46BHWlX4kZlD3VmYf+qzK33RWWOEz
         OnMVQ4lSDg/fCGEwF3qEmghnSZ1nyOow/pVij/Fyf1bnxEGzjIVnixuhIS7BCSE5SzZm
         RNudlsqw8EzBwOlpNO6oRxhePYsZFcx5q4SXQ57+rCIlJfPDspy0Y1m5/Sqr1Tmo+2FN
         sG27H2EBTwpRRz33KGEyGnJKOFId5aF6+v4ife8LtxtcskHkunBPKFXC6D1YgJh7NWP6
         jLMIYZrTO8yfDE4X9TKgbiveMGBwwVrWwvRfevRrtQqXBDqvm4Z6gncahpAvLt4IgQgT
         xd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399874; x=1764004674;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i93olX92WqAcMU2/NsjuIGXAvZ22y9Ah3If85Gfr8Ow=;
        b=gDWFzgd5ZijIF29SBl91EnpqRiQ6jvN+BCcoycoszZDws3Ko38F8XNkVChnNdq5Aol
         ovcazsko868KP4L6sn2e9dY+5AHN3vmfg5UeErW9E6FesezbZy7bRDeNNg/FL8kDD/AL
         ywUpmBqSjLcA07v7mwhRLgRjJUwfqV3qtsEwMkb2LAvAiv2tmU1tdWfnI6kJoOr7Bgnp
         b7LQiHkz8m7r3Doy2gMNKQ6YYE6SCHd5eIT/7rVulUGZvQuLDAvYl/AbiTCAO1HyJTa3
         r2coLBRQ97WVWvqxZ2Cvpym4vJDV+dyOzZLm/iyEcG5nGCEyFDRMLkaour5dU+ms0KYr
         QV2Q==
X-Gm-Message-State: AOJu0Yx7g8TxmpRqwu/1aG7U61ioy4H4MMDxAp7547DNJiSNINwQmlIb
	O80KPBgyD9/k5w/0frKG4XBIIcPIWjIuEOgm5Drq3smIKFxsUbBHKbAatjNFDDKaSFzpbb82USK
	Hbjf0Z7TZR/ERLipNE4JKsU+lYhrXoJoPSRq2y9UpCqmZ8sZKdLEloMNVkQ34on4=
X-Gm-Gg: ASbGncvSlOoV9V2T8N3sdBnyrMdp6snPBhPYAu3zH8h2G6R7AE3VWJB2VL40gYOvD3j
	noNDh8mGBShq5Bd/R00RPjc7tsp9uXCAmMEsgEh25EBgVrm3h87rf7dmHjT6tGsIbQDV9x+CtIa
	BgyE3mMt8aCBmXLa9f66inogLhDZHrPYYU1ZbCtImYvcv4Cb/jFLDO9JF+PAqFcDYJwClLy7CbZ
	bLuauieEm3Zy0TChmkKeFCvckLgtKwTn7Wl/ArmBtiOwfM9sPLBzxDg6N2/RVTPJ1P5PldZeCvT
	g2V3a1zZ247nlNqdXGZPsD538fn5UwvTzNMWAKFj68VxkqAbqV5/7IVqa5RD1TieYksoEwRE
X-Received: by 2002:a17:902:d607:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-2986a75e3abmr163279095ad.56.1763399873601;
        Mon, 17 Nov 2025 09:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXqHYNFy2gFUByh/xB5XQrlDQJxkWr13L5mGpmFTI1mFj2T5raib6vRXVu9+YiT1oOKIIsdw==
X-Received: by 2002:a17:902:d607:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-2986a75e3abmr163278645ad.56.1763399873107;
        Mon, 17 Nov 2025 09:17:53 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b06b6sm146804555ad.55.2025.11.17.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:17:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251114-atu_align_ep-v1-1-88da5366fa04@foss.st.com>
References: <20251114-atu_align_ep-v1-1-88da5366fa04@foss.st.com>
Subject: Re: [PATCH] PCI: stm32: Fix EP page_size alignment
Message-Id: <176339986701.12619.4602667156488973060.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 22:47:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE0NyBTYWx0ZWRfX0H7qfgxG0ivh
 MA1OhUgVAvj0Uoo3yxaAqUgwaDyCqDkqxwhQVtBjKfQZbmtaQyjwgJ9c3Xr1aabn46kbC//9KOd
 8wdNvIGBA6PeZpIfJkGGxubUxFrcuLdIEeE7cKamaUR4vACLpYNJqrjenjsncryIpQJrCZhq/BS
 hzmpDAANh5jzHJe53SooO41lc8kXm6NZdvONk7lgXvFd3QfMrwmp1xTVLAaOdF+CUbXvkqc0aaD
 n5SJfoYaKmDqD384pya0Hn+BOtbq+q2V0VZaBPhqJVGfQGQtO9mup/rC0/W9t5Kz9BtEe/4GUPu
 F7UCrnR26R83zDaIodcklNEEPG027T8M4+4o6gRMo1KjrDq7cQ5k1s04rzrOpSCBizLlDMrED/K
 W0mGgcZ4fh5QhuPmuGGzfgS6l/uM8g==
X-Proofpoint-ORIG-GUID: oTPtsSCrYKNTowWvE9vDBQ5xMbjBSUgG
X-Proofpoint-GUID: oTPtsSCrYKNTowWvE9vDBQ5xMbjBSUgG
X-Authority-Analysis: v=2.4 cv=J6OnLQnS c=1 sm=1 tr=0 ts=691b58c2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=do5hrM8nwbRZ-HPJZGUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170147


On Fri, 14 Nov 2025 09:08:05 +0100, Christian Bruel wrote:
> pci_epc_mem_alloc_addr() will allocate the cpu addr from the ATU
> window phys base and a page number. The resulting cpu addr must be
> correcly aligned with the ATU required alignment.
> 
> 

Applied, thanks!

[1/1] PCI: stm32: Fix EP page_size alignment
      commit: cf2eff021ee3c179a4ec4a6c1d34a27fd92b8acf

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


