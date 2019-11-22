Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85B7107028
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfKVLU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:20:29 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17016 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfKVKpy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:45:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd7bc630001>; Fri, 22 Nov 2019 02:45:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 02:45:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 02:45:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:52 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 Nov 2019 10:45:52 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd7bc5b0001>; Fri, 22 Nov 2019 02:45:51 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 5/6] arm64: tegra: Enable GPIO controllers nodes for P2972-0000 platform
Date:   Fri, 22 Nov 2019 16:15:04 +0530
Message-ID: <20191122104505.8986-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122104505.8986-1-vidyas@nvidia.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574419555; bh=F6/Ov3FRHWjTCpHNYAElFVGDpjp7zAUe/K07HA+D/Lo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RRTdKrP/hxJqKkvG/cuJyacZRDOqI7uPuqzizjVNNiqEsoFMusGXZE5R1G2IgDAUq
         ClJG0K8nW6Rvwhqs88MB9UZxgH3qQz9p8urjvKNyQjEt9eZNVSUVaaG7cHXURgeJhZ
         NcYsG3lrMc6ukL3NJUYLXW2v8f1CxvT5jS64ny+0V5YFauKIN7hjMSdHhlj6Oso90B
         CDRQ+wYcU/PV4D+AdZDNPzpyxZObKoCzPeyY5j0YgjnZqK1A2N4HQ83UdZRIeEJYKC
         hKslp3sSJ3pO2NCbJP1KNZhR9YIuljsi0MPC9FqaQkNO4n1/FThVggly0V7K61ZObP
         SHajOjncPpD6A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable GPIO controllers nodes for P2972-0000 platform which are required
by other controllers in the SoC for example when PCIe C5 controller
operates in endpoint mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 353a6a22196d..7eb64b816e08 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -37,6 +37,14 @@
 			status = "okay";
 		};
 
+		gpio@2200000 {
+			status = "okay";
+		};
+
+		gpio@c2f0000 {
+			status = "okay";
+		};
+
 		pwm@c340000 {
 			status = "okay";
 		};
-- 
2.17.1

