Return-Path: <linux-pci+bounces-24303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69FA6B397
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 05:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC50119C44BF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9591E834B;
	Fri, 21 Mar 2025 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qRqQepu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2C1E8348;
	Fri, 21 Mar 2025 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529911; cv=none; b=jj0AncpoMdAmvUTy4ZKvPB1iWyL/iQOs4S1jIvs7k3rqysGZnUIAJE6+FB+QOX6ZTO4Wa2r8+SdkUdy0NwNr9LYOWHTrpO3WyTHdzNUgeNnj5qDD7Ivlvw5VNsvGztucmdgsOxuC7lDhTi1hKpFJVLTbvxA1uQRFoUvi1e1dDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529911; c=relaxed/simple;
	bh=8wrzbj5ssYulxdONn+5PAZojqiM++bNYF+2hBtQlB8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDZsinh7LcaetfcJgpNoSdQuhAuqIqyseDabg4SZ/93tDhXDhky3MB7SZ7MohCN4Ewwb6ePZw0OzG3Ky1abCvQa/kKqLwRQKzWkF/WdHJcp/Q4Xf0oKLRkqIFAX5ernfmwfyn4v/G1PqFhZd4bCucNSKknjF2WyYC3bR2F0j4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qRqQepu6; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HzGL2
	1t50mabge27U9hki9qzqcC6EARkMmCFBnRtxd0=; b=qRqQepu6tF/6GbNOY8tRk
	g9Q6iQ3Sc1BMeiEwuSTOyTGW+veAuxs7ee5x7t7CRuZ88DksONokBqNeBATE+GiF
	vvH7TJzxA/Hxvdap2qdIoCAEYX9DzUDI2FmYWIp2u5A/wnD5RVP4+ThiOrnYSVPw
	mNqFOo7V85ppGmAC5ZctLA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Hxsw5dxnbYNpAw--.34788S5;
	Fri, 21 Mar 2025 12:04:04 +0800 (CST)
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
Subject: [v3 3/4] PCI: cadence: Add configuration space capability search API
Date: Fri, 21 Mar 2025 12:03:57 +0800
Message-Id: <20250321040358.360755-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321040358.360755-1-18255117159@163.com>
References: <20250321040358.360755-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hxsw5dxnbYNpAw--.34788S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry7AFy5Cr17ZrWUCr1fCrg_yoW8ur17pF
	yDGFyfC3WrJrW3u3Z3Za45XF13JF9Yk347t39ak34fZF17CryUGF12gFyrtFZxKrZrWr17
	XryDtFykGrn3trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UopBDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUXo2fc32Nz2QAGsF

Add configuration space capability search API using struct cdns_pcie*
pointer.

Signed-off-by: Hans Zhang <18255117159@163.com>
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


