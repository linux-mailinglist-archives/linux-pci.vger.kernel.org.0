Return-Path: <linux-pci+bounces-32291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD1B07AC8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993C917F7BE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165F2F546A;
	Wed, 16 Jul 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="anYL3Ya2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C834F263F5F;
	Wed, 16 Jul 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682355; cv=none; b=M2PWagqGCAuYFqEbx9kC2aWUjEqlRcQsPD1sRlv2gMVoHtH5G5cXMHCQHztgsV9ZgGpZOcKb6Oy2WZgr89KPCQmBkWl76rD48nBZPzvzs832/7BDXUXf8lFeqQGHlP5rfjKirbCQp3IqcUMez1KrYSPmfGRSmBTg3DrkohRfLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682355; c=relaxed/simple;
	bh=b3SoGKLeVxEoNXjs8FeqCT0UfXpUtfv5yFWrYc7kX/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGww9A/5L8H19uwZ4oca+NW+9SFYtitxUcwOVaP2I3ATIqbQKhdBj6lBp+wbxRSa9dDPhGuYu/IEJwS9QLxnGjRKfnY6jpWS3xsfhhG57lF/gcdPm+6w4vhEosJICQYZxmVYfpyJQ1mHb6Odds3ZpYIpCJnHOt/gG3tbN9RUDNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=anYL3Ya2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ws
	X/XzDFYl5gZ/hOmtj100DtUZjYraRlhsA9nZOlLWg=; b=anYL3Ya2KwQipXP9AY
	z05KQ94RM5MyhKou7IBvTz7BxZ7tjOO9gSepQQzBZdIZS7Xz/ksXQDzaWNOr0BQ/
	pfBLSGckySTexiRLjdUCMJs4HULIDLq44W1zEO93Fw8KEupNH3hF4G4NMnfi4to7
	nfAsscCGChLndCdH1E0hMsETM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S3;
	Thu, 17 Jul 2025 00:12:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v14 1/7] PCI: Introduce generic bus config read helper function
Date: Thu, 17 Jul 2025 00:11:57 +0800
Message-Id: <20250716161203.83823-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716161203.83823-1-18255117159@163.com>
References: <20250716161203.83823-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8KFW8pF
	W5AF13Cr48JF13JFsYvay8CFy5GFZ7tay7GrWxJ3sxZF43Ca4UAasFgFy5Xr12grWDur1S
	van5GFyUC3Z8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM6wZUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwSMo2h3yP1-BwAAs6

The primary PCI config space accessors are tied to the size of the read
(byte/word/dword). Upcoming refactoring of PCI capability discovery logic
requires passing a config accessor function that must be able to perform
read with different sizes.

Add any size config space read accessor pci_bus_read_config() to allow
giving it as the config space accessor to the upcoming PCI capability
discovery macro.

Reconstructs the PCI function discovery logic to prepare for unified
configuration of access modes. No function changes are intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes since v13:
- None

Changes since v12:
- Optimize the function return values.

Changes since v9 ~ v11:
- None

Changes since v8:
- The new split is patch 1/6.
- The patch commit message were modified.
---
 drivers/pci/access.c | 15 +++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..ba66f55d2524 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,6 +85,21 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val)
+{
+	struct pci_bus *bus = priv;
+
+	if (size == 1)
+		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else if (size == 4)
+		return pci_bus_read_config_dword(bus, devfn, where, val);
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+}
+
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 			    int where, int size, u32 *val)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..e7d31ed56731 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -90,6 +90,8 @@ extern bool pci_early_dump;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val);
 
 /* Functions internal to the PCI core code */
 
-- 
2.25.1


