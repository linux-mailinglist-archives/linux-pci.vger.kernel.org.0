Return-Path: <linux-pci+bounces-21055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B526A2E5EA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72DB1886387
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B051BEF91;
	Mon, 10 Feb 2025 07:58:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E91BCA0F;
	Mon, 10 Feb 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174306; cv=none; b=f9eiDDgArA224p3nLqVSDAaKgxTr9y8DccE8K5XW3Eu0Roj7PeUggkFk8ItLwk8BnglVjW4WELpzUs94EFtdHRNLv7y9hj0WPeNVM3Th0/yXKjmgIIFyoXNVY5Vsyyuk0dzG11M+dt7EJ0IAn58ihQXHFU2Xvov8hQ9XjwG7Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174306; c=relaxed/simple;
	bh=sWNOI2uoT7I2pQ45KuU15VwsIF8Tkr6Kp38yOtdv0C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZ6kVaR68i0Qa51LtvypELM0hqHhyQpfTkvZKiNI8zGiWnjJgFW3lCveOWnMSHTtQHoWQ4b43cIw+M91H/yxLaA/kB+HUKd0lhnRoLYCpFzFAkVw2oBfSNn9nhOrD4FOXkGLodzX2AKnE7SkjZEvRibjDu7zWCSgU5yRTTSbH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Feb 2025 16:58:23 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9949C20090C1;
	Mon, 10 Feb 2025 16:58:23 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 16:58:23 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id D56211CDD;
	Mon, 10 Feb 2025 16:58:22 +0900 (JST)
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
	stable@vger.kernel.org
Subject: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey the correct type
Date: Mon, 10 Feb 2025 16:58:10 +0900
Message-Id: <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
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

There are two variables that indicate the interrupt type to be used
in the next test execution, "irq_type" as global and test->irq_type.

The global is referenced from pci_endpoint_test_get_irq() to preserve
the current type for ioctl(PCITEST_GET_IRQTYPE).

The type set in this function isn't reflected in the global "irq_type",
so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
As a result, the wrong type will be displayed in "pcitest" as follows:

    # pcitest -i 0
    SET IRQ TYPE TO LEGACY:         OKAY
    # pcitest -I
    GET IRQ TYPE:           MSI

Fix this issue by propagating the current type to the global "irq_type".

Cc: stable@vger.kernel.org
Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f13fa32ef91a..6a0972e7674f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -829,6 +829,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return ret;
 	}
 
+	irq_type = test->irq_type;
 	return 0;
 }
 
-- 
2.25.1


