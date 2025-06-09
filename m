Return-Path: <linux-pci+bounces-29264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2258AD294F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A023AD825
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135422577D;
	Mon,  9 Jun 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DbprGGZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE58225407
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507446; cv=none; b=GXRkYTefnZbgz/5RCC27kbnDWF0Z/QIvjxxujcVxpsKJhHJkspzNpZotYaVZLrFaYGPHps3CrIfN9JkwbQ7An5YLdta5TGj8dheLfL++nk7dkoHjeTeirV4Cqd5IMCodE7Y7Xa9P0NCcI/YkuBbtXH1sNeUh2Bmf9rh7w8WP4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507446; c=relaxed/simple;
	bh=UBflQpbbZ7w3WTTGgjY5gFLz6h4vwKvYcXA9ikEVJt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzXgdO28QGLenNU4NlkLArzqMF9vLxvNzTP02VEqIORoM0VVKSlS1JcZRP4NNbmkqlINvsVqE3HtVuZqGoUPlX5+mmndVy5HDYwTpzRdNSH3egzJJcg7fb3EfVrJhmX4Icq1ElssvV8Fc0EOGSfNgtsY4rEY3sx1Xgp5swEpt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DbprGGZF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e09f57ed4so51918505ad.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749507443; x=1750112243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBUD75Q3AziMcY5PYVnKHBZmS1CbPzVtDbztEvvN+00=;
        b=DbprGGZFISL/kka4ONVfLXKwFsqj6h270ByNe9DW7c7xnkfX9tKnVesB2RJqcRfHtZ
         z9dhlP/IGiYEqbxGC12krmUtk0ykAbQ4WEbqynb7QCdDmf+AfwIeZidj35GlGKx86E2c
         I/A+3iQIVkJ+Fi91HHZeXQr6WTkV6uPHTAMB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507443; x=1750112243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBUD75Q3AziMcY5PYVnKHBZmS1CbPzVtDbztEvvN+00=;
        b=BTjByyxHT6Sr9UA4qxJMzJJKJ0SNDlwpWHDup2+mdniUVPL2WM4x9y408TigOx4J0x
         WPRBdJWVqldJgvdSUp168lX2wmBvBBfA7CJ5JGmHias1obFvBr3Yx5gzp4cddGaGRU+9
         TDIudewOPu2F4bxZNJbOx5DSMpUIrmHjnepStA0VZTNyt+82bzTUuMkIw0r4DTLfsUAs
         VmSwrN48Py+UXXKT/3jqPQHyqNfCW2yCcka69igHqDegPZDE30Xwm0Bps3gh2/CE2sUj
         i9R1eGZjRpWUBPS4Fuds3h5/n0wesTIWk88uiodG23Vppg4pcfCxIcIvPHdSKlqvvLka
         3/Jw==
X-Gm-Message-State: AOJu0YxqxRm/6eAlHsPX/UrsPcygmLDcCGzpG6vuLNstdzIVnh8b3nU4
	rZI/67QfSANQ984Rs1n2+n/K3Ylpf2qqgappS4eZpGXPvSypSz4VMAXpmHd9ogJCtZzkl6PkWhn
	XW+veBmLwJ9pi3vET4uPo0MNx1n7JnlogUWVh3nk2nZ+ssXYvL4FahwOsGmW0E5rJ+5NhFl83fJ
	DRkLDZDqc6OmFcrEluGYmh9TUcjxfjy259CfEUgDJLoKKia/z0wibT
X-Gm-Gg: ASbGncvGJEpnIosBH9HT1gM2hjmIGECm4E6l6C1xEqc/9xldMtYMMku2p8kAhlgqIce
	+oyg5VKkP/gKSmg7icl5VKWfMvxA3aUsd3EQiUGYQEkO+lyqjpi36g3y8o2XxZjXhGK19lfNGGU
	5m8F4aA6rIWLeMzdALPpYLUzGBDVSjs0//XMflFQes9peE4fRlC9C0cexjAD3v7eMpyWD2mvqOM
	sPDURnaoeRDGgh4xSbUfah5cCVGVVWa8N9pCM4VNMNJppg3/WEHi/5jfEJfhc95RuS9JixvRmyk
	Qa8A0xS3E3IML/2kQgEqOm9bupmDBte7SNGsgp6S3ZEs+WH4t+gNoljFgOMGBSwXO5wfL1IdTLK
	K4obROW7nsCnH51zETeT/za2dKTZe/VHQZOxb6CgRuA==
X-Google-Smtp-Source: AGHT+IE1FNMKtiTApYjphNha+o5VVMyg4NsmX0jAuwgOPEaUxUgCBJ815QhGkEUl1A7feIyNVDvKnQ==
X-Received: by 2002:a17:903:2f81:b0:221:751f:cfbe with SMTP id d9443c01a7336-23635c522f7mr16738715ad.19.1749507443428;
        Mon, 09 Jun 2025 15:17:23 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d65sm59290415ad.5.2025.06.09.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:17:23 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] PCI: brcmstb: Refactor indication of SSC status
Date: Mon,  9 Jun 2025 18:17:05 -0400
Message-ID: <20250609221710.10315-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609221710.10315-1-james.quinlan@broadcom.com>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using a bool to track the Spread Spectrum Clocking (SSC), just
use a string constant since that will be the end result anyway.  The
motivation for this change is underscored by a subsequent commit that adds
Cable Modem SoCs to the driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 92887b394eb4..db7872cda960 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1320,8 +1320,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	void __iomem *base = pcie->base;
+	const char *ssc_str = "(!SSC)";
 	u16 nlw, cls, lnksta;
-	bool ssc_good = false;
 	int ret, i;
 
 	/* Limit the generation if specified */
@@ -1357,7 +1357,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
-			ssc_good = true;
+			ssc_str = "(SSC)";
 		else
 			dev_err(dev, "failed attempt to enter ssc mode\n");
 	}
@@ -1366,8 +1366,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
 	nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 	dev_info(dev, "link up, %s x%u %s\n",
-		 pci_speed_string(pcie_link_speed[cls]), nlw,
-		 ssc_good ? "(SSC)" : "(!SSC)");
+		 pci_speed_string(pcie_link_speed[cls]), nlw, ssc_str);
 
 	return 0;
 }
-- 
2.43.0


