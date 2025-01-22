Return-Path: <linux-pci+bounces-20215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7815A189DB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 03:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A777A3A5515
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F7149E17;
	Wed, 22 Jan 2025 02:25:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61426145324;
	Wed, 22 Jan 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512704; cv=none; b=agQBrobSBri3LxFI/7kZMYmwHK31tmhASQwKHwH6oJzW+ViYm3FuHTqY1JCTCeE+X3c+IkIyXO3cC4Ncu8ZnLCQ1ZcqGDqiwSfkS5sGR9RllRKYJbVnlk7lduxJhPFPFR3F0/fYoB3UyTmBzdfUUSIQJblwrR2KazZxjQBGUfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512704; c=relaxed/simple;
	bh=/6U8WaefUiYDBAPIWBEtvBPVshgWitlCi0YZkJbyDCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAGyZl+3RtmxJPEH1ooZR7Umvx0w+oJmWs+unVB98mDnxlLRrh+mDBpg/s+Pk8drXvDYtwNn/wWWFg/tKAwt+YsITMUnmxggWlvhkRiL+oM/EcUo1lBIf7JoV48PRN5ToaFV/maL643isTT0aVMCt/+mei3BUHvOoJ/Zzn3l6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Jan 2025 11:24:54 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 0E2D12009097;
	Wed, 22 Jan 2025 11:24:54 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Jan 2025 11:24:54 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id E42363732;
	Wed, 22 Jan 2025 11:24:52 +0900 (JST)
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
Subject: [PATCH v2 1/3] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Wed, 22 Jan 2025 11:24:44 +0900
Message-Id: <20250122022446.2898248-2-hayashi.kunihiko@socionext.com>
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

After devm_request_irq() fails with error,
pci_endpoint_test_free_irq_vectors() is called to free allocated vectors
with pci_free_irq_vectors().

However some requested IRQs are still allocated, so there are still
/proc/irq/* entries remaining and we encounters WARN() with the following
message:

    remove_proc_entry: removing non-empty directory 'irq/30', leaking at
    least 'pci-endpoint-test.0'
    WARNING: CPU: 0 PID: 80 at fs/proc/generic.c:717 remove_proc_entry
    +0x190/0x19c

To solve this issue, set the number of remaining IRQs and release the IRQs
in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3702dcc89ab7..302955c20979 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -252,6 +252,9 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return false;
 }
 
-- 
2.25.1


