Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE6348C49
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYJKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:10:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51562 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhCYJKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:10:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P99gVs038622;
        Thu, 25 Mar 2021 04:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616663382;
        bh=mwt4wwrEtUJHC8wDADVD1cxRcCICZUaomOKQFuestNU=;
        h=From:To:CC:Subject:Date;
        b=Ej9vGqU3JieiGcS+yps0nI4AAEVAbYgFZBEMwX0B+oZSiaLhZxIS+SIdHD9PMQ1B4
         oJMt8iWovE9fnwFare97h5UMk34HpM+qpi6Mr6tFJSniPvVnTQq42lO/cxt7X1Hq+d
         2uZaUbSJ8W2w6s/gWBHETOVvgXgUIPpv18K2U5W4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P99gUn069105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:09:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:09:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:09:42 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P99b9v078373;
        Thu, 25 Mar 2021 04:09:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] PCI: Add legacy interrupt support in pci-j721e
Date:   Thu, 25 Mar 2021 14:39:32 +0530
Message-ID: <20210325090936.9306-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series adds support for legacy interrupt in pci-j721e. There are
two HW implementations of legacy interrupt controller, one specific to
J721E and the other for J7200/AM64.

In both these implementations, the legacy interrupt is connect to pulse
interrupt of GIC and level to pulse is handled by configuring EOI
register.

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
  PCI: j721e: Add PCI legacy interrupt support for J721E
  PCI: j721e: Add PCIe support for j7200
  PCI: j721e: Add PCIe support for AM64

 .../bindings/pci/ti,j721e-pci-host.yaml       |  13 ++
 drivers/pci/controller/cadence/pci-j721e.c    | 194 +++++++++++++++++-
 2 files changed, 201 insertions(+), 6 deletions(-)

-- 
2.17.1

