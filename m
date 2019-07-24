Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1886F735F8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfGXRtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 13:49:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1679 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRtg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 13:49:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d389a360000>; Wed, 24 Jul 2019 10:49:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 10:49:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jul 2019 10:49:35 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:34 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 17:49:34 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d389a290000>; Wed, 24 Jul 2019 10:49:33 -0700
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
Subject: [PATCH V14 09/13] dt-bindings: Add PCIe supports-clkreq property
Date:   Wed, 24 Jul 2019 23:18:20 +0530
Message-ID: <20190724174824.20933-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724174824.20933-1-vidyas@nvidia.com>
References: <20190724174824.20933-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563990582; bh=1XTlZLOeibk6Sijtie1DHOvB31jbyTTU4CG2Qvq0bZo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=La5SjQ/SwBrUoCpHQYxxSGn2IMOUkEPBLs8ULmDYHbtdLhK6yg9ET99URIhFx4gjD
         YfcKW6szfKqcEZRbWRi/NrpWoWIJ1L1CTcYPQdZdBQz84/0J+8aCNPlIa8MTxHAcNn
         cbw0IkC1zAPmgL4LnnEK+qD+IrtxQ9c1GXsHR1zGNph3NC8qOfPGihtmlqCKwso3Tk
         /Ch7OvK0f4rZeW+tmSYHSGGxv9Hof8Jc1/r211iSlZDVbH5iCLbdemmuk2hOBu81hc
         cfKpeODQwYNqK1tPgzEPaVBphr9TC6wQ4HLYUBCJA3kttA0W6egLEITiaOlxQqhJuT
         o9EXv6q9wqsVA==
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

