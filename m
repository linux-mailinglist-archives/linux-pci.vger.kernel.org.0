Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944C0BF160
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfIZLaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:30:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50076 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfIZLav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:30:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUg2U025799;
        Thu, 26 Sep 2019 06:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497442;
        bh=w4V1m2OIe5LxeaAVTxkVjAlE3hYEXz8xzCprrL6Lk3E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Uf7JmbNG6w90r/mXZUmOwfHwc9w/+6ts5g9vsD7NkUymYzdwe9dyvO+6wE7SC1Rm5
         cN+vwTY7+MxWSYWMAKAdeoXJ2HCvuzwlTIYuHg3pSwccNIHb67pjHo0ABqHmoF+1Go
         XbjyXbTKllanp7dKTj163h0SaWzKX0/UjoieX518=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBUg3m090981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:30:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:35 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTjt069017;
        Thu, 26 Sep 2019 06:30:38 -0500
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
Subject: [RFC PATCH 02/21] dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Device
Date:   Thu, 26 Sep 2019 16:59:14 +0530
Message-ID: <20190926112933.8922-3-kishon@ti.com>
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

Add device tree bindings for PCI endpoint function device. The
nodes for PCI endpoint function device should be attached to
PCI endpoint function bus.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/endpoint/pci-epf.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt

diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
new file mode 100644
index 000000000000..f006395fd526
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
@@ -0,0 +1,28 @@
+PCI Endpoint Function Device
+
+This describes the generic bindings to be used when a device has to be
+exposed to the remote host over PCIe. The device could be an actual
+peripheral in the platform or a virtual device created by the software.
+
+epcs : phandle to the endpoint controller device
+epc-names : the names of the endpoint controller device corresponding
+	    to the EPCs present in the *epcs* phandle
+vendor-id: used to identify device manufacturer
+device-id: used to identify a particular device
+baseclass-code: used to classify the type of function the device performs
+subclass-code: used to identify more specifically the function of the device
+subsys-vendor-id: used to identify vendor of the add-in card or subsystem
+subsys-id: used to specify an id that is specific to a vendor
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

