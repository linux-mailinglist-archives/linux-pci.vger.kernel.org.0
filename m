Return-Path: <linux-pci+bounces-43107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B93CC1E76
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6F8300A1D7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0D2D9EF3;
	Tue, 16 Dec 2025 10:04:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7DD223323;
	Tue, 16 Dec 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879455; cv=none; b=arZlZA18QQRRiUPXrGh6+l3jnrzaHmwwJ6YkifXCavFxwV/PXOMu46FYUryJQWIoN7006twNMFduXj/DY+VCgpjuHymRgw3cPGRS9EKBfh+Ktye04e5S+OT3E3YLrj3SoBRRb4yFxaQmRnegzTOrm2oW6C5jRdFa/k0Fes5r2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879455; c=relaxed/simple;
	bh=grUy09gLPd2DEeB4kQyoA4RxU1bcU665zMX11qtITWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kmOuqwgC2LkQ51W80sGCxTxrN2n0RkD7MALwjRP3SPZE3AaDITH9VjN8b0PYabIQJ11Nn6O3sBIOvZVUZ1MKlvTCgMzQOGiYdVmlvccMMW7WSwUGag3ZcocpBY/ACsHgGtHXmYH9IBR2ZcluTcSOmn4yPNdj1rIdNQIeScPFgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dVsvs4PNrz1YQpmN;
	Tue, 16 Dec 2025 18:03:53 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dVsvq165gz1YQpmN;
	Tue, 16 Dec 2025 18:03:51 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 4EB8D1648;
	Tue, 16 Dec 2025 18:03:47 +0800 (CST)
Received: from mars.hygon.cn (172.18.228.93) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Dec
 2025 18:03:51 +0800
From: Yang Zhang <zhangz@hygon.cn>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhelgaas@google.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Yang Zhang <zhangz@hygon.cn>
Subject: [PATCH] X86/PCI: Prioritize MMCFG access to hardware registers
Date: Tue, 16 Dec 2025 18:03:32 +0800
Message-ID: <20251216100332.6610-1-zhangz@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

As CPU performance demands increase, the configuration of some internal CPU
registers needs to be dynamically configured in the program, such as
configuring memory controller strategies within specific time windows.
These configurations place high demands on the efficiency of the
configuration instructions themselves, requiring them to retire and
take effect as quickly as possible.

However, the current kernel code forces the use of the IO Port method for
PCI accesses with domain=0 and offset less than 256. The IO Port method is
more like a legacy from historical reasons, and its performance is lower
than that of the MMCFG method. We conducted comparative tests on AMD and
Hygon CPUs respectively, even without considering the impact of indirect
access (IO Ports use 0xCF8 and 0xCFC), simply comparing the performance of
the following two code:

1)outl(0x400702,0xCFC);

2)mmio_config_writel(data_addr,0x400702);

while both codes access the same register. The results shows the MMCFG
(400+ cycle per access) method outperforms the IO Port (1000+ cycle
per access) by twice.

Through PMC/PMU event statistics within the AMD/Hygon microarchitecture,
we found IO Port access causes more stalls within the CPU's internal
dispatch module, and these stalls are mainly due to the front-end's
inability to decode the corresponding uops in a timely manner.
Therefore the main reason for the performance difference between the
two access methods is that the in/out instructions corresponding to
the IO Port access belong to microcode, and therefore their decoding
efficiency is lower than that of mmcfg.

For CPUs that support both MMCFG and IO Port access methods, if a hardware
register only supports IO Port access, this configuration may lead to
illegal access. However, we think registers that support I/O Port access
have corresponding MMCFG addresses. Even we test several AMD/Hygon CPUs
with this patch and found no problems, we still cannot rule out the
possibility that all CPUs are problem-free, especially older CPUs. To
address this risk, we have created a new macro, PREFER MMCONFIG, allowing
users to choose whether or not to enable this feature.

Signed-off-by: Yang Zhang <zhangz@hygon.cn>
---
 arch/x86/Kconfig      | 15 +++++++++++++++
 arch/x86/pci/common.c | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f..037d56690 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2932,6 +2932,21 @@ config PCI_MMCONFIG
 
 	  Say Y otherwise.
 
+config PREFER_MMCONFIG
+        bool "Perfer to use mmconfig over IO Port"
+        depends on PCI_MMCONFIG
+        help
+          This setting will prioritize the use of mmcfg, which is superior to
+          io port from a performance perspective, mainly for the following reasons:
+          1) io port is an indirect access; 2) io port instructions are decoded
+          by microcode, which is more likely to cause CPU front-end bound compared
+          to mmcfg using mov instructions.
+
+          For CPUs that support both MMCFG and IO Port access methods, if a
+          hardware register only supports IO Port access, this configuration
+          may lead to illegal access. Therefore, users must ensure that the
+          configuration will not cause any exceptions before enabling it.
+
 config PCI_OLPC
 	def_bool y
 	depends on PCI && OLPC && (PCI_GOOLPC || PCI_GOANY)
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index ddb798603..8bde5d1df 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -40,20 +40,34 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
 {
+#ifdef CONFIG_PREFER_MMCONFIG
+	if (raw_pci_ext_ops)
+		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
+	if (domain == 0 && reg < 256 && raw_pci_ops)
+		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
+#else
 	if (domain == 0 && reg < 256 && raw_pci_ops)
 		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
 	if (raw_pci_ext_ops)
 		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
+#endif
 	return -EINVAL;
 }
 
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 val)
 {
+#ifdef CONFIG_PREFER_MMCONFIG
+	if (raw_pci_ext_ops)
+		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
+	if (domain == 0 && reg < 256 && raw_pci_ops)
+		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
+#else
 	if (domain == 0 && reg < 256 && raw_pci_ops)
 		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
 	if (raw_pci_ext_ops)
 		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
+#endif
 	return -EINVAL;
 }
 
-- 
2.34.1



