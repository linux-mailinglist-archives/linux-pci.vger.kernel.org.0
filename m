Return-Path: <linux-pci+bounces-24321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D859A6B899
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC04835EF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0F1EEA42;
	Fri, 21 Mar 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gpJPnueS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5EC1F3FC8;
	Fri, 21 Mar 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552285; cv=none; b=ndel0chjxg2aClRlwrvlcH7ee/HVVzbaEjk5+sae6TpYMB+7sDlwemUsUb9OwXZTNXYngO2cYnI5szWDxJU5DjuOHGjtENyZ7soGNXRuTuPE/jTYQV6DBiYjhUn2HlnFdUaRVy6HhNfczU8ZG6fH/LtCJAkEEzB4Tp+eAhj+dzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552285; c=relaxed/simple;
	bh=Q6GUi4RcRFR3AoExKKpEnwaF7MviZmpRVh9dEitza00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1ELHCPHcFRNJ2rAyv10FpIhaGmdtPmpLyH1IgYSpvlviw0Pr9kMeBwVNRX7kFn29OMPZyUV8GzU+pCUI3K4VJy09zkCRPkO6RxOGaOUWEbWqKVHnB/lmt7Gc2RbpJnVppceGYlJJG5qkSBtIKj/gcnqe8rIfAsO/GMnG9Pnkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gpJPnueS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mMEfx
	Mlq7f9rmltj+hAv8IQtF7oddhheYpeTLYpEfYA=; b=gpJPnueS5hVhzfnVCRFHy
	MA8MmlZB4RvmLVt6M9QvbhcwYCHVPTPHOrOF76CALlfI2H4YVuoqUYnGWQ6nAfUZ
	uzWvwB6iS7EndJuOdkyuj83uPWiQ3XE/FzbFgPwS1nOOSXuigRMc0y5oJ1JLsvOF
	G4y81WLcjh1JZkUUZRfJMc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnKl+oPN1n7W5_AA--.28658S5;
	Fri, 21 Mar 2025 18:17:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v4 3/4] PCI: cadence: Add configuration space capability search API
Date: Fri, 21 Mar 2025 18:17:09 +0800
Message-Id: <20250321101710.371480-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321101710.371480-1-18255117159@163.com>
References: <20250321101710.371480-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnKl+oPN1n7W5_AA--.28658S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry7CrWfKF1xtr15Cw1rJFb_yoW5Jw43pF
	WDCFyfCF1rJrW7uFs3Za1UXF13tF9ay347t39ak34fZF17CF1UGFn2gFy5tFZIkrZFgr1f
	XryDtFykKrn5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UobytUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwUXo2fdN0Oe8AAAse

Add configuration space capability search API using struct cdns_pcie*
pointer.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v2~v3:
https://lore.kernel.org/linux-pci/20250308133903.322216-1-18255117159@163.com/
https://lore.kernel.org/linux-pci/20250321040358.360755-4-18255117159@163.com/

- Introduce generic capability search functions

Changes since v1:
https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com

- Added calling the new API in PCI-Cadence ep.c.
- Add a commit message reason for adding the API.
---
 drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..ea9bfbe76cd6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,31 @@
 
 #include "pcie-cadence.h"
 
+static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
+{
+	struct cdns_pcie *pcie = priv;
+	u32 val;
+
+	if (size == 4)
+		val = readl(pcie->reg_base + where);
+	else if (size == 2)
+		val = readw(pcie->reg_base + where);
+	else if (size == 1)
+		val = readb(pcie->reg_base + where);
+
+	return val;
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_generic_find_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_generic_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..6f4981fccb94 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1


