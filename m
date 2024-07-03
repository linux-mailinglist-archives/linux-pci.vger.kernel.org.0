Return-Path: <linux-pci+bounces-9712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6709257A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AD9B24CCD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CDE13D2BE;
	Wed,  3 Jul 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ycccfK8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457813959B;
	Wed,  3 Jul 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000863; cv=none; b=pVllRmFppfqeTYnMEL/zSTEq2E3fjJQ6EbxDHJ+2B4md4MPrTy8GDHJ4oL+5ULnRniEKBaNz1OCnmVAKbb8E3NwVP1DO05AKDUGU+HcETPq19IKNkn60rJW1aoFRL6xll7DRuLjtS7eWrdBNcoetPo3t6neJ9YKasV4WF5SW5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000863; c=relaxed/simple;
	bh=5S7OIak8KMX4SPZE1IZ04r7Fyg5HB/5TDqC6p0LLmVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mILpEKRZ1hjnH3HiVJ1ndvBxw4YgsBMI9V7czsHYPEm3EHAbW2rZVJLEj4JPnRCQVr3ODvZ1Xnn2XjdaOXyvUYoy2gVTab0Kk8lqxKOoqP1uM7FqLHYKLUSmt0g8HjZoisIFZsQwnSBbiVTcb1ug3U47sBwHlGikGTIjNctsWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ycccfK8W; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 223F41FA41;
	Wed,  3 Jul 2024 12:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720000858;
	bh=A06Qdd51m/cTgDkR7m4qcv00PEC00drBl2l9uZqt1kc=; h=From:To:Subject;
	b=ycccfK8WO5UKIh9tXba+0pbjvyA9JzBznHVFlq9adOI+JqwZxdg1b522/4bMuenfC
	 yOSTw6mIrDtGzsZiHjAWPDF1mwH1WjP16CucB15dVlPPN83zJvL0FD6P9Z4EweenjU
	 TY/9eUFJOx6IwUicuKlkFaKmhumofd/zQJIN/iVJSBAjZxnLhCP2bhr9Sru17hyhBQ
	 icL2C/LcG8ydWLnsqiZvGeqC5ceD5tJvSlhpDDqL2q4fVIfaeP1YrYX5H7hQwQrLMn
	 HsurcXcL2MhlLEtCvxLsufKgJvnH8aHFiZALavEG5o48e+uekc3+PYe5LTF/QN8a9n
	 7D4A51pofEOHA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] PCI: j721e: Fix PERST# polarity
Date: Wed,  3 Jul 2024 12:00:36 +0200
Message-Id: <20240703100036.17896-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703100036.17896-1-francesco@dolcini.it>
References: <20240703100036.17896-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Now that PERST# is properly defined as active-low in the device tree,
fix the driver to correctly drive the line independently of the implied
polarity.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..4d7e1104de1f 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -503,7 +503,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 		if (IS_ERR(gpiod)) {
 			ret = PTR_ERR(gpiod);
 			if (ret != -EPROBE_DEFER)
@@ -541,7 +541,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 */
 		if (gpiod) {
 			usleep_range(100, 200);
-			gpiod_set_value_cansleep(gpiod, 1);
+			gpiod_set_value_cansleep(gpiod, 0);
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-- 
2.39.2


