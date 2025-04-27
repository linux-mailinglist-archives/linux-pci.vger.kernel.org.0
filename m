Return-Path: <linux-pci+bounces-26865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFFA9E318
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EB5A2A1B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2F154457;
	Sun, 27 Apr 2025 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FP3RFEvR"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3972AEE1;
	Sun, 27 Apr 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758447; cv=none; b=XoAmLsVbBo2Rn3Qa5eRjXD0xpUX5npyPgtE5W2Pr7trZhZeh06DNzPh4kZQL71QbcYQKZZg3CTO+D25ADSDbQp1+68YxXoOlGYf576wdjVG3nqNjgyv6lJjX/bNf8DC7F9sbfLLQwwR5Y3XqMfn+aXILqCYASXTHSvG8dqbEwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758447; c=relaxed/simple;
	bh=GSlbB56K0ESuzYRh6DM1zXQRUOraBVh6Wp+RgeVaZ9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soE9DzIwHzBhga27f6wvht/zEXRNKljELw3yrzKEJAgOPkQ75+U/NqYq9PgUdfLUNFX6EYBdQcKPxEru7lP3YPtYDt6n8qDU2MkrgPoaphxl6RtaFcGu9DEL1j1jzT222wgdowtL53e1UwV9Sl+UfCahf03fCzGRjMULlPKIbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FP3RFEvR; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a4qEw
	fske43/vfxYVnMiAvY6fWKRLGjrP0gzaLq1nD4=; b=FP3RFEvRSxhbARzBfEvlf
	VV5ox97bb+Qk1pM4K86E10rDHHvT21qSGKzb/UvzCR2tF4kd+X31noRgJhvZw35y
	D33ppMi9AGHENYdvMTqodWe/+TIUVwkNFPeYBofk4vFuGmi18xAGdkNNiKyAE/UB
	To7h/tNcLjJ4drwTbth8BQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3LwC9KA5oNqx8Cw--.63816S2;
	Sun, 27 Apr 2025 20:53:19 +0800 (CST)
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
Subject: [PATCH v4 0/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Sun, 27 Apr 2025 20:53:13 +0800
Message-Id: <20250427125316.99627-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3LwC9KA5oNqx8Cw--.63816S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyfXw4kGrWkWw1DCF47XFb_yoW5Gw1fpF
	s8WFZ3Wr47Jw4Fvan7Kw17ZFy8K3ZxCFZ8Zw4DKw1xJ34Yg3W8WFyfKF1F9ry7JrWIgF1I
	vw47X3409FyYya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEwIDUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx88o2gOJqQ3gAAAsc

1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
2. PCI: dw-rockchip: Reorganize register and bitfield definitions
3. PCI: dw-rockchip: Unify link status checks with FIELD_GET

---
Changes for v4:
- According to Mani's suggestion, submit based on the following branches
  and do not rely on others' patches.

  Because of *this* dependency, I couldn't apply this series. I'd suggest
  to respin this series avoiding the above mentioned patch and just rebase
  on top of controller/dw-rockchip branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip

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

- Submissions based on the following patches:
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com/
https://patchwork.kernel.org/project/linux-pci/patch/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
---

Hans Zhang (3):
  PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
  PCI: dw-rockchip: Reorganize register and bitfield definitions
  PCI: dw-rockchip: Unify link status checks with FIELD_GET

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 65 ++++++++++---------
 1 file changed, 36 insertions(+), 29 deletions(-)


base-commit: d4a5d7e6d91f6e53c8bf6ec72b7ee6c51f781695
-- 
2.25.1


