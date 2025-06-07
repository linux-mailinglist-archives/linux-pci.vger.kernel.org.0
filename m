Return-Path: <linux-pci+bounces-29136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B632AD0E4F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F5B16AF72
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D981FBC91;
	Sat,  7 Jun 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jZTBHJbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA31E9919;
	Sat,  7 Jun 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311788; cv=none; b=nJnZf+WvnTPyfMch9IkE/JX808zYnSf2U3oOwyXq+MwFZh4W0sk7kMx5CzE6/kZboAmK6fhr+eqXYSQGiygfGuKgn7SZTCPMFcqMiLrQFp+GSkYP+cWVIcdSpBv410133sVoZcdO5gjOpsZMDy7qbz8Jk84r39Y5md56o0Csjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311788; c=relaxed/simple;
	bh=Ib37S/aFr6sspMFSGVSpqLR24+UDtFLykycmt9nVzxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7FECkFjScuY0w+gcdiYd780YMi0jKt1b8tu9pLkK7fXp8pKLx57gRJ8kVa8hL0xLJ/ACENQT/3AIQsr0OKBS3h3oPi3NBO1u4qpsLstzXz8rxmGVSd7S/QbYes+opJ15HMblxgiMU/314BHO54KryjBgLGFmWowTRTQvDyH0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jZTBHJbs; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iY
	FyEf7eoneXqod4Riqo+qvwkbk4yQx6bwHjnCJK1dw=; b=jZTBHJbsg1ml2M6Zrf
	ouTk1WR7eejGuHFhOhYargyvP+5oE7zhJb2QFqrSuyuslfVZeOiPYsFN2LluYb89
	d2dCDUtIqGHks5w8lLU720j2L1HArpZJRBiHfHw2PoBv/+bQoi7kYOroCwdYei+4
	GS9oOUPJD9UBB8see8ov6ntJ4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3dpsKYURonH09Gw--.59622S2;
	Sat, 07 Jun 2025 23:55:54 +0800 (CST)
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
Subject: [PATCH v2 0/3] PCIe: Refactor link speed configuration with unified macro
Date: Sat,  7 Jun 2025 23:55:42 +0800
Message-Id: <20250607155545.806496-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3dpsKYURonH09Gw--.59622S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxZF4xtr18Jw4rZF4xJFb_yoWDAFXEvF
	y7XFy2kr4UtrW3ZFyFyr4avryrAay8Wr4fAF18tw4rtFy2yr4DGr1q9rZrXa4kWFsxGanr
	tFn8ur1rAwn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRusjjPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwxlo2hEXglD+QAAsQ

This series standardizes PCIe link speed handling across multiple drivers
by introducing a common conversion macro PCIE_SPEED2LNKCTL2_TLS(). The
changes eliminate redundant speed-to-register mappings and simplify code
maintenance:

The refactoring improves code consistency and reduces conditional
branching, while maintaining full backward compatibility with existing
speed settings.

---
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


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1


