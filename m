Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5F16A6C2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 14:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXNFd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 08:05:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59064 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBXNFd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 08:05:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5QSX086053;
        Mon, 24 Feb 2020 07:05:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582549526;
        bh=SYBU5pE8qnsxWqM4agBgkitC2zqD/Vs7Rlu+vfpZ/Ho=;
        h=From:To:CC:Subject:Date;
        b=qaXmMS83KZP/tQwPkjqI+cxGanvDxPNW5OPXVqIlt3rIKoW/oLGjdfE8zSCwiGXyJ
         zMx6Pwgmz8SHLEQEiO/ReNuzlX0G3vpR8rT3VI7d0CcGPTTfm5s1DdQFJKlC2QHfFO
         tvyr/eoFJlcKfrWpoo367AhsiuXndgqbB8gRuTGY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5Q6L109411;
        Mon, 24 Feb 2020 07:05:26 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 07:05:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 07:05:25 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OD5M7N017839;
        Mon, 24 Feb 2020 07:05:23 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 0/4] dt-bindings: Convert Cadence PCIe RC/EP to DT Schema
Date:   Mon, 24 Feb 2020 18:39:01 +0530
Message-ID: <20200224130905.952-1-kishon@ti.com>
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
 .../bindings/pci/cdns-pcie-host.yaml          | 28 +++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    | 32 ++++++++
 .../devicetree/bindings/pci/pci-ep.yaml       | 41 ++++++++++
 MAINTAINERS                                   |  2 +-
 8 files changed, 226 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml

-- 
2.17.1

