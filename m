Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE19339B026
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFDCHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 22:07:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52260 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFDCHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 22:07:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A662F202792;
        Fri,  4 Jun 2021 04:05:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com A662F202792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector4; t=1622772331;
        bh=rBhHVYYa2cvVqZWgA6IVePb2jppYe0UdKnOtfgIPo64=;
        h=From:To:Cc:Subject:Date:From;
        b=NkkZKcBWooNqI2UeCgr8oTylbJN2ukN0M0NLZ5PSx2XoDzckyg9/65b8vW69fBFdV
         xp7kLl08h/8veqkSafHAwYkb05e92j4WxnMB2gMvitne0ydovcHdufY891eOshKqLP
         Y8qaBWHQeJ+9EvwcrBdDFpcooGi80GxcPoG9xNE28f0p7ETeEFz4tjkCIiITBpXxhm
         bA8dZS8GPITmvcYYJjfBSOT1M+D4ptTyyXwBd5vJSiLPjHNt0LGM6qzvvXiMfI3bU1
         YWQ7FkLqMgQBTenM5YLFnoH0tCekyMb/Nha2VqxivchBc4qjbq1imuDi8eP2CZsoqX
         gxgLwx/XI0d/g==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B00D202768;
        Fri,  4 Jun 2021 04:05:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 8B00D202768
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 12B224012F;
        Fri,  4 Jun 2021 10:05:20 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [RESEND, V5 0/2] add one regulator used to power up pcie phy
Date:   Fri,  4 Jun 2021 09:47:47 +0800
Message-Id: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes v4->v5:
- Refine the commit logs refer to bhelgaas' comments.
- Resend v5 patch-set after CC "devicetree@vger.kernel.org"
in the mail-list.

v4:
https://patchwork.kernel.org/project/linux-pci/patch/1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com/

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  3 +++
drivers/pci/controller/dwc/pci-imx6.c                    | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+)

[RESEND, V5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY
[RESEND, V5 2/2] PCI: imx6: Enable PHY internal regulator when
