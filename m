Return-Path: <linux-pci+bounces-21057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5EA2E5EE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B32163FCE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF71C1F23;
	Mon, 10 Feb 2025 07:58:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1C1BEF6F;
	Mon, 10 Feb 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174307; cv=none; b=TiFgD7oBTC4qGLlogSmrHlQ6xhpU79HDQB3jgNIwsNypkaOLDZgjaIBV+q6pCGqPGVh7YVvUalDNKXE+pGL2OzIcYJlaDc7U7AKwcoJxbolgz13sjf/N4aF1gVVmuSiMQLYdE9sBYWLgweDxrxuJSERFsk55xsI4mdNpvNVuaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174307; c=relaxed/simple;
	bh=1/idm9AJ+1pOB6k9pyLer3mBBTzxI9dHzyA4ixoFR/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDw+BXAbAPMM4mE/C+pnGQKkP/JZxZwUf5BWEPrxm+KumoywAiFqteEZAxaWK4C0M7k7taZJUZHz5R4Mfbv1Vne81v8z9XHRbQ2XNVgzE7nU3bNflVIHakNH6hUkX6BBy0Ryd5+DjEWQffBFKHroto99xbr5K7CUn5aDHwNAqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Feb 2025 16:58:24 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6EFBC2006EA4;
	Mon, 10 Feb 2025 16:58:24 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 16:58:24 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 1621C1CDD;
	Mon, 10 Feb 2025 16:58:24 +0900 (JST)
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
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 5/5] misc: pci_endpoint_test: Do not use managed irq functions
Date: Mon, 10 Feb 2025 16:58:12 +0900
Message-Id: <20250210075812.3900646-6-hayashi.kunihiko@socionext.com>
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

The pci_endpoint_test_request_irq() and pci_endpoint_test_release_irq()
are called repeatedly by the users through pci_endpoint_test_set_irq().
So using the managed version of IRQ functions within these functions
has no effect.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8d98cd18634d..9465d2ab259a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -212,10 +212,9 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
 {
 	int i;
 	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
 
 	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
+		free_irq(pci_irq_vector(pdev, i), test);
 
 	test->num_irqs = 0;
 }
@@ -228,9 +227,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	struct device *dev = &pdev->dev;
 
 	for (i = 0; i < test->num_irqs; i++) {
-		ret = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, test->name, test);
+		ret = request_irq(pci_irq_vector(pdev, i),
+				  pci_endpoint_test_irqhandler, IRQF_SHARED,
+				  test->name, test);
 		if (ret)
 			goto fail;
 	}
-- 
2.25.1


