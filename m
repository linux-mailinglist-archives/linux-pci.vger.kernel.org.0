Return-Path: <linux-pci+bounces-29901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402DADBD0F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A8018922F2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94522578C;
	Mon, 16 Jun 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/OtMreW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0514223DD5
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113790; cv=none; b=qEEHZ7LP2ydU7QHJM5jzDCo7eR6762QNLSkk9nTwNIrSVfiu1twY2DcaMYD5HOpe7hJYUSx4AThWNkaIX97DBmudN6Odkt9GEyUj6MKv7WIBuwsP7dCgQ5plx29ySJ+ranxt5dBKshfqAJbi6Nr+id8WSU0qqwjDy7Oo5lrxtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113790; c=relaxed/simple;
	bh=jwXAlYfmhDYsCRlqK3RU34h6+Mh+UVwAG7ubZFvcMXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYN3azthGROB/FkB7A4+oS31MCY0GnSwF+q9JTu7t7SoBbiTOPENxyTAIAzDLd/wpX+gQzR1Y+XlBBCmt7uhNUeRuPXS4z3Zm1SfDC9XYmHUHsgj6AnhRol9DZTSeid4QJYFoSNW3w5aXXuR2HW3fMXl2RbjDx4wYf7iZ7Qt1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/OtMreW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHUgYL015543
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lhwmguzIPmh
	cfCIr+Zeb4Fe0l1FXFzrQsdEuYLGejCA=; b=M/OtMreW6tTSjgnFMKZdWIY0O+k
	YeB9UMeLnYPvtr/fjiNgGWs44d/z1Fe+TBG01jUOyxhxuIaQ5pROidaUtfNFDbtj
	XdsvnEMv8hu+81/724GXJeGUqhALpr4eEwG/mEdxlV2JPw7rgb/BIRUZzOc6BRmH
	hNKnst2CCHCZwoLJdcuNj8cJX3zm/PlJzi04x/fuMHigzrQYOms1FhO9xNIYyutD
	KVShgJR3eKQHjGgpU/gGEj0O/bSyg8SDxFCvVpL1dUn43add1hapRfHMXCE6UBtB
	t1S7n8eFJz1dkSAxg6WYxmUdsXRzdhUDUnFb40H/J/kQ/dvD16R/AF3fLaA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfe4jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c38df7ed2so3591571a12.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113787; x=1750718587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhwmguzIPmhcfCIr+Zeb4Fe0l1FXFzrQsdEuYLGejCA=;
        b=BiqHRtz8yuXztw69rgZst0kwF2O6hMDhRxR58XIWBypkkVZ5z7+iibqsWpSygQgxR5
         FraYryaIiLHGKSY68h2f6fb5QhkLPsxDqYkr+rWuqVxyEHqq/hpM8SD+HRORiwgYKfH7
         dZsDOQb6UEsXQHP4DnmRrwVOnkcjaU83C5qpD1SdW7kuIbka9ISDdWtm3GM5M1JhUmA9
         jMjuv7H5M5/IOUoV2kG631ph1qKYZ+jtis9q+Y6HsI3Lwp924Ty4uTeabJVvi0L5xczh
         sFl/TKI4vVyWK7SnmOz4VEszr1QZqhwNOi6cfOJtVB/slMHgVKtQQuJfcUMZKpwL+T8F
         pMaA==
X-Gm-Message-State: AOJu0Yy743q5RXCm2y0+DqbHBCtNuO7JeSr9Emql1wUVzfJytQPj0F+X
	jBLYFwi22wZO5vg3ED3EQxnpYvNuj8uLnpwKXleMb9VrCFPo50cHFS13enIjjN2wsHGd0ceWS8O
	U4X5yiNIOnC6DWvZnwT34aDrl34dUivDstDBKSRWWHgxGatgdksTMSNZ3ogPhJ3PBtH3Qtzc=
X-Gm-Gg: ASbGncutv6n7Cp7j46gvGZAx1RpVoJtphR4HNSLZRH+tCF2Sh58lTYgvyshWwsAobU2
	H4bGAuLk7PKbiZ8+pJWpgxN64hoy2p4B5zyDwiYuiHth8ZHLkzKc272cimAxLdSH6QErpNNmmvQ
	+P0V7gCwJSlT+9CHrqv65GXb9K00g9GuXpq488EeZOLcbD+V67Ic+Ju9FA7lVmmBAXuJGhngzpy
	oq6xsE+/dLL/XFIe66olXpRTwU/9M40x8iVKKbcewaeWARr3dS6jtbnybPUSDlWIonH2wQzVnpq
	KBZ2olUd6jfr5xqSyOzwb90D8nXIWhr3HF/uhlwGGnUCsheYpVCsm+rW4Mm4D7TaPJlYHpGG
X-Received: by 2002:a05:6a21:6481:b0:216:1476:f5c with SMTP id adf61e73a8af0-21fbd67e9a0mr16273214637.25.1750113786544;
        Mon, 16 Jun 2025 15:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCUK4WZBPlh1OsfUgx/7QkUvePE7tIw8RLbrhNrBkgKdkjJRcElSReSy0icKZ0zCzm+TpmAg==
X-Received: by 2002:a05:6a21:6481:b0:216:1476:f5c with SMTP id adf61e73a8af0-21fbd67e9a0mr16273194637.25.1750113786125;
        Mon, 16 Jun 2025 15:43:06 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083029sm7405077b3a.81.2025.06.16.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:43:05 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v5 2/4] PCI: host-generic: Rename and export gen_pci_init() to allow ECAM creation
Date: Mon, 16 Jun 2025 15:42:57 -0700
Message-Id: <20250616224259.3549811-3-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
References: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2MiBTYWx0ZWRfXzGA2FyA2P3Gg
 dXx3bpZxpDc8M/bd1TbKMG6+dB41ys2HaSCZc2ukU1JIrUCmAVcNDNWLcltCM3/p95LkWLP/6wd
 YA6sO8K6kcJC3N6I6x4isVAXXrEWf+Q4vl8mM21fm512Pbz8I+mwUgBah6lULt0AjmSqfdcT0hM
 9phmc0zx3VnIZ02CEyOY9HlB7/LQrjR1n3fxWvt//tJQecLAl3ASu68E99dqS+SeBv5a9+JETvM
 0HPK5b4aGjcPFO5e/8LT6/uh/f1TIlWqT0OdIBv3i1jaEQAP6Zjoh7VkBhc4BQBGNmKTOobd6SK
 QyV96ZXqGOu0A9AIymoG7f99OeV92/3ewYASds3oVGex+oVA8u+nXS2HhS1TuuUciundIV4v8xC
 r6AJInyakdRFwPiZXLnPaNqSJwXFtYNzIeRRxcN6oK/Am7UhsVLul8GwzraUhOOoUUisklK8
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=68509dfb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=IL0NFLon8k7eL5dmDYQA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 4QQILT0vnYCZ2v3o4XZ3zkc9uKo64J8z
X-Proofpoint-ORIG-GUID: 4QQILT0vnYCZ2v3o4XZ3zkc9uKo64J8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160162

Rename gen_pci_init() API as pci_host_common_ecam_create() and export it to
create ECAM and initialized ECAM OPs from PCIe driver which don't have way
to populate driver_data as just ECAM ops.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 5 +++--
 drivers/pci/controller/pci-host-common.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index b0992325dd65..5b61b5a9e0f9 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -22,7 +22,7 @@ static void gen_pci_unmap_cfg(void *ptr)
 	pci_ecam_free((struct pci_config_window *)ptr);
 }
 
-static struct pci_config_window *gen_pci_init(struct device *dev,
+struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
 {
 	int err;
@@ -50,6 +50,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 
 	return cfg;
 }
+EXPORT_SYMBOL_GPL(pci_host_common_ecam_create);
 
 int pci_host_common_init(struct platform_device *pdev,
 			 const struct pci_ecam_ops *ops)
@@ -65,7 +66,7 @@ int pci_host_common_init(struct platform_device *pdev,
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
-	cfg = gen_pci_init(dev, bridge, ops);
+	cfg = pci_host_common_ecam_create(dev, bridge, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 65bd9e032353..51c35ec0cf37 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -17,4 +17,6 @@ int pci_host_common_init(struct platform_device *pdev,
 			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
 
+struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
+	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
 #endif
-- 
2.25.1


