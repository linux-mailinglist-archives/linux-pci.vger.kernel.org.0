Return-Path: <linux-pci+bounces-8564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D464902C9C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 01:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA74CB21A41
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4815219B;
	Mon, 10 Jun 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UOUm2buN"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071C3BB48
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063457; cv=none; b=MMPYg6nrMvEm7zsqRSYADLM2SoqRz9Q1ONO53jX3xe87gipsNdFHmHYWjc/Ku23jAkuUMinQc1L79U5bbcg2VPeS+OFaOZacsGupb11LBFXflLbr8XhDxw7WEJLhrMecqoO7TF+lLBJLLHaZUA3ISehTszvUicABGnItsKygWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063457; c=relaxed/simple;
	bh=nrjUvpe5pwAWsxMZEu1RWz+m+u2/UwlLeoZ3e0BYER0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qwWcGcw+X03ynuQUvc7MtztBM2qKEpei2ftgt5+w6nwpQIQABoWBgp6Behq6W40ahoZSW/jnCVjXk0zwsp6uA44J2g0z5h1uyiE2qn0vWVpgKU8T2CiIT3PHuHQ+HA87jJ3syWM2w0xYxJQiiyby44GytqxKsItgZ7WgJS/gaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UOUm2buN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.vs.shawcable.net (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7CBF220B915A;
	Mon, 10 Jun 2024 16:50:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CBF220B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718063455;
	bh=eFQNQDKwL9CouxWbZRZolUW0Yc83+U04HNLrlNKAYyE=;
	h=From:To:Cc:Subject:Date:From;
	b=UOUm2buNzCin56FzjGTdQ+DfCkr9HQ7aEF+fOTLIXisb+ujSJ3OCa57fTxEF5fBwk
	 L7BpwBGGSkXdOx9DyBiPNCepH1T/Mf4GVzn8geF/ZIPGAQAXVoMJ+3J1BmenBdHpJJ
	 0fhEUjzTXytWqQsSMO2+NtOsOjAc1eJo6Skwp0bw=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: jingoohan1@gmail.com
Cc: Sergey.Semin@baikalelectronics.ru,
	fancer.lancer@gmail.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	code@tyhicks.com,
	apais@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	okaya@kernel.org,
	shyamsaini@linux.microsoft.com,
	srivatsa@csail.mit.edu,
	tballasi@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Date: Mon, 10 Jun 2024 16:50:48 -0700
Message-Id: <20240610235048.319266-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change, the dwc PCIe driver configures only 1 ATU region,
which is sufficient for the devices with PCIe memory <= 4GB. However,
the driver probe fails when device uses more than 4GB of pcie memory.

Fix this by configuring multiple ATU regions for the devices which
use more than 4GB of PCIe memory.

Given each 4GB block of memory requires a new ATU region, the total
number of ATU regions are calculated using the size of PCIe device
tree node's MEM64 pref range size.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d15a5c2d5b48..bed0b189b6ad 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -652,6 +652,33 @@ static struct pci_ops dw_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
+static int dw_pcie_num_atu_regions(struct resource_entry *entry)
+{
+	return DIV_ROUND_UP(resource_size(entry->res), SZ_4G);
+}
+
+static int dw_pcie_prog_outbound_atu_multi(struct dw_pcie *pci, int type,
+						struct resource_entry *entry)
+{
+	int idx, ret, num_regions;
+
+	num_regions = dw_pcie_num_atu_regions(entry);
+
+	for (idx = 0; idx < num_regions; idx++) {
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, idx);
+		ret = dw_pcie_prog_outbound_atu(pci, idx, PCIE_ATU_TYPE_MEM,
+						entry->res->start,
+						entry->res->start - entry->offset,
+						resource_size(entry->res)/4);
+
+		if (ret)
+			goto err;
+	}
+
+err:
+	return ret;
+}
+
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -682,10 +709,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		if (resource_size(entry->res) > SZ_4G)
+			ret = dw_pcie_prog_outbound_atu_multi(pci, PCIE_ATU_TYPE_MEM, entry);
+		else
+			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
+							entry->res->start,
+							entry->res->start - entry->offset,
+							resource_size(entry->res));
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
-- 
2.34.1


