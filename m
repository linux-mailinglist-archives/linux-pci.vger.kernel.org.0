Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C914F34713C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 06:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhCXFsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 01:48:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56148 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhCXFsD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 01:48:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C6D591A0E7F;
        Wed, 24 Mar 2021 06:48:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 134C31A008F;
        Wed, 24 Mar 2021 06:47:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CD516402BB;
        Wed, 24 Mar 2021 06:47:50 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 0/3] add one regulator used to power up pcie phy
Date:   Wed, 24 Mar 2021 13:34:16 +0800
Message-Id: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
v1 --> v2:
Suggested by Lucas, don't use the boolean property to specify the
different power supplies to PCIe PHY.
Use one regulator to power up PCIe PHY, and the regulator APIs to
get the voltage of it.

[PATCH v2 1/3] dt-bindings: imx6q-pcie: add one regulator used to
[PATCH v2 2/3] arm64: dts: imx8mq-evk: add one regulator used to
[PATCH v2 3/3] PCI: imx: clear vreg bypass when pcie vph voltage is
