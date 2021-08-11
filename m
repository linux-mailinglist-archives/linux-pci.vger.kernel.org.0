Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6D3E9191
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhHKMgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:36:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52814 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhHKMeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:34:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXg0m014858;
        Wed, 11 Aug 2021 07:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685222;
        bh=wQKg58xfu7G4pe7QXg+Kb6DRDN/qD/B/LTJP2320xY0=;
        h=From:To:CC:Subject:Date;
        b=rCIZ45AgmxPbuOQEZp3g69OQ863Jspx+lftVB86ThJci8gP3Fw+kg+B9kq5qJ6wwE
         8mGkt7HHOCPiJrbzsCkt20Y7mtE9CUJ5jLZOiV/Hvt/d+rrHHNmyVcsZeP6XjbJbZx
         QxIy81p/mi6/QFzssaF9a8O6Jcq8O7IwdKP48qkg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCXgaK117023
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:33:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:33:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:33:42 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXbiu083813;
        Wed, 11 Aug 2021 07:33:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v3 0/5] PCI: Add support for J7200 and AM64
Date:   Wed, 11 Aug 2021 18:03:31 +0530
Message-ID: <20210811123336.31357-1-kishon@ti.com>
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

v1 of the patch series can be found at [2]
v2 of the patch series can be found at [3]

Changes from v2:
1) Drop the patch that does not request or allocate IRQs in probe for
J721E/AM654
2) Fix other minor comments given by Lorenzo

Changes from v1:
1) As suggested by Bjorn, used unsigned int :1, instead of bool for
structure members
2) Removed using unnecessary local variables and also fixed some
code alignment

[1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
[2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
[3] -> https://lore.kernel.org/r/20210803074932.19820-1-kishon@ti.com

Kishon Vijay Abraham I (4):
  PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
  PCI: j721e: Add PCIe support for J7200
  PCI: j721e: Add PCIe support for AM64
  misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Nadeem Athani (1):
  PCI: cadence: Add quirk flag to set minimum delay in LTSSM
    Detect.Quiet state

 drivers/misc/pci_endpoint_test.c              |  8 +++
 drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
 .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
 .../controller/cadence/pcie-cadence-host.c    |  3 +
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +++++
 drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
 6 files changed, 103 insertions(+), 6 deletions(-)

-- 
2.17.1

