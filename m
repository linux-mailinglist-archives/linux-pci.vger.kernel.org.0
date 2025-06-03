Return-Path: <linux-pci+bounces-28881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9732ACCBAC
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2363A70A1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E01DACB1;
	Tue,  3 Jun 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bgh4YTUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800491A3160
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970248; cv=none; b=SMhDJzNkt6tcWC6iyVmmxT4rrda1zbgtuPolZeXgSTq9ITL9stRFm0mZTqOm50J6If9PFQNEbluI1oxCaDroMFdtjlFaAOu9/8Nuu6x8N6M9nLj2pOlhKvWYxtJ9lk3P2m7Mzv5NHObIQRss6RfO3tUtRCpSOBugcRHKPjnvS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970248; c=relaxed/simple;
	bh=o5elYaZvS8wbMI7TEu2FQ0/cKa3utfUsILwG/lu1jg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nej1qqZcrpQNEHC87P+cXjkMRIk582qzuGl/POyaN0HYP0Ta9+h3/s4WMlggLOzWRDrF8xCEF5L4EUomKTg1Z5amsz7tTkrbPevKG4KJ5d2Hz+lwzVMilZ+sTcfF2o6kJiKQxgcjBzhUx8r3fIpA9uq8DZLw37h3o61261673Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bgh4YTUT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf214200so54702925e9.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748970245; x=1749575045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M2rtMrLUp1znoFQ7fmm+p8Omluvozwl8sFwFwa3e+U=;
        b=bgh4YTUTb4Hf6kDx4/Pm/7SNzwr2GD782UfKQ7z/JSVb2v3v5yIYjA2OF94oz1Vd3Z
         bCFxKCUcmIe2sUSVVJAsNswqseWQf8DHMmpNR2SsJI6FnhgHIBloD6memn8RlvuvZknS
         9A8SYKBx2Sgz2W3iWcbZB0UPlKVYcWv5oX8IZS5vPBTqa5JcMJY5MIWk5ZNjq8Ou2lTb
         o7Ff1PKkEzJ29/AQiYn+jUaqdboB6sZvJJEYYijsvEVLXQGOSb2EcT5TZq4447GtzHsV
         XPprBHGhiRa2uRYoH8U20vuwbhIiHrbrz7cIwmPZrOWzMlu8OeVyd20G79m+AAVAwdri
         CZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970245; x=1749575045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M2rtMrLUp1znoFQ7fmm+p8Omluvozwl8sFwFwa3e+U=;
        b=aJAvJxOJicfyacpHLoxVB0r9Gn6a3TpUG7t8fQNfxdl6fQNRmB+6GwAPNW31V09TLQ
         7HehqJlN9beEKi3hwgJ5Uwn4AnGbXZuJobINVjsSF/tU81XAFdd+h4TNvl6MwjMOZNAA
         Qmi7TGMC8fuSAzx1ttBW/GsIF9NKnM+4WNk/z4jmajr3q5tnM7VubfMk3wyS5eoI4L+w
         qYkPBMAUvbKHLdFEjhtPM6G+IHwpSxjF6z0yZLkmK5nDUKvMXrOvl1Id39tuGOBmEvNB
         01xK1PnkDmdj1XBLmRwEoGne+qo8KFIe8NLna74Tom59SxxADw0koyguAtMKcZAu2Sqo
         dSog==
X-Forwarded-Encrypted: i=1; AJvYcCWRtEyKgjp0DNVKuKAI6BZXCacMbuiXs5GJc+AsVasTaStQoFLsXhOO0wx0p9WgeJTfwVZ5fPqRRnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5STNIYEb/EU6mZL3qBN9Y1R0o31DHZOMGTDbBMCDx3eZJa80
	YWVighcv+G23ufz2K5KlwRReqDpfxQYw/bq1p/018vZ+FUX4ayFsuv3rY6Lrb8r2cI4=
X-Gm-Gg: ASbGncsPg4V0+m2gjk6OYGGMTaUlHvH3lKxP1eiB0hhBApnrNSGLaVpe7esyNSAn+KX
	pzkEE1lflWT6INvCygZ+Otll8p0FpAwo1tI/ttsRnG0fbaiB8sJWs+i5BPAg9JzCOShwDnwzgHT
	tO8t0dwDCT5UUj5USerFzoHBVKmVh0ov9Bzbmm9zh/mGUwJSfbvQWyBd01FOM1TC37f8mWCeT9U
	/cIy4jkt7lIdjEbv68IVVfUko8L3jJLJKq49mSipDFWRSo/BeN9T/9EbGXwr5aelHIT/nHA6BFt
	Li7Ae2AKJQMKTdmS+EUkN2FvYkoVn1kQn8A+76Q/N1y7sOOECoVepW8YWun4jj9Fq+RTgyLtzxV
	u
X-Google-Smtp-Source: AGHT+IEoenzqKEQuINiY64yrGWyrdaVaIcGaeVKG2UkL9DTmm9pcDBekWoRxeOOfpXVr7/oDe0au6A==
X-Received: by 2002:a05:600c:a51:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-450d8871448mr182944585e9.31.1748970244569;
        Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ce70:8503:aea6:a8ed])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm19165796f8f.69.2025.06.03.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 03 Jun 2025 19:03:39 +0200
Subject: [PATCH v2 2/3] PCI: endpoint: pci-epf-vntb: Align mw naming with
 config names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-pci-vntb-bar-mapping-v2-2-fc685a22ad28@baylibre.com>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=o5elYaZvS8wbMI7TEu2FQ0/cKa3utfUsILwG/lu1jg0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoPysAmNdY3L3Sx78z2vvbh/WQc4IMEoBC/bPXW
 vk8+PspXkWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaD8rAAAKCRDm/A8cN/La
 hV3NEACTtimKhQfTMZzspVbi0CI9sKwDERzuHOBEmAytqOAZDm1Uqm0X1ykPRJvmL0ig6Dd8ZPB
 k4rNVU/qpXnb9vcNmFPad/DVPVxGZvEpM5s3gw6TkngFr88EfBGXbokRrgb8f+0i2QcgvAc9ZiS
 iiQJprUFLNaS4xIKb0ch/bvs+mL4xK9duMp0d69RJaXFTwKYnsXIqYnETZPE5a1niYAa8qBaKe4
 0+K/k8pfUjrvk5Ui0YFt2+dI1qPwUB0KGo2N5GVqWCCR+eyhs/B8rRJO5qUUZ1iRfB0g5LkRHiC
 Xl5AKisqFutIcv7GSp/r8XCC4sLCc5CUw5jOurQjg+lCavWWA/Lv3ueGCfMGvvxzeeCd5IK1/NM
 WhhVtg0fOE1Gz+uTayQ/cjvmYnYtnbUoWwdzDH0iXdRzEZb+Y3NBkaze12zuL8SL8UC6w2sUDFr
 oRTXZCVBFOvadQ4gngpM9qkHMVAdXLYCQRVKbhDLop7HhAxzj2DxaLg/QbHkvr4IsKC17ywYJrk
 nkDPZ20bLnF4/dCnVhTHzg61vTS7MVx5uiuKehGAQzbsCMHVz4VbWBK6Mw2iV8tWeu0NLwC03aL
 UsLC2aLVVzuZ5ovOo3StWw4n0qP4IMl5ha2fDWPvIVVyUdc2ZAiELx8l3VUBSDSdxZpu28xJeVu
 qTIIajQwq7fR6Tw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The config file related to the memory windows start the numbering of
the MW from 1. The other NTB function does the same, yet the enumeration
defining the BARs of the vNTB function starts numbering the MW from 0.

Both numbering are fine I suppose but mixing the two is a bit confusing.
The configfs file being the interface with userspace, lets keep that stable
and consistently start the numbering of the MW from 1.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..2198282a80a40774047502a37f0288ca396bdb0e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -70,9 +70,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
-	BAR_MW0,
 	BAR_MW1,
 	BAR_MW2,
+	BAR_MW3,
 };
 
 /*
@@ -576,7 +576,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -629,7 +629,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 		pci_epc_clear_bar(ntb->epf->epc,
 				  ntb->epf->func_no,
 				  ntb->epf->vfunc_no,
@@ -676,7 +676,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
 
 	/* These are required BARs which are mandatory for NTB functionality */
-	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
+	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
@@ -1048,7 +1048,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	struct device *dev;
 
 	dev = &ntb->ntb.dev;
-	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
+	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;

-- 
2.47.2


