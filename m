Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C577A085D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1R3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 13:29:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2775 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfH1R3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:29:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66b9e20000>; Wed, 28 Aug 2019 10:29:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 10:29:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 10:29:05 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:05 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 17:29:04 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d66b9dc0000>; Wed, 28 Aug 2019 10:29:04 -0700
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
Subject: [PATCH V3 1/6] dt-bindings: PCI: tegra: Add sideband pins configuration entries
Date:   Wed, 28 Aug 2019 22:58:45 +0530
Message-ID: <20190828172850.19871-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567013346; bh=O79XXU+FgU5VlOcFCcmCkVC2Mfp2Dtl0A7DmUNFaMsA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=aoqMPddLJrd9EpFViiaz91Sdp/psH1ucAVBDb2utiNJnoqFTusfyWQ6aglWkyioeC
         8Epuup2VUuC2ocxznqm4a0ST56entekLqmWZaVJtbKQc7VpZyewXPkALVIQmaxW+io
         ugcN/chcvEnBbvVAbUiiRoReKTVexsNuPFOtZUo3TuDNNrHCwTptAip1dGPvRwKYrf
         ivBTby6VcCmj75E02HgOSsBEN5lxFZ/ZdnmtVKvqCDOmVenm2Qj2oDLQH82Bz3ZwiM
         xwQdSijfUbyx4MVpDW/tbEK+pUu3dbAxHKzxfXfZFu0E6qhR6yJVOsxQhlVl1UWDWQ
         3+/5jzuHO0SuQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
configuration information of a particular PCIe controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

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

