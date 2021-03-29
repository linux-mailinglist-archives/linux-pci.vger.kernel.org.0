Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3034C8CB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhC2IYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 04:24:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38812 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233237AbhC2IRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 04:17:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 799651A26AF;
        Mon, 29 Mar 2021 10:17:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BBE421A2699;
        Mon, 29 Mar 2021 10:17:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A2A68402EC;
        Mon, 29 Mar 2021 10:17:01 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v4 0/2] add one regulator used to power up pcie phy
Date:   Mon, 29 Mar 2021 16:03:11 +0800
Message-Id: <1617004993-29728-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
v3 -> v4
Split the DTS changes to a standalone patch from this patch-set.
And would post to Shawn to take it, after the other two are accepted
by PCIe tree.
Refine the DT binding descriptions refer to Lucas' suggestion.
Use "Regarding" to replace the "Regarding to" in the comments
refer to Krzysztof's suggestion.

v2 -> v3:
Refine the DT binding descriptions, and the condition adjustment in the codes.

v1 -> v2:
Don't use the boolean property to specify the different power supply of PCIe PHY.
Use one regulator as a supply to the PCIe controller node, and the regulator APIs
to get the voltage of it.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  3 +++
drivers/pci/controller/dwc/pci-imx6.c                    | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+)

[PATCH v4 1/2] dt-bindings: imx6q-pcie: add one regulator used to
[PATCH v4 2/2] PCI: imx: clear vreg bypass when pcie vph voltage is

