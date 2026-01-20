Return-Path: <linux-pci+bounces-45298-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOHyNrjDb2lsMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45298-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:04:40 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC71490D2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B61C7EB4FA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11343CEC3;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWAxiFZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE63D7D6D;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931267; cv=none; b=cUCxY0ZMJ5eGjlHZ49soZ9ipPumEyjilIShjtkg0F8fPb5WdPV/Jb5j7ZUDj5G0fYqcCHBBQfoH4DJbpbpsCdIVRWDDneFsRmQrNbsZ9Q6wR6B6sjNiahzyAVYhXyFFCG5DOjsZR2mWo++xyR6Z0eXnY/RdbKbqIYAjUrW21ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931267; c=relaxed/simple;
	bh=C8nwED4p1cQ2wtMW2HPS1mPsc14tf99b6gRgPOBZGhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCyfMzYbhVQR5CJl7g3Lcnm8NPJUhbXYvsC8BP30wgSVbhqhr6cLAw2S1fRogpnpIN6U2PIPrWXZ5vFrsney2tO7vYKECNrKkpi2qtxNo9bYcYEscp7itrUQQWZyOnDQeme50iKZ061jnVKpKsDPWRk9J1sZImRTLBeKEQZoklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWAxiFZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 856EDC2BCAF;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=C8nwED4p1cQ2wtMW2HPS1mPsc14tf99b6gRgPOBZGhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mWAxiFZv/d/qCj05by6uszliClNF7jzh/NWbTZzKdy1LIv8jcj+qeuSA5K/71adRM
	 xYa/+szlpKcDD6K7ts8C3mO5OqcVUvk/0pzdeglo/WKvCG87vuNVaUqgrhnmkIl1pq
	 pl0kdLqI1a43fpDL1yVuDxpBQ7kCoTlReH3n8+6ExcaFkSPvcLeG3Q5/FFOc7Joo/m
	 IwDQoNmRAcJy0ERbwPeGfUkNfBHjlSuMX9OJFgmQVJ9K+obXS5bvV4wyLh15RESibi
	 RThmudTsN4qdQvy6WrM5nZNqLoVpoZ8kaQ/f0nAplAbCIX728t026Jd0sJ1h+ncmSV
	 5tbWTQKThXO7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8CCCA5FBE;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 20 Jan 2026 23:17:42 +0530
Subject: [PATCH v4 3/5] PCI: dwc: Rename and move ltssm_status_string() to
 pcie-designware.c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pci-dwc-suspend-rework-v4-3-2f32d5082549@oss.qualcomm.com>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>, 
 Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6978;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=YDcMfZz0icBe3ieaYn+20aXeuIU9BKHrj3OGQbzLjOQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpb7/AUlbm0wVqExuah7B3N+NH3EttQxeg403X6
 LHSQaTe/vOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaW+/wAAKCRBVnxHm/pHO
 9WSiB/93jurdvVLnoevl7Xz6tf0SPOFErzpnHYES6i7GZQucbxnreTXd10r980FhFlQg1q/LQVM
 qohFO7vj8n9Pschc9ONITmJkKyuz6WOPtyFH3cRhb2CSZ/f+mHgSmEIQ/98rdiMdSZ1nVpnbz7U
 Txf+nQORthLB1bcFaOd3Lxdp1mhx2/HHus+oXEu6vY2bJYI6Mn6+ud0v+Ci+gJqsGMydi5UAzNE
 HvSV10e+A0ctKwRLpHiFgPBnBfQx8MMnRVyJz6uXUmkK35aX++2DdarDgZCi3jWEsnnMYWyUYQc
 +hTP3PSQEWcfIIavcWOE9UzN1cYQaU9SuTvRccASOZzOPFer
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45298-lists,linux-pci=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,rock-chips.com:email]
X-Rspamd-Queue-Id: 9BC71490D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Rename ltssm_status_string() to dw_pcie_ltssm_status_string() and move it
to the common file pcie-designware.c so that this function could be used
outside of pcie-designware-debugfs.c file.

Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------------
 drivers/pci/controller/dwc/pcie-designware.c       | 52 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h       |  2 +
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index df98fee69892..0d1340c9b364 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -443,65 +443,13 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
 }
 
-static const char *ltssm_status_string(enum dw_pcie_ltssm ltssm)
-{
-	const char *str;
-
-	switch (ltssm) {
-#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
-	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
-	default:
-		str = "DW_PCIE_LTSSM_UNKNOWN";
-		break;
-	}
-
-	return str + strlen("DW_PCIE_LTSSM_");
-}
-
 static int ltssm_status_show(struct seq_file *s, void *v)
 {
 	struct dw_pcie *pci = s->private;
 	enum dw_pcie_ltssm val;
 
 	val = dw_pcie_get_ltssm(pci);
-	seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
+	seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index aca5bbeade03..f74eae79cca4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,6 +692,58 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
+const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
+{
+	const char *str;
+
+	switch (ltssm) {
+#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
+	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
+	default:
+		str = "DW_PCIE_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("DW_PCIE_LTSSM_");
+}
+
 /**
  * dw_pcie_wait_for_link - Wait for the PCIe link to be up
  * @pci: DWC instance
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..c1def4d9cf62 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -828,6 +828,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
 }
 
+const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
+
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);

-- 
2.51.0



