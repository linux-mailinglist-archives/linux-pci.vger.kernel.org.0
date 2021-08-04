Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D013E01F4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhHDN3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 09:29:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54582 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhHDN3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 09:29:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 174DTHdl057534;
        Wed, 4 Aug 2021 08:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628083757;
        bh=9moRnrpmBjB7p9uddZsLa7NQ+66WsK44V3pFNOwnlg4=;
        h=From:To:CC:Subject:Date;
        b=KPFZxPtZToLnl5xYXzEEpBRGqdZ6ca4xjXLb2/1BnFMIUfJShX6Lojvzc5/2j1SV1
         cQdBcWO/VyykfJ7B/yytIZfmXrDmBinYHiqKwVhQ1QjZZwgbC7S9MG2TPLaFd8ZXet
         f2sUHVDku0l1hQc9VDf2UwQY04tQ3r/fKg072LCk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 174DTHdJ043103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Aug 2021 08:29:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 08:29:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 4 Aug 2021 08:29:17 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 174DTDpd029237;
        Wed, 4 Aug 2021 08:29:14 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/3] PCI: Add legacy interrupt support in pci-j721e
Date:   Wed, 4 Aug 2021 18:59:09 +0530
Message-ID: <20210804132912.30685-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series adds support for legacy interrupt in pci-j721e. There are
two HW implementations of legacy interrupt controller, one specific to
J721E and the other for J7200/AM64.

In both these implementations, the legacy interrupt is connect to pulse
interrupt of GIC and level to pulse is handled by configuring EOI
register. EOI to convert level to pulse is broken in J721E due to an
errata but is functional in J7200.

v1 of the patch series can be found @ [1]
Patch series is created on top of [2]

Changes from v1:
1) Only the legacy interrupt specific part is sent as part of this
series. Rest are split and sent as a separate series [2]
2) Created irq_chip for legacy interrupt and used it's ops for enabling,
disabling the interrupts.

[1] -> http://lore.kernel.org/r/20210325090936.9306-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20210803074932.19820-1-kishon@ti.com

Kishon Vijay Abraham I (3):
  dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
  PCI: j721e: Add PCI legacy interrupt support for J721E
  PCI: j721e: Add PCI legacy interrupt support for J7200

 .../bindings/pci/ti,j721e-pci-host.yaml       |  15 ++
 drivers/pci/controller/cadence/pci-j721e.c    | 150 ++++++++++++++++++
 2 files changed, 165 insertions(+)

-- 
2.17.1

