Return-Path: <linux-pci+bounces-20217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6004A189E1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 03:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DB63A4B4E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 02:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA12153BC1;
	Wed, 22 Jan 2025 02:25:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AD414A619;
	Wed, 22 Jan 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512706; cv=none; b=G2151OeXIiTr06gAkWfQjxmyEWfTVTxnW6ZDNeJSsYW28Ozzu9K1nJdx7nD4EIbncgGpNQGIzctipnf/8+g8zUnvj+amwfD3U5i/D9Yv1gNm3YnP+mVdpKLd9Tywuun79yy6Ea+4VRt2jRGAgknfY+Clb7T164+EjBIt1KK+19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512706; c=relaxed/simple;
	bh=zNjjVTNpCe9/02Yg7k2e+F/dI6XDTX/eYAktHa0ZlHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKifPFxgOjb++Er0CEaxDu8kve8IlMdT6XVMtmGsdDCC+RfZZO2YzVdO/osGkdp8Z93I/m4N545vC4Grgl7ctYOvaPnfSIow5vvYi81Ayr3A3jh1abpeyJkmYXHvoUWb9CH8pF5lIQh4gebF9IY0sJ7wiWzZARGnFuezp4fb8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Jan 2025 11:24:56 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 8C1DE2010183;
	Wed, 22 Jan 2025 11:24:56 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Jan 2025 11:24:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id A537C3730;
	Wed, 22 Jan 2025 11:24:55 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=8F=AB=CDski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey the correct type
Date: Wed, 22 Jan 2025 11:24:46 +0900
Message-Id: <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
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
index a342587fc78a..33058630cd50 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -742,6 +742,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
+	irq_type = test->irq_type;
 	return true;
 
 err:
-- 
2.25.1


