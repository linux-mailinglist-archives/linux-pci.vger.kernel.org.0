Return-Path: <linux-pci+bounces-20086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DDA15A2E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 00:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EC67A340F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA01DE88A;
	Fri, 17 Jan 2025 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFwlw5EZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25A1AE875;
	Fri, 17 Jan 2025 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157884; cv=none; b=qVl7iOAaeVnDUwkC50wh33CECHrQisQ4mVULC9GmcqPeyWFDUHA3Prt6W/2ji2WoRzfw36wJjghLCHlxhIuLufd6n8Z5udQs5maB9Cyfl1W0b+qcIf9VFL58g0lsZb+WaEQ7Nd6gMJjpm53iaf+tSF8KwzvMqUxKoIA2OVyEncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157884; c=relaxed/simple;
	bh=YUpO9eYQ0TIUyuA/r/QD8BEuiJnHYfJBDHmibOGdOd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tG+IDBnlsnI04qavqqeRQ+UzcPQk6QUuZFEQUIv1RHOhUSkEUyVW6wBDSd2PkN1pI4j3jQCTHOk5zk2L/3dpPa2d1P0qPfmX0/l1hUgyqBaw0Zpy5zRbuS5NA2va+8MTycKafpoibeTsLA5cNIP74yJiZtXmxbrWbxVcyMiVfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFwlw5EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A921FC4CEDD;
	Fri, 17 Jan 2025 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737157883;
	bh=YUpO9eYQ0TIUyuA/r/QD8BEuiJnHYfJBDHmibOGdOd8=;
	h=From:To:Cc:Subject:Date:From;
	b=gFwlw5EZjvC06x2h6nXHQtew93kadvMBhhN6lFiwpROF/iHmJPanpyPqQsgALT0zT
	 2T0zQaX+OfXOjrRKzYJCha8jNZ/MwecuCmrkvBv41Lrfq6pWzEmjzY/qBRSmpbwv7p
	 jc5ComI8+2MmJacUt+ms9cgO4F4G+ZinGSv3u/4i/wgQQ0IXoJpqVbMJ1hU7bBYwhf
	 urHZWEUrC5o3ul89nw0TIZ2OZRbIpuJuWXoX6awv0Z/a7EB8KhZ2XcKZQVynTRo3Ud
	 REtvY8UPc+5Hhde2Rl82dzHa0+wJFtT38HuQL3ah/L+JGQJaTKyhSJBfQ63P3cij/W
	 /AuZxvqlus+eg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: dwc: Simplify config resource lookup
Date: Fri, 17 Jan 2025 17:51:19 -0600
Message-Id: <20250117235119.712043-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

If platform_get_resource_byname("config") fails, return error immediately
and unindent the normal path.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e42a74108f0f..3fca55751dca 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -436,18 +436,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (res) {
-		pp->cfg0_size = resource_size(res);
-		pp->cfg0_base = res->start;
-
-		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-		if (IS_ERR(pp->va_cfg0_base))
-			return PTR_ERR(pp->va_cfg0_base);
-	} else {
+	if (!res) {
 		dev_err(dev, "Missing *config* reg space\n");
 		return -ENODEV;
 	}
 
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
-- 
2.34.1


