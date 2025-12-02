Return-Path: <linux-pci+bounces-42484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5BC9BC46
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 519B9347F9C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D13212550;
	Tue,  2 Dec 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/uLkYr3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jlusAH7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89FA322A25
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685393; cv=none; b=TKDFUtaNMJVGNVOuhz+kB8WmCEqak7dM1mThyGMFYlSOvM1CTsqLPaTYwSzZxmFdBW3c23MSwrn1pZWEjsAGrdNVff7WseOBYlPl3pY5AYXXff3dcyr2H/Ui4OqkgaK1naMQ0ssvWOcAL/vmym+AtiDUhXTm2kRZYwDUENJxEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685393; c=relaxed/simple;
	bh=DhqZPv/0aWBnunXhwhTfHEiUQFo6lSXbuazcurYzQjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Snqkbnbl047fRsMPUj3KQrCJkf5Ir0PwPZO8QZ6FymFqw1EbAXWrH5YVUQhUTXY/TA0qCfDVXRI9F6Y1bqaNKw1uzR7qvEeqCyn7g2Eg1ZXkIWhgduzZWoJP/yYTT32/u7dL9CxMwRJCawHIR+AqhsrM6trYtcSUaxhvO7qmvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/uLkYr3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jlusAH7i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2B4Ve03310412
	for <linux-pci@vger.kernel.org>; Tue, 2 Dec 2025 14:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=; b=B/uLkYr32qvdAtOj
	cLnamVoRFfgpYSSOZQLfeqE7fGNRhJKIbr0Jm28gEGmOblFtJNN3Kfe4dhpi0PJ/
	c3fmYiz/NSDj+eyBMnWF/AS5irTXPoYslnTLE5yGZb9Fan8qkEZXkdhQD0Ljlaiq
	8+SN3be3kjRgUU66cY+Mk41xbXAv/c5B24tw/xyZVIu0RNEmxsflGiuNXvuKAJdT
	uLErWHPXm7QrZWiFQMRR/6zmb4WZ7Iwuyt5o4wRSgLhntAXdWQmfgtyJ3+qAus/t
	qi6oLan9JAtVJJpj0ewjXCSbxUvgeS1+jgDbq9x4NiIFU9mBmnA4p5eiiieufBIO
	2dv1NA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxwwghry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso9982535a91.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685389; x=1765290189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=;
        b=jlusAH7ipu+Y3nJOOVc/zovQELX8tEpDVLiGclw5FnPcBGbmiJR50erKgbwpd6ks2Q
         j1lbesfbKwkvE7VLZ4lzVGXz3dCH+LOLd9ZlUQdTm+PAkN9BunaLuBfbeK5ynvE9oWcj
         i6/gmgeO0eLdOo1ELTHBIg/CfnnCcejrzV/JTl2H01Dduj/DxUkeJG/c+cAAe8SPr63n
         RNMoqN6n1NP5jUOrV0iDWZQSX+NTPnwPYx60Caxbn5D7/VrjjAbe64VdZrahTY0IdnRK
         enVU/XZYUPXym0p7pM5SZww2ZQV5mf+4ja1Nhj3w0a7mgNBI3VEjEw3guvAg6dfuED/4
         HghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685389; x=1765290189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DcZ/qO2H5yuWrIIc81AedSaXbGKplExVCuz7hlc7lQ=;
        b=o8HLYqUvmv2Cng3XSoT+DUjP+oRrGFcC1fkO90jZ7ycZyZPesgJ9ySuVOZwFzyrGI4
         SAI7EriQtaXliBGy5ZkwTfUEuErAP6yyH23gmuMSzqBSxSbaKYH8t56XuKvoOPbPfSPC
         YcLnr9Kqu4a3zQMRrsKc4ug7nveT3bUn5QoaSoCPesm5pN+prZljfoPBnoxQmq2Ixkgv
         K6q8TQHSDOP+Ce3f2/06FRw/6fCI7/xCCe83PDZnTgKPWulGFUVg4xnlKcxyx5pFPqm3
         mzUqa+uXFUXM9yuJtfkGhGFeN5zPP5hc2RQGSND+YxHo/zInvKVfMGqurZddalEef5Ww
         MLhg==
X-Gm-Message-State: AOJu0YzK0o37ZFI3u/5AYEQHHBb8lDZlLI/gVZJy92QlV85g37j9v9OG
	DzrtKnL4r9PlrE7cNCX8cZYY+iRFR/kbIP8Qc8+QV7iCsKzACGsIgSZBX6By7BVPoVorWXTgAtc
	5AFSrs8pj2ks+rUGet5HKjbtVbywaVRHN31Yj5UDW5xDGwSQHoUll3u6tDS4Or7U=
X-Gm-Gg: ASbGncuyPX4ym/I8RIxsjrqZy9ujtWTxEme17yiue+gCfSIn9xuptHtVqdxSI/N0rC8
	/clnNJcXzqRpU8+h4sHPyP0ZiGjyFhOJLMr0I22OBG1FIHGlsKg8bPTGqyOexYPGvTktWJgnLRN
	JT8eutZxef/GVvDeR3KfbPED1Q10yNhoPDm3VxVN+Z1T/aoemPpR1QBTAb4UAP6GBqulgBUkkMB
	B5ktcGgj0RZM+s6FggviTrblnRrWwlDM8m5e7aCiT2yRjLrQ0kSp6dkC22l5PdoGF9Aa+Ty3EdK
	8e0YIURKNb8VwEPdYNoQy4YVoPAjLqrgYeZD+cTDcKKfLbIXmCbs77dbs6dT2GFBbEOHK76ww/e
	qwCPNOaMiN59Nqm5QuEB/KEMN5zP1frGoGvDnU6Q=
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr47143838a91.7.1764685388498;
        Tue, 02 Dec 2025 06:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmJreXIxtC7QqwcAohA6pn3gbslnhbRvbp4ehG7lAwm1lgqaC+sUN5cC5F2+qBMdTsdTSDcA==
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr47143796a91.7.1764685388019;
        Tue, 02 Dec 2025 06:23:08 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:49 +0530
Subject: [PATCH v2 2/4] PCI: Cache ACS capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-2-5d2759a71489@oss.qualcomm.com>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=DhqZPv/0aWBnunXhwhTfHEiUQFo6lSXbuazcurYzQjA=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsjU++bwaMOrxteL72S1ui6vDb/luSzu78qTHxz2GSUFF
 jelSR9/0MlozMLAyMUgK6bIkr7UWavR4/SNJRHq02EGsTKBTGHg4hSAiVR/Zv8fzv9IKenA0QAG
 JuHc585XHRbxvQq00wkWc2e7mjmBqWd7qFCF/WHtgsTvvxkiNLaY5noqqjW0XReduIjJ9eK3q2/
 XaPVbJKufUy0su+sTKMb871Z1yplNu0zMwwMC7jIdWakq31zwpuD0Ou+zMdUvpjMrsXT3P+i509
 vmrLlQz+fT7uvuq64vl3nemn+heFJ2UnO4q4ahyJK6vqls2uuu7hMSnJfJ1q3jyRxifqH77vT7Q
 imhpjIPf5WnJGdIL7z6QVIw5Tuj5Oa3+wJncG6926mr9PB3otW7rMwPrJFythkK1lWfOe7sYuiM
 kBRp+mO/OEJtV7zFrO91tU8brrwruFDGb7ddPHHTjZgOAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=JbyxbEKV c=1 sm=1 tr=0 ts=692ef64d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4sYZdrzHdZFwjucz0qEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: fFDrywZmPk2gIpCa3JG315rXB7Cph6dD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX5HEkLIrArmR3
 lK5dGywFBZ6bBXY27xFwjDUbo17zaQJ0xRytnQM5p/xxO/o9hd6kfO5CNlvMJ3kuyaiU1Dd4xQQ
 bMMIKoW7ZNWDM3GeNe0elxUhA6Bwc4KBOUoIcTefu+rYi5GHMLh2azAOJnHiRS3YASZkQn3QFpf
 KXFjbQtAaZGgp05iKw+e7Rbe+oAQ4WAs7iqgoukugA4cZsySDy2o28Ju0PtdrNB6Bqqhaym48sS
 VFFGGyYzE4Y4qB6DoQviebTy/iRsZaz3LEzob6JQoaejJ715SgCtlJ3UbCq9v1TlxQWsQ0K5UiB
 3+KthAXRmt6UNo7lAafo1m6zHs7d3jd0iyXIKtHFR0+rZl75vT/zweXXBagkRKCweFDc3OFefc7
 /Qi/8hP/pnJVDXUtzMK09mlzYENKvw==
X-Proofpoint-GUID: fFDrywZmPk2gIpCa3JG315rXB7Cph6dD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

ACS capabilities are the RO values set by the hardware. Cache them to avoid
reading it all the time when required and also to override any capability
in quirks.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 26 +++++++++++++++-----------
 include/linux/pci.h |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f594fc6dade..4eb5b487c982 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -892,7 +892,6 @@ static const char *disable_acs_redir_param;
 static const char *config_acs_param;
 
 struct pci_acs {
-	u16 cap;
 	u16 ctrl;
 	u16 fw_ctrl;
 };
@@ -995,27 +994,27 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
 	/* Source Validation */
-	caps->ctrl |= (caps->cap & PCI_ACS_SV);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_SV);
 
 	/* P2P Request Redirect */
-	caps->ctrl |= (caps->cap & PCI_ACS_RR);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_RR);
 
 	/* P2P Completion Redirect */
-	caps->ctrl |= (caps->cap & PCI_ACS_CR);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_CR);
 
 	/* Upstream Forwarding */
-	caps->ctrl |= (caps->cap & PCI_ACS_UF);
+	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
-		caps->ctrl |= (caps->cap & PCI_ACS_TB);
+		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-static void pci_enable_acs(struct pci_dev *dev)
+void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -1031,7 +1030,6 @@ static void pci_enable_acs(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
 	caps.fw_ctrl = caps.ctrl;
 
@@ -3543,7 +3541,7 @@ void pci_configure_ari(struct pci_dev *dev)
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
-	u16 cap, ctrl;
+	u16 ctrl;
 
 	pos = pdev->acs_cap;
 	if (!pos)
@@ -3554,8 +3552,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 * or only required if controllable.  Features missing from the
 	 * capability field can therefore be assumed as hard-wired enabled.
 	 */
-	pci_read_config_word(pdev, pos + PCI_ACS_CAP, &cap);
-	acs_flags &= (cap | PCI_ACS_EC);
+	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
 	return (ctrl & acs_flags) == acs_flags;
@@ -3676,7 +3673,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
  */
 void pci_acs_init(struct pci_dev *dev)
 {
+	int pos;
+
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	pos = dev->acs_cap;
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
 }
 
 void pci_rebar_init(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bf97d49c23cf..c6ee1dfdb0fb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -543,6 +543,7 @@ struct pci_dev {
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u16		acs_capabilities; /* ACS Capabilities */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */

-- 
2.48.1


