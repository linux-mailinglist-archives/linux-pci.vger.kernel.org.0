Return-Path: <linux-pci+bounces-29143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB3AD0E61
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9423A3B90
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCF113AD05;
	Sat,  7 Jun 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bd7bhc4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36800184F;
	Sat,  7 Jun 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312310; cv=none; b=U37k1ECCN3VdOZr+mmt2lMHQ8vk9MUjQTUaWN+E42GQj62nTAbIoPunkZswljaspqSR3+gMzEnncS0WoB6e4PenZ82XN3bE1QWXDHyPtbPsjdKIXql5BzyiZ6rs4cszC71PpK6Ry7sC3djBlpnLxCe+XCdsP5XWSOEaB0pBUkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312310; c=relaxed/simple;
	bh=6leJmzYy9qYX+PS1PoEw39SWzakrUethGO16mt5pYaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=entvfs0iBVQ9Xns2shyCQRMvIYe78UoPuvGpmKtHM9Mpqs0eKu2EQ6p0eTvsf0Q8LrBnHEi1ExSUCE34+uZtJEqaqXu3khPnkFsMu3EP7uGkp0jiviJ+mXBLleRzpGZbFlP3mnz+24W8bqij3wCJ/zbqEcQDMowZIc6zvTBV8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bd7bhc4U; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k0
	A/8eOa3/qxuN6ibHKqnIXti28+I3rQhaeeIBTeaok=; b=Bd7bhc4UH4kUYHYnrT
	xuxQYoU8OouzKeeiwGx8rhHFRdD7g1HX+EW0UAnO6tWcDaTrk80HEEpOcv5jl8TC
	WhhoX+arHMFZaav1G7KREzvM1WyFYzcNR3bPYWrHCremOblaqZmYTMdks8q4FwI6
	jL2mQNq2ZPjrJRK65HRbJQ2qM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnzz17X0RoTZo8Gw--.4221S2;
	Sat, 07 Jun 2025 23:49:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	shawn.lin@rock-chips.com,
	heiko@sntech.de
Cc: robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] PCI: Consolidate PCIe message routing definitions and remove driver-specific duplicates
Date: Sat,  7 Jun 2025 23:49:11 +0800
Message-Id: <20250607154913.805027-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnzz17X0RoTZo8Gw--.4221S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7Wr1xuF4fWF1fCF4xtFb_yoWfArcE9F
	y8Xa9FvF1UGryayr4YyrW3JF95Z3yUZrn8Gan5tF45AFyfArn5XF98CrW8XFyrWF4rtF13
	Kr1DZw13CF4xAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZNVkUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhNlo2hEXNoO6QABsj

This series consolidates PCIe message routing definitions into the common
PCI core header, eliminating redundant enums in the Cadence and Rockchip
drivers. By using standardized macros (PCIE_MSG_TYPE_R_* and
PCIE_MSG_CODE_*) from drivers/pci/pci.h, we ensure alignment with the PCIe
r6.0 specification, reduce code duplication, and improve maintainability
across the PCI subsystem.

Hans Zhang (2):
  PCI: cadence: Replace private message routing enums with PCI core
    definitions
  PCI: rockchip: Remove redundant PCIe message routing definitions

 .../pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 20 -------------------
 drivers/pci/controller/pcie-rockchip.h        | 14 -------------
 3 files changed, 1 insertion(+), 35 deletions(-)


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1


