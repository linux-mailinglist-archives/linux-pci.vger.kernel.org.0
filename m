Return-Path: <linux-pci+bounces-23430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF1A5C39F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD09188423C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982B25BAC3;
	Tue, 11 Mar 2025 14:17:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE821C5D61
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702651; cv=none; b=uiF7Bc2vBXyi9TATPkpRvMypOcz72vJzMUbseX1Zvgnu/6d7HBlL3ydGn/8ZCO4xaC78H/x+MAPTFBU/GQrIoERRnbNyD/UCSiLSmmnDl0LslJa/IWSbsE42Wrz1nB5p+S853rOUaBs4afCxrlNatcJpDkJ4815smpU721yjOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702651; c=relaxed/simple;
	bh=LKmYCLsgh14jgzOXslw0xBpZ4YsbedeRx4QFVUEXTz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRjsTGsk+7vnd7vFJRjMzaotbki7aDFimxy4MjrQw/Zmtu63cbTqZtBKwQ5PYHloIFpi9SdoDDzHfTdP1+AkQQEQ2bkLTsR/OY9wzqryhPO+WGAcGcc7KRVoBn+HCs9mzf4xVoDrLZs+mWwTb99X1fSMCp14ZAT8WSDmeTxDPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01DC21762;
	Tue, 11 Mar 2025 07:17:41 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7A03F694;
	Tue, 11 Mar 2025 07:17:28 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: lpieralisi@kernel.org,
	robin.murphy@arm.com,
	aneesh.kumar@kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2 06/11] samples/devsec: Introduce a PCI device-security
Date: Tue, 11 Mar 2025 14:17:08 +0000
Message-ID: <20250311141712.145625-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com>
References: <174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dan,

I have been playing with this, and these changes kind of makes it work on arm64
and hopefully for others with CONFIG_PCI_DOMAINS_GENERIC.

The first patch is a build failure fix for my toolchain.

[RFC PATCH 0/3] samples: devsec: Add support for PCI_DOMAINS_GENERIC

# insmod devsec_common.ko
# insmod devsec_bus.ko
# insmod devsec_tsm.ko
# dmesg
[ 7817.297135] devsec_bus devsec_bus: PCI host bridge to bus 0001:00
[ 7817.297251] pci_bus 0001:00: root bus resource [bus 00-01]
[ 7817.297374] pci_bus 0001:00: root bus resource [mem 0xfffffff000000000-0xffffffffffffffff 64bit]
[ 7817.297653] pci 0001:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
[ 7817.297856] pci 0001:00:00.0: PCI bridge to [bus 00]
[ 7817.297986] pci 0001:00:00.0:   bridge window [io  0x0000-0x0fff]
[ 7817.298115] pci 0001:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[ 7817.298267] pci 0001:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[ 7817.304866] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[ 7817.305464] pci 0001:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
[ 7817.305664] pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x001fffff]
[ 7817.312503] pci 0001:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[ 7817.312714] pci_bus 0001:01: busn_res: [bus 01] end is updated to 01
# cd /sys/bus/pci/devices/0001\:01\:00.0/
# cat tsm/connect
0
# echo 1 > tsm/connect
# cat authenticated
1
# echo 0 > tsm/connect
# cat authenticated
0



Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev

Suzuki K Poulose (3):
  pci: ide: Fix build failure
  pci: generic-domains: Add helpers to alloc/free dynamic bus numbers
  samples: devsec: Add support for PCI_DOMAINS_GENERIC

 drivers/pci/ide.c       |  5 +++--
 drivers/pci/pci.c       | 16 ++++++++++++++--
 include/linux/pci.h     |  3 +++
 samples/Kconfig         |  1 -
 samples/devsec/bus.c    | 32 +++++++++++++++++++++-----------
 samples/devsec/common.c |  2 +-
 samples/devsec/devsec.h |  2 +-
 7 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.43.0


