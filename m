Return-Path: <linux-pci+bounces-10710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CB93ACD1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384F52834D3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533049647;
	Wed, 24 Jul 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R9kQEeSt"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DFD29E;
	Wed, 24 Jul 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803924; cv=none; b=RApfP0jx9vfM/x89xCvv8FScd+FmVPGMmtSAbszFsDqCOQXfjROBGMOfJ0EGvcFmAbsTs0rzULjsVmvNndjlcFmMUXuUGS9RsBxlg5QKFv45haJ1WtP1e7XCRQGiedmKk9EMYfveWASVYVwYtGbo/s1f4Hqfa1r/8YqExpnTTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803924; c=relaxed/simple;
	bh=BKJYkElVdsyTz+MpTbuIrQNslbwroEkRjhC7/2y1VaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9SKfaA4rYyMKFMS//A2DCXjSIERtP7xi0heL94iVlF8todZhYhOIYqn3HDV1HX96kg/XBCXzAQ6EKG1O0sYfcRZnVURYCD2BG+xSfO+E1bpfE134CBk7pWWmTRerw3YLUHrTIKVD4tZCeK3FOYG/TjwfxSYBX6H8Y7eLKrlGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R9kQEeSt; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46O6or1x108730;
	Wed, 24 Jul 2024 01:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721803853;
	bh=5zKtgi31JMulsen7u4BdGoizzwd/ypkXhdtnrLehHH4=;
	h=From:To:CC:Subject:Date;
	b=R9kQEeStn5qFzjwdoTKuoydTgDH5MPkPNt/cVYAdxa1OvlmN1+a6WGdUxDd+MbcCq
	 bw76yLGgYgMXGyAKXLKJFPhTl5PU5zXMSQck+ktm30v9IoiK/WHb/Q/H+sVsmZE1Ts
	 m6ZeYo5wG9fHw+Ps+M6eu5kudZ1nMfUl9XwVD/DQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46O6orV7079908
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jul 2024 01:50:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jul 2024 01:50:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jul 2024 01:50:52 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46O6omlk070009;
	Wed, 24 Jul 2024 01:50:49 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>,
        <ahalaney@redhat.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Date: Wed, 24 Jul 2024 12:20:48 +0530
Message-ID: <20240724065048.285838-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since the configuration of Legacy Interrupts (INTx) is not supported, set
the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
  of_irq_parse_pci: failed with rc=-22
due to the absence of Legacy Interrupts in the device-tree.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Reported-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
of Mainline Linux.

Patch has been tested on J784S4-EVM and J721e-EVM, both of which have
the PCIe Controller configured by the pci-j721e.c driver.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 85718246016b..5372218849a8 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		if (!bridge)
 			return -ENOMEM;
 
+		/* Legacy interrupts are not supported */
+		bridge->map_irq = NULL;
+		bridge->swizzle_irq = NULL;
+
 		if (!data->byte_access_allowed)
 			bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
-- 
2.40.1


