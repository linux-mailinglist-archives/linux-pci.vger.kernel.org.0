Return-Path: <linux-pci+bounces-36023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AACB54DCB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78993AED51
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFAE3054CE;
	Fri, 12 Sep 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rDToLn5f"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6A3009F1;
	Fri, 12 Sep 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679931; cv=none; b=NvdjfIJomqvqOQaDOjwxtCC8bj+4XZWnBC3uAKQlno9E0mAhi++pm6jCDqErt97us3P9j5bFop6gW42A5t4K999pUdL6AD9zQPW+EERAPCDgIunWsnxadkrPcY3J5ucd1ETGGmbElLE0L4In44prMu6fz/AkViD0CckvoI60lOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679931; c=relaxed/simple;
	bh=uAmLqt2uYW6hGY3CCbjNVJwY2tGhzkjYsKl26ulAF1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUXIhtDfCf4xymNYgND1pVJI1GyzjEhe4PGQ/VdHi64+diNrJhwm43DwBj1LIQYH8+9SmtlnX0Fy7cdJohMTpKkVLFONAQobd0EyNV3+6Gm8k2m+i8PPLskcg4spp0+/XvcPkIRKmgPhghPNnHOEMYRJYx3w7ZZI/zQtViZLbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rDToLn5f; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCP85t517320;
	Fri, 12 Sep 2025 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679908;
	bh=twQ/qDEYavg0CzDuS8LI1uuNmhbFxWRYMM68N+ELTS8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rDToLn5foQeG4gqx7PEjuuMdZQFOm2U67cDhQHwTDku6j6C46vNwDTA5bxIj1NRtD
	 u8MJAq7ui5ol3bXrz/hpbpGrx1/05NXtC9nnlCn0/ci73xWLmiu4EekbTinQqElHu1
	 cPt68ORYxZlQFaPDpML0OgDIt2pe7B3ucjE4Zr8g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCP8sJ1849867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:25:08 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:25:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:25:07 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLb3589278;
	Fri, 12 Sep 2025 07:25:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <qiang.yu@oss.qualcomm.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <quic_schintav@quicinc.com>,
        <inochiama@gmail.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>
CC: <jirislaby@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 09/10] PCI: keystone: Exit ks_pcie_probe() for the default switch-case of "mode"
Date: Fri, 12 Sep 2025 17:46:20 +0530
Message-ID: <20250912122356.3326888-10-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122356.3326888-1-s-vadapalli@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In ks_pcie_probe(), the switch-case for the "mode" is used to configure
the PCIe Controller for either Root-Complex or Endpoint mode of operation.
Prior to the switch-case statement for "mode" an invalid mode will result
in probe failure only if "dw_pcie_ver_is_ge(pci, 480A)" is true, which
is the case for the AM654 platform. On the other hand, when that is not
the case, "ks_pcie_set_mode()" will be invoked, which does not validate
the mode. As a result, it is possible for the switch-case statement for
"mode" to receive an invalid mode. Currently, an error message is displayed
in the "default" case where "mode" is neither "DW_PCIE_RC_TYPE" nor
"DW_PCIE_EP_TYPE", but the probe succeeds. However, since the configuration
required for Root-Complex and Endpoint mode have not been performed, the
Controller is not operational.

Fix this by exiting "ks_pcie_probe()" with the return value of "-EINVAL"
in addition to displaying the existing error message.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1: https://lore.kernel.org/r/20250903124505.365913-11-s-vadapalli@ti.com/
No changes since v1.

 drivers/pci/controller/dwc/pci-keystone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2da9feaaf9ee..e85942b4f6be 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1414,6 +1414,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
+		ret = -EINVAL;
+		goto err_get_sync;
 	}
 
 	ks_pcie_enable_error_irq(ks_pcie);
-- 
2.43.0


