Return-Path: <linux-pci+bounces-43657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34776CDBED6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E0A8300E3E2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7EA333431;
	Wed, 24 Dec 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d22GcvMT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AtVD1oQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFEE329E5F
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571051; cv=none; b=o5t39v/+7nAKZbQaDNWu3+1URqKLWo10ycHG2URFBg0yv2NEOZZZiQi3D3OCUJFTk8nVZmqSpmr8C+AiFuNA2Y8SIA4Fen6+7DGa/ibhGKIhMrZnuiuFWfFn1/sBeccPKM6UW2c23IDnLvdXEtuD0/KF5zWFw1w5q6mJSVlYico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571051; c=relaxed/simple;
	bh=Xnv/sBrBqHQV+BvV3+s0nYNYKZOsfD25aEwqAwM49rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YI73mQ13ZY/2NtYP9F1g1a9PALUCVro85k2z52lYj8LomGYJo+mRuWA4LH5XytncCRf81e+qk5xm6wmdMkOqk1IvUhwh2SwT4stBNJOb5wH1fZ0FUwf+Ywv2vZMmgSULDHVGWsXL5OWQu2zqcVfRImGSRMXqofl9Kf948TK8WC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d22GcvMT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AtVD1oQn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO6YJqW678258
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 10:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XZ3FDxXMHarmPLEBVnXVNx
	8cfejAj3WmwsVhyYVYA0k=; b=d22GcvMTuW6GfT9ArSoF4tG0CzRXGxnSx86DNH
	qpN/YlIXHkr/1u9GD+8EEDrYdjI0BT2nRMBzL+32iQLHqzhF/z53+H6dpzZOq4M2
	7DfNzczJx+fiDZqE1tlgAUb+JaB/te4jY8d69ZGNHyJhS720MxUokVukXm3kXs3t
	zRmZz7YlqEZUR7g2jDlR6LdKmMYL1yufwIKLGV41nXpTq3lrrdAm61XSqSpWJ9+h
	KD/oMvD8QN0L+48UzpgSSMtzXFzVOk4JP+CwR8Bo/CkP61UCAQn/lW+vXwFrm+4C
	NloC+hKk4EdfjT4CNISwCtzOs3Oio+PmyErRsgzxvr2eWM3Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7yvq2a6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 10:10:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso12874482a91.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766571049; x=1767175849; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ3FDxXMHarmPLEBVnXVNx8cfejAj3WmwsVhyYVYA0k=;
        b=AtVD1oQn8kDALeaXEvJbZZH/9vAMM6tLcYu7iKM3G1OAWc8pPch3JpVrWFL+hGaGgY
         lrLnO5fSRbg1tKkRdyvn7x0UhrWtnbwkjjx8y2kqFxD2NPDPwZaHkC+2VKzjPsm2CL9d
         ZvmgviY0UuxSNhIt6RhwsV1M+SerSBSxxfGLiOmp8GSCEZvAcBiYaw9cz+rwJtx4irib
         OwY/M+uHff+tNzbkWuOxTBz7A6gEkWWcWW8+otmxcP49s7N/J6Y/uTjKdYDwwY2wv8Cp
         9v2exjn7wMvpvAtifKUE0NyXVpHwpfKMMzFefeEswYaUk1Ay7KFyv/7wjSL2/aLUZKKb
         gRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571049; x=1767175849;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ3FDxXMHarmPLEBVnXVNx8cfejAj3WmwsVhyYVYA0k=;
        b=eAqauj0EThf6LkdWKrbe53+cXPbrnHW1fcAj9z4LW4CKi6tHgUYqa5xlDMnqj1L3/0
         PRdFyleXcgrIgLhkmUsI33n3miG1uwCcb5D35YhCL3+TSPLA3dlaFiqsEGC0q9s6f4Fk
         0zHaIn2pqyOkW5/vrqJ99T9DsHr6QC89yis0muEgM2SVSn14WPe+H5r8g2Q7wt3I9A8r
         hxYKmikpu+pYPbFyPFIBXa1eA6er4/sMLR/VIfUTipNMMnc9jiCKwvUIY3rzcFSp41m8
         Kq9//n93yOxsuDBwUDlnDFQUpLkEHCQhIP7bQYwEGICUnp6Mx6SF749bFJNiiVunioKa
         R6Ig==
X-Gm-Message-State: AOJu0YxXYwVDF6tRBpKrsT7oe9JJLuWVhqpb3J86wr7VPs8LDFlS8fXe
	3/frHXPYZGXs6InHY9NQG3jmCl9g77NSTlQuWD+HVFJCy3NDsDdQW0lgikGglNbhrBvJoSUlLYA
	+7BCrhrM9utI7ZH1wTEF8B0MwNrJYes96IlG3TQA6Pxn1AnjGJJt5Vv94qGNpMvY=
X-Gm-Gg: AY/fxX4kqdTnLkCxveq7cJyuQT32U4lk04NamhAWV5yU3pM4MbPiV1LJO1rKWJG4Mfy
	rZPro8XKcA4wkkb8lXcKEzlejqdtTVxbS82i3BelQL6svKqposB6KFtXdt/tsTvmrgjSgWsMb1I
	pzid79YlH9UxD9UObtJwE1O1a77oeJK6TtKbi5zjB3W7L6myz5Hy9UPyhB7YaHMSo3ZXHoliaT5
	ES3N16cFZ4Jw7psYzFoz59DaD6BO89kdRLWV5MtFZqqEHjlICpSYSfY9GbTpnBlKwmzk46BkKX+
	zTc6Hko3cgQdoj4yrMD1iA72n3Jehljnyhn+4ZDuuYayzF8VRAGUvubzPhIMsMSoWKioHyEj5pz
	My9yXMpeMzveyxMKcmIArYE7oaXiGpcmb/g5ZFYsHji6ebLRRZZtln42I
X-Received: by 2002:a05:7022:f307:b0:11d:ef84:6cff with SMTP id a92af1059eb24-12172308947mr17530629c88.37.1766571048423;
        Wed, 24 Dec 2025 02:10:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqAiL4jHSU7/9+MwgxQ3qP3nId9JEayrA1C8JJppmIis0sasuK6f1Hyw36MlCj9gYMjatsdA==
X-Received: by 2002:a05:7022:f307:b0:11d:ef84:6cff with SMTP id a92af1059eb24-12172308947mr17530605c88.37.1766571047809;
        Wed, 24 Dec 2025 02:10:47 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm64523514c88.1.2025.12.24.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:10:47 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 02:10:46 -0800
Subject: [PATCH] PCI: dwc: Remove duplicate
 dw_pcie_ep_hide_ext_capability() function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACW8S2kC/x2NwQqDMBAFf0X23IBJlEJ/pZRlTbb1QashEWsR/
 93Q0zCXmZ2KZmihW7NT1hUF81TFXhoKo0wvNYjVybWut851JutnXpXjl1OAsiYeESu3hYMkGfD
 G8jM+DmL79ireW6qtlPWJ7f+5P47jBBFpZ2p3AAAA
X-Change-ID: 20251224-remove_dw_pcie_ep_hide_ext_capability-3dba1507a331
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766571047; l=4607;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=Xnv/sBrBqHQV+BvV3+s0nYNYKZOsfD25aEwqAwM49rc=;
 b=buJx2QJGgffIcLDxa1NPfng5yROlUFJRA1KD//+D3k35OGdkRjY7fl+/aSQpupAMdmodeo8mk
 XUZ/mNu/OGhD5/2s4OrjIWfRFxaLN8TJIX8z3mhsq7r7326qt3Wd3GU
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: d58GHP1YjMErhUtta29YRpbvvHgB_MZZ
X-Authority-Analysis: v=2.4 cv=abZsXBot c=1 sm=1 tr=0 ts=694bbc29 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Svf4W_lptdzYmPpfBLsA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: d58GHP1YjMErhUtta29YRpbvvHgB_MZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4NyBTYWx0ZWRfXwgoXZl85kRUg
 ODG3ZD/g6xikV4uEde0l6f4jZXddR7N1ep1holTu+Pu286J4PzvdF1/IhMUeZ7XSpUG0XwLOifW
 WDxJ4cZAn6c/9CCwCpjm66Q8Hv/pqMI5edbA/dDMsD685oKLjoeFOkCLHODCd95wYG5rk6sfbQj
 JTcZD2ejlcRrRR5J2l60IMSMzchgw5zX7Ts3iY/wQtkjJf4yLb/rx6AnO44nLw9szV4tCDZZuqR
 02bJfKMNq45wjwKcJYHsYhPQvNlcgtbCmxCEMp39lG4GV7fVeYt7HN0hQb/zpqNfHUNnXmbqG6X
 CFWvql5pDSthBVEJeOqbhRl8CDG4KArykOTEwTXUXgFCFKfa3xeEM5hmWO4UK2hssxYxeM0gbG3
 Pf5xnIf4ST/2nbqz78zoVSudxZAUu0Ttz55Ce8aKoKWhMlE/fXtT9jjnKmz2a/yqnCZoE2ZgmR8
 OJrI9lfa0gQXuQAyWLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240087

Remove dw_pcie_ep_hide_ext_capability() and replace its usage with
dw_pcie_remove_ext_capability(). Both functions serve the same purpose
of hiding PCIe extended capabilities, but dw_pcie_remove_ext_capability()
provides a cleaner API that doesn't require the caller to specify the
previous capability ID.

Compile-tested only. Runtime testing on RK3588 hardware would be
appreciated.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 39 -------------------------
 drivers/pci/controller/dwc/pcie-designware.h    |  7 -----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c   |  4 +--
 3 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19eafbab2fb267f5cda3c24ecdfbd1..cfd59899c7b85fd0dddc9c6ce6b9c9fed84ad7a3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -75,45 +75,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 				 cap, NULL, ep, func_no);
 }
 
-/**
- * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
- * @pci: DWC PCI device
- * @prev_cap: Capability preceding the capability that should be hidden
- * @cap: Capability that should be hidden
- *
- * Return: 0 if success, errno otherwise.
- */
-int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci, u8 prev_cap, u8 cap)
-{
-	u16 prev_cap_offset, cap_offset;
-	u32 prev_cap_header, cap_header;
-
-	prev_cap_offset = dw_pcie_find_ext_capability(pci, prev_cap);
-	if (!prev_cap_offset)
-		return -EINVAL;
-
-	prev_cap_header = dw_pcie_readl_dbi(pci, prev_cap_offset);
-	cap_offset = PCI_EXT_CAP_NEXT(prev_cap_header);
-	cap_header = dw_pcie_readl_dbi(pci, cap_offset);
-
-	/* cap must immediately follow prev_cap. */
-	if (PCI_EXT_CAP_ID(cap_header) != cap)
-		return -EINVAL;
-
-	/* Clear next ptr. */
-	prev_cap_header &= ~GENMASK(31, 20);
-
-	/* Set next ptr to next ptr of cap. */
-	prev_cap_header |= cap_header & GENMASK(31, 20);
-
-	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writel_dbi(pci, prev_cap_offset, prev_cap_header);
-	dw_pcie_dbi_ro_wr_dis(pci);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_hide_ext_capability);
-
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3a81d46e60b00f7cb92d9634eba6708244bce976..c5fff03073ea3945a5c38b1626838c6a67d21c57 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -909,7 +909,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num);
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
-int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci, u8 prev_cap, u8 cap);
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no);
 #else
@@ -967,12 +966,6 @@ static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 }
 
-static inline int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci,
-						 u8 prev_cap, u8 cap)
-{
-	return 0;
-}
-
 static inline struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 352f513ebf0363ff0ec79fdd8d8b245eeb28474c..77c4e6a4ddead91fe12eb6c727e77350207ef5fa 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -347,9 +347,7 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
 	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3588-pcie-ep"))
 		return;
 
-	if (dw_pcie_ep_hide_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI,
-					   PCI_EXT_CAP_ID_ATS))
-		dev_err(dev, "failed to hide ATS capability\n");
+	dw_pcie_remove_ext_capability(pci, PCI_EXT_CAP_ID_ATS);
 }
 
 static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)

---
base-commit: 37781eb814e16c75abb78dec2f9412d2e4d88298
change-id: 20251224-remove_dw_pcie_ep_hide_ext_capability-3dba1507a331

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>


