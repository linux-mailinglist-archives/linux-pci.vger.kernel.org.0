Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAFCCB5F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfJEQm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 12:42:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13261 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfJEQmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 12:42:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d98c7f90000>; Sat, 05 Oct 2019 09:42:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 05 Oct 2019 09:42:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 05 Oct 2019 09:42:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 5 Oct
 2019 16:42:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 5 Oct 2019 16:42:24 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d98c7ed0000>; Sat, 05 Oct 2019 09:42:24 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 2/2] arm64: tegra: Assume no CLKREQ presence by default
Date:   Sat, 5 Oct 2019 22:12:12 +0530
Message-ID: <20191005164212.3646-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005164212.3646-1-vidyas@nvidia.com>
References: <20191005164212.3646-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570293753; bh=MZYyKVmEQSs/fOW9jXMmxgmCMVq3eo89Qu0p+NPSTVs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=j35q6JEW7K9nAmcdjpdn34hh+aHHtBRTtQKQR6I9CWmFoch/UAIotH6IvOwFMQC5Z
         29j07RDPa6pCovA8XMXNILtunib6GzSgzceovbUasU65YmgrUCVe5IWlWt/6kLIvVp
         JLx/CM30Wcft5Cq4ya56SRKkZa+Jh6daRz5FPeuaMQ0bfJi1AC00IdAffaF7w4gsM7
         Hb5JR96QyYdCFnBhFFfG5m/JXL1zm9uMpdeOz9JaY/bFs0Z2ydXNsR6HhHY39/TRyb
         usRnBUYolrfqpFcz9LVJgOuWwpJ+goDpl1c5TuiuXFRnFohFW3ldCi+zQFJtTw//sU
         b3607CK08OAXQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Although Tegra194 has support for CLKREQ sideband signal and P2972
has routing of the same till the slot, it is the case most of the time
that the connected device doesn't have CLKREQ support. Hence, it makes
sense to assume that there is no CLKREQ support by default and it can
be enabled on need basis when a card with CLKREQ support is connected.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index a312c051448b..11220d97adb8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1186,7 +1186,6 @@
 
 		nvidia,bpmp = <&bpmp 1>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
@@ -1232,7 +1231,6 @@
 
 		nvidia,bpmp = <&bpmp 2>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
@@ -1278,7 +1276,6 @@
 
 		nvidia,bpmp = <&bpmp 3>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
@@ -1324,7 +1321,6 @@
 
 		nvidia,bpmp = <&bpmp 4>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
@@ -1370,7 +1366,6 @@
 
 		nvidia,bpmp = <&bpmp 0>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
@@ -1420,7 +1415,6 @@
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 
-		supports-clkreq;
 		nvidia,aspm-cmrt-us = <60>;
 		nvidia,aspm-pwr-on-t-us = <20>;
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
-- 
2.17.1

