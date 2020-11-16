Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7552B4D06
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgKPRcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:32:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbgKPRcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:32:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHVuu8043031;
        Mon, 16 Nov 2020 11:31:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605547916;
        bh=dZGi3ypT0ZFXTzoD+yEupcW6YeD06JU7GidsOmlz2qI=;
        h=From:To:CC:Subject:Date;
        b=lOtXQKA3ZazEDBx9IBCgl6euohVmhHOLDqMPIlIhs+miIK44tSaKX/mCXBvkttQsw
         2PlT+rqw8k1jNIiHA10gQL+kfqUS+/CwUrWuSYVLGn14VCr/+CbcfxR6bklhA850bs
         T3dr0HNWOmdUtaQD00kCc/xn4alRgQ8eadI36aZI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGHVuC6076163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 11:31:56 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 11:31:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 11:31:55 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHVgJF030552;
        Mon, 16 Nov 2020 11:31:43 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] PCI: J721E: Fix Broken DT w.r.t SYSCON DT
Date:   Mon, 16 Nov 2020 23:01:38 +0530
Message-ID: <20201116173141.31873-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously a subnode to syscon node was added which has the
exact memory mapped address of pcie_ctrl but based on review comment
provided by Rob [1], the offset is now being passed as argument to
"ti,syscon-pcie-ctrl" phandle.

This series has both driver change and DT change and both has to
get in together in the -rc cycle.

[1] -> Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Kishon Vijay Abraham I (3):
  dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
  PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl"
    phandle arg
  arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
    pcieX_ctrl

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 12 +++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 12 +++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 48 ++++---------------
 drivers/pci/controller/cadence/pci-j721e.c    | 28 +++++++----
 4 files changed, 43 insertions(+), 57 deletions(-)

-- 
2.17.1

