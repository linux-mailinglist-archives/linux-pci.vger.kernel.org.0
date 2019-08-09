Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1624E870EA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 06:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404954AbfHIErT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 00:47:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10116 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfHIErS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 00:47:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cfad70000>; Thu, 08 Aug 2019 21:47:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 21:47:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 21:47:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:47:17 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:47:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 9 Aug 2019 04:47:17 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cfad00001>; Thu, 08 Aug 2019 21:47:16 -0700
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
Subject: [PATCH V15 09/13] dt-bindings: Add PCIe supports-clkreq property
Date:   Fri, 9 Aug 2019 10:16:05 +0530
Message-ID: <20190809044609.20401-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809044609.20401-1-vidyas@nvidia.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565326039; bh=JaeDFMl3+SezdOM9rq5yR1FviGL5whud/iI/cQ7JkV4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WIisXH/iTpeIxmOFKaQl20+vf7aAk4Kp/ltPb/HAGukZgj64cYzJos0lLzHiX/yOq
         5ySbLK7gn3vXliS4CU2CfAe5xHtfa5P6guxNSIeRTz+kE3iKW+fl/lau4ANsaVBuaW
         33CeCn7AeIdqPtyrgBxTXi+J1JYG7zVgvqojWfLSP0i5qcQzJkkclFOFlfKxAO0twl
         sY+Ej1Pd2O8nbojN0oRvbnUvcyUmg0NkeSqfv+ljPhX18B4DIrtst4aQ30WhkA+lzn
         dp1vvbSf5tWXbnr6/XBzy1oP67cnYSMcc7cA8iIwLY/jQT/ArsP+Jyu4402aJzG2yZ
         ObO7zbMuamHjw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host controllers need to know the existence of clkreq signal routing
to downstream devices to be able to advertise low power features like
ASPM L1 substates. Without clkreq signal routing being present, enabling
ASPM L1 substates might lead to downstream devices being disconnected
from the bus. Hence a new device tree property 'supports-clkreq' is added
to make such host controllers aware of clkreq signal routing to
downstream devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
V15:
* None

V14:
* s/falling off the bus/being disconnected from the bus/ in commit message.

V13:
* None

V12:
* Rebased on top of linux-next top of the tree

V11:
* None

V10:
* None

V9:
* None

V8:
* None

V7:
* None

V6:
* s/Documentation\/devicetree/dt-bindings/ in the subject

V5:
* None

V4:
* Rebased on top of linux-next top of the tree

V3:
* None

V2:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 2a5d91024059..29bcbd88f457 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -27,6 +27,11 @@ driver implementation may support the following properties:
 - reset-gpios:
    If present this property specifies PERST# GPIO. Host drivers can parse the
    GPIO and apply fundamental reset to endpoints.
+- supports-clkreq:
+   If present this property specifies that CLKREQ signal routing exists from
+   root port to downstream device and host bridge drivers can do programming
+   which depends on CLKREQ signal existence. For example, programming root port
+   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.17.1

