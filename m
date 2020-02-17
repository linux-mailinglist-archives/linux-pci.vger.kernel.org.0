Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A71610B8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 12:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBQLLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 06:11:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52666 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgBQLLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 06:11:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01HBBlQB039631;
        Mon, 17 Feb 2020 05:11:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581937907;
        bh=YUlkxjL/5rW7/xSy0zkSYbWN6Df5HFgJ5tv8RMZL+nQ=;
        h=From:To:CC:Subject:Date;
        b=aPguU36PRPwnNWqe00LmaSV66/DGBMf8mdFtljWYkmQa5H4p/sCNIXdSrW78iWlbx
         jEIZB+hpMGEnvRPBtb+Imc/wLuJkS673EknFIBcw4EvfGEsNbSHrTtulLMH2Y0Mm9C
         QmlemScm18BkRFlc3RcfFR2U91C624YLAURT8Ow8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01HBBlA2049795;
        Mon, 17 Feb 2020 05:11:47 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 05:11:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 05:11:46 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01HBBhYK030042;
        Mon, 17 Feb 2020 05:11:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Mark Rutland <mark.rutland@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/2] dt-bindings: Convert Cadence PCIe RC/EP to DT Schema
Date:   Mon, 17 Feb 2020 16:45:17 +0530
Message-ID: <20200217111519.29163-1-kishon@ti.com>
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

Changes from v1:
*) Fix maximum values of num-lanes and cdns,no-bar-match-nbits
*) Fix example DT node for PCIe Endpoint.

Ref: Patches to convert Cadence driver to library
     https://lkml.org/lkml/2019/11/11/317

Some of this was initially part of [1], but to accelerate it getting
into upstream, sending this as a separate series.

[1] -> [1] -> http://lore.kernel.org/r/20200106102058.19183-1-kishon@ti.com

Kishon Vijay Abraham I (2):
  dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
  dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT
    schema

 .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
 .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 22 ++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 27 +++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 45 +++++++++++
 MAINTAINERS                                   |  2 +-
 8 files changed, 219 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

-- 
2.17.1

