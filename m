Return-Path: <linux-pci+bounces-34127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA8B28F41
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB517B60B3
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F42EB5C7;
	Sat, 16 Aug 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PD4Dx4Xm"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDA2DE6EA;
	Sat, 16 Aug 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359242; cv=none; b=jXH8XPI3WDAVMnh7thYLsr5nrnZ7Ok6b/qQGycqCwNX8kvp8/1WvCxdbDdLHhCiS73RBa7SenTEPDC9jw3ZmXp7vAEG5CV4U9NQkxouzNo9d7//0jZV0mmqzvy0IGqLI6lBQe/dzz0oy/1/WcXOD8f3oe21RLbzD12gnMDdS5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359242; c=relaxed/simple;
	bh=2aukL0kJEli4cIpF9lNeOMmlFomt6T6CHJMbTxc5Efw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acJYPUay+DUJ1AazAev196kg9REi7KVfmz41i3enheAi/P3sLNC0dqX1o9IiJBoUR3Xhc6LYf+3TmeOinh+i53cQlay55wM4sfFqEJRPbkx0K7V+VKSt+8MV4Z8i4dl3viEwriW8oey8+5RKZdMLRkoshSRhPvfTjDImPZOfKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PD4Dx4Xm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=M3
	64n49fvVCUS9f/bM7DYaH6Murcb4YBFOLmmbIlPlI=; b=PD4Dx4XmXlWxxlEOw6
	WTD1TvuyXaEwmSKXKP78sIcH8Qh+mUl0psNAZnAzpUa9LjbbawbxrI/Y1Pxxpc14
	bKW4XNxweYqoo9GA2Gbgin6Namrkk/HWlnZyzfMCDEULLZcFSlHFQwqrmNqaj9q7
	Kdtv0pR+EnELSvMq3QaJI7qmw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHfLfip6BoVzqMBw--.15530S2;
	Sat, 16 Aug 2025 23:46:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 0/3] PCIe: Refactor link speed configuration with unified macro
Date: Sat, 16 Aug 2025 23:46:30 +0800
Message-Id: <20250816154633.338653-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHfLfip6BoVzqMBw--.15530S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxZF4xtr18Jw4rZF4xJFb_yoWDKrcEvF
	y2qFy2kr4UtrZ3ZFyFyr4avry5Aay8GrW3AFy0y3y5JFy2vF4DGr1kZrZrXa48WFsxCa9r
	JFn8Xr1fAwn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM8nYUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQw+ro2igp4IHuQAAsX

This series standardizes PCIe link speed handling across multiple drivers
by introducing a common conversion macro PCIE_SPEED2LNKCTL2_TLS(). The
changes eliminate redundant speed-to-register mappings and simplify code
maintenance:

The refactoring improves code consistency and reduces conditional
branching, while maintaining full backward compatibility with existing
speed settings.

---
Changes for v3:
- Rebase to v6.17-rc1.
- Gentle ping.

Changes for v2:
- s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
- The patch commit message were modified.
---

Hans Zhang (3):
  PCI: Add PCIE_SPEED2LNKCTL2_TLS conversion macro
  PCI: dwc: Simplify link speed configuration with macro
  PCI/bwctrl: Replace legacy speed conversion with shared macro

 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 drivers/pci/pci.h                            |  9 +++++++++
 drivers/pci/pcie/bwctrl.c                    | 19 +------------------
 3 files changed, 13 insertions(+), 33 deletions(-)


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.25.1


