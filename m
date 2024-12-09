Return-Path: <linux-pci+bounces-17920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467A9E9218
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDDE161DA9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA0219EA4;
	Mon,  9 Dec 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fh/kCLCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DB219EBB;
	Mon,  9 Dec 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743417; cv=none; b=VDAA/OpAjD/sSVymRZ/deULYy67hUPsfF6ePyBKPIUxdIbirosKV7cT4atjYVeWjGTQmmWQs6hDGpkNF+Dkz5XS04HdQTeaFn8EMGpY5g82iM3RtbT1u1jXRk2Xch7EWK6k1eJUBmiZiuVfOpyBzTHc6EoAITILqkyReiQresTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743417; c=relaxed/simple;
	bh=9Lt6c2S9LV8YsfIOxcthxk+wBtw8vpUh4lVxP8XzsMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kd4/rtwPRYoZIBtCYpxxXKApPv58j3+1nzr210wgHp907f2dhXe1l+GbeJqrIyGZleTZ2yAkhG6dN5IcunowuQzeSDmBM/gNFVDwXwbrMoaN9D22zOT1xEcuP6TssHg6gsgilvBtA/IM9SIoa/sd+MfbfWWm4iDwvMzM6X2yENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fh/kCLCn; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 687F120008;
	Mon,  9 Dec 2024 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733743408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k3vRqml1KschqrqQ0MliiBVEeoMW5PWCe2FzpUkVNkQ=;
	b=fh/kCLCn8aHeCuI/toH5XuqdwxkFSzlg92oSxTr2IhJT5l8MPjeYF/stySgowTq2k7wSUb
	RHQQNz7CxTBObd6GSD+mSGJ7T/2LsoektcokLDYiWst7oElKJdwxiMm30Gz6rCzBnoPG0z
	/ogUc3as+1GCzY1rxiqLEIAB0TQG8rplTbeGETQSX8eT33FldVrKueCyIzPq+FpvJFVZer
	F72TCA+vd1ddSFCALW7NpxBhPIpwmxaZVBBofT/8FUUijq0uriWBfH2UwFGjuMuqpD7q6f
	mtcxXLwMEb3xMd/t19z2GY/7tAdOLC5LFwnMoXhbJjKaD7U+GogjinWMJyxnCQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: vigneshr@ti.com,
	s-vadapalli@ti.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	theo.lebrun@bootlin.com
Cc: thomas.petazzoni@bootlin.com,
	kwilczynski@kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com,
	u-kumar1@ti.com,
	thomas.richard@bootlin.com
Subject: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check reset_gpio before to use it
Date: Mon,  9 Dec 2024 12:23:21 +0100
Message-Id: <20241209112321.65320-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
not NULL before to use it.

Fixes: c538d40f365b ("PCI: j721e: Add suspend and resume support")
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0341d51d6aed..5bc14dd70811 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -644,7 +644,9 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
 	struct j721e_pcie *pcie = dev_get_drvdata(dev);
 
 	if (pcie->mode == PCI_MODE_RC) {
-		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+		if (pcie->reset_gpio)
+			gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+
 		clk_disable_unprepare(pcie->refclk);
 	}
 
-- 
2.39.5


