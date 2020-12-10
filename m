Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273522D5AEA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgLJMuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:50:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbgLJMu0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 07:50:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnOHl054477;
        Thu, 10 Dec 2020 06:49:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607604564;
        bh=dyXVorj+Oj06fTeJdoJln15ZodxygE5nv0OPXaSQGYs=;
        h=From:To:CC:Subject:Date;
        b=fwpvRVH1JzQoCdWHXtv6NeiKwrYY9Y4smmo5IM+2TZg5FMnSY/86hiy594SCGlFHe
         YDEVWwe6VL4TKLz/GMzvSUtx+N29D/7Sgm5c0w5jK5SC4ojBw8NfOT31BitvCLOU7j
         ldmX4b96umdZ7BS/CPFH1toP1no7u8/9VDaHsWiY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BACnOlN108501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 06:49:24 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 06:49:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 06:49:24 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnKJL112244;
        Thu, 10 Dec 2020 06:49:20 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH 0/4] PCI: J7: J7200/J721E PCIe bindings
Date:   Thu, 10 Dec 2020 18:19:13 +0530
Message-ID: <20201210124917.24185-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series adds PCIe binding for J7200 and and fixes
"ti,syscon-pcie-ctrl" applicable to both J721E and J7200.

All the four patches here have got Acks from Rob Herring.

Ack for "dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take
argument"
lore.kernel.org/r/CAL_JsqJQju8TUZA-wu=WA-5XH4H9s2ifO8Hf4TnT5epa=Gg1ng@mail.gmail.com

Ack for "dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC"
lore.kernel.org/r/20201105165604.GA1474027@bogus

Ack for "dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC"
http://lore.kernel.org/r/20201105165627.GA1474647@bogus

Ack for "PCI: j721e: Get offset within "syscon" from
"ti,syscon-pcie-ctrl" phandle arg"
http://lore.kernel.org/r/CAL_JsqKQwx2qKJb5eAsutdHH5DevC+XH33yXrCBWE+OCrrQFYg@mail.gmail.com

Kishon Vijay Abraham I (4):
  dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
  dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
  dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
  PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl"
    phandle arg

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 21 ++++++++++----
 .../bindings/pci/ti,j721e-pci-host.yaml       | 27 +++++++++++++-----
 drivers/pci/controller/cadence/pci-j721e.c    | 28 +++++++++++++------
 3 files changed, 54 insertions(+), 22 deletions(-)

-- 
2.17.1

