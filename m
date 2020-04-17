Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F11ADC60
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgDQLng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 07:43:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42614 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 07:43:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhRCh041068;
        Fri, 17 Apr 2020 06:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587123807;
        bh=yuBQyvA0GMGkB3omubxAVTkYVNdrDfOrC0NJg9r6+gE=;
        h=From:To:CC:Subject:Date;
        b=hXbSYv78QBjkpHXzQCHToySVSUNydXQKqqXBFvaIyp09f8vaB+L4qcJQky8vuqNMw
         51AlOLzlO1PYPluH7cxbZzZaA+zP80fWNLeGLeinLpNDSBMSLGP8z+62LQIxP8dCQv
         Osl+QUZs69bUJBfXLHXMXDk/dtQ9OetZK1WNC5c0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HBhQLl083113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 06:43:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 06:43:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 06:43:26 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhN9n088610;
        Fri, 17 Apr 2020 06:43:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] PCI: cadence: Deprecate inbound/outbound specific bindings
Date:   Fri, 17 Apr 2020 17:13:18 +0530
Message-ID: <20200417114322.31111-1-kishon@ti.com>
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

[1] -> http://lore.kernel.org/r/20200219202700.GA21908@bogus

Changes from v1:
1) Added Reviewed-by: Rob Herring <robh@kernel.org> for dt-binding patch
2) Fixed nitpick comments from Bjorn Helgaas
3) Added a patch to read 32-bit Vendor ID/Device ID property from DT

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
    bindings
  PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
    property
  PCI: cadence: Remove "cdns,max-outbound-regions" DT property
  PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
 .../controller/cadence/pcie-cadence-host.c    | 21 +++++++++-------
 drivers/pci/controller/cadence/pcie-cadence.h |  6 ++---
 7 files changed, 51 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml

-- 
2.17.1

