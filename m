Return-Path: <linux-pci+bounces-26945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829CA9F6F2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 19:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FEB17A8C6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140F28E60C;
	Mon, 28 Apr 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nhtfs8GY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021A28BA85;
	Mon, 28 Apr 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860316; cv=none; b=lI1nxZhlMvBs4jJkskWXvMq4xnFb4DzzgKOXYzSYN3aQ/IUIDvnUwbo6LeSai6GouY6VNm5FriKWWcVPYlilrLKVWrfnPJRVjVOT8GI0KRjmqsu6ydfgpAaQJcq7sESapsdY+B+PzjfeovRaUWFzI/SSmi6y0dzXTTkkza/FdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860316; c=relaxed/simple;
	bh=fCsS8SVUonQ+8IdW0IZhO5lmrpWAhj+OAjCTb6i/g/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXpnv0NEvUYMR92pCHoGrC0UJ7PJOC+Fgh4pHU/o1s90JzAYw6D0vspAhoIIe2wDraU1ddYbJlkMJAvNPWbvaI0Gy01hKBMyIOBKKOi4bj3Fj6u+IT9MFX5dfpJaEt2W6z4OubBZeMcTUImgYTKCfvdkgqm2liNwjpHMpKCiFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nhtfs8GY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MJ1Uv
	YoXWhfZap7nd66XJTEzKwW73kWiiLL1y6iU2RM=; b=Nhtfs8GYLVIsgRYxsv26V
	P3TBORYWw1lKtETEDGAHlvzbONVm0X5UiNpfqvTDV55VUIMxEiNN8QMKSoACbjvb
	9XW6MZHn5IN5rR2tFioBMyBH6d42VBkmMo7dbdzCVLmPkCPwOids9bRfX7esuZ4L
	gUPGCSfNmUGcyOqgrIGiRI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCH4haitg9otPCfDA--.1694S2;
	Tue, 29 Apr 2025 01:10:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] Standardize link status check to return bool
Date: Tue, 29 Apr 2025 01:10:24 +0800
Message-Id: <20250428171027.13237-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4haitg9otPCfDA--.1694S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDAFWfZw1xur4rJw4xZwb_yoW8Ww1Dpa
	45tayxAF1rtF4YvF1Yy3WDC34Yq3ZrZF9rK393Wa4fWFyfCFWUXry5GFySqasxtrW0qw17
	KF15t3W7JFs3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieOJUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxw9o2gPr6StEQAAsJ

1. PCI: dwc: Standardize link status check to return bool.
2. PCI: mobiveil: Refactor link status check.
3. PCI: cadence: Simplify j721e link status check.

Hans Zhang (3):
  PCI: dwc: Standardize link status check to return bool.
  PCI: mobiveil: Refactor link status check.
  PCI: cadence: Simplify j721e link status check.

 drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
 drivers/pci/controller/dwc/pci-dra7xx.c                | 2 +-
 drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
 drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
 drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
 drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
 drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
 drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
 drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
 drivers/pci/controller/dwc/pcie-qcom-ep.c              | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom.c                 | 2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
 drivers/pci/controller/dwc/pcie-tegra194.c             | 2 +-
 drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
 drivers/pci/controller/dwc/pcie-visconti.c             | 2 +-
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
 21 files changed, 34 insertions(+), 53 deletions(-)


base-commit: 286ed198b899739862456f451eda884558526a9d
-- 
2.25.1


