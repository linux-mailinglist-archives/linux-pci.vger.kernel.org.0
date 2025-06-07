Return-Path: <linux-pci+bounces-29141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BAAD0E5B
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544367A66C0
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6AE202F71;
	Sat,  7 Jun 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CPi7pqzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F71F540F;
	Sat,  7 Jun 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312165; cv=none; b=tM4OT0h4tJbG4wSW24KcaCliJdqikB3Rv32ZjtVgBAf7/+kuC2mbLqzHZGVxRbNtmYjk5yepzVdsbmqOOmkN/Ps9C7w7n1ydLWiHW+JMxzKIZqf0+/yUs+sbGhACc3cBjoRrz57/5AMRwRYL2aC7RV4anzL/898McCwIvd3vEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312165; c=relaxed/simple;
	bh=r6gDx6f11bVEjlUv5uJa6UiNPN3q7jZ2fNiTgfwe2D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnLUqoSStIkaCacORnrBAV0pJTfBW8UF0B7WCEG9e3vmQiK5ubQiqf4QN/iSMLSzTUMNAtjhoBHBDiEsLEfG4MNb0iinx9/0qe6uk0idHyIaKvz1xk/9tfUVPFfj+U7nZ95+6nd9PLvo7NU9kQAwSLQ7xE1cLHTIF8XjUWGj60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CPi7pqzN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eo
	Av3IDLdY0ltTR+dHrxsqkIT8E3OgEA8g+uP4y5wzc=; b=CPi7pqzNAmNJauEeUy
	aY0Z52nHnDiOSG8xQV6M0rJfqgiMSf2Aj988kc0YnUaiw5OuZSoscnPtFvDBMnyq
	meNIq3bEirDFo0MFdhcS9WMwyTbSmbI8ygwvsZco2sx2ThTwsV6Y2RC2yTjcsDH5
	mWdH3kkwjyquOcXRlHGkOrKBg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnk_V6YkRoJ9qHGg--.28203S2;
	Sun, 08 Jun 2025 00:02:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	mani@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 0/3] Fix interrupt log message
Date: Sun,  8 Jun 2025 00:01:58 +0800
Message-Id: <20250607160201.807043-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnk_V6YkRoJ9qHGg--.28203S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw43JFy8ZryDCw4kJFyrJFb_yoW8Xry7pF
	9xG3ZFyr4DJr4Sy3WvkwsYk3W5Xan8JFWUGr12qw1fX3WavF10gr9IqF1rWryYgayvq3Wa
	vrWjyw15Gw1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEuc_hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgtlo2hEXNqC1QAAsK

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
Changes for v3:
- Add Reviewed-by: Manivannan Sadhasivam <mani@kernel.org> (Mani's new email address.)

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


base-commit: ec7714e4947909190ffb3041a03311a975350fe0

-- 
2.25.1


