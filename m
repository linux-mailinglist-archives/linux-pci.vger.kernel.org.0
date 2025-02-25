Return-Path: <linux-pci+bounces-22320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13634A43CF3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1443BDEFA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701026B2C5;
	Tue, 25 Feb 2025 11:03:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDB26AAB9;
	Tue, 25 Feb 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481391; cv=none; b=smfu8LWH8khOc8Wve/al3KIjbN+yZb1zQCjS1zqlcQ2u2FYKP/MINbm70MVUkFc0cwcyzCOtsHASDd2+09dZIn3ozYhUfsmSJfe54+CKHLurTiDtYFx+ITCLWoToe+KZN8irKabAAELXMgSZcIlMK+Mw8DitWHMFAtbekYdMcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481391; c=relaxed/simple;
	bh=5nejIMLJ8y/qOjJkfWJrFYsps54a6ZHcVBkaxfaA7To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijDDGjHcT5K8qlKKc4OXFOshO1+F3V0vy2rhrRn2s9SiLfNXTTudZd8cioRHlwzIaMvWQ1kCUH+v/ZHHUprYEsZSGThbViVMA2Zl64vcYdAB8GBearWWCbARxQ08Q3ihad0JM5NkIs/sIRxgHME6evurSZiuMqONt9Wv06PVVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:03:00 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 70AAF20090C2;
	Tue, 25 Feb 2025 20:03:00 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:03:00 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id D59663730;
	Tue, 25 Feb 2025 20:02:59 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Krzysztof Wilczynski" <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/6] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Tue, 25 Feb 2025 20:02:48 +0900
Message-Id: <20250225110252.28866-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After devm_request_irq() fails with error in
pci_endpoint_test_request_irq(), pci_endpoint_test_free_irq_vectors() is
called assuming that all IRQs have been released.

However some requested IRQs remain unreleased, so there are still
/proc/irq/* entries remaining and this results in WARN() with the following
message:

    remove_proc_entry: removing non-empty directory 'irq/30', leaking at
    least 'pci-endpoint-test.0'
    WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry
    +0x190/0x19c

To solve this issue, set the number of remaining IRQs to test->num_irqs
and release IRQs in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a3d2caa7a6bb..9e56d200d2f0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -259,6 +259,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return ret;
 }
 
-- 
2.25.1


