Return-Path: <linux-pci+bounces-21056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF2CA2E5EC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5ED3A765D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E21C07D9;
	Mon, 10 Feb 2025 07:58:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763B1BD4E4;
	Mon, 10 Feb 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174306; cv=none; b=IPi9HLYqZ+rkT3tnU+DlPwIWe82EuE8uj9VWVbuMaTwajaWZyUQDzHGrYW6QRN32tA0e6FMIxXIdHEkScSGGnZifCce6tvNldcu4s7z27EX77suV98lc3d6F+T8cK0hMu/zyP2h5fEFYi3EzrPucbsRS9DceQmtP4ImsbmGeLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174306; c=relaxed/simple;
	bh=ntdFh32/lfRw2nQvhlkL6tVguSwGZ4bh/tTdhq8w+N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2ggn+XyY6yOtG5Y0GML6JDPOrOCqcnwCY01DCDaRWUDqHtF8p8XJqxpcrCwk4zNJzgrMe1V44hahYf4ndlsVmcwcIEMEhIVtm2C+4/cbSh/cFYdMf7/ghGYh6N9kKSpv2QQeJZhXja+FQi642kV/8Tf8Cg6QwCmUR3QVkcssLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Feb 2025 16:58:24 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 209312006EA4;
	Mon, 10 Feb 2025 16:58:24 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 16:58:24 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 717281CDD;
	Mon, 10 Feb 2025 16:58:23 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski  <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 4/5] misc: pci_endpoint_test: Remove global irq_type
Date: Mon, 10 Feb 2025 16:58:11 +0900
Message-Id: <20250210075812.3900646-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "irq_type" preserves the current value of
ioctl(GET_IRQTYPE), however, it's enough to use test->irq_type.
Remove the variable, and replace with test->irq_type.

The ioctl(GET_IRQTYPE) returns an error if test->irq_type has
IRQ_TYPE_UNDEFINED.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 6a0972e7674f..8d98cd18634d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -100,10 +100,6 @@ static bool no_msi;
 module_param(no_msi, bool, 0444);
 MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
 
-static int irq_type = IRQ_TYPE_MSI;
-module_param(irq_type, int, 0444);
-MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
-
 enum pci_barno {
 	BAR_0,
 	BAR_1,
@@ -829,7 +825,6 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return ret;
 	}
 
-	irq_type = test->irq_type;
 	return 0;
 }
 
@@ -878,7 +873,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_endpoint_test_set_irq(test, arg);
 		break;
 	case PCITEST_GET_IRQTYPE:
-		ret = irq_type;
+		ret = test->irq_type;
 		break;
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
@@ -936,14 +931,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 
 	if (no_msi)
-		irq_type = IRQ_TYPE_INTX;
+		test->irq_type = IRQ_TYPE_INTX;
 
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
-		irq_type = data->irq_type;
+		test->irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -965,7 +960,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
+	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
 	if (ret)
 		goto err_disable_irq;
 
-- 
2.25.1


