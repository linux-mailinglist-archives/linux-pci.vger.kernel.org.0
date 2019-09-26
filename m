Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5243BBF165
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfIZLaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:30:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50088 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfIZLaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:30:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUkYQ025811;
        Thu, 26 Sep 2019 06:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497446;
        bh=kAwPRxdL1IzoZOayvlUYSsrr9LV2V6bEEofoVpSjJg8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TI7jM4NwXQzoUFUPR2HA2qpvyu4JpjUhuP8P5O5nsWLXjiWgTfmVtUU2EsCHicYhR
         F+TUSEIBBeRj1XEDjN9qThsAcEidjvenuTCwJ5Jl+Jyg9RH+xnENXNC4wWk/sQIvxt
         MCd+AwLGSz4XDg/pFG6XBKxv+WMLgaOv1eaYg9WY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUkLZ013299;
        Thu, 26 Sep 2019 06:30:46 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:46 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTju069017;
        Thu, 26 Sep 2019 06:30:42 -0500
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
Subject: [RFC PATCH 03/21] dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF NTB Device
Date:   Thu, 26 Sep 2019 16:59:15 +0530
Message-ID: <20190926112933.8922-4-kishon@ti.com>
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

Add device tree bindings for PCI endpoint NTB function device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/endpoint/pci-epf-ntb.txt     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt

diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt
new file mode 100644
index 000000000000..e7896932423e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt
@@ -0,0 +1,31 @@
+PCI Endpoint NTB Function Device
+
+This describes the bindings to be used when a NTB device has to be
+exposed to the remote host over PCIe.
+
+Required Properties:
+ - compatible: Should be "pci-epf-ntb"
+ - epcs: As defined in generic pci-epf bindings defined in pci-epf.txt
+ - epc-names: As defined in generic pci-epf bindings defined in pci-epf.txt
+ - vendor-id: As defined in generic pci-epf bindings defined in pci-epf.txt
+ - device-id: As defined in generic pci-epf bindings defined in pci-epf.txt
+ - num-mws: Specify the number of memory windows. Should not be more than 4.
+ - mws-size: List of 'num-mws' entries containing size of each memory window.
+
+Optional Properties:
+ - spad-count: Specify the number of scratchpad registers to be supported
+ - db-count: Specify the number of doorbell interrupts to be supported. Must
+	     not be greater than 32.
+
+Example:
+Following is an example of NTB device exposed to the remote host.
+
+ntb {
+	compatible = "pci-epf-ntb";
+	epcs = <&pcie0_ep>, <&pcie1_ep>;
+	epc-names = "primary", "secondary";
+	vendor-id = /bits/ 16 <0x104c>;
+	device-id = /bits/ 16 <0xb00d>;
+	num-mws = <4>;
+	mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
+};
-- 
2.17.1

