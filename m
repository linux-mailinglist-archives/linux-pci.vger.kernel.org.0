Return-Path: <linux-pci+bounces-41420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A68C64BB3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DE77728BD5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1432826E;
	Mon, 17 Nov 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lTOhfrUn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWcxW8ri"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76B337111
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391342; cv=none; b=IPyKFW81gJks2cc+wRN0AA9XoqdA8qhkt/KGXtkJlagUQmFMPxK8XzljXfZ5xj340XDXCq5RTOq8MnTMccy292kXrDlY1gqEbWasf9uAljqZoa9QYvo2ZhGepirU9E0q85AxQJ2J92xxHI0cdtj+MslNDekT2bwewsI5RPVTifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391342; c=relaxed/simple;
	bh=ddKQbg+5aeA8Eos2HAPxgAnbpLqgnU3/bB5DYQTsIto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RV4rIyWZDv5ZWm1lfL4GOm1DFhCH3UyDRFTKdZX3udXu5nQHM2z++45C4qRltVoMEEZrQGby4ddYMhW1OJhc4QYSfwgMhvNLaonhxQT52BUeoex51jA6I0t5aJbAI6e2AOostTL7/2RPVfH7qwbuUJZUeLVj0IDWaf/0pjJQZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lTOhfrUn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWcxW8ri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB3jV63517304
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 14:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	awbwG/k9XyjzMvCh6NANh6uyBFKHQ/YUvVhYaVb6bNY=; b=lTOhfrUnVVdViObc
	dVXIqvdmzxpeVtUkMLX1z9OnGv+edJ5XTbdvLAe2DcgV7rbnHw0BOsnuKQol2q01
	QZcPHjtaQn8EzTqNSO2LQ6ek9A4xnbC604QgAjnOEctwy5r0OM2URZ8APcqr2VCC
	fRhU+xXuIzWe/ux1tU7orrxc2HqY4KwWSHjTwo4raNX/OkNcIy/qs4RbphlZhnx6
	g4xdwJbZ4AvaBrFyrauLgDFcMsL2VsWA0dNk2Ij9aWC4xxKa0aOTihkVCxA40Bb3
	l5RVJEVFdvWmgkwFTqiCO0Jev0xG5WAlddEn2GCmXr8Ckg44ZJObXSO6OejjMeGg
	nPO9gw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2gg8mye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 14:55:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9321b9312so11274653b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763391339; x=1763996139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awbwG/k9XyjzMvCh6NANh6uyBFKHQ/YUvVhYaVb6bNY=;
        b=cWcxW8riHwTDdXC/9Tza7IZ6XhDJJkljIr0PzICXT/U+cpgaB+HOZ6OqEO3HL/Vzpi
         LfJpoP8+YuOUuR+mFoFcAOuv1FvnFU2m1NYypeEc1HxNg5cDu2Yx0n46Isj+9ynil0yD
         OUD7z1n5yrzloHN4mjC8fgEZ512LF9mYtW2JSqVafIub5iOkNSKfJgA1J4v+3xQZ+eNh
         QztkCa5G2IzdNnotQpiNvB/KP178x6/ceLGKsMS/Pc71czga5TB62aSJ1Yldzp1zLyvj
         Bjk8HvV5a48qGgJBnAR5B7bA59Jk97YSWQZ1RoBRuCk6B98V59yrV2r+S40r78cBF4B8
         p/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763391339; x=1763996139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awbwG/k9XyjzMvCh6NANh6uyBFKHQ/YUvVhYaVb6bNY=;
        b=gFbQDqxRPhnQlas3UMMKQ1tAU0euMja11TNConUxd+FT8Ovtar4ESAZFccx9vmgxVD
         zzj1UJ5w5U2N9EByaTGkNjK+ffeFRw4FYsrNLpTYX9Ec//dncjXtYgqv3dPY6XXU6sRe
         OSUUd+q/uTbl5brWKmUwdnlzF3k2wrfMk8TKdZy9MwbGpwk2aAEK8hY9T1BN5u/1IO/Y
         n9h+3gyy9T+KSwfRF70MfUALFrkOJDvdBXTzsX1BH5v/QFAa2ZMWG1eeT55f8FG1o/GE
         VV3DaOcYhcCoWscU1qD8Iw5UYUAaF7XKVbM1dGskuO1/d4cU5wVbnXdaijHPbKjC02ie
         Oj6g==
X-Forwarded-Encrypted: i=1; AJvYcCVrZdfRlbKPzxVcRcOy0JMsDmon7RRll1nspJE/0MwJUeBU9KD7TAoWPX9idZw4+/gXRuJ+iMGKM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/rKJEDSBcMt5i8h+Ud8IBsjIgyIA3P5zOPiOswdDidmS1Kic
	6lqRTyXKUhXyVXH8/BD746t/2lCOoroBSuUyMSisU7jBhd1O4Az5jmuMwpD860llI0g/O7Qonmc
	W8/yTjZPa7XTDDN70J4lfvrVLLRg8mgRQog+h+D/+JQHhd6T8a7/XQgw3LnVSsj0=
X-Gm-Gg: ASbGncs+iFn2YAA2OuWXgNKVPrtOPpj84M8zC56Q8YpFUxrRHl4k0qxHjQS2AvPV5/0
	4tM0YPxN9XeLVUhA6dpsJixxSu8lGusC6QcMBOM6GggmnuH0PLgD8sfzM7V9JwIFUWluT2Hn8WA
	TcI1TpEs9gFLJoHYE34NtySqIM3O8vfYAEGnjOVSkOZQxNsCipVxDajUL7COh2ZSDsEJkL1frq4
	xGU7Vd3LfT8x98TQpG9eKrCIAzlbRltcr1pBZLqSDLaIsA6OWnNQKWORucWuh1z4yNrgWFAPc4H
	w6bqhZkQt1k96xlpIZL93DhBaT2WmGTVIcxNIbnGGbpYl05WdvgI453sPqxAq+O/sX9cgMFb
X-Received: by 2002:aa7:9069:0:b0:7b8:349:1b24 with SMTP id d2e1a72fcca58-7ba3bb8c363mr13353817b3a.22.1763391339403;
        Mon, 17 Nov 2025 06:55:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSL5vJ9zpN99/df4BrrN39IGWZXi59cv6hPKEmE1JVTmbqGnrZbM2VZhjhEvINN7S/y/pFWA==
X-Received: by 2002:aa7:9069:0:b0:7b8:349:1b24 with SMTP id d2e1a72fcca58-7ba3bb8c363mr13353786b3a.22.1763391338914;
        Mon, 17 Nov 2025 06:55:38 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aee8afsm13627213b3a.8.2025.11.17.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 06:55:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org,
        Alex Elder <elder@riscstar.com>
Cc: ziyao@disroot.org, aurelien@aurel32.net, johannes@erdfelt.com,
        mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        p.zabel@pengutronix.de, christian.bruel@foss.st.com,
        thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
        guodong@riscstar.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
References: <20251113214540.2623070-1-elder@riscstar.com>
Subject: Re: (subset) [PATCH v6 0/7] Introduce SpacemiT K1 PCIe phy and
 host controller
Message-Id: <176339133088.9268.13766811346004998135.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 20:25:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Ap77oaqs0zsVzuj1CC7Wz1v2VlV1J-p3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEyNyBTYWx0ZWRfX5IBJZ8mb0ycU
 ZP6L9R8YjbxnV9UBtu4BJb2yNjoGFItJZjRft5b/rBa3Y5nYPc8IFaz20mPGVvOgClmzQeRTDCT
 mTSRTTFIrkdNqNpFWNm1CqgOh2paTNHMd5ybCY9h6i336W2EmfM3sNRjGQRPKcb6qgGTPSypEF6
 9aeYEzZtmpvSOYQs+Paf02s+oSDdaiB07QikICXFL5iy40Cu/vlYl/hlko+AJX1I02mki9lu89F
 XFG+fwfb4NnvYGhLnogh+P33B0B+MeofUF4RovFBCFZypWH4saBvy3YiWcP/rcHnGJl06zvWyLJ
 3HUIBRtLpeHXHN0OFoM0O0tgv8PrQraburShfWzJbnO0mSyewmvZfXavuUZfMkogbELRobnrsgm
 nPJ02DJ4syuIpoODlb1nH2S0eI1zYA==
X-Authority-Analysis: v=2.4 cv=Cryys34D c=1 sm=1 tr=0 ts=691b376c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=TFzoyenawzPvhxzIwaMA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Ap77oaqs0zsVzuj1CC7Wz1v2VlV1J-p3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170127


On Thu, 13 Nov 2025 15:45:32 -0600, Alex Elder wrote:
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
> 
> [...]

Applied, thanks!

[3/7] dt-bindings: pci: spacemit: Introduce PCIe host controller
      commit: a812b09a6b599ea80ec1065a9a635724a235843d
[5/7] PCI: spacemit: Add SpacemiT PCIe host driver
      commit: ff64e078e45faee50cc6ca7900a3520e8ff1c79e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


