Return-Path: <linux-pci+bounces-40674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79338C4524E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075B11882BC1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACA2EA174;
	Mon, 10 Nov 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBM6Tocs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4vqqIUj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5662E92B4
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757989; cv=none; b=QLnKAy/qawJQgOqHEYu7+WC6/3mwCqW2KU5Wq19RJwIOX6EkdZLR6iR5ZLtTOPtQlyYUjO6JdBsixet0dekVFryBlPJ2U8BkCQU+qzJdTkOSZraVr9znhUkQFU1xPgcDR8NWAlJcPMRp51uhCsOnIA1oFKbrDiMIOHLMONUQvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757989; c=relaxed/simple;
	bh=lheq4zqcXF0V+xUrX0TlihExRthP4vhu5nMZ8XNAZMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuR+8OsQ5jQrUUrbFc3zdaTi/50bUbSeCXrwM4rlz86c1NP+8cMHM1r6rj0Rbvm4UUS7J2iJK8QAUyiYjLZJGvfA/k5oFqhhRaGAKBw07Mec4KUUPPqcBPFf8vajHvG83VXnbMRnKHExn3h42kxonlTU/PtN48vOsBO2dGwDYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBM6Tocs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4vqqIUj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9KXREH1576829
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NX+WSRUid0tXKn8v+sqR+bMcouVyO3/EANf4m01nNzw=; b=GBM6TocsCOu2jKfs
	iFsoTdlvuiMf4oJXTMNFyZ/BJGIyxrtzq2EhDv/c3vae19nQiWTZAQvOLvDZIIdF
	+/HHg2qKFU12mSt3/lgzrdLBCYYhIZEqMtyg5v3NncXB/0deiyLUwjHqOdcv21Tf
	Qgyqq3pzuO4PxBAjrOpIuRdMwFj6fTI5PjSuuf+ZAsBWkrtdNsp/mOcx6drhE4EU
	ozxXZPbVx76Tk3LR0dKlMASvmttNMHNUK4mwGHdbjVUni79zaAa5Qa6g2OXJ6Soz
	aHZo4FIYNPCLZZP2953NJ7p/ElxHnmmbMu60oP0E8VYvsDtNTaYf6DmAqKfYLloq
	Y0xWzw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xueknm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so5294761a12.0
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757985; x=1763362785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NX+WSRUid0tXKn8v+sqR+bMcouVyO3/EANf4m01nNzw=;
        b=L4vqqIUjrcGppJTwbwy7CRZNUGgmGVfn0ghGjNdOBYqjmYm5Rx2ZauBajLj9kHaj2x
         vsXZ1ngDU2uzTyadt0sqp1sWrEykc70JbAcJBsiEPhHzw84V9VaGLljukz5/4eRXEhtG
         QX5JKDrglPUZqYs4sz3KkERu/AfnymKC5n3+lRXx9/gjARLohxlXxo0YAVouQlsk8O3F
         +XZ/MwKl7P5d4ehYKCitpS7euW0OaXmJUxtQKe7fhG5S+pHJuYg5yeqjRZ7D35DsgmHa
         5/m8M0qgyN+PhevABWgIF6srQgvfcb1DK8lzbjAXjkNGbPf2p+3Ak4lAV7sOVV1TOb/L
         mATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757985; x=1763362785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NX+WSRUid0tXKn8v+sqR+bMcouVyO3/EANf4m01nNzw=;
        b=OfOi0FUc4pPj1xeJOczoNB8UFXBHV5a5wPfecnF4wZEf3raQcdOzJ8oeLdNJIEvidY
         dNdGA6A+YH6PcUoL5IfHOeFHG8YGdY4fYoKnuqbFzFt+e2hc8+y7oHCwii/j9wHqwSfU
         ms1NyovmZ9kU/kJ3q/Fbqp2s4vtbyQT06ubdsRpMnQjs3loLM9LYNHf8nVSnTiB2joi0
         99z5aDzxpovDsGz7IoltzKOl+e8QJUavJLrJc6kcENFZvm4Odt28ayjmS+vw+b8M9qhO
         vJdMhUBWMuWiUTwdb6x7OfCQZJwp8b7aOTaE9EuvxtigfnpneGNMuC/Vgtn0lvOMXY8R
         RUmw==
X-Gm-Message-State: AOJu0YxIKpO7G9wquB6V9SI33Dgw2L21dCjUJRUz9g8FqMUMlFLxV3w5
	EiCBarBd6ULAdckPJy5eJSjVllqUOlFp0kIjuxr9xp3+b8e03FSftO7XaS871sm8prU5fEUEiQa
	FFy/jUZ6G3p+p9zEcpmKPf+Dy0XgowMnrmKEv/oXuC+qoV5y27F9f0pTxoJMfFC0=
X-Gm-Gg: ASbGncvRzD9/KCvEO18qxqXRbttI2TXTan3uWyxXws/W62jrNzfL+u/yTPkdjKjM+do
	+wL/u2sJGhpQSK63aVzSElDvDHg7gAJG0MLL1dBTjcePkfRIa/Uw0fM09ha60vXVABJHOwvbCUC
	EeG5JzRatSuaxzb7vU6+pZZqukHaGbMPXlHVTi9V2z/Z4wpXKrRhPUDrswthnwRNEluz9A4vFes
	mBtGVLZvfcY/xvYOqQ8keJSyo/lm2ZzCNqFCxEm5rHJxj9//vF7szQoWSzPDtp4Hglt7r2t/fLn
	jDelkeozqiiKUjCVCElj+BU/xk0o82bOhbqAyFvgKCaC4Xe8il5kjHxf0IA6ykFBfPK+ibhYkrk
	M2z00xygoB28z/Fu9dBVK2L+XgLdFmEF6XhW8iqt0rpkiHQ==
X-Received: by 2002:a05:6a20:3d05:b0:341:5e2:d354 with SMTP id adf61e73a8af0-353a2d48208mr9181253637.37.1762757984973;
        Sun, 09 Nov 2025 22:59:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGscuuIxvsDe9jMJBV6hffp7qvCaiqzQ/Q62q0BlcHjegOcn8cHLjlzG/BB+jY/Ms/+Ib4qCg==
X-Received: by 2002:a05:6a20:3d05:b0:341:5e2:d354 with SMTP id adf61e73a8af0-353a2d48208mr9181220637.37.1762757984422;
        Sun, 09 Nov 2025 22:59:44 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:44 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:40 -0800
Subject: [PATCH 1/5] PCI: Add preceding capability position support and
 update drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-1-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=9581;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=lheq4zqcXF0V+xUrX0TlihExRthP4vhu5nMZ8XNAZMg=;
 b=cVUy0eA5OZC/0i0rD7U0TQC5C3uBC8Ga+nIMqzU8VAMhvERqOTQRiC7EYLcbKX6EM1vsOAIID
 mshZgDqp2wFD0ub+NdYUe+8+Cnxok2mBNJrDzXD9AzwsC99mSKT5cFc
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX0silwwe2gU4w
 QX0UuvPDbmKZxLOsggUoQY64dpdQOR4LzOZljHzz7uBfPlMQAfuPHODoAtAPj0ieZQh2Psi7bK/
 r+VQrfD1dEOIFEYXrqhtNEvnmJKbSSOO9twgM2hWBIHFm7+srwJDg75E8jC/XCbKXfFrb7DE2S2
 YqjJF3VZihGPPVfMQCjgxSdhMIgzeRA8L7dm5VqEo4KSIPneNW3qxEC8/KzLd+Ac7/lzU1lTZ/e
 8p3/lalOdk5co1h1jRkG/IPGNQsLSf9GIWW1TD63uBqspm/H3GPWsWAyOgi9SQkgLw53sOpvxJQ
 CwZeOb7k3R/hYtOSoryt6Rnvcb+fA/rZA6QVC54nDhCuFberlljN846mbmisEgog3I33JRwYdgm
 3crVoeUGwfba1AzeLjMeRdkNm0Ufrw==
X-Proofpoint-GUID: 2UqSwn8hXI3rMxXoE3AUoUKVMRl-4tTM
X-Proofpoint-ORIG-GUID: 2UqSwn8hXI3rMxXoE3AUoUKVMRl-4tTM
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69118d62 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ihv9QP4IZydUHuvoN0kA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

Add support for finding the preceding capability position in PCI
capability list by extending the capability finding macros with an
additional parameter. This functionality is essential for modifying PCI
capability list, as it provides the necessary information to update the
"next" pointer of the predecessor capability when removing entries.

Modify two macros to accept a new 'prev_ptr' parameter:
- PCI_FIND_NEXT_CAP - Now accepts 'prev_ptr' parameter for standard
  capabilities
- PCI_FIND_NEXT_EXT_CAP - Now accepts 'prev_ptr' parameter for extended
  capabilities

When a capability is found, these macros:
- Store the position of the preceding capability in *prev_ptr
  (if prev_ptr != NULL)
- Maintain all existing functionality when prev_ptr is NULL

Update current callers to accommodate this API
change:
- Cadence PCIe controller: Pass NULL to cdns_pcie_find_capability() and
  cdns_pcie_find_ext_capability() calls
- DesignWare PCIe controller: Pass NULL to all capability finding macro
  calls

The drivers pass NULL as the prev_ptr parameter since they don't require
knowledge of the preceding capability position for their current
functionality. This ensures backward compatibility while enabling future
capability list manipulation features.

No functional changes to driver behavior result from this patch - it
maintains the existing capability finding functionality while adding the
infrastructure for future capability removal operations.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c   |  4 ++--
 drivers/pci/controller/dwc/pcie-designware-ep.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c    |  6 +++---
 drivers/pci/pci.c                               |  8 ++++----
 drivers/pci/pci.h                               | 23 +++++++++++++++++++----
 5 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index bd683d0fecb225f2134893faa7199d659157b3f1..d614452861f7755108b1220527dc277a3754a76d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -13,13 +13,13 @@
 u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
 {
 	return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
-				 cap, pcie);
+				 cap, NULL, pcie);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_find_capability);
 
 u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
 {
-	return PCI_FIND_NEXT_EXT_CAP(cdns_pcie_read_cfg, 0, cap, pcie);
+	return PCI_FIND_NEXT_EXT_CAP(cdns_pcie_read_cfg, 0, cap, NULL, pcie);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_find_ext_capability);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7f2112c2fb21543d11e848a4a62d529cc3f4e8d0..e62665e228b9035f35c441bffd2a5759ecf12546 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 {
 	return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
-				 cap, ep, func_no);
+				 cap, NULL, ep, func_no);
 }
 
 /**
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f69cbf065e61a0392bf1e5e32cf56e..5585d3ed74316bd218572484f6320019db8d6a10 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -224,13 +224,13 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 {
 	return PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
-				 pci);
+				 NULL, pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 {
-	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, pci);
+	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, NULL, pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
@@ -244,7 +244,7 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 		return 0;
 
 	while ((vsec = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, vsec,
-					     PCI_EXT_CAP_ID_VNDR, pci))) {
+					     PCI_EXT_CAP_ID_VNDR, NULL, pci))) {
 		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
 		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
 			return vsec;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006cca80ec5275e45a35d6dc2b4d0bbc..83e3252f6691f2289ab5cacc3346a37c69a13d59 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -426,7 +426,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
 			      u8 pos, int cap)
 {
-	return PCI_FIND_NEXT_CAP(pci_bus_read_config, pos, cap, bus, devfn);
+	return PCI_FIND_NEXT_CAP(pci_bus_read_config, pos, cap, NULL, bus, devfn);
 }
 
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
@@ -531,7 +531,7 @@ u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
 		return 0;
 
 	return PCI_FIND_NEXT_EXT_CAP(pci_bus_read_config, start, cap,
-				     dev->bus, dev->devfn);
+				     NULL, dev->bus, dev->devfn);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
@@ -600,7 +600,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 		mask = HT_5BIT_CAP_MASK;
 
 	pos = PCI_FIND_NEXT_CAP(pci_bus_read_config, pos,
-				PCI_CAP_ID_HT, dev->bus, dev->devfn);
+				PCI_CAP_ID_HT, NULL, dev->bus, dev->devfn);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
 		if (rc != PCIBIOS_SUCCESSFUL)
@@ -611,7 +611,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 
 		pos = PCI_FIND_NEXT_CAP(pci_bus_read_config,
 					pos + PCI_CAP_LIST_NEXT,
-					PCI_CAP_ID_HT, dev->bus,
+					PCI_CAP_ID_HT, NULL, dev->bus,
 					dev->devfn);
 	}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b5794bd94dfbc20102cb208c3fa2f..2a33356acc2e8cfe55801bcb7d0cd6d2a336561b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -103,17 +103,21 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
  * @read_cfg: Function pointer for reading PCI config space
  * @start: Starting position to begin search
  * @cap: Capability ID to find
+ * @prev_ptr: Pointer to store position of preceding capability (optional)
  * @args: Arguments to pass to read_cfg function
  *
- * Search the capability list in PCI config space to find @cap.
+ * Search the capability list in PCI config space to find @cap. If
+ * found, update *prev_ptr with the position of the preceding capability
+ * (if prev_ptr != NULL)
  * Implements TTL (time-to-live) protection against infinite loops.
  *
  * Return: Position of the capability if found, 0 otherwise.
  */
-#define PCI_FIND_NEXT_CAP(read_cfg, start, cap, args...)		\
+#define PCI_FIND_NEXT_CAP(read_cfg, start, cap, prev_ptr, args...)	\
 ({									\
 	int __ttl = PCI_FIND_CAP_TTL;					\
-	u8 __id, __found_pos = 0;					\
+	u8 __id,  __found_pos = 0;					\
+	u8 __prev_pos = (start);					\
 	u8 __pos = (start);						\
 	u16 __ent;							\
 									\
@@ -132,9 +136,12 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 									\
 		if (__id == (cap)) {					\
 			__found_pos = __pos;				\
+			if (prev_ptr != NULL)				\
+				*(u8 *)prev_ptr = __prev_pos;		\
 			break;						\
 		}							\
 									\
+		__prev_pos = __pos;					\
 		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
 	}								\
 	__found_pos;							\
@@ -146,21 +153,26 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
  * @read_cfg: Function pointer for reading PCI config space
  * @start: Starting position to begin search (0 for initial search)
  * @cap: Extended capability ID to find
+ * @prev_ptr: Pointer to store position of preceding capability (optional)
  * @args: Arguments to pass to read_cfg function
  *
  * Search the extended capability list in PCI config space to find @cap.
+ * If found, update *prev_ptr with the position of the preceding capability
+ * (if prev_ptr != NULL)
  * Implements TTL protection against infinite loops using a calculated
  * maximum search count.
  *
  * Return: Position of the capability if found, 0 otherwise.
  */
-#define PCI_FIND_NEXT_EXT_CAP(read_cfg, start, cap, args...)		\
+#define PCI_FIND_NEXT_EXT_CAP(read_cfg, start, cap, prev_ptr, args...)	\
 ({									\
 	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;			\
 	u16 __found_pos = 0;						\
+	u16 __prev_pos;							\
 	int __ttl, __ret;						\
 	u32 __header;							\
 									\
+	__prev_pos = __pos;						\
 	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;	\
 	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {		\
 		__ret = read_cfg##_dword(args, __pos, &__header);	\
@@ -172,9 +184,12 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 									\
 		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {\
 			__found_pos = __pos;				\
+			if (prev_ptr != NULL)				\
+				*(u16 *)prev_ptr = __prev_pos;		\
 			break;						\
 		}							\
 									\
+		__prev_pos = __pos;					\
 		__pos = PCI_EXT_CAP_NEXT(__header);			\
 	}								\
 	__found_pos;							\

-- 
2.34.1


