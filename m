Return-Path: <linux-pci+bounces-35379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2999B41F92
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C687AFED3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD23009E4;
	Wed,  3 Sep 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GMExD6Nb"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBC3019D1;
	Wed,  3 Sep 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903598; cv=none; b=uMqCGK99a70mUwkeezEMOl+LXO102C+GWskm6ROZu7qP2j4yQ65WZsCzHzaxkx18KVc9eRRxJYKOk3FuUPbAO2HMaRswbr1/gNrav728Dh/9PS8mjLH8HeVOS4sOXIcCVkIuEZZ0JQCPG64Lq8AHH0d+/M/IZjkEB1YY+W0bm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903598; c=relaxed/simple;
	bh=RMyU4qN6lb1VAO/6Ebo/EW9ZSLN6J/a8zPn9TGDbqf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Albc+ksuYsZWBzhX3iwLOCYMlkZOHR7LsHrLQBOG+hlJlaMuTZFtlx3RwIxge6niDWtdiLcqPC9zYMeqa58A4mmQn3QHtTSZoli6NKlRMWW6MzcoyNJBtLydYYf3aUWetMZ38/TqbYE1kIvraTL+SOJz42sCDzieobpuJReN5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GMExD6Nb; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CkKfT2831378;
	Wed, 3 Sep 2025 07:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903580;
	bh=SSgvnTvhiPvpnGrJs7A+0odLklISOXka10lYXHEdnGk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GMExD6NbY/oe5Loa5ZYnMAS8SnUhVlYBUqG6U+61HDqlqD/6ta6eORPqzqQ71I6zX
	 B+GnHvuo6LKbpV1ukLpKCmt3yqTrloqYxmDzHwjAREfmIUP+3kYBd/i7Yubb0SwL3r
	 FNvyGnMcxmkYgiX20q6vTykzlNERyvK34x1q89U4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CkKxl3523158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:46:20 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:46:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:46:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wb1576150;
	Wed, 3 Sep 2025 07:46:13 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 10/11] PCI: keystone: Exit ks_pcie_probe() for the default switch-case of "mode"
Date: Wed, 3 Sep 2025 18:14:51 +0530
Message-ID: <20250903124505.365913-11-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
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

NOTE: A "Fixes" tag is ommitted on purpose since the fix is not crucial:
1. It doesn't fix a crash or any fatal error
2. It doesn't enable controller functionality by fixing the issue

Therefore, the patch may not be worth backporting.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 02f9a6d0e4a8..4ed6eab0a2f0 100644
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


