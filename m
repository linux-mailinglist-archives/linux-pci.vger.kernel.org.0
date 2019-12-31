Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D735612D848
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLaLeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 06:34:14 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42316 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfLaLeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXiiF117359;
        Tue, 31 Dec 2019 05:33:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792025;
        bh=Zgv5kKXEm0tGssEL2rZei0b8iDsdKd/7gxbFA0EbGJ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LxTajdmEA1opLpYGrfYdkrp37fx68617N57vcZUIEsR548YXf5WMuZrPQJ7p43m/J
         gtD54EtPpLAMt5z0XGryj4uHmQLKRRdjy+dj+RRf5Ls3JPePXupRBouVwrIQK+W5xz
         rrVNeeH/kc6cPbZCZadn3QHeAPj9U1ccicCgZ4dk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBXi5n040074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:33:44 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:33:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:33:44 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX32024759;
        Tue, 31 Dec 2019 05:33:39 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/7] Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
Date:   Tue, 31 Dec 2019 17:05:28 +0530
Message-ID: <20191231113534.30405-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation to help users use PCI endpoint to create virtual
functions using configfs. An endpoint function is designated as a
virtual endpoint function device when it is linked to a physical
endpoint function device (instead of a endpoint controller).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index b6d39cdec56e..0f55c5511c6c 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -43,6 +43,7 @@ entries corresponding to EPF driver will be created by the EPF core.
 		.. <EPF Driver1>/
 			... <EPF Device 11>/
 			... <EPF Device 21>/
+			... <EPF Device 31>/
 		.. <EPF Driver2>/
 			... <EPF Device 12>/
 			... <EPF Device 22>/
@@ -68,6 +69,14 @@ created)
 				... subsys_vendor_id
 				... subsys_id
 				... interrupt_pin
+			        ... <Symlink EPF Device 31>/
+
+The <EPF Device> directory can have a list of symbolic links to
+other <EPF Device>. These symbolic links should be created by the user
+to represent the virtual functions that are bound to the physical
+function. In the above directory structure <EPF Device 11> is a physical
+function and <EPF Device 31> is a virtual function. A EPF device once it's
+linked to another EPF device, cannot be linked to a EPC device.
 
 EPC Device
 ==========
@@ -88,7 +97,8 @@ entries corresponding to EPC device will be created by the EPC core.
 
 The <EPC Device> directory will have a list of symbolic links to
 <EPF Device>. These symbolic links should be created by the user to
-represent the functions present in the endpoint device.
+represent the functions present in the endpoint device. Only <EPF Device>
+that represents a physical function can be linked to a EPC device.
 
 The <EPC Device> directory will also have a *start* field. Once
 "1" is written to this field, the endpoint device will be ready to
-- 
2.17.1

