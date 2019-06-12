Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDEF421A0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437831AbfFLJzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 05:55:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9837 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437696AbfFLJzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 05:55:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00cbf80000>; Wed, 12 Jun 2019 02:55:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 02:55:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Jun 2019 02:55:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 09:55:03 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 09:55:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Jun 2019 09:55:03 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d00cbf20003>; Wed, 12 Jun 2019 02:55:03 -0700
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
Subject: [PATCH V10 08/15] dt-bindings: Add PCIe supports-clkreq property
Date:   Wed, 12 Jun 2019 15:23:32 +0530
Message-ID: <20190612095339.20118-9-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612095339.20118-1-vidyas@nvidia.com>
References: <20190612095339.20118-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560333304; bh=L/lFihiSEvCPhrdoRfhpfDJHrBMZvhI8I+hkWbTCIo0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FHGlsRp+OOi8eK1gcDDqXegmRVKSE0RlqhYTWyOCmpJ7B18NDdmcyEYE/kztnVxg1
         fYuzDlIzLPsNWanssl2ISlBJUNdziGFBcTTpWBUEcoZeA0oVHbtbN3hoTPvCn/1vm/
         y1EqVKyxg1NMMEnUTgyiTkHjBr7Gpgfp5FPRlrh4QCG4/yvx4MjP3JDPkaWOuzTHq5
         3dB06J0VagOHs9s7mHolLuk5JJDfto8mRrLGriGR0/1JAFEFr9kWqo48/jRwv1ZHk3
         O/9iRWsY+PKJ4eBDcQXfWJ03/gojElTga+JxqKxakjapDvLwIzabBvfUgEED12VTcj
         KmSCXhi1BGikw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host controllers need to know the existence of clkreq signal routing to
downstream devices to be able to advertise low power features like ASPM L1
substates. Without clkreq signal routing being present, enabling ASPM L1 sub
states might lead to downstream devices falling off the bus. Hence a new device
tree property 'supports-clkreq' is added to make such host controllers
aware of clkreq signal routing to downstream devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes since [v9]:
* None

Changes since [v8]:
* None

Changes since [v7]:
* None

Changes since [v6]:
* None

Changes since [v5]:
* s/Documentation\/devicetree/dt-bindings/ in the subject

Changes since [v4]:
* None

Changes since [v3]:
* Rebased on top of linux-next top of the tree

Changes since [v2]:
* None

Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 92c01db610df..d132f9efeb3e 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,6 +24,11 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- supports-clkreq:
+   If present this property specifies that CLKREQ signal routing exists from
+   root port to downstream device and host bridge drivers can do programming
+   which depends on CLKREQ signal existence. For example, programming root port
+   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.17.1

