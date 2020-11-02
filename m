Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D962A27D0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKBKML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38988 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2AC1tB012395;
        Mon, 2 Nov 2020 04:12:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311921;
        bh=row4Qmm+Sy6AeCkksWsL63c1mPytd2Sut67vK2qDDK4=;
        h=From:To:CC:Subject:Date;
        b=PHAfVHAbEycyGnfV/JY1PPz/DUNJK8GuH1xVdG5pKAjIR1f3pcwEd2w+YlyW4Y2xz
         Lndew3W++22y7bls54WhBntosA0k/djp69LRxe9LFAfw1BfVYfmh/pmTFlMSd05l9q
         9YlezcXiHN564Hybwx7GJeaenfvCde/QWhn14ceE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2AC0UD044653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:00 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:00 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtuX059084;
        Mon, 2 Nov 2020 04:11:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/8] J7200: Add PCIe DT nodes to Enable PCIe
Date:   Mon, 2 Nov 2020 15:41:46 +0530
Message-ID: <20201102101154.13598-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT binding documentation and device tree nodes to enable
PCIe in J7200.

Also included a fix in J721E that fixes the maximum number of
outbound regions. (This can go in 5.11 as it doesn't impact
any of the existing use-cases).

Kishon Vijay Abraham I (8):
  dt-bindings: mfd: ti,j721e-system-controller.yaml: Document
    "pcie-ctrl"
  dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
  dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
  arm64: dts: ti: k3-j7200-main: Add DT for WIZ and SERDES
  arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
  arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
  arm64: dts: ti: k3-j721e-main: Fix PCIe maximum outbound regions

 .../mfd/ti,j721e-system-controller.yaml       |   6 +
 .../bindings/pci/ti,j721e-pci-ep.yaml         |  10 +-
 .../bindings/pci/ti,j721e-pci-host.yaml       |  16 ++-
 .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 119 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   8 +-
 6 files changed, 188 insertions(+), 9 deletions(-)

-- 
2.17.1

