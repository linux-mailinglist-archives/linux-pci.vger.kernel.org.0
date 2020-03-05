Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4517A30D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEKZz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 05:25:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33470 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEKZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 05:25:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025APlWP062329;
        Thu, 5 Mar 2020 04:25:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583403947;
        bh=67cJhbV6Sc6CacSrpS4iujpMiPELAghBczXEmeuLeBo=;
        h=From:To:CC:Subject:Date;
        b=g+ZkUxQxWCrBENEQmI68w9sBMAYU9JI7q/SSzJd7Plo2ijqQxOA1SWmPWzQ4+z5uS
         2yxMrkfo4fQvCSkM9H9soZQLrcaqvu6FEGzT/iQmmtrsTCVUn93qTfwPic/bfHXva8
         8YR8cBfTYxQ6Ra5h71ysT4Dc2dBmelhyUs2yQ3D0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025APlsZ116674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 04:25:47 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 04:25:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 04:25:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025APijD013418;
        Thu, 5 Mar 2020 04:25:45 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 0/4] dt-bindings: Convert Cadence PCIe RC/EP to DT Schema
Date:   Thu, 5 Mar 2020 16:00:13 +0530
Message-ID: <20200305103017.16706-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence PCIe IP is used by multiple SoC vendors (e.g. TI). Cadence
themselves have a validation platform for validating the PCIe IP which
is already in the upstream kernel. Right now the binding only exists for
Cadence platform and this will result in adding redundant binding schema
for any platform using Cadence PCIe core.

This series:
1) Create cdns-pcie.yaml which includes properties that are applicable
   to both host mode and endpoint mode of Cadence PCIe core.
2) Create cdns-pcie-host.yaml to include properties that are specific to
   host mode of Cadence PCIe core. cdns-pcie-host.yaml will include
   cdns-pcie.yaml.
3) Create cdns-pcie-ep.yaml to include properties that are specific to
   endpoint mode of Cadence PCIe core. cdns-pcie-ep.yaml will include
   cdns-pcie.yaml.
4) Remove cdns,cdns-pcie-ep.txt and cdns,cdns-pcie-host.txt which had
   the binding for Cadence "platform" and add cdns,cdns-pcie-host.yaml
   and cdns,cdns-pcie-ep.yaml schema for Cadence Platform. The schema
   for Cadence platform then includes schema for Cadence PCIe core.

Changes from v4:
*) Deprecate "cdns,max-outbound-regions" only for host mode. For EP mode
   this will be a mandatory property.

Changes from v3:
*) Add "Reviewed-by: Rob Herring <robh@kernel.org>"
*) Fix typo in SPDX header

Changes from v2:
*) Created "pci-ep.yaml" for common endpoint controller bindings
*) Deprecate "cdns,max-outbound-regions" and "cdns,no-bar-match-nbits"
   binding

Changes from v1:
*) Fix maximum values of num-lanes and cdns,no-bar-match-nbits
*) Fix example DT node for PCIe Endpoint.

Ref: Patches to convert Cadence driver to library
     https://lkml.org/lkml/2019/11/11/317

Some of this was initially part of [1], but to accelerate it getting
into upstream, sending this as a separate series.

[1] -> http://lore.kernel.org/r/20200106102058.19183-1-kishon@ti.com

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: Add PCI Endpoint Controller Schema
  dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
  dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT
    schema
  dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
    bindings

 .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 49 ++++++++++++
 .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 75 +++++++++++++++++++
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 37 +++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 23 ++++++
 .../devicetree/bindings/pci/pci-ep.yaml       | 41 ++++++++++
 MAINTAINERS                                   |  2 +-
 9 files changed, 251 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml

-- 
2.17.1

