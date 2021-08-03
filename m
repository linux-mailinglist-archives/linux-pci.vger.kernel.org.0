Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF763DE77C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhHCHuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 03:50:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35722 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhHCHuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 03:50:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1737ndL5031663;
        Tue, 3 Aug 2021 02:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627976979;
        bh=jU6NdUOo1QvDJP+eJFQCU2O42F89bmLL3ZejTmPvGHk=;
        h=From:To:CC:Subject:Date;
        b=dSQa9pc7mip0liDz7RQSJn4WMD2X1/FGOvkztAz/4xNW5Yapv+Bgj8HDjknIyCbio
         D1aaKTyNHYIOR9JLS2jKg+d/9Rm1eTcJhUkHl176RDLMX+nOLlPczPBiprr0kLC9Je
         kH26BZGGTyy5p8ZTvqOF1a2l+SBDdEOCTOh/w/nc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1737ndu4120998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 02:49:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 02:49:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 3 Aug 2021 02:49:38 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1737nXrv045202;
        Tue, 3 Aug 2021 02:49:34 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v2 0/6] PCI: Add support for J7200 and AM64
Date:   Tue, 3 Aug 2021 13:19:26 +0530
Message-ID: <20210803074932.19820-1-kishon@ti.com>
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

Changes from v1:
1) As suggested by Bjorn, used unsigned int :1, instead of bool for
structure members
2) Removed using unnecessary local variables and also fixed some
code alignment

[1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
[2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com

Kishon Vijay Abraham I (5):
  PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
  PCI: j721e: Add PCIe support for J7200
  PCI: j721e: Add PCIe support for AM64
  misc: pci_endpoint_test: Do not request or allocate IRQs in probe
  misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Nadeem Athani (1):
  PCI: cadence: Add quirk flag to set minimum delay in LTSSM
    Detect.Quiet state

 drivers/misc/pci_endpoint_test.c              | 27 ++++++--
 drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
 .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
 .../controller/cadence/pcie-cadence-host.c    |  3 +
 drivers/pci/controller/cadence/pcie-cadence.c | 17 ++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
 6 files changed, 117 insertions(+), 12 deletions(-)

-- 
2.17.1

