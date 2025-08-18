Return-Path: <linux-pci+bounces-34209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB7FB2ADE5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27F07B18BF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7E32A3F2;
	Mon, 18 Aug 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KHnEZ0ly"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E157308F3B;
	Mon, 18 Aug 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533751; cv=none; b=MaYPAxwKBuwHW4cPdPmTL/m+uMFYCW4x/1tN8F4amNHiUdHbEGjsaJfNbNOFJH3FahMylaZ4AJtigoFew/T6m4KfM0Qgg1QveA7znh4g5fM7U1G2JJkR6lDsDb9/t3LZuPDgf7Eu7aLwOjDCMo7czszdsqdav3Tx8+QcB58ibqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533751; c=relaxed/simple;
	bh=5nWCJ5QCtsBmc7noyT68SATJhsdCzufXpdESYb3gVeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s+KAB+PS9Cc065obWaFIZKNpvkwCeInHkEaOxhM83lIIveoJLdlkzYy+EFs9ai0vo1el9XfiIetL8FDUYzu9XWKN3jcvjSdiX/pqU3jiNUfRMpJj5qvJe0AsXAZpjfmfXV0NKxPKZBdOKBaW5GXZbbfp+DW/R+AHCtsj7XRrsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KHnEZ0ly; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9t
	P1LLYdRr/BqHbJev6RqyxqZPPW7NhIMvgXJosQ1o8=; b=KHnEZ0lyVwzwdPNgVe
	Hyqi1jQNreJC1tNc25uUCxdOXYkUEW0iN6cYN+awwpff7+O0pk/mYlyMro4+r9ak
	2NRIE7ZNLc+KfErfpp6hZcHHxNiadaa4eM3x3kCSXMv9aZXHgwZZeQVG78gr1Z0C
	gNaGTsuyOc8pPqMTwh/RzVb44=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3b8FtUaNopYAWCw--.8667S2;
	Tue, 19 Aug 2025 00:14:38 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 0/2] PCI: Introduce pci_clear/set_config_dword()
Date: Tue, 19 Aug 2025 00:14:29 +0800
Message-Id: <20250818161431.372590-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b8FtUaNopYAWCw--.8667S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3Zr17tFykJFyUCw1fCrg_yoW8XrWUpr
	WfZry3Xr47GFya9FW7WF12ka45Wan7AFWrGr13K34rZr43ZrW7XF9YqryrAF9rJrW8Jw4a
	9rs7WF109w1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjQ6dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhCto2ijSkC+8gACsr

This series introduces auxiliary functions for the PCI configuration space
and simplifies the read and write operations of the AER driver, reducing a
lot of repetitive code.

Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
to reduce repetitive read-modify-write sequences when modifying PCI config
space. These helpers improve code readability and maintainability.

Patch 2 refactors the PCIe AER driver to use these new helpers,
eliminating manual read-modify-write patterns and intermediate variable
in several functions. This results in cleaner and more concise code.

---
Changes for v4:
- Introduce pci_clear/set_config_dword()

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/

- Rebase to v6.17-rc1.
- The patch commit message were modified.
- Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Changes for v2:
- The patch commit message were modified.
- New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
---

Hans Zhang (2):
  PCI: Introduce pci_clear/set_config_dword()
  PCI/AER: Use pci_clear/set_config_dword to simplify code

 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 include/linux/pci.h    | 12 ++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.25.1


