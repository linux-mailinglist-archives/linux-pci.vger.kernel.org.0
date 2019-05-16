Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5011FF2B
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEPFyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8989 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEPFyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb220000>; Wed, 15 May 2019 22:54:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:35 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:32 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 23/28] dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
Date:   Thu, 16 May 2019 11:23:02 +0530
Message-ID: <20190516055307.25737-24-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986082; bh=5zXrmiaHUKs6SIIvx1WiF4WNJDqK6pSOeSjOtFii8/8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JQ29f8ougo3zjSpFl2CT9iFAUY9uq3pugwbqJmJvAO9gYbQv4IfzDrNgWdDUWCLja
         myOjkZX9yUBzKKj2eA7y4SN9Vci90A6b+NXuedChbsPpWuwKLNDB1j/YW7n4IubcO7
         OMCLf4lSxXknQWrrfq/L+5+BX4oCZXdEeu+n7ZFaqL6i4M84URV1DEVrsDWgHR+ssD
         zPqzqMj3yFgND1nABXjFCOyjClYB12XZxfR9oW+yznvb7EXanzaONTh97m7mztPXZE
         jipRPZmiqHLdHWdtfnZDjGQj2urwhft9ArlqVNYDzRqg0KBdsgqcy1lFm9dc4vxzEv
         wuwZp2aB5zIeg==
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

