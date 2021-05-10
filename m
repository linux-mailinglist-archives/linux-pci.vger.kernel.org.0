Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3753537919C
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhEJO4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbhEJOz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60AAC046859
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:17 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gh-0000Fk-Ky; Mon, 10 May 2021 16:15:11 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 4/7] dt-bindings: imx6q-pcie: add a property configure refclk pad usage mode
Date:   Mon, 10 May 2021 16:15:06 +0200
Message-Id: <20210510141509.929120-4-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Starting with the i.MX7, arch PCIe instance has a differential refclk pad,
which can beused in multiple ways:

- It's not used at all and the PHY reference clock is provided by a SoC
  internal source, like on the previous SOCs.
- It's used as a clock input, for the board to provide a reference clock
  for the PHY.
- It's used as a clock output, where the PHY reference clock is provided
  by a SoC internal source and the same clock is also routed to the
  refclk pad for consumption of board-level components.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 308540df99ef..3ebd8553a818 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -38,6 +38,11 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- fsl,refclk-pad-mode: Usage mode of the refclk pad. Valid values:
+  - 0: pad not used. PHY refclock is derived from SoC internal source.
+  - 1: pad input. PHY refclock is provided externally via the refclk pad.
+  - 2: pad output. PHY refclock is derived from SoC internal source and
+       provided on the refclk pad.
 
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
-- 
2.29.2

