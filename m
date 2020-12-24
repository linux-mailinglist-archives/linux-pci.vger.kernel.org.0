Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF12E268C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgLXL55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 06:57:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXL55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 06:57:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBv7h2052020;
        Thu, 24 Dec 2020 05:57:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608811027;
        bh=bDPoCuBi3kgmclo0TxNZWprdvDYs5f0BkCsZXnq5/6c=;
        h=From:To:CC:Subject:Date;
        b=J8XU076PjjxUnZ2iE0K86PD7L4TKSJGhYvLc/m7g35bS8MN8BFB+Qe2QkPNZ5bgrC
         bFx8DB1Kjby3pOElKKCEDaSn4aAeqKr5fjARWx3wmaCs+O974jOh03xlop7P3sxLHR
         icA1CNRqM5ZSQIW+chcQjGEfD1D8emHORRRnShT4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBv6Ri020110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:57:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:57:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:57:06 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBv0Hq006549;
        Thu, 24 Dec 2020 05:57:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] AM64: Add PCIe bindings and driver support
Date:   Thu, 24 Dec 2020 17:26:54 +0530
Message-ID: <20201224115658.2795-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AM64 uses the same PCIe controller as in J7200, however AM642 EVM
doesn't have a clock generator (unlike J7200 base board). Here
the clock from the SERDES has to be routed to the PCIE connector.
This series provides an option for the pci-j721e.c driver to
drive reference clock output to the connector.

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the
    connector
  dt-bindings: pci: ti,j721e: Add host mode dt-bindings for TI's AM64
    SoC
  dt-bindings: pci: ti,j721e: Add endpoint mode dt-bindings for TI's
    AM64 SoC
  PCI: j721e: Add support to provide refclk to PCIe connector

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 10 ++++---
 .../bindings/pci/ti,j721e-pci-host.yaml       | 27 ++++++++++++++-----
 drivers/pci/controller/cadence/pci-j721e.c    | 17 ++++++++++++
 3 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.17.1

