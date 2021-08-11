Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730443E91AB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHKMj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:39:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhHKMjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:39:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCcpDx018046;
        Wed, 11 Aug 2021 07:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685531;
        bh=pHvrbMNdD6ZqFqlIVcWlZcPt0n1QzBmXRLI7yry//as=;
        h=From:To:CC:Subject:Date;
        b=iv504BLIU5mYMTDZbZ6J0lilFMqCmft/7aBf8s+xxcKkcyXyGd1jBmRKRb41NbH1i
         4WNSzusDLeRLMDKvKKCFvEfuutNwN7uAdT85Nah3ehKais/FUBJx5qZPYYlPFj55TO
         +cf+v4+agb2nL6prbj58o+qGmPDmxCD3hAFLc2U0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCcpw5018400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:38:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:38:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:38:51 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCckKx053470;
        Wed, 11 Aug 2021 07:38:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] PCI: Add legacy interrupt support in pci-j721e
Date:   Wed, 11 Aug 2021 18:08:44 +0530
Message-ID: <20210811123846.31921-1-kishon@ti.com>
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
errata but is functional in J7200. Hence legacy interrupt support is not
added for J721E

v1 of the patch series can be found @ [1]
Patch series is created on top of [2]

Changes from v2:
1) Dropped legacy interrupt support for J721e
2) Enable legacy interrupts registers in .irq_enable callback

Changes from v1:
1) Only the legacy interrupt specific part is sent as part of this
series. Rest are split and sent as a separate series [2]
2) Created irq_chip for legacy interrupt and used it's ops for enabling,
disabling the interrupts.

[1] -> http://lore.kernel.org/r/20210325090936.9306-1-kishon@ti.com
[2] -> https://lore.kernel.org/linux-omap/20210811123336.31357-1-kishon@ti.com/

Kishon Vijay Abraham I (2):
  dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
  PCI: j721e: Add PCI legacy interrupt support for J7200

 .../bindings/pci/ti,j721e-pci-host.yaml       |  15 +++
 drivers/pci/controller/cadence/pci-j721e.c    | 119 ++++++++++++++++++
 2 files changed, 134 insertions(+)

-- 
2.17.1

