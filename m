Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F95A1376CB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgAJTPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 14:15:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1668 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgAJTPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 14:15:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e18cd310000>; Fri, 10 Jan 2020 11:14:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jan 2020 11:15:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jan 2020 11:15:15 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 19:15:15 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 19:15:14 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jan 2020 19:15:14 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e18cd3e0001>; Fri, 10 Jan 2020 11:15:14 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <andrew.murray@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 1/2] arm64: tegra: Re-order PCIe aperture mappings to support ACPI boot
Date:   Sat, 11 Jan 2020 00:44:59 +0530
Message-ID: <20200110191500.9538-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110191500.9538-1-vidyas@nvidia.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578683697; bh=A9295dTyR+j2yr8EqSviqtTgED4nGyVgvOv0oWR2ueU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gf35ja2k7JnAqX+jyF1OxPVsYL5Fk4U+zYrMvTudBnjv0lLjB+7vnkXuO5FnSX28a
         o2Mvk9yks+a7NYLZkVfmKCXKbeDNoGPlPSy+g8CAyeAd5u7leSGONsy5awV83vmud7
         /KuuExw/Ko4JihAJdQ57/4EaaohgPWUNbodkmI5Wo0e7qyfgf5PvkAkwe1PdtgEKls
         t9tsBwoqjGJn5WWPiQMaUZ8OHdSvPrUDuyKEFPjjr9IpczNvMzJE8SyHDZci42N+s+
         f0iCjfLLhugetglYqrGi5j8eknYwfvMIV+vnkZj0dSmiS70Y1G31dVfgR/s3ueHnRy
         jBNjNRTUtey9w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-order Tegra194's PCIe aperture mappings to have IO window moved to
64-bit aperture and have the entire 32-bit aperture used for accessing
the configuration space. This makes it to use the entire 32MB of the 32-bit
aperture for ECAM purpose while booting through ACPI.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* New change in this series

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index ccac43be12ac..5d790ec5bdef 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1247,9 +1247,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0x30000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0x3fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14120000 {
@@ -1292,9 +1292,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0x70000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0x7fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14140000 {
@@ -1337,9 +1337,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0xb0000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0xbfff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14160000 {
@@ -1382,9 +1382,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x17 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x17 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14180000 {
@@ -1427,9 +1427,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x1b 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x1b 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@141a0000 {
@@ -1476,9 +1476,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x1f 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x1f 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	sysram@40000000 {
-- 
2.17.1

