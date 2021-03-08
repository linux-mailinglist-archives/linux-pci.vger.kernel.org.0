Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53D330828
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 07:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhCHGgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 01:36:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhCHGgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 01:36:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286a3SY110124;
        Mon, 8 Mar 2021 00:36:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615185363;
        bh=Oqgiy062oERwqX+R9eU5hIC/GSFaSqKW8euiNn4SusI=;
        h=From:To:CC:Subject:Date;
        b=xBySieFtiwuutlFMCE90M5Ay3VODEH0SSqL8eAXcrB8DKCLZJKGiPxnS9Xi7oa17X
         pGZSi1Rw0woGZzLFeGYbvYHjvp4Oa9tY/Rn+jDRCRBOqy0rv8vbmOozTrU3YhZjhoE
         y5yVGGBjIMQiMunVOTEqNMVE6IbAmRrT0L/M7h74=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286a2OQ016646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:36:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:36:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:36:01 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286ZuTS117458;
        Mon, 8 Mar 2021 00:35:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 0/4] AM64: Add PCIe bindings and driver support
Date:   Mon, 8 Mar 2021 12:05:46 +0530
Message-ID: <20210308063550.6227-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
v2 of the patch series can be found @ [2]
v3 of the patch series can be found @ [3]

Changes from v3:
*) Added Reviewed by from Rob
*) Incorporated Krzysztof Wilczyński comment on DT binding documentation
*) Fixed "warn: missing error code 'ret'"

Changes from v2:
*) Fix DT binding documentation suggested by Rob

Changes from v1:
*) Fixed missing initialization of "ret" variable in the error path.

[1] -> http://lore.kernel.org/r/20201224115658.2795-1-kishon@ti.com
[2] -> https://lore.kernel.org/r/20210104124103.30930-1-kishon@ti.com
[3] -> https://lore.kernel.org/r/20210222114030.26445-1-kishon@ti.com

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the
    connector
  dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64
    SoC
  dt-bindings: PCI: ti,j721e: Add endpoint mode dt-bindings for TI's
    AM64 SoC
  PCI: j721e: Add support to provide refclk to PCIe connector

 .../bindings/pci/ti,j721e-pci-ep.yaml         |  9 ++++----
 .../bindings/pci/ti,j721e-pci-host.yaml       | 20 ++++++++++++-----
 drivers/pci/controller/cadence/pci-j721e.c    | 22 ++++++++++++++++++-
 3 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.17.1

