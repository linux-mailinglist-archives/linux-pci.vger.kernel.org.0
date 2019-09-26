Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D208DBF15C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfIZLar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:30:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57100 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfIZLaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:30:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUcr9026304;
        Thu, 26 Sep 2019 06:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497438;
        bh=x66YoPfkVrSslDYTR1it1VZ0fOMT2dXKRxNtTuO8skc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TmjtRAWbIZKJfVZ26xthEV/qMcEchITjWlq+rtNw//czY8az0TSdTWyfakfAgprvy
         6+uywSjIeSNxuOlsf11Anmw5+bQMyL21Nmqtc+WAJ6w2Dn2O4QL57T2qNX9gmDcTL7
         sSN7h3HQu8Ly4IT83pwr0Q7gmtkGVsPrBQHHeB38=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBUcWY049632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:30:38 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:31 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTjs069017;
        Thu, 26 Sep 2019 06:30:34 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 01/21] dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Bus
Date:   Thu, 26 Sep 2019 16:59:13 +0530
Message-ID: <20190926112933.8922-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree bindings for PCI endpoint function bus to which
endpoint function devices should be attached.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/endpoint/pci-epf-bus.txt     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt

diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt
new file mode 100644
index 000000000000..16727ddf01f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt
@@ -0,0 +1,27 @@
+PCI Endpoint Function Bus
+
+This describes the bindings for endpoint function bus to which endpoint
+function devices should be attached.
+
+Required Properties:
+ - compatible: Should be "pci-epf-bus"
+
+One or more subnodes representing PCIe endpoint function device exposed
+to the remote host.
+
+Example:
+Following is an example of NTB device exposed to the remote host.
+
+epf_bus {
+	compatible = "pci-epf-bus";
+
+	ntb {
+		compatible = "pci-epf-ntb";
+		epcs = <&pcie0_ep>, <&pcie1_ep>;
+		epc-names = "primary", "secondary";
+		vendor-id = /bits/ 16 <0x104c>;
+		device-id = /bits/ 16 <0xb00d>;
+		num-mws = <4>;
+		mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
+	};
+};
-- 
2.17.1

