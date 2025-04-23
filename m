Return-Path: <linux-pci+bounces-26557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97052A9936F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B003A5897
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE122BEC20;
	Wed, 23 Apr 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DuAUA07N"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141E298CB5;
	Wed, 23 Apr 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422441; cv=none; b=LKEXKzgMSNbF/edHLbb2R8z/vbL4RxvSrURPWdGAuXjJGKjuUbwtaOnQqsVjBWExRfIIi/FpSYyoNkPg+0avCgbdnc4dnhoDw6Qr2LEGth94MEbq+WtnFtB+3vE3KWqHo0RaY/pb+sgVeFUR4rQuddDXnvbsbNXdhZab87yZQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422441; c=relaxed/simple;
	bh=opnKFTMm+a02TWuFe4RTIDKmUrtlWqmONLUdXLdysMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tM1vLkINO914Fxa9aadLiVtW3FZcRopS9z4UNjS9QLGphJVCPlpW96EJAoQfL01bmtwx8NIAYgO8cLaZ7xNLF7a3UZpItbTuL2yyK1MHn8DNTV+pA3QlTL8g6pJG6bkFO0gGU5Rbf+6OQIzktW7mnMm0RXR14OLKAcLDp8AU8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DuAUA07N; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=T0Bwx
	Q0ZQe3Cgjyln3gV2mBApbISigEbknxbPIiH8GU=; b=DuAUA07NVrrnDCLaBesvX
	foWKFnBcrcmTKtxRiy6XAmMx5jC+TEtLFzvJ0RIr9MG9T9/5OJhu90mg3MOQTjp6
	EollnGNab1HVLWDqKTCYniQKfBNTbu2tv/IQ7U9vEvIkgb/SMaw2z3/HGb27GV1i
	7KATc7Pl++rneBmRW587Ts=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnosAACAlogeYfCA--.9428S2;
	Wed, 23 Apr 2025 23:32:17 +0800 (CST)
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
Subject: [PATCH v3 0/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Wed, 23 Apr 2025 23:32:11 +0800
Message-Id: <20250423153214.16405-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnosAACAlogeYfCA--.9428S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyfWr1rAFWkWF47ZF45GFg_yoW5Jw13p3
	Z8JFZ5ur4fJw40van7Jw17XFy8K3ZrCFWY9w4UKw18Xa40qa48WFyftF1rury7XrWxKF17
	ZwsrX3yI9a1Yy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEQJ5hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgs4o2gJB+UC5AAAsP

1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
2. PCI: dw-rockchip: Reorganize register and bitfield definitions
3. PCI: dw-rockchip: Unify link status checks with FIELD_GET

---
Changes for v3:
- Delete the redundant Spaces in the comments of patch 2/3.

Changes for v2:
- Add register annotations to enhance readability.
- Use macro definitions instead of magic numbers.

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

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 87 +++++++++++--------
 1 file changed, 50 insertions(+), 37 deletions(-)


base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
prerequisite-patch-id: 5d9f110f238212cde763b841f1337d0045d93f5b
prerequisite-patch-id: b63975b89227a41b9b6d701c9130ee342848c8b6
prerequisite-patch-id: 46f02da0db4737b46cd06cd0d25ba69b8d789f90
prerequisite-patch-id: d06e25de3658b73ad85d148728ed3948bfcec731
-- 
2.25.1


