Return-Path: <linux-pci+bounces-36621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49021B8F3E3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E76189F07E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633022F3612;
	Mon, 22 Sep 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="efGxgJBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F92367B5;
	Mon, 22 Sep 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525188; cv=none; b=it8L14NyVVDFdzlMxn8gQtjWACa1NkqBcColyVaQbLEe1B5/9YbwaGCsTB1UOk/wjzrD0gsKAxomMLLEQorq4ifcjqdt4Geu/xmfYD4xw8sI0lA68HWjHTmwe69h58wmXJPJdD8Zs9xje26eNTVHGFEbxbW87GqYIH/CTb4q/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525188; c=relaxed/simple;
	bh=uFc2miPfGpmCAPx9kuHAwYwqzPLQ8Z6Z9IujXoqNmL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpCG0xTAzd4WYTQCeduDQc9Ia61Dc6FwUBDFttmKWviFgErZb4TUvZzqwmh5adJ//GvSqxGEmuM37f6lcE/vEPYbzBoCjNt/zrSry9J3RpIfL8CUEbYlbPKhIPnoJn9K8lenOJppxb5XXujVZxj9fR6JCjZn6IUJbQhEx0vyzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=efGxgJBR; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M7Cmxx1183988;
	Mon, 22 Sep 2025 02:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758525169;
	bh=VV49ihaF8LjwLtRf5svh2loSSu7iyybrckUp+jaDzz0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=efGxgJBRBSJBPSG+Qi585Dxn5RzhIEU3l+rTUBOyqDYAmd4MpOrOZDng5q3AQ5SEi
	 oTzvkG+eo3q3XIzQG+RfAKsJSlzeoAYySUFIZ4aoxViUHvp2GsZt5PyFCjD/8Xe59h
	 WqZM31SHCD3TKKDcK9O7rc/1ksRQ8690+aSadakU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M7CmIZ1800486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 02:12:48 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 02:12:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:12:48 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M7CN0U2369246;
	Mon, 22 Sep 2025 02:12:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <inochiama@gmail.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
Date: Mon, 22 Sep 2025 12:42:15 +0530
Message-ID: <20250922071222.2814937-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922071222.2814937-1-s-vadapalli@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Commit under Fixes introduced support for PCIe EP mode on AM654x platforms.
When the mode happens to be either "DW_PCIE_RC_TYPE" or "DW_PCIE_EP_TYPE",
the PCIe Controller is configured accordingly. However, when the mode is
neither of them, an error message is displayed but the driver probe
succeeds. Since this "invalid" mode is not associated with a functional
PCIe Controller, the probe should fail.

Fix the behavior by exiting "ks_pcie_probe()" with the return value of
"-EINVAL" in addition to displaying the existing error message when the
mode is invalid.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://lore.kernel.org/r/20250912122356.3326888-10-s-vadapalli@ti.com/
Changes since v2:
- The commit subject and description has been updated to keep it concise
  and highlight the issue and the fix.
- A "Fixes" tag has been added but 'stable' hasn't been CCed on purpose
  since backporting the patch isn't required - doesn't enable
  functionality.

 drivers/pci/controller/dwc/pci-keystone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d03e95bf7d54..f9f8235ea3cd 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1337,6 +1337,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
+		ret = -EINVAL;
+		goto err_get_sync;
 	}
 
 	ks_pcie_enable_error_irq(ks_pcie);
-- 
2.43.0


