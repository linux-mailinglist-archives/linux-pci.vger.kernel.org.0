Return-Path: <linux-pci+bounces-25299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF179A7C2C0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 19:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AE27A5EF3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620D215040;
	Fri,  4 Apr 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZP/p8dXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E0215060
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788798; cv=none; b=RFJynsZ17rmVabOWpQ5tEZEmhjcC0EW++aZFgNwiFVouZJSqMZCWWz58m3Zh0dIXZ0Heb7DwzKJ2swPxfJtSfjgqWqS7TUrhCKb7vDjIqPukRwWmsJu8hjEpPSszEg12WWbgVnyadWS7Tws4QpEYrCADpfz7KXbVFko1gk0GFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788798; c=relaxed/simple;
	bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VfjtQAnHEQAayfRhBymFicSXfjj3k5GlkRvphLWZFqey4oGDf6270rFvcOkFKHHXPpLBJ5HQPJe/Uzg8fcRUD33NMnEA1A1v3OesOIAR44wYXb30dm527eXnUpMyKST1PDXxrShS6iAyfLbx08KSQX4LplEO4gh+S8HbEve19rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZP/p8dXw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1509224f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2025 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788795; x=1744393595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=ZP/p8dXw58qJXYdRhzm8N6Jb+79SD6nldnsyJ5wM4600xOtsQPalyW6vUM4J/OEaBc
         THc74vAgMrPMznB0emXJID/aQSQJqHFVS1bKXRYVoYYW8sMrTa+mDB/2yEYstgrbgCpi
         R6dWtiWZbQvJzECr7GTFO+OqEX5914DzXg4tQdqQJGTLWrJYd8XzRHFZBegfDE972i9w
         ZIS0yYRyArZXneXT3UtjKK5UQFrCsSw0chmzSE8NLg6oa3ALBEgqjlEQO/K5nmANdZcZ
         V4yalWGyw4TtbcSdV/9+EcsrAFwjMSdI57xOw8c7lD3i3rNLplS9NQhWDfueL2XKZVvl
         EgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788795; x=1744393595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=j/gdOkE3AvIcxQF/T+dwMm/dSbIphQiX9lQxmlUeOlW4Zah0U2OXFpjmsFXE7XZai8
         mg6D0nvE6XdZ5c59LrNAmrl8SFihM5Igz/K1cZbbm+8eemqpITksFDQtDwzFQ23Rhx9r
         6o9igBxmPWaLEnXOpn1cStFfi+h58RFoFDkApGU/2k1mWWKKe4Eny39I7CuvwaLXdJkf
         A+9YT9r5hgNgpf/wuBe/1LAxUxJctMnViErXhDiKqp3SMpCVz5gnwzzEXUI7plGw58xu
         KjEYD8jADjCureJX5yGBHy9ImXM3GeJKWvgey5JQlD2S4fdbzLxCuJcfZGKoF0NOD9mA
         rVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCg5YQBD/g6Gx0JOzukUDmz0c8r9pJRVjdFWA/reYZrVsk4TLKYgwit/gY+O9cKK47E/Jy4z1hhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3PzDoaPKTkyhYKtnBeqC1LpxZxVQ1P/GePlqXeuLmVQybhgz
	Lr5p56YmYC9Q8V+aHoh2ZMJkzwt+H16cBMj6b4gvx1RvL0J9KeMstq6JgpMSH6k=
X-Gm-Gg: ASbGnctzQKKOEmbHTVN5Rwi0Qa44lbe5DjprMB7v3d4fYOH8bSjgQp0DGNtroARRCtn
	PjtywyP9OywIrozRqJoEOovRS/+2f5qHLH1jl3bmQbMPDPZYhfvH989ItPhVlRUFax1US3jUum6
	ePhTGlIhA1+J9SyWedyJUGbP9gyvq7CrBZhbaUE6mdYo+u5Al66OVoyy5mnO0HcwA63aIkSyb3O
	658r1N9Z6LYiu0P1LcahjetAMOT7qJBZq4AaTELByOIJg38hmOgjsiHK2hvkA9jiRr7/YRfkkNY
	Ah23elNImkg+9pkNvHm+Gw6VIaPsm9LCZEU0XE9EUyuRzhsHw2EKTy9VpxV6bFH6Qn3t
X-Google-Smtp-Source: AGHT+IGJK67GjTDKDpj5bH038uXsv6Y5SZCtrTzwfFsjB58QOdWQqxfjOKhYa5MkwP/MU+TWVGqe2w==
X-Received: by 2002:a05:6000:270e:b0:39c:1257:c96c with SMTP id ffacd0b85a97d-39cba93f966mr3020079f8f.56.1743788795236;
        Fri, 04 Apr 2025 10:46:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 04 Apr 2025 19:46:22 +0200
Subject: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pci-ep-size-alignment-v2-3-c3a0db4cfc57@baylibre.com>
References: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
In-Reply-To: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br21+RpEyu7VflBJ+7DQPDTHDsNR/iu152/c
 AfIb7ODPZ2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9gAKCRDm/A8cN/La
 haVOD/94gKh4Rwrb9XZS7wgvtm4xpuUyG+eCwYuUMEyNfOou0meG7+SOlSJhtvZ1NsV6kD7V4HB
 ngGvBJwsU0P8WC5cRU9CLVrc8i3A61jPsLvNnhVrJ77uvSg2C0HRqgHw15xyRsvIZArIb8CU040
 A5JupzLwaZDYkREjQjLEBNqAuUVCwD1MT3sm61cZFKdXJoxqRr67QoUoZ10GzQTv/X28JQL5WeD
 1IAy6A3fkHtphYdtl1vFCY5PDeijD0KzoIycqy3dDl0gFiMFKYCVBCIsOXI8ms25+GlwwlR7jmr
 KmXHh8zMIoCtoVTRXR5zeCq1lqvi/V4m7MFSpW7uC9iaTFfFYEmPDFxK2xDemp8L4++PHROmJ5u
 7CPXSakNhZVd9WGCVQEZkifF5j1ciFeaeBmWbCoBFtVHjzioGu0Ss+9cTluMndT1YxZwhHJF9cr
 oHScr42ldiZkUIDW1DkshspaPEpv3+Y1TSIsPrvN+hztJzk+OcKTp9RlR3Y4X6f2JlAk7gBPUml
 wkrZh30XKCKDfZAQ8DYmIRGV34JTkX7GOPSSsQrfp5SOLZJ7XvcIEqTbdf+kX/GD6lHLtTfiTzN
 ZmBFc5ZcRokYQuO2ciUIO9fsoRZpg+CGU25E0E+08pGb9b45MlAvo8mc3JWcE6ql2TykQ9kl+PZ
 G6+yE31B/oorRXg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c..bc4a9c7c4338db6cc89fa47de89dc704d0a03806 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -413,11 +413,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -427,31 +425,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


