Return-Path: <linux-pci+bounces-27871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5923AAB9F07
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3E3506787
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE91AD3E5;
	Fri, 16 May 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YdcG1sYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174E18A93C;
	Fri, 16 May 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407390; cv=none; b=a6zUiYo5AMmYqlWDQRIks2arjvnOoPwY4CR7SP6myczIXl6bgn1gtvZNOW9Kpth9JX6oTQos9IzT5wXvbbStCKcgA0/sYHvDAjDiUoveBQNXaaxcjCJKsHNFTANkmA5FlRF5A0nsGajmBbMrS7Y+bEUjQcfvUnuRjW5b/VYLb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407390; c=relaxed/simple;
	bh=A5qq7VFbRBaVctX2na4XBQL3BPUzd1S7zMgm1THsCOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/6QvlV5RDtS+2+IY7oxMMBRzZ06fmcJERK1HdLep97oBU27VnAXU+mfozPTTGN48Xm9byqTR3Bv6tes/3kvUfVcaCcu0FbG1jfebSUgSZ6K8bHJEU6bEucp6jLJwYBKSNPEwKpfG1Ro4mWUhvABQG0bd3aJD5sL8nwWT0AwoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YdcG1sYn; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=b8
	4+eY2PFKvb5YMPP6BEsx0UZiHjhkA8hcScECvXrLE=; b=YdcG1sYntyrS34MqtB
	lIlMZF4ETqn9yMWe10z3KkidFquUDOdXALlHV43nDg+il/ggbo1b6UjSRc1JTHEd
	Icg4dWCMxzR1w39oqZWRJM0fB1JDYzvqX90ucOPHy16qM6N/pDZbKdbbNNJg9s8H
	pmyBg8IOqyvncKlxJrAMZtajY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXtfDyUSdoaTNOBw--.62835S2;
	Fri, 16 May 2025 22:55:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 0/3] Fix interrupt log message
Date: Fri, 16 May 2025 22:55:41 +0800
Message-Id: <20250516145544.110516-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXtfDyUSdoaTNOBw--.62835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw43JFy8ZryDCw4kJFyrJFb_yoW8GrW7pF
	ZxG3ZIyr4DGr4Fv3Z2ywnYk3W5Xan8Ja1UGr12ga4xX3W2vF10gr9agF18WFy5K395tw1Y
	vrWUtw15Gw4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMc_-UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxFPo2gnTwJd1gAAsv

Dear Maintainers,

Detailed descriptions of interrupts can be seen from RK3399 TRM doc.
I found two errors and cleaned up the driver by the way.

This patch series improves the logging accuracy and code cleanliness of
the Rockchip PCIe host controller driver:

Log Message Clarifications

Patch 1 fixes a misleading debug message for the PCIE_CORE_INT_UCR
interrupt, replacing a duplicated "malformed TLP" message with "Unexpected
Completion" to reflect the actual error condition.

Patch 2 corrects the terminology for non-fatal errors, renaming "no fatal
error" to "non fatal error interrupt received" to align with PCIe interrupt
semantics.

Code Cleanup

Patch 3 removes redundant header includes (e.g., unused clock/reset
headers) to streamline the driver and reduce build dependencies.

These changes enhance debug log reliability, eliminate ambiguity for
developers.

---
Changes for v2:
- Drop patch [v1 3/4].
- The other patches have not been modified.
---

Hans Zhang (3):
  PCI: rockchip-host: Fix "Unexpected Completion" log message
  PCI: rockchip-host: Correct non-fatal error log message
  PCI: rockchip-host: Remove unused header includes

 drivers/pci/controller/pcie-rockchip-host.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)


base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.25.1


