Return-Path: <linux-pci+bounces-40040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8949C28288
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41CB3B5DD4
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B8C2571DD;
	Sat,  1 Nov 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WlW5KisV"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4A223DEC;
	Sat,  1 Nov 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014258; cv=none; b=YrdQpDqcN9bLQGxro+AvxDou/stmiEy3dlKENU2Nmvhwo8E2sV1oGfBHJp7QlIeD+dd1KAH+j11V28WPh/2kk4XN7oUDMOiJ1QcNxqJs75l5ZqxT4yGZmm6+NFdetTqP/AJSlu1ONEwG3Kxj+dIKfMqtlAXPB3QMrSaxToCIi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014258; c=relaxed/simple;
	bh=5nWCJ5QCtsBmc7noyT68SATJhsdCzufXpdESYb3gVeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AASs7yUpHBhGJi1euxp5vnpFEsISz7TXeowGQMxsMzjs5/6eA64Nm24/4XhIXnFD/1vnNwXMfdwBWSORHFDW+ke02lfnPE8XG/jid0/pVFMWglAn7lXHzMim+jO+++RuqPHUM2b+2kBvRdnxUXQGuYVJ1CDs6nd7tafHmnz/Pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WlW5KisV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9t
	P1LLYdRr/BqHbJev6RqyxqZPPW7NhIMvgXJosQ1o8=; b=WlW5KisVw+/w/PZOId
	7TL1828mg4ukbv3DgW8Z+zOiugVKyLpRGtWvuPxBCeBL7QNR8S6TuntuNlPfLyH7
	SHhxqrwwL39bcbFt4xGjIa2kqrk8SAqNSDA07MAOzZsjtCO8Gsjedgdbu/CXavXv
	MJqbec2Gcpw7otVWbsp66TbdM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHBDkQNAZpNmGwAw--.59274S2;
	Sun, 02 Nov 2025 00:23:45 +0800 (CST)
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
Subject: [RESEND PATCH v4 0/2] PCI: Introduce pci_clear/set_config_dword()
Date: Sun,  2 Nov 2025 00:22:17 +0800
Message-Id: <20251101162219.12016-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHBDkQNAZpNmGwAw--.59274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3Zr17tFykJFyUCw1fCrg_yoW8XrWUpr
	WfZry3Xr47GFya9FW7WF12ka45Wan7AFWrGr13K34rZr43ZrW7XF9YqryrAF9rJrW8Jw4a
	9rs7WF109w1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRX_-DUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw74o2kGMDUqJQABs+

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


