Return-Path: <linux-pci+bounces-41731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5BC72773
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA67334B6AA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A412ED16D;
	Thu, 20 Nov 2025 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EULGsr3N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drkeLGyZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F482FF142
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621495; cv=none; b=CiPXmaFLQvofywVZd0psImxrOnLeEh4SA7n2ZFio4attQEpBIS9qq/+3LRbF8aGy4EGitpVMzpTdgFvFedeYerKSI64W1/b8C9uEM5jsX8hU9RxPkQ0BuKNFbh67+YHk8llyoNKRG4H0gv88fgia0rPXCCJfDQ6jxEK/adSpLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621495; c=relaxed/simple;
	bh=jbWXfQth9GVHzPYvi+zWJauMcw6AHqqSBkXF+rGcMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJj9LLSTv7kEiOw7aRo0hTftkIAXTOrz26bmmFXB6WQvgFwgKgoylNyhKozk1v6zXnm/8qZqPVh6FVaE3W4JtxO5GmheWQfVNQ8ar6LInmgcW3l678VgRlmrsr4xtvw1fGe6u8dOLheK+C/+ghh+dUEmn4NVlhel4gecQdraCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EULGsr3N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drkeLGyZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4xP0p4101326
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HhW/BDA9kJbD8ZtjpvU/SWvDrxOGay5LV4M
	odQ1qpFY=; b=EULGsr3Nipt6HwWyrS0/emVI/8g9U1nDvoTUCNjeoMHqkVNq79o
	W6iXcpWyA8vLOzKeAaXhyteFyo2ole4bghRM+ZXy1mg9zi5TpAy7AdvC/9RcL0uA
	D7fxiteMqdWOV8OHFyz3gbzAudeWZATwvyF2Bl4xTarXIlz21fwzzDAxb3soXHZW
	AV3FGekRlxiZNdvCVrVPEUSxO8/mfTtqxzoNB1BIqBN2jCTSHi1WT8sTCY+a3Ou6
	dEsqK/c21YWCsumr10PqO+r/uMgE0fEbvod8tfFY3wp5+TSu5tL748I+3T7ZJHtV
	6ZMtHaDUaAaGerbCm/JdPNcIyoI3VkhNG9g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahver092m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34188ba5990so1710449a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763621490; x=1764226290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhW/BDA9kJbD8ZtjpvU/SWvDrxOGay5LV4ModQ1qpFY=;
        b=drkeLGyZcnnrl3pVxsGmbm7rPvIBKcHfBgEDQfsY6Y8rPm81iAkoPdca89i8MUwQil
         SdYijtsXnxPXCFzrVE3wvrgWGxgnUoZ28nwSS1tN/6Rkk+xvdC1/EfeTUjddL/PfEHfp
         ymy6Z2Bc4qAAi0ZOvAQ1M47eygpTtT5Gwwf1DC8VEddJHrHLgsJjfu/OyVx3juWgCQvC
         SUMWrtPrPxx2zZiulTxoBo9OjHJWQPoMgeZhwE3joy8FFk8TWMJct4K+FXicLHlvEvZ/
         OwyA0H1bVy+iCw4owtmO89gQ0ay2ZKrVDNbwvAFdrdOeAGfwR3/YmSJnvnKnRhJRAw33
         zlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763621490; x=1764226290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhW/BDA9kJbD8ZtjpvU/SWvDrxOGay5LV4ModQ1qpFY=;
        b=Ga580xdJh+DO7cC2hWRkgA7lYVsTELq8XWGdc9ZzZsXWL6QtpI7mzjuz0z69PLACZA
         8YBKy+jbdPj7E/LMaoeDX038P95QS0/CX7Sk2NI4Mz2SyRKZ37IxDvQwK0wzirkTP8Sd
         UxKLdlAh6Iw10oB5K8/0zPt/51asmgpfL2QtZcDsrgu0u63t/P7amsMdKkCX+EHT9krD
         EoU7lPckR9WdtZiP8xqe1WW6GYPCaupc67V07TzRRnJQJRZdFZDuSvXXsPAfY+asPinI
         YMUHz+K2k1D26lswy7Q0OLrT4OLqi1yLxfQnImkRHfFfCNQXTG1/jLWZCzZKrR3lTrLI
         37ag==
X-Gm-Message-State: AOJu0YxocVmeTnnsPWjCWoUefkHozVnRpM+drRQFSxFClTSLiASU46V0
	d+NMP4qIr/AONXAkIsI3jCm77oSIR2gLwzyAHfYfXfxYi6+Tl1A4ZcNiRCLhLC8MfNPzIk4c8i9
	2dn6fGs2Z3Cc1WgibP0yU60gogZ4crnazORtsbE7Xly9sNmidtFaVrN86qLe0XkE=
X-Gm-Gg: ASbGncujxGaofdEMhQSg5pz0x2diKDqwaz2gDhN+inXo+qKogmcFvP75UAznI4tEr2v
	yT6fv7mknPTvgFpw4dpXO9LRmgFLcACHpq1J2crL1TU7DEeFzSrdziIbLA1dQlx2bE4+xUYVU4d
	3pWktadC4ZHijM+jwRn/8NR9mnz82fUiIvbVvfzyEIMq+cK88ZBLQrsI0Tpnv+qYI8aBc2FUVsp
	HWT7D3MbzwH7rJv84sLC5fuHh2Tt39ilzn+4pM4wEOPKw2E4EpHKoBt9Jw1FoP/kpk55XnmTJXP
	GA56ktZIMF/Cjlm7yL4yfGA3x8gRnMzvfSIcUI8+leIIPj8XEsO8PaMmVpgk0slnp55CIy5Uups
	=
X-Received: by 2002:a17:90b:4c89:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34727bedd4emr2137611a91.14.1763621490530;
        Wed, 19 Nov 2025 22:51:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ+yyXxiPgnxHO5oZ43ZpZfzsb37SvB0SUP6zqPA9Fc5P+y7RNC7NrAO3gNuZ132gjq0U5SQ==
X-Received: by 2002:a17:90b:4c89:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34727bedd4emr2137584a91.14.1763621489889;
        Wed, 19 Nov 2025 22:51:29 -0800 (PST)
Received: from work.. ([117.193.198.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm1292681a91.8.2025.11.19.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 22:51:29 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        krishna.chundru@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/2] PCI/pwrctrl: tc9563: A couple of fixes
Date: Thu, 20 Nov 2025 12:21:14 +0530
Message-ID: <20251120065116.13647-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZvPg6t7G c=1 sm=1 tr=0 ts=691eba73 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=UMbGOA4G/0oMlBJKcU414A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xPqfuKhK0gA17P8DOGIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Mw1NNwm_4metrmK5dpr_HqFzLTaYREVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAzOSBTYWx0ZWRfX3woWEPpDuWeZ
 4tUHc1NmpJ41WscLjWriUH2uqOCHo03N9tebPohHC94yhyf9Jk2xFMw5NvXM5pr5wylnLcAmiWq
 +VWZN5ndQjmaBZK1o61L+JzXuH+JjCepqN9zd1MXfskKMU7QwPcW8+GCxvQod8YGukXfv4r0BmJ
 TrjZdGPIWpqkiO6Nf4HpShyvARAQX69ilgRArWObwFTY4JJGPCimzAcQw2Vq/vztiXGNiWL9qQv
 Hs5+g/qIkBjgDHaVknSPUVPqhiN90fpPMjX272wp9D1r859I3cIxKMaJ/T7Jvx+kBVjJv1tBVSt
 s9DFW0T1KteBVNqN1e5vKXqL3rmZMNL6OYCpf3y7UI7G+hIw7YY5Mr/0LVIYNC/kBb/zNKrEN5O
 ZGwdSV0MRdwWGNCnoYiH7zEdm/vuEw==
X-Proofpoint-GUID: Mw1NNwm_4metrmK5dpr_HqFzLTaYREVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200039

Hi Bjorn,

Please squash these fixes with the offending commit.

- Mani

Manivannan Sadhasivam (2):
  PCI/pwrctrl: tc9563: Enforce I2C dependency
  PCI/pwrctrl: tc9563: Remove unnecessary semicolons

 drivers/pci/pwrctrl/Kconfig              | 1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.48.1


