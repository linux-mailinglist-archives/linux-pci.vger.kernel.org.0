Return-Path: <linux-pci+bounces-35370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDDB41F84
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9E3BF56D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444013009CA;
	Wed,  3 Sep 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jb/WkbG6"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797003002C3;
	Wed,  3 Sep 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903539; cv=none; b=Mgju12GTvZS6UUyoxjDh5FPl92cPGRModKhfqVlMvDioscDqtdBG1V8iC2Fc7hLNp+9+qAtDbaFchdSnF5BygRxjKZj+JDwhCx+ceEghKmi1XjB9eYrzwATuW/2o1RMJlcrQtVeQLpaa9mcW4CI86DBJYPiQbIv0YnkeGSKejoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903539; c=relaxed/simple;
	bh=vUt4teJ3M7wKwNW+Hcva03Ui4u8mgaTh7fKCrdfZ0QQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=URkd/4I2Cu2UTkzk1Cfc/yq6EpAZmq4PnDYrq5SHRsVZmLcr12pLZY7YmQJxISkQnFEGpr5Vhk5j2GlMIEYli62UVqC2rgTuWqysyrFafzskZW6N9UF+Vz+0U39oGO2FVUkcXEXq+ETlDSNi2gzifNAvOCte7tOCucotF7IiuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jb/WkbG6; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CjD443263768;
	Wed, 3 Sep 2025 07:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903513;
	bh=MJIJ1bbVcymHncqSqQqeKOAPaRiZ1naG0SLE1m9EcvA=;
	h=From:To:CC:Subject:Date;
	b=jb/WkbG6Mb1Ar4jRlYTnjlScvg05D/pBMUBeehItPGtLKkCm3u+LDYn/i+0GMK9RV
	 3zgTyzdzR5hhey9ySVUXvbpM5N97AZNQqNUYSkfXO3Fr/rrJVX9k9qTZZhelcK7sHn
	 k9Va0J/2BAZYnNDtKk8rOwcN0PRcWT44e3JnVnb4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CjDr2083850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:45:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:45:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:45:12 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wR1576150;
	Wed, 3 Sep 2025 07:45:06 -0500
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
Subject: [PATCH 00/11] PCI: Keystone: Enable loadable module support
Date: Wed, 3 Sep 2025 18:14:41 +0530
Message-ID: <20250903124505.365913-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series enables support for the 'pci-keystone.c' driver to be built
as a loadable module. The motivation for the series is that PCIe is not
a necessity for booting Linux due to which the 'pci-keystone.c' driver
does not need to be built-in.

Series is based on linux-next tagged next-20250903.

Series has been tested on the AM654-IDK-EVM by validating module removal
and reprobe while connected to an Intel PCIe-Ethernet Adapter. Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/dfd7821c187241d63098117eb7431a1b

Regards,
Siddharth.

Siddharth Vadapalli (11):
  PCI: Export pci_get_host_bridge_device() for use by pci-keystone
  PCI: dwc: Export dw_pcie_allocate_domains() for pci-keystone
  PCI: dwc: Add dw_pcie_free_domains() helper for cleanup
  PCI: dwc: ep: Export dw_pcie_ep_raise_msix_irq() for pci-keystone
  PCI: keystone: Add ks_pcie_free_msi_irq() helper for cleanup
  PCI: keystone: Add ks_pcie_free_intx_irq() helper for cleanup
  PCI: keystone: Add ks_pcie_host_deinit() helper for cleanup
  PCI: keystone: Add ks_pcie_disable_error_irq() helper for cleanup
  PCI: keystone: Switch to devm_request_irq() for "ks-pcie-error-irq"
    IRQ
  PCI: keystone: Exit ks_pcie_probe() for the default switch-case of
    "mode"
  PCI: keystone: Add support to build as a loadable module

 drivers/pci/controller/dwc/Kconfig            |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 111 +++++++++++++++++-
 .../pci/controller/dwc/pcie-designware-ep.c   |   1 +
 .../pci/controller/dwc/pcie-designware-host.c |  10 ++
 drivers/pci/controller/dwc/pcie-designware.h  |   5 +
 drivers/pci/host-bridge.c                     |   1 +
 include/linux/pci.h                           |   1 +
 7 files changed, 127 insertions(+), 8 deletions(-)

-- 
2.43.0


