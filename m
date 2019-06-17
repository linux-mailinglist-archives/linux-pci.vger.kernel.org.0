Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37348A9B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfFQRlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:41:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12003 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0b80005>; Mon, 17 Jun 2019 10:41:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 10:41:13 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:13 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:12 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:09 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 22/27] dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
Date:   Mon, 17 Jun 2019 23:09:47 +0530
Message-ID: <20190617173952.29363-23-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793273; bh=+pqFuAByCIJZ4WLL9oG+v7N0kYgYWiHit82owuupTQA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pt8pppvpG0AIcWY8aK6BLh5eb0kJ6zCeJmTlG2PruEv5Sk7zTIBGp8ARmyzULZoZl
         F9SrwPojFBTv4lpqjQXAs5PhIGc6n6FYyY5VNSRc1AW4ZttA68NjyNnJ051cLbo1c+
         SGYHd7nG4rU6fvS5o+zlxju4GNMXSMq/ppUq6RskEfjP5wCS5aH6Ou0doubE3g15ME
         uibJKjKNca4k6sUaG5+VY/1j0WMD+elkgcFNsyzT+qiEJx1M0BgZKdBVW6+8oGgdt4
         /ddP2+4d7EgU3cud9+qyfDw0mq22GaUiI+9S2kEDzJGewNQatOB5F6IgFch10p7LYT
         mQSg+BAept9qw==
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
V5: No change

V4: No change

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

