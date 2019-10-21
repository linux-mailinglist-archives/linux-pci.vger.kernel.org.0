Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8406DEC24
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfJUM0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 08:26:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54831 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfJUM0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 08:26:35 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191021122632epoutp033d0ba588368fff3ef1d2d4c82bb7abb5~PqSoCsjo92577025770epoutp037
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 12:26:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191021122632epoutp033d0ba588368fff3ef1d2d4c82bb7abb5~PqSoCsjo92577025770epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571660792;
        bh=Ib8mQYcAATt7VC/ozZSjbgQ4fyxDkPbivTJaQXT9kTU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Z970tQQcAQKqVuiEhEqBw/PoifBpOUJ3dN2dJdLGDYPyH7e8LIfE8GhmBy+BskQ8Z
         LGEkDTAO2yWdRuZWFKew/0I92Tl6VqJB35+byAmPjSMmICyk1m4r6KKpH2boOsJmq0
         T157LDJ7dORA1z0hqIHf442jmp8qapjoP2a0Dz3E=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191021122631epcas5p441ec4095a56595f6bb88d3065ea8199c~PqSmvKwR42322723227epcas5p4w;
        Mon, 21 Oct 2019 12:26:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.F6.04660.7F3ADAD5; Mon, 21 Oct 2019 21:26:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191021122630epcas5p32bd92762c4304035cad5c1822d96e304~PqSmDKWob2825528255epcas5p3P;
        Mon, 21 Oct 2019 12:26:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191021122630epsmtrp1f9091c284304576aa739d5e3e0f35ee5~PqSmCcBig0379003790epsmtrp1F;
        Mon, 21 Oct 2019 12:26:30 +0000 (GMT)
X-AuditID: b6c32a4a-5f7ff70000001234-54-5dada3f79b13
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.FC.03889.6F3ADAD5; Mon, 21 Oct 2019 21:26:30 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191021122629epsmtip1ddbc1e74c4a1df5055eb035be96e15ca~PqSkfHkg82000820008epsmtip1y;
        Mon, 21 Oct 2019 12:26:28 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for ZRX-DC
 PHY property
Date:   Mon, 21 Oct 2019 17:55:55 +0530
Message-Id: <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCmpu73xWtjDV7PYrY4u2shq8WSpgyL
        +UfOsVrsutvBbrHiy0x2i8u75rBZnJ13nM1i6fWLTBaLtn5ht2jde4Tdgctjzbw1jB47Z91l
        91iwqdRj06pONo++LasYPbbs/8zo8XmTXAB7FJdNSmpOZllqkb5dAldG5+YDTAW7uSpOXZnJ
        3sD4naOLkZNDQsBEYvftc+wgtpDAbkaJw7u8IOxPjBLf9oRD2N8YJTomisDUX/77kbmLkQso
        vpdR4sOUo4wQTguTxNTWf0wgVWwC2hI/j+4FmsrBISIQKXG8gRWkhlngFKPEgbPTmEFqhAUi
        JLYfuQ5WzyKgKnFy3WOwOK+Ai8SCnZNZIbbJSdw81wm2TUJgDZvEv8/vmCESLhI3+h9BFQlL
        vDq+hR3ClpJ42d8GZedL9N5dCmXXSEy528EIYdtLHLgyhwXkOGYBTYn1u/RBwswCfBK9v58w
        gYQlBHglOtqEIEwlibaZ1RCNEhKL59+EOsBDYu6sqyyQ8ImVuN86m2UCo8wshJkLGBlXMUqm
        FhTnpqcWmxYY5aWW6xUn5haX5qXrJefnbmIEpwEtrx2My875HGIU4GBU4uEtWLQ2Vog1say4
        MvcQowQHs5II7x0DoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeSaxXY4QE0hNLUrNTUwtSi2Cy
        TBycUg2MmgWvP++2LXybFBemraX6xVAto8dE9/PqHTcTVXN1r15dHb1ZQ8lwTgS/3X3n7dcF
        GNP7zuWnfjh9eOIiT4Vv1106eyt527rsTnZws7ulmddqyiqkaTyuitI9ynlh/r/Cww9uqLct
        qT929dXMZUHioSp8OXkp0tVrbFXlj842tGra4qxtp6nEUpyRaKjFXFScCADVRSLP/wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO63xWtjDb7v0LI4u2shq8WSpgyL
        +UfOsVrsutvBbrHiy0x2i8u75rBZnJ13nM1i6fWLTBaLtn5ht2jde4Tdgctjzbw1jB47Z91l
        91iwqdRj06pONo++LasYPbbs/8zo8XmTXAB7FJdNSmpOZllqkb5dAldG5+YDTAW7uSpOXZnJ
        3sD4naOLkZNDQsBE4vLfj8xdjFwcQgK7GSXWXLjKBJGQkPiy9ysbhC0ssfLfc3YQW0igiUli
        2g0LEJtNQFvi59G9QHEODhGBaIkNr4RA5jALXGKUePl4CytIXFggTOJFVwlIOYuAqsTJdY+Z
        QWxeAReJBTsns0KMl5O4ea6TeQIjzwJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMEBp6W1g/HEifhDjAIcjEo8vA7T18QKsSaWFVfmHmKU4GBWEuG9Y7A2Vog3JbGyKrUoP76o
        NCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANjzpujN3693W2hktP2MHmRseSM
        bX+/BkWXl6/W5PWNi6hwLZy7fsnU0/IzW/iuGmgmr250C/vteT50zj4dg9+3Y3/3tplnh1qu
        DGUyiXC3j4n5eXPJ9Qe60cl3TP3Elyn7rGtm974lu2nO7CPqLO1ufu5ZBwsE6/g8RPaF3uj0
        stoWrqZu+02JpTgj0VCLuag4EQACwT8sNAIAAA==
X-CMS-MailID: 20191021122630epcas5p32bd92762c4304035cad5c1822d96e304
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021122630epcas5p32bd92762c4304035cad5c1822d96e304
References: <CGME20191021122630epcas5p32bd92762c4304035cad5c1822d96e304@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
specification, then after every 100ms link should transition to recovery
state during the low power states which increases power consumption.

Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
property in DesignWare controller DT node.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 78494c4050f7..9507ac38ac89 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -38,6 +38,8 @@ Optional properties:
    for data corruption. CDM registers include standard PCIe configuration
    space registers, Port Logic registers, DMA and iATU (internal Address
    Translation Unit) registers.
+- snps,phy-zrxdc-compliant: This property is needed if phy complies with the
+  ZRX-DC specification.
 RC mode:
 - num-viewport: number of view ports configured in hardware. If a platform
   does not specify it, the driver assumes 2.
-- 
2.17.1

