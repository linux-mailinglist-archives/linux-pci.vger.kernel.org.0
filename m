Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF211CAE32
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEHNHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 09:07:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39136 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgEHNHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 09:07:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048D6oHY082815;
        Fri, 8 May 2020 08:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588943210;
        bh=7TFi8DenwabYdupg92PMqRYeyZT1ttnchvOUlGfcwpc=;
        h=From:To:CC:Subject:Date;
        b=TqL3Pzp733fAQrOCIkHz80JSjfKlDiEM2UFYAzUyw3GGabhU9P2Gm4C7KS/giVKuo
         u29bGztq86zQOohltHNcW/FbJr2dKt7knj3L8yg5owuuj2URSasgEVXdu2eSSX52YS
         SlACno9Jma6W7hZhBnfHcspidkek4id/gYuveUMM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048D6oGH000444;
        Fri, 8 May 2020 08:06:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 08:06:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 08:06:50 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048D6kYk018673;
        Fri, 8 May 2020 08:06:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v3 0/4] PCI: cadence: Deprecate inbound/outbound specific bindings
Date:   Fri, 8 May 2020 18:36:42 +0530
Message-ID: <20200508130646.23939-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is a result of comments given by Rob Herring @ [1].
Patch series changes the DT bindings and makes the corresponding driver
changes.

Changes from v2:
1) Changed the order of patches (no solid reason. Just save some
rebasing effort for me)
2) Added Acked-by Tom and Rob except for the dma-ranges patch
3) Re-worked dma-ranges patch for it do decode multiple dma-ranges
   and configure BAR0, BAR1 and NO_BAR instead of just NO_BAR [2].

Changes from v1:
1) Added Reviewed-by: Rob Herring <robh@kernel.org> for dt-binding patch
2) Fixed nitpick comments from Bjorn Helgaas
3) Added a patch to read 32-bit Vendor ID/Device ID property from DT

[1] -> http://lore.kernel.org/r/20200219202700.GA21908@bogus
[2] -> http://lore.kernel.org/r/eb1ffcb3-264f-5174-1f25-b5b2d3269840@ti.com

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
    bindings
  PCI: cadence: Remove "cdns,max-outbound-regions" DT property
  PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
  PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
    property

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   3 +-
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml |  25 +++
 .../bindings/pci/cdns-pcie-host.yaml          |  10 ++
 .../devicetree/bindings/pci/cdns-pcie.yaml    |   8 -
 .../controller/cadence/pcie-cadence-host.c    | 151 +++++++++++++++---
 drivers/pci/controller/cadence/pcie-cadence.h |  23 ++-
 7 files changed, 182 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml

-- 
2.17.1

