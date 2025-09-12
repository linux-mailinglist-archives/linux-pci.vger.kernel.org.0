Return-Path: <linux-pci+bounces-36007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F49B54D95
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19ED17E544
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F72F617C;
	Fri, 12 Sep 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jH82VOsf"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50030146B;
	Fri, 12 Sep 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679872; cv=none; b=DeSNoco3NqrlReaLpjyV4EP/RcvukOsc5wqKKiIq1EjrfmO6+Rg1YR/XvxaXRb+9mh6ybZxnLksuGLafuVFgX+NGgiTDJa6cjgJlCCTWq/8IA4nvGlSRdAkrT4BHHYZtyzdLFnrLYFhEwvvojTRQLW02VXsljfHEI92YtAOZH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679872; c=relaxed/simple;
	bh=cH2/kj0mvWarunBy3cwZ0FaYOYmx5tevzhN8dH9BfIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQwlYFSordlTq6d2dYAsZHsFNs6ruLjZznJ2PScJWZztgamoY9db6u2RewmADCei35Jyi4CHrEgNZZDCDI5Szk1QTzWfCTzucnzKBk2tnp6kSCjZX4aGhP8VXwCgRdzeVf7YJiqRTUa8EeTT5OvqV9ZjQm2qZAyMsjHRzu9ZKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jH82VOsf; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCO4hS967935;
	Fri, 12 Sep 2025 07:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757679844;
	bh=41ADgNrKihGdh6ABSZq8itBkuFhnZ+8ndSF55rURelI=;
	h=From:To:CC:Subject:Date;
	b=jH82VOsf6aACJOZ1aGamQtJYN4wRtOdhrrZF4qB713aRU35oAVF2V0rFt8pt8fdyc
	 mrmH9SbF4gZFMbzPzfoGRF66lh9fIaTn0ahb0yu5ZYQn0xyl5wtexPTMpTXoEh/hpb
	 otq3k24f2EJsZvECr5K/MhhljqlZHjAolaz0sfMo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCO42Y2760210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 07:24:04 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:24:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:24:03 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCNuLS3589278;
	Fri, 12 Sep 2025 07:23:57 -0500
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
Subject: [PATCH v2 00/10] PCI: Keystone: Enable loadable module support
Date: Fri, 12 Sep 2025 17:46:11 +0530
Message-ID: <20250912122356.3326888-1-s-vadapalli@ti.com>
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
bfd2c81b061c Merge branch 'pci/misc'
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

v1 of this series is at:
https://lore.kernel.org/r/20250903124505.365913-1-s-vadapalli@ti.com/
Changes since v1:
- Based on the feedback provided by Jiri Slaby <jirislaby@kernel.org> at:
  https://lore.kernel.org/r/3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org/
  patch 09/11 of the v1 series has been posted as a FIX at:
  https://lore.kernel.org/r/20250912100802.3136121-2-s-vadapalli@ti.com/
  and is therefore no longer a part of the current series.
- Based on the feedback provided by Manivannan Sadhasivam <mani@kernel.org> at:
  https://lore.kernel.org/r/2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5/
  patch 11/11 of the v1 series which is patch 10/10 of this series has
  been modified by retaining 'builtin_platform_driver()' instead of
  changing it to 'module_platform_driver()'.
- Series has been based on pci/next instead of linux-next.

For testing the series, Linux has been built in the following manner:
1. Check out at commit bfd2c81b061c Merge branch 'pci/misc' of pci/next
2. Apply commit and patch series mentioned as dependencies above.
3. Apply current series.
4. Build Linux with CONFIG_PCI_KEYSTONE, CONFIG_PCI_KEYSTONE_HOST and
   CONFIG_PCI_KEYSTONE_EP set to 'm'.

Series has been tested on AM654-EVM with an NVMe SSD connected to the
PCIe connector on the board and verifying that the NVMe SSD enumerates
successfully. Additionally, the 'hdparm' utility has been used to read
the NVMe SSD for verifying functionality. Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/54848d3414dc965bec3c29253a1b2764

Regards,
Siddharth.

Siddharth Vadapalli (10):
  PCI: Export pci_get_host_bridge_device() for use by pci-keystone
  PCI: dwc: Export dw_pcie_allocate_domains() for pci-keystone
  PCI: dwc: Add dw_pcie_free_domains() helper for cleanup
  PCI: dwc: ep: Export dw_pcie_ep_raise_msix_irq() for pci-keystone
  PCI: keystone: Add ks_pcie_free_msi_irq() helper for cleanup
  PCI: keystone: Add ks_pcie_free_intx_irq() helper for cleanup
  PCI: keystone: Add ks_pcie_host_deinit() helper for cleanup
  PCI: keystone: Add ks_pcie_disable_error_irq() helper for cleanup
  PCI: keystone: Exit ks_pcie_probe() for the default switch-case of
    "mode"
  PCI: keystone: Add support to build as a loadable module

 drivers/pci/controller/dwc/Kconfig            |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 101 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   1 +
 .../pci/controller/dwc/pcie-designware-host.c |  10 ++
 drivers/pci/controller/dwc/pcie-designware.h  |   5 +
 drivers/pci/host-bridge.c                     |   1 +
 include/linux/pci.h                           |   1 +
 7 files changed, 122 insertions(+), 3 deletions(-)

-- 
2.43.0


