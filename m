Return-Path: <linux-pci+bounces-21053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90542A2E5E4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E2A7A23BF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A51BD014;
	Mon, 10 Feb 2025 07:58:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F141B423C;
	Mon, 10 Feb 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174304; cv=none; b=TJf3fLWakDxQz355MJziC7ZHIjC6EfDgKhN3xg3BqEz/P3BAX8qlgLIj2BzeTpNBk9RZ5xbLSq4CniihRJ0n2suaSwYKP3JNBwnYCblm4Zwa+DA/Gu49uz8KT8/sdMhz9uK4lgVd5MZ3ZEUwGpm1GryUTkYoiNnxR6eY8sKyp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174304; c=relaxed/simple;
	bh=5gIni1hll9AhWRvsZYkRSmFxm66ZAWImR+apzjyut8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrvfS/1ryGNNkaFq2q5wqRECSFekNo/J3FBQjv7TTOi3kgdNnfk0hmCZsXAiY7TOLl4L95Yb9Hm/igrW3NjhUfvd4UmbPyspWYBd8YGQZWXvlBgL4u8lB2KbrFQ4R2BzvId2TVVvNJ23bsA0hWtaN50WTiB+UMRTmoqaPDDYTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Feb 2025 16:58:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E4D422006EA4;
	Mon, 10 Feb 2025 16:58:20 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 16:58:20 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 71A2DC3C1E;
	Mon, 10 Feb 2025 16:58:20 +0900 (JST)
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
Subject: [PATCH v3 0/5] Fix some issues related to an interrupt type in pci_endpoint_test
Date: Mon, 10 Feb 2025 16:58:07 +0900
Message-Id: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series solves some issues about global "irq_type" that is used for
indicating the current type for users.

In addition, avoid an unexpected warning that occur due to interrupts
remaining after displaying an error caused by devm_request_irq().

Patch 1-3 include fixes for stable kernels that have global "irq_type".
Patch 4-5 include improvements for the latest.

Changes since v2:
- Rebase to v6.14-rc1
- Update message to clarify, and add result of call trace (patch 1)
- Add Reviewed-by: lines (patch 2)
- Add new patch to remove global "irq_type" variable (patch 4)
- Add new patch to replace "devm" version of IRQ functions (patch 5)

Changes since v1:
- Divide original patch into two
- Add an error message example
- Add "pcitest" display example
- Add a patch to fix an interrupt remaining issue

Kunihiko Hayashi (5):
  misc: pci_endpoint_test: Avoid issue of interrupts remaining after
    request_irq error
  misc: pci_endpoint_test: Fix disyplaying irq_type after request_irq
    error
  misc: pci_endpoint_test: Fix irq_type to convey the correct type
  misc: pci_endpoint_test: Remove global irq_type
  misc: pci_endpoint_test: Do not use managed irq functions

 drivers/misc/pci_endpoint_test.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.25.1


