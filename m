Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D317733E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 10:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgCCJ7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 04:59:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45764 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgCCJ7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 04:59:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0239wx30004669;
        Tue, 3 Mar 2020 03:58:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583229539;
        bh=HjAC8m8mX74yllGfOtb45JtP+3cyFygiTL2RJv5MW4Y=;
        h=From:To:CC:Subject:Date;
        b=QMoEOu2IzDhbbAKCm0zIKDGwcPfkGun13PpUJ0QLbITwyBQSPpn/aGRj7g+Wsd2Dx
         00O18d6neLeC3/y74/QTUwe2BNaYDjaoWEEBlaT5L2SX1mWYbk4k0eRJ0KBDf2Iqjg
         DPKq825ZT69sczuilbr6hitsRsWbSOKtW7SGqv1o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0239wwDG104273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 03:58:58 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 03:58:58 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 03:58:58 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0239wtHk052895;
        Tue, 3 Mar 2020 03:58:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 0/4] dt-bindings: Convert Cadence PCIe RC/EP to DT Schema
Date:   Tue, 3 Mar 2020 15:33:23 +0530
Message-ID: <20200303100327.3603-1-kishon@ti.com>
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

