Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E914FA02E2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1NPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:15:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3228 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:15:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d667e6a0000>; Wed, 28 Aug 2019 06:15:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 06:15:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 06:15:21 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:21 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 13:15:20 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d667e640005>; Wed, 28 Aug 2019 06:15:20 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 1/6] dt-bindings: PCI: tegra: Add sideband pins configuration entries
Date:   Wed, 28 Aug 2019 18:45:00 +0530
Message-ID: <20190828131505.28475-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828131505.28475-1-vidyas@nvidia.com>
References: <20190828131505.28475-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566998123; bh=g+/0ogzPEXBTSPeVJRLzdjZyB9us9Xr8S9yfGErF1J4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=i8flEPfvPOhKjt4caCsoCy9O1XkxBxv2bgLVYRo2Ahd4shBnXGvh0zGo8O/vzliqT
         97lITUs42N9xAZNXKkChCe10YD6ogh2kzyQsKHHq9lvkZaUVHeOegjr2pmu2pBWaji
         lBoxvJ2cKwb2pk6Ysu/N228fcwSPavH+58M+jh3tpuKYL4Bo5d/eYVHC7aD9aXFd0R
         MnZAOXTwgvPHnQoWO/nSZYET7sL7lNfrSCpUp/0IOBqirt1sww/8a0rpK3lJyvkTys
         UHP7zx8LPSYbxTgE4BZU9h757S4eEpeTELAHG/E4zBCEusRri7zBbAuWbii6hbF9zb
         +FVk/QgE32hyA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
configuration information of a particular PCIe controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 674e5adb2895..0ac1b867ac24 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -83,6 +83,11 @@ Required properties:
 - vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
 
 Optional properties:
+- pinctrl-names: A list of pinctrl state names.
+  It is mandatory for C5 controller and optional for other controllers.
+  - "default": Configures PCIe I/O for proper operation.
+- pinctrl-0: phandle for the 'default' state of pin configuration.
+  It is mandatory for C5 controller and optional for other controllers.
 - supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
 - nvidia,update-fc-fixup: This is a boolean property and needs to be present to
     improve performance when a platform is designed in such a way that it
@@ -120,6 +125,9 @@ Tegra194:
 		num-lanes = <8>;
 		linux,pci-domain = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
+
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
 		clock-names = "core";
 
-- 
2.17.1

