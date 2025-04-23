Return-Path: <linux-pci+bounces-26524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E6A987EA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D66C443C3E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC102268C49;
	Wed, 23 Apr 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VJUCQCIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186517D346;
	Wed, 23 Apr 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405707; cv=none; b=GKVABEb14IOZVdTPxAiwyzqYtSzcdIoTBxE+aT/5XnRRdiq99uL8Gm1VClW8fw0t62PyCvveM6icucZ+K0ybkAbhr+IIYxCi/DT5Rway4J93QPE3gBubG1gAqkuGq70dIiqQmeM6/IkdyiHRRYZqLBzHBvkU8Nm9pL0KvtNEB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405707; c=relaxed/simple;
	bh=LydAg/3DZqJBoy3RvGL9TnEWtAS497xWnCoRb7eMUN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hVGeXT/PgH82KEMa6y7DpoFKTzGqwyrmyFiphYLQJvaGV9ZU08fC6Ckxtctl9iwc4wqqzILAqojB00gTdRZtmUxf5tfiaUEnR/6k5sVRyMUxAiu3zVC9XAzfgGrUkG4YpCloJvFZNkHIi/bjYw9KuZdCfHYt9BDn4UrrjfrcIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VJUCQCIt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8Zmrb
	eq6bLjH06q2d/S498jz0cbVk1UENxMwcMkAn1U=; b=VJUCQCItXqAHYSERxhXjG
	bogofW1u71PDTk9/YcgKwHGZN3XSd8B+zNnzTV9GekBPgDrmFhovExSPKcONQ2Nl
	QKohm02Z8KmKgOAXEf8STgZ/0iA3/pncnoCMSrwEv4xi/SttMnUj/6d/v2MwP7SJ
	DeIDW1gRBnkVAXYPle2cAo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAnRTjYxghozJctBw--.58909S2;
	Wed, 23 Apr 2025 18:54:18 +0800 (CST)
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
Subject: [PATCH v2 0/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Wed, 23 Apr 2025 18:54:12 +0800
Message-Id: <20250423105415.305556-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnRTjYxghozJctBw--.58909S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFykKw4ruF1kZry5tryfCrg_yoW5Jry7p3
	Z8JFZ8ur43Jw40van7tw17XFy8K3ZrCFyY9w4UKw18Xa40qa48WFyftF1rury7XrWxKF17
	ZwsrX3yI9a4av3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE4E_JUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDws4o2gIwTqxqgAAsf

1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
2. PCI: dw-rockchip: Reorganize register and bitfield definitions
3. PCI: dw-rockchip: Unify link status checks with FIELD_GET

---
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


