Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5A2AC1AC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgKIREX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:04:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55308 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIREX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:04:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4Fh4107584;
        Mon, 9 Nov 2020 11:04:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604941455;
        bh=Bg9FYT0fE1znyq+q7h9IJnLlKZ/jB3UvEybSIbwAaHI=;
        h=From:To:CC:Subject:Date;
        b=Mtq+i8ZYoOroLqUBKSmfgbuLsASkKUJ99+JWa+HFb9kbQHO1meKQm4Fk2ll6IFJ1X
         XN0DjxHlSC3p2u3U9BX3V7zNqxlxQ+Ik++pQbbl3UwYcAnjqJkBt6X/0vjBf9xJ442
         YUIBCQwU1bZ8slAeKoyxs/HyhS7nKW8YJ/fFy0fU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9H4FXh096194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:04:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:04:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:04:14 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4AwT036684;
        Mon, 9 Nov 2020 11:04:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] J7200: Add PCIe DT nodes to Enable PCIe
Date:   Mon, 9 Nov 2020 22:34:02 +0530
Message-ID: <20201109170409.4498-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT binding documentation and device tree nodes to enable
PCIe in J7200.

Changes from v1:
*) Renamed "pcie-ctrl" to "syscon" DT node and expanded "syscon" DT
   sub-node
*) Fixed "cdns,max-outbound-regions" in EP mode and removed
   "cdns,max-outbound-regions" for RC mode.
*) Remove patches specific to J721E

V1 of the patch series can be found @:
http://lore.kernel.org/r/20201102101154.13598-1-kishon@ti.com

Kishon Vijay Abraham I (7):
  dt-bindings: mfd: ti,j721e-system-controller.yaml: Document "syscon"
  dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
  dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
  arm64: dts: ti: k3-j7200-main: Add DT for WIZ and SERDES
  arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
  arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe

 .../mfd/ti,j721e-system-controller.yaml       |  40 ++++++
 .../bindings/pci/ti,j721e-pci-ep.yaml         |  10 +-
 .../bindings/pci/ti,j721e-pci-host.yaml       |  16 ++-
 .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 118 ++++++++++++++++++
 5 files changed, 217 insertions(+), 5 deletions(-)

-- 
2.17.1

