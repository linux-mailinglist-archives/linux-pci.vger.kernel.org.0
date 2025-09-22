Return-Path: <linux-pci+bounces-36620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B2B8F3DA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A386189EF53
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4A2F0C75;
	Mon, 22 Sep 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BAoGWRwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6D2367B5;
	Mon, 22 Sep 2025 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525182; cv=none; b=shKs736MgywkTAAtiUPjvOJmVxqJYwng+KVngIwbz67UDluDbATjlMMQDJg+JrX7tUZnUMg5dSEzDFf61UlFw+CuEJc4oJLGx/wGWTjYM9GGCOTe6pHHSKOUpKLt+VZxk+H/mQe6ePrm3X+OlZYj/i+w6t65/Ml/91FnavYJpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525182; c=relaxed/simple;
	bh=pc8fOIWyIeYU2I8WMVPLAOavlN5Cjc5WzDkmGR6HOiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HlRo+xBt4MQTh/VKcdFZ1rKhEjIu/R03MH/nt6KsryFhiBcIbx7s6uL5/0ZiO2bMedTttWwcqgCdypLJrfaytr/7pdLOVqF49MdhAa0FdX+MkNizFpk0KE4cG9b2LSaeuqdSaFg5cVtPJrHGKWT1Zp4GgzSCTBoDp8c5Exy4D04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BAoGWRwC; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M7CUVE1183964;
	Mon, 22 Sep 2025 02:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758525150;
	bh=uTctHAVrrJJhz8+sjGmeprmgZ6Z8FF5nTjBctXETYv4=;
	h=From:To:CC:Subject:Date;
	b=BAoGWRwCnSwvL4b0XnSGtYbNbEKjRnVDuw7/S+M03ymgz+EEe09FXJF78GE8ohYch
	 22Px5giTvLQek6ziat2OAnuNh2S/9uRk8anNPfw0QYdPKzlfsubfvDJswaDWtaV/dX
	 V6YPEpdaCWguGMdvSCzIy5SSTujICRodxTO3UDwg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M7CULP1800388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 02:12:30 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 02:12:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:12:29 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M7CN0R2369246;
	Mon, 22 Sep 2025 02:12:23 -0500
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
Subject: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Date: Mon, 22 Sep 2025 12:42:12 +0530
Message-ID: <20250922071222.2814937-1-s-vadapalli@ti.com>
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

Series is based on commit
dc72930fe22e Merge branch 'pci/misc'
of pci/next.

NOTE for MAINTAINERS: This series has the following dependencies:
1. The following commit in Linux-Next is a build-dependency for the
series:
https://github.com/ColinIanKing/linux-next/commit/8de1de5a3a8d42975953382068fb5195e9d6e6c6
Since the v1 series was based on linux-next, there were no build errors.
However, since this series is based on pci/next based on the feedback from
Manivannan Sadhasivam <mani@kernel.org> at:
https://lore.kernel.org/r/2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5/
without the aforementioned commit, build will fail.
2. The following patch series include fixes for the driver which are
required to verify the driver functionality:
https://lore.kernel.org/r/20250912100802.3136121-1-s-vadapalli@ti.com/

v2 of this series is at:
https://lore.kernel.org/r/20250912122356.3326888-1-s-vadapalli@ti.com/
Changes since v2:
- Patch 04/10 of the v2 series has been squashed into patch 02/10 of the
  v2 series. In the v3 series, the squashed patch is 02/04.
- Patches 03/10, 05/10, 06/10, 07/10 and 08/10 of the v2 series have been
  dropped. The reason for dropping them is that all of the aforementioned
  patches introduce helpers for cleanup on driver removal. Since Mani
  pointed out that the driver cannot be removed until the IRQ issues are
  fixed, the driver's remove function hasn't been updated and therefore
  the helpers have been discarded.
- The commit message of patch 09/10 of the v2 series has been updated,
  keeping it concise and focusing on the issue and the fix. Moreover, a
  'Fixes' tag has been included although a backport isn't necessary, in
  order to address Mani's feedback.
- All changes associated with driver removal in patch 10/10 of the v2
  series have been discarded.
- Patch relation between v2 and v3 series is as follows:
  v3 01/04 => v2 01/10
  v3 02/04 => v2 02/10 + 04/10
  v3 03/04 => v2 09/10
  v3 04/04 => v2 10/10

For testing the series, Linux has been built in the following manner:
1. Check out at commit dc72930fe22e Merge branch 'pci/misc' of pci/next
2. Apply commit and patch series mentioned as dependencies above.
3. Apply current series.
4. Build Linux with CONFIG_PCI_KEYSTONE, CONFIG_PCI_KEYSTONE_HOST and
   CONFIG_PCI_KEYSTONE_EP set to 'm'.

Series has been tested on AM654-EVM with an NVMe SSD connected to the
PCIe connector on the board and verifying that the NVMe SSD enumerates
successfully. Additionally, the 'hdparm' utility has been used to read
the NVMe SSD for verifying functionality. Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/182a80bb43e9c407982f7674034a7c9d

Regards,
Siddharth.

Siddharth Vadapalli (4):
  PCI: Export pci_get_host_bridge_device() for use by pci-keystone
  PCI: dwc: Export dw_pcie_allocate_domains() and
    dw_pcie_ep_raise_msix_irq()
  PCI: keystone: Exit ks_pcie_probe() for invalid mode
  PCI: keystone: Add support to build as a loadable module

 drivers/pci/controller/dwc/Kconfig                | 6 +++---
 drivers/pci/controller/dwc/pci-keystone.c         | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/host-bridge.c                         | 1 +
 include/linux/pci.h                               | 1 +
 6 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.43.0


