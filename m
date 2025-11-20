Return-Path: <linux-pci+bounces-41733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D580C72812
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CDCE4F0A20
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B02FE07D;
	Thu, 20 Nov 2025 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+9a5FSU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFHo2pAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2930596F
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621503; cv=none; b=dQhxgoJUbJH9maC0DFsHOnnJD/cbc8ICaah10O+S5zQuDuY9jENQ3meHHV9AnjuQp5Qmz11sWTORIt2yxUHEPkU8ojl4DRDuY4engP+DptA5rZdCIGgf0LdvKpC8ly2VM0CBUPVkFvdcueF28P7uupT/TrihJGADlZPlGAVyvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621503; c=relaxed/simple;
	bh=Ja7W6q1bZ1FedcjRBoB474TS/+m581fbMO8QlwzJfFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TngzlPhPGFI5O5uBGoO6nH7Rnh+bdxNyBcnEiFjWzz56ezQTZ+ZXciS4UfVoYEdT1TeWdEmsTbfD5cPlpr3VNjR3IeGMkPvkLdpMV+FmSGmEGMrKFcGYN+1PuxaMKAuDc/v/QvXEb7rgX9TNu95enJ5KvDQKJKknQ5NWw3S83ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+9a5FSU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFHo2pAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4pRJo3719913
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y16S3tll6Q2
	Dwx29gSSuDw2ZmeI9hldZEJhsy6wP9Qs=; b=L+9a5FSUbTneIkievv/tiibae3X
	6QGTfNc0z8znjYoBXejP8aPRicN3qGF6W+O/rfxj+LtvbLhJpBDAItCAmRh/N7Bf
	HRz1Vh6iSCTvAvf0sLg7dsqFFAR2L6NzuPxhNEqHQ/ctap3lq+JqGtEiMXm4CupN
	tqQpF9rw51oVQB9/EHaoqSFEFA9UFq+JHfFiTAFgp2GedPvy4gi0Hhp9jDWvjWFL
	tvLCvmz9aaiCB/Lc2mNt0agYxVpA3++JKFM65rJJhdlIqqGSS1bcq5vB+JuzOOI1
	ZoIjf1F8Ioo/gpvgfIi00skZaH0auzQCM4L7+MTd9oeDEwL+TpP9GoY5RHQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahqb0h6bq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 06:51:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-345b4f2a8e8so1121932a91.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763621499; x=1764226299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y16S3tll6Q2Dwx29gSSuDw2ZmeI9hldZEJhsy6wP9Qs=;
        b=DFHo2pAi84ABm/Wr2ihtQP9suNbn/bM8MMXP/IamDULuATPXrwIt0NGlLscIBBzLUN
         DK4gaKKLRdxmUGcM+yxDmXPEXLcHTt6f//lco2tHTehfgomeJhJ7SwRZ0Os3TV6dT9aA
         Eii38KlvW1kUgrJJYoMZNuf3tfvOSNM+voWVp6qC2ARziKy6o9QITPAcZpw0sRHdknuX
         RqEbtSCjSir32iIWhHFPSk5BeyK9FMp1p3tQ83uVIG+bUQEygvY4BaFmrNhgHH/T8BvP
         kzATLaU/oEajqhkAzGrFzA0ST8wSIyDTovFIkAQqACigubLRvxvpkJKSN0UbkU5KN0xO
         3TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763621499; x=1764226299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y16S3tll6Q2Dwx29gSSuDw2ZmeI9hldZEJhsy6wP9Qs=;
        b=WJc9h3mBwstdjVwiGlWZBL2e2yxaSQ/ymaQ27I8M6TMx1PTInM8xrya2Q5kh3sLATi
         fpJ/zyO5MkaOlDz56Hx44XhKKAa412QCRPcKankSNgMjToIbvQaJVjughMQzz9neFDy5
         0XnKELTLlR5BrOqdHwGF6rgGf8++LSku4zDUijis0E0iUFx3ospcr3ogdtjuJWHSCsRz
         8qUKDSmZaTl1f1s+LIMwFYmV2SsykGrSgAeYjOjaQPAnSH6ULJR4fyePhwNOkSx1THIz
         l+6FMoF5pxU7kJh5MF+YVgdtY9gdUBISd5XjOKg4+hmhVG53f3GK7rP/dovpElUAJ6ws
         mz/Q==
X-Gm-Message-State: AOJu0YyCOMUdSy6MH1EOFERzV8i3iiuDw2+nmUwalQ4CJGJO//u/6CO5
	3YQn6LygsIedViKsGOcaycKrl9YrKBmmrTeg068N/fygILNfeAnNAPBTWCwJae6woOoqAuHlexk
	NEd70ArvkU3AgiyDL49VRbF3NT7lJZc3h1kqf5wCpbLnRgOa/j82HwCukch43jNBk8DPlLhk=
X-Gm-Gg: ASbGncvsH0lQfobPhZkXRyME/GbElhM5LteqjL0Y9cJiWLffzGCWHhJEDJwWcGtwE8v
	1vFaO/euxXEsyYdfUO9QDsxuo3mi6rHw2MBt+qKd+OVWCvx0I3tPIOqkrjL07BJbyEDfIB/DiCP
	GOa2QqMkoIvmn0VB9OhE4Lwi1fPwXMnxw5n3ur5JDYEdlVdIwjcTis8Lq4Sd8APzNQtYM9q19/r
	9zbcSzKExhs9AWIfoXGTBE4QBkJdTRT69biYClpccUUsArrPSqm1TtinrpydHjtxogocepom1Mx
	kbQqfqiNrSwuM6vHk8Bq+lfEJTv2OAvOsmHWaTR69fF6N5Q5Zqd+ypchnW5u55jCqOfpKsck7l4
	=
X-Received: by 2002:a17:90b:3503:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-3472a8fb7d1mr1345993a91.10.1763621499095;
        Wed, 19 Nov 2025 22:51:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOI3P3sZBigObQBcntoOBA9Cgm8W9LpVczA06qC00OoEJA7kMnN9Vm2SIneQPZ/N0GPIQ6sQ==
X-Received: by 2002:a17:90b:3503:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-3472a8fb7d1mr1345964a91.10.1763621498572;
        Wed, 19 Nov 2025 22:51:38 -0800 (PST)
Received: from work.. ([117.193.198.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm1292681a91.8.2025.11.19.22.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 22:51:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        krishna.chundru@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] PCI/pwrctrl: tc9563: Remove unnecessary semicolons
Date: Thu, 20 Nov 2025 12:21:16 +0530
Message-ID: <20251120065116.13647-3-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251120065116.13647-1-mani@kernel.org>
References: <20251120065116.13647-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XaieCY7JNREie68V3dvfNqbXyAkWob9o
X-Proofpoint-ORIG-GUID: XaieCY7JNREie68V3dvfNqbXyAkWob9o
X-Authority-Analysis: v=2.4 cv=DMqCIiNb c=1 sm=1 tr=0 ts=691eba7c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=UMbGOA4G/0oMlBJKcU414A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=JNczjLBnLAn8E9S2VXIA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAzOSBTYWx0ZWRfX/s1RpO1JxZ5R
 KkGbUfVX8ppLJSxk2iXfH+/urcRpnjkvygkzPldRCbLnli/yz2GkzwpdPFbG+oGigLEweYszB6i
 EaNtCFQrRfOQ2IJhYkKCzOwsEq5kIr/jBtBho56Uo+4+7dw6wYiPMjFzBKCm3Xk5hjNKduqgscV
 11uG6z/6emkNyQBxeeAM8GA75SKPKj+vizcciXBzTz1kL03h5cWqlzD6930fMftmjr1MR9YolCy
 h8jYGJ2RVVv4XonequM44EvEfgusND35B753l/855+4PNhRtM1fF02suQmyFhtj+vL7QHsQrdgL
 RArmKW7YNA6i6VPFxxVFua/MIZi+62m2XTkiL+zaXWT0IubEULT9duW5aqj+dNEDlLP5RRykqxy
 ksoIHIT8LNlXd2NsfYBvGQz0eC9eRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200039

As reported by the LKP bot, semicolons are not needed at the end of the
switch and if blocks. Hence, remove them.

This fixes the below cocci warnings:

  cocci warnings: (new ones prefixed by >>)
  >> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:351:2-3: Unneeded semicolon
     drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:414:2-3: Unneeded semicolon
     drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:316:2-3: Unneeded semicolon

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 46339a23204f..ec423432ac65 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -313,7 +313,7 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	struct tc9563_pwrctrl_reg_setting tx_amp_seq[] = {
 		{TC9563_PORT_ACCESS_ENABLE, port_access},
@@ -348,7 +348,7 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	struct tc9563_pwrctrl_reg_setting disable_dfe_seq[] = {
 		{TC9563_PORT_ACCESS_ENABLE, port_access},
@@ -411,7 +411,7 @@ static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx, struct
 	if (!of_device_is_available(node)) {
 		cfg->disable_port = true;
 		return 0;
-	};
+	}
 
 	ret = of_property_read_u32(node, "aspm-l0s-entry-delay-ns", &cfg->l0s_delay);
 	if (ret && ret != -EINVAL)
-- 
2.48.1


