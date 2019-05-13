Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B841BCE6
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfEMSJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18159 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2db0000>; Mon, 13 May 2019 11:09:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:24 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:24 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:23 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:20 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 23/29] dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
Date:   Mon, 13 May 2019 23:37:38 +0530
Message-ID: <20190513180744.16493-24-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770971; bh=73Z4NcD9AZJXyEFB6teAMzqjtfymV4WvYIAkvN3EXZI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hY6lxyz18sX1qPZDgMqRY/b+SFU/UdIu0e+Lh++laLCfhtTEz+v2Ctc9LfeMboXEE
         E/xzKrBcm4ccprD85GbnnbyloWP0bqoBKRkARBf7yR2T5QAQ0UoqJ68Wa902i6YeZS
         zojDGvdqJItXEfeYLiOLXWSXcjAiTvg2Mo0iwFquF5Phofa+Ie7c1KTZ6v3KbtdzK5
         NWrwBeEq7hJSfIY78JaxFSnatmqTfqaoqO+1yn9MnYoDuSHbpNWbiOyTRkQDBFpX/u
         dJPlLhKji/VUvo+igvCYtdhfMITS/EHwOVFq4r5BwqszCXCx1PZn9CNbm3/gT0Lzgt
         Po/+W6YGIhSjw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
in low power mode.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3: No change

V2: Using standard pinctrl names, default and idle

 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 145a4f04194f..7939bca47861 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -65,6 +65,14 @@ Required properties:
   - afi
   - pcie_x
 
+Optional properties:
+- pinctrl-names: A list of pinctrl state names. Must contain the following
+  entries:
+  - "default": active state, puts PCIe I/O out of deep power down state
+  - "idle": puts PCIe I/O into deep power down state
+- pinctrl-0: phandle for the default/active state of pin configurations.
+- pinctrl-1: phandle for the idle state of pin configurations.
+
 Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
 - phy-names: Must include the following entries:
-- 
2.17.1

