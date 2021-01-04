Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D192E952F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhADMnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 07:43:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35032 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhADMnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 07:43:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104Cfw1r015297;
        Mon, 4 Jan 2021 06:41:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609764118;
        bh=PDv3Jixr3M5clZhrNBfpbXuxNLrgt8dzQxEDS9DO98o=;
        h=From:To:CC:Subject:Date;
        b=tRRjTbwSyKK0+5oE7u7H9YfV5/HTw+rmvgwcZYTgx0Aq7SqrYHIQKSbw0qU/ozBZf
         qc16m6P7YryD3D+sOTS+XmGQmUxj7h0rZ70YQEmVA6HB8qCjijPWJFnwcKOJB4lc1q
         zMgA9OOkL9yzeXRBMMoEf+ZNHtorMuCDmSsGSKYE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CfwMs129208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:41:58 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:41:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:41:08 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104Cf3bg034579;
        Mon, 4 Jan 2021 06:41:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] AM64: Add PCIe bindings and driver support
Date:   Mon, 4 Jan 2021 18:10:59 +0530
Message-ID: <20210104124103.30930-1-kishon@ti.com>
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

v1 of the patch series can be found @ [1]

Changes from v1:
*) Fixed missing initialization of "ret" variable in the error path.

[1] -> http://lore.kernel.org/r/20201224115658.2795-1-kishon@ti.com

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
 drivers/pci/controller/cadence/pci-j721e.c    | 18 +++++++++++++
 3 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.17.1

