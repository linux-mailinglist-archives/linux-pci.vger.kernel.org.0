Return-Path: <linux-pci+bounces-39367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37996C0C923
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70618405273
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7DE2FA0DD;
	Mon, 27 Oct 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMV1rXdU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE92F9DA2
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555814; cv=none; b=TU0RD+9DKY98X0ZhCr2PfH7c2UwTGgqGhy1Wdugxvyom0TucyG3NTj/4DAvOEu9nJ9/dKkzhSMqud6snOpSP1j2BM03xilOj3HOa+yBPL7+GkB3GSTBQ7LTmOhB7URhE0E5OFy7qE2bSf6c7Up6sy9Rpoo1/pDpdKJruCtdIQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555814; c=relaxed/simple;
	bh=OvUDbo5pGuUu7qotyzejFUWD0f6M8h+6eVPsJH2aFMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxYfWRtkx1oGLKoCbjp2wNB3OwzAz2yfM9wcNH4/5WIIiA0+wkQawgQDHYg0rifCa49+sXKBB3YclY3tVDjFVwmsc0WsHFWdAdtW1WkZaH8DCNbZz/R0lnja9LlR7WqyFBvSdC/J4ZJBF194H/Hop35w8QJl52D+bZl9/1aQIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMV1rXdU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf25c9ad5so3403197a12.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555812; x=1762160612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoTpyL8LPqpthgwVzy0CiG0xAa+lw5VtWyKYbKOT8QE=;
        b=dMV1rXdUJDSL7ZIEqmUbuTc4SonyFxw7qN50GjxH3wPhCs8Sv8qiPUZ1azC+us72AI
         FOnyGPVBRD1T9VQxK0Z8G971Hrn/Q1NsDXCPLovscO1GEn5/V46aaiBtQJ4lWLYtaaCZ
         adDgsxrjKq6tPoJQoDK6ng6WZYHZgIDfmUK3vcyqKjpRgmd7ra3EUu28jyXTP+GDf5Kh
         IPEMYq2mX2x9XMiPtMuI+Jg94aBUu0ui9LGLtvx2f8FSEPYzWGh5tr9kYlzrbw5TSQdt
         /cizUhs7mo7MLLayxQt8GnyRmEN8l2GfC41DfIezpWurU+yrUTnesMbpf+zYLOMphrv8
         slVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555812; x=1762160612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoTpyL8LPqpthgwVzy0CiG0xAa+lw5VtWyKYbKOT8QE=;
        b=Wc6mtsis8Wqyijbwc3KM9NafLyllrD9KlQx6oyuOcboQP6itKqWH1ahDLDEXYmXuUc
         an7k1ZGK3R34nmiio8o4GK86Vuetkzg1tP3/xar6HgiorJch2Eo9LTMx9bYOcmGr2s4E
         ImYQGLPmanzioF9DAJ/k10rh3AQKM/UucM5Ugn8wUEnnKPIxZdzIYaM5jscYFlLPvOGL
         xD9rVTC+PMk+C5YqkTR2QkMIaa/i9H/M0dt9G1mjoC8G3vljgd4jE+JaUKmjFrX2kT77
         7+ZoF/UyHBjw4gUb+p0k1CbVSBFn+Aq93bA472Vn1UJvnlpch0wARK2jD/7Ve84TsE6B
         ttcw==
X-Forwarded-Encrypted: i=1; AJvYcCWOl1fwww7FK2Isyz+obn4p/N4kHOA3wzZgnE6Y11mc92Vj7rc5UeNdY+YWGWT9Km7pgm3IyQTD0Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfc2obpfme8HReOIx5BcEPJMPWzkSH1s37mg0frMyPZ2lsq/a
	Xv3khgOfMkJy38iNg1QkegSdGhS920CCWbrZbOSLAtcKd5Z9bDIeyuuC
X-Gm-Gg: ASbGncvBZHLXnH/TCGfbMF2ByCXbVbmxmoJyGIf5Nk9d+vF99dmUjGk/5KqEjzWSnpC
	FvaxA6hdKaWiKm8pWjtIpoU2bVpK/YUwf9/3GImoxXjdwhztGX+afOxwqfFSFePbMzfwP+4QntW
	dDzrWxZpy4RlGRP/Xl3HTiEa5ec3Ic+1gDg8grVpcgbERolRdvH4z9f6v+GHKK7VoCQ/kkmOxEQ
	s1ikbI1oEHrz7Rv5aO761fwHAkl2gu+T7SMIwbkXlsEY2MYy64degRAvypkimNBDILugnf563Zo
	P1ppX6eCQSbJn6Sm3poZlVodrZh4PwkvR2O2OSpV9uT4Ds1Pby+oqffDm4Yx/rO2QN3CUW2QFvW
	YG68oVbdI0V9G83ZC0/ZTuJ9N+LJACnvJfOV3DgrvC5lSXnyG5b8GZ887sKS7qGzgLAx3BTrPby
	utSpX++d/ECZSxETlz0NI=
X-Google-Smtp-Source: AGHT+IGXwneCAjsjJPL0hWiNqGqUVbp6EE3p4IZGCMQRdN0SZJ+QzldDOpFCpQQntrr/66rhZtbW2Q==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id d9443c01a7336-290cba4edaemr464679185ad.31.1761555812013;
        Mon, 27 Oct 2025 02:03:32 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and drop local variable
Date: Mon, 27 Oct 2025 14:33:06 +0530
Message-ID: <20251027090310.38999-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027090310.38999-1-linux.amoon@gmail.com>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result of devm_gpiod_get_optional() is now assigned directly
assigned to pcie->reset_gpio. This removes a superfluous local gpiod
variable, improving code readability and compactness. The functionality
remains unchanged, but the code is now more streamlined

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a88b2e52fd78..ecd1b0312400 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -477,7 +477,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc = NULL;
 	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
 	void __iomem *base;
 	u32 num_lanes;
 	u32 mode;
@@ -589,12 +588,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
+		pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(pcie->reset_gpio)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+					    "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
-		pcie->reset_gpio = gpiod;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {
@@ -616,9 +615,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * This shall ensure that the power and the reference clock
 		 * are stable.
 		 */
-		if (gpiod) {
+		if (pcie->reset_gpio) {
 			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(gpiod, 1);
+			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-- 
2.50.1


