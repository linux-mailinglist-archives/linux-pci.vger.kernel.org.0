Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B605055F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfFXJQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:16:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11760 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfFXJQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 05:16:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1094d30000>; Mon, 24 Jun 2019 02:16:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Jun 2019 02:16:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Jun 2019 02:16:04 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 09:16:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 09:16:04 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d1094ce0003>; Mon, 24 Jun 2019 02:16:03 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V11 06/12] dt-bindings: PCI: designware: Add binding for CDM register check
Date:   Mon, 24 Jun 2019 14:44:59 +0530
Message-ID: <20190624091505.1711-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624091505.1711-1-vidyas@nvidia.com>
References: <20190624091505.1711-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561367763; bh=Svmd31YxycpyO46eMiqcFVQEfjX5Oi1VhS7fqz11dow=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kqi0QvjdHc8OCaLiUa8eprfPWJwzWqnPxmQSdCP7kDTUe2mE7nMhlTVqUWHewuDQ1
         glUBzvuRLRM/X8avxjTgGwXhy7Sc4BZCMVmZrGQKm/F/RENUq9/zzk2kuuKnq10C0T
         dZw/h+58Pqr/jDCHGjWRTHHLfdxW02zA7ElCWxUnUQsh2rkCcbGGxaO21a25UGEZzt
         UNXEbqTEYhdI9VvruwwdAtpQQstE+XLuVqfZsFHMdLbkhxltCC+B0GH4RWmnacotxx
         sC2duHSGkVSZZCnOjzGXd/1CzukkjrUvTgMACmWrT50EhFlLq9C4gLlqEj5Nq6bhQk
         wRTuekWFqUOVw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to enable CDM (Configuration Dependent Module) registers check
for any data corruption. CDM registers include standard PCIe configuration
space registers, Port Logic registers and iATU and DMA registers.
Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
Version 4.90a

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since [v10]:
* None

Changes since [v9]:
* None

Changes since [v8]:
* None

Changes since [v7]:
* None

Changes since [v6]:
* Changed "enable-cdm-check" to "snps,enable-cdm-check"

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Changed flag name from 'cdm-check' to 'enable-cdm-check'
* Added info about Port Logic and DMA registers being part of CDM

Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 5561a1c060d0..3fba04da6a59 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -34,6 +34,11 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+- snps,enable-cdm-check: This is a boolean property and if present enables
+   automatic checking of CDM (Configuration Dependent Module) registers
+   for data corruption. CDM registers include standard PCIe configuration
+   space registers, Port Logic registers, DMA and iATU (internal Address
+   Translation Unit) registers.
 RC mode:
 - num-viewport: number of view ports configured in hardware. If a platform
   does not specify it, the driver assumes 2.
-- 
2.17.1

