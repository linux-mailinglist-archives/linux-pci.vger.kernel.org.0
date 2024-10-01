Return-Path: <linux-pci+bounces-13677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A089F98BA2A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50839B213FF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992C1BE86E;
	Tue,  1 Oct 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jToG2rnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517E1BE844;
	Tue,  1 Oct 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780275; cv=none; b=rn55Aqpzh3IUIyQMNN7uzkdd2pYad4P97Kfz5lF5O9+bJkIEVFq1C+fe57c6KYgJnVY09pgPw7CZvi0/Bu26UXNoS/ei+q6kqdy9hCDrRs9IxnkPvH4U2+X2N5l0jQwCQUMBCURfJJb8SnFcynMyOK0UP7t01VheiTouQvUxZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780275; c=relaxed/simple;
	bh=kX4fvjsFongNoCxNryFoqj8xRI066V4+yt0N+iVFFMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoLaf/weNSpxhtruYqQrxJZH5DOLvUAlMqsW64nKf5yjJejUVxY0VWZoNR3ILg/Q/+b1nj83XodUPr7yjSjjESiHIMXeIhsqiZhoWRVwOUpAQ13f0JPmJl6iNRQ4yd/olAI5TfgTHLxX4PAZaerJ9zC1XR4QDozFl9qUhIgl8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jToG2rnW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3570923a12.1;
        Tue, 01 Oct 2024 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727780273; x=1728385073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XodivF81UWtP2cNwWOGWcI/Uct7qBUohMsaji6ENUY=;
        b=jToG2rnWCSFqzJ0MlJqhXN6Vg/OVFH5q1qn/xh5XYOWAhUUt9YF8TFEz65oGeqZ5W5
         Dho7UwVPnanpap6gEwt/mlm3ZRjZib2nYrDgwnW5wPFfokmSYYBSFWep+uD6wD+l4i+u
         Oeds6ZWdn96wzoGYPO2UpAZ1HlFR8CmiAINlTJWgXy5siL5i8ltWgiHsUDFkcq4AdMPi
         pQGTBLTZtEhgixVKwGgy8NUz5H2sQ9J/sCTAtfsgWq6C06JJAQjE5houGd9OjdE1MYRQ
         91jCGljlChYWwi3KN9K82cSq2TsGrXf7VxfRJtLP49ssTFKWQED1iNzjVdALvjoU7djQ
         aK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780273; x=1728385073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XodivF81UWtP2cNwWOGWcI/Uct7qBUohMsaji6ENUY=;
        b=fPooNu8CrIc5ZHsEW+UmBMLqBWU6SsKeeQEj6hgTAAW426jizuzJJfsOrdJxnDB+Vb
         /UdEOgymPpMYQbEha2L0f3Daopa8p91YSwRFe/PmAVgvL+vm7CGp26zAvXvbEmpIUfjS
         waBxHdGINjgISlx/qm803YjL8mc4xzBm6hMI1BhckBXFOwdDV1MfzwEeWj8LVM5M+TyB
         SBW+zpzXM+Tsdwa1Hm0WJkcT/OhowF0fWkvS/EySq/xQCP/hGU29MEBE5ABK2N2oVsIh
         jMFJGIT1bUTswrWKuFrehDHISZAZ897WDPU8OB7ynA4oQGJDm92jg4jnu3zPAVnnsmo/
         iHHA==
X-Forwarded-Encrypted: i=1; AJvYcCV4wynpvycPVeXz1yQlxYD/3zOog7ZMicfKspzBlkkB/VYvyTMWRXs7qCmCYoJpKHqQKNcqx6O4aT/vNg==@vger.kernel.org, AJvYcCXo/TuZD2llutxwEH7q3alWNPk49USlia45YOcNFMEKIdCSySdl8G8gho+pKfSNfmSUTnQjKrKl9P03@vger.kernel.org, AJvYcCXvWnfPexuMJpDXF2uCImG/ySKfDn8zPZ/eR/e2jtnzCWShkNi//LxB8PKK3FHqZ6AQ9hctkM7on4fjuQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrF5fCmFf+ac8RixNgcD2jkNgtWnhoR+rMYeno6mRlTjzxopg
	R6wuA6/ZK0orLLGWKTVuzQdntKws/TrraOSnSy7zAVZYKqlsAR0H
X-Google-Smtp-Source: AGHT+IGhZN9+wVKG14eYUdsgaPGOEoVAZRpX351sFX9Rh29MejCBf9Qb4pmMk6uv2ceETeAVZBeWUA==
X-Received: by 2002:a05:6a21:1193:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1d4fa6cfd50mr21889572637.29.1727780272943;
        Tue, 01 Oct 2024 03:57:52 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5ed0e9sm8069195a12.57.2024.10.01.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:57:52 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: vigneshr@ti.com,
	s-vadapalli@ti.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: kishon@kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] PCI: dra7xx: Added error handling in probe function when devm_phy_get() fails
Date: Tue,  1 Oct 2024 16:27:18 +0530
Message-ID: <20241001105717.4566-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While creation of device link, if devm_phy_get() function fails then it 
directly returns PTR_ERR without any cleanup of previous added device 
links.

Added goto statement to handle the cleanup of already added device links.

Fixes: 7a4db656a635 (PCI: dra7xx: Create functional dependency between 
PCIe and PHY)
Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
v2: resend when tree is open and reformat commit message

 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4fe3b0cb72ec..c329d107b811 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -762,8 +762,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i]))
-			return PTR_ERR(phy[i]);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
 
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
-- 
2.46.1


