Return-Path: <linux-pci+bounces-26379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4CA9675E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44C2176EF0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374827C156;
	Tue, 22 Apr 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lp8bbt1A"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96D27C860;
	Tue, 22 Apr 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321370; cv=none; b=qSVOcbo3mFeNv9RYAxwkD7xj4Hue16XHe+1/bj/A4tF5kw7XaTXkrOHXIuhxox/mRTqsewtZkrU+Uv/BVE3TqYvx5dmqyMFZRAWeB4xMOVwqkbs/iWYzCzLtXWn2Y4KyvtJGj0GzjU1zk41II2Ci39D7kdRXmRrRCPmB6CsbH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321370; c=relaxed/simple;
	bh=AmnegAGf3G44zAjt+HxnrgnyyFqitKP3Mq6tvhHo/R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpLoTd800tyXfBmqp1N8rs0+eMUcUvpexeWTED/JrLjbYAUbWDrjLFEd0uaiZlGuhDVFDkb7glm76lYPQrCJqeKmg4c36uTx5hwVkkIhalBAONwTrQcurhyblKsGHK8JZPJxkjOntU8tB4B4VUyfKtg+Lwjx+o5PajBrwyVLhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lp8bbt1A; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hk85i
	Y4ymzyKE4GF/XJIv+VOxpEfbG0odDZoakglHzU=; b=lp8bbt1AYA98UYm7u9TfQ
	ynqlrk6uZpn4Yt2QLQDYSlHVGrZWmWmzl4cQGOuoLtfKNfbQafTsg3ExvSVV1SUi
	1qlhPQFeyhWntuZSTOZ23yUHa6DdhBtV67b8lZefbIkAMFxWaEgQZrjBC1Vb2nYz
	USj6gNOPnihzMm/y2DqpjA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXbK1gfQdoRW2NBg--.44191S2;
	Tue, 22 Apr 2025 19:28:33 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Tue, 22 Apr 2025 19:28:27 +0800
Message-Id: <20250422112830.204374-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXbK1gfQdoRW2NBg--.44191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFykKw4ruF18XrW7Xr4kCrg_yoW8Kryxp3
	Z8JFWrur4fJw40vws7tw17ZFy8K3ZrCFyY9w4DKw10qa40qa48WFyftF1F9ry7Xr4xKF17
	ZwsrX34I93Wav3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJPEPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw83o2gHegpLtwADs0

1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
2. PCI: dw-rockchip: Reorganize register and bitfield definitions
3. PCI: dw-rockchip: Unify link status checks with FIELD_GET

---
https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/

Bjorn Helgaas:
These would be material for a separate patch:

- The #defines for register offsets and bits are kind of a mess,
  e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
  PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
  PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
  names, and they're not even defined together.

- Same for PCIE_RDLH_LINK_UP_CHGED, PCIE_LINK_REQ_RST_NOT_INT,
  PCIE_RDLH_LINK_UP_CHGED, which are in PCIE_CLIENT_INTR_STATUS_MISC.

- PCIE_LTSSM_ENABLE_ENHANCE is apparently in PCIE_CLIENT_HOT_RESET_CTRL?
  Sure wouldn't guess that from the names or the order of #defines.

- PCIE_CLIENT_GENERAL_DEBUG isn't used at all.

- Submissions based on the following v5 patches:
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
---

Hans Zhang (3):
  PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
  PCI: dw-rockchip: Reorganize register and bitfield definitions
  PCI: dw-rockchip: Unify link status checks with FIELD_GET

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)


base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
prerequisite-patch-id: 5d9f110f238212cde763b841f1337d0045d93f5b
prerequisite-patch-id: b63975b89227a41b9b6d701c9130ee342848c8b6
prerequisite-patch-id: 46f02da0db4737b46cd06cd0d25ba69b8d789f90
prerequisite-patch-id: d06e25de3658b73ad85d148728ed3948bfcec731
-- 
2.25.1


