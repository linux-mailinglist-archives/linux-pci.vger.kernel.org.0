Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098834782F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 13:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhCXMTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 08:19:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhCXMTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 08:19:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJ65V074002;
        Wed, 24 Mar 2021 07:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616588346;
        bh=4zNAk6cBK18g4U4veJusH44WE8cfhR5G6ftOuayllUQ=;
        h=From:To:CC:Subject:Date;
        b=ZvGhMWanNegTiP0A+2Z7tt3D4B+NW6lvuWQpTFCgE2AlTv1LtS/BeCletGSLHptB+
         hLMw90449xEd3Oc02fhcGsY/dUnXC2GyQUfKcC+KEvSi01ng/hovupE4LyJjnJ4HIh
         QXXdz6YfRymBo6s13l3c++IfU5cTMsydsJz4xPoY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12OCJ5vf065772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 07:19:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 07:19:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 07:19:05 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJ1Cg121061;
        Wed, 24 Mar 2021 07:19:02 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/2] PCI: Fixes in pci-keystone driver
Date:   Wed, 24 Mar 2021 17:48:59 +0530
Message-ID: <20210324121901.1856-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series includes a couple of fixes in pci-keystone driver
for issues seen when testing Root Complex mode in K2G driver.

Kishon Vijay Abraham I (2):
  PCI: keystone: Set mode as RootComplex for "ti,keystone-pcie"
    compatible
  PCI: keystone: Add link up check in ks_child_pcie_ops.map_bus()

 drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.17.1

