Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424823BCAE3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGFKxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 06:53:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54394 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhGFKxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 06:53:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 166AofKQ120207;
        Tue, 6 Jul 2021 05:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625568641;
        bh=YupTXfbCyy05B3KqZZW7b3hS1qPuZGuK9+S4VX2p/J4=;
        h=From:To:CC:Subject:Date;
        b=DSYm27J6mAOBI48g8TUnj4rBg1ygFjoi9zB3JwpevYCJOPhaI47GaFpdnE1jmHbET
         INh0sajCh58AeIIf7FdUkQjx7DUeuLX/cZ2XvcMy/qu4QrlI5RX5Hb474SiW3DbdxG
         o85FfMeOmqf4OH33g1Hd6S/K9mAOBgpQ0oDP9J9c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 166AoffZ125987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jul 2021 05:50:41 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Jul
 2021 05:50:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Jul 2021 05:50:40 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 166Aoar1015822;
        Tue, 6 Jul 2021 05:50:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nadeem Athani <nadeem@cadence.com>
Subject: [PATCH 0/5] PCI: Add support for J7200 and AM64
Date:   Tue, 6 Jul 2021 16:20:30 +0530
Message-ID: <20210706105035.9915-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds the compatible specific to J7200 and AM64 and
applies the erratas and configuration specific to them.

This series also includes Nadeem's patch that adds a quirk in
Cadence driver which is used by J7200 [1].

The DT binding for both J7200 and AM64 is already merged.

[1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com

Kishon Vijay Abraham I (4):
  PCI: j721e: Add PCIe support for J7200
  PCI: j721e: Add PCIe support for AM64
  misc: pci_endpoint_test: Do not request or allocate IRQs in probe
  misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Nadeem Athani (1):
  PCI: cadence: Add quirk flag to set minimum delay in LTSSM
    Detect.Quiet state

 drivers/misc/pci_endpoint_test.c              | 27 ++++++--
 drivers/pci/controller/cadence/pci-j721e.c    | 63 +++++++++++++++++--
 .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
 .../controller/cadence/pcie-cadence-host.c    |  3 +
 drivers/pci/controller/cadence/pcie-cadence.c | 17 +++++
 drivers/pci/controller/cadence/pcie-cadence.h | 15 +++++
 6 files changed, 119 insertions(+), 10 deletions(-)

-- 
2.17.1

