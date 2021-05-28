Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6F393D54
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhE1Gsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 02:48:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48632 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhE1Gsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 02:48:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 24B201A35B5;
        Fri, 28 May 2021 08:47:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 24B201A35B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1622184424;
        bh=21r/3Ha2KwM1oZ30mKtfCuC/zWbmRZbOa780Bt3dfZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfk1Tcamfh1gL/kM834kRA8N2eGYYR99HxNAybw0k+NnBFyLL894tKdVcF7MxbNzc
         8YiyvOXHL9EBoQXxI2eaHP7ZjpdC39gSAw4F5tjVog//LOxddwbts8Ubc+BJYUJVNI
         OlSxS5knrXIj+20I49CjxzMhMG/h7OHZiMUqHFLpMaZf60mW9rDiiE/zT8ax78vXpT
         DSgt2G19+iWSpJHFn3S4P/UiC8jy/2wAYttkW8x/ebTAJ37osOQ4EZXL3nCUC1v/u7
         6a3t2pbY6QEgQWf8sAsuwA35VsvlX2/+fNnJOGwZB4T4NIKha3rC95l+eCF9BaQ/O6
         oMLxrPfI+04OA==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AA3C1A1EA7;
        Fri, 28 May 2021 08:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 0AA3C1A1EA7
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 83CEF402F6;
        Fri, 28 May 2021 14:46:52 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
Date:   Fri, 28 May 2021 14:29:42 +0800
Message-Id: <1622183383-3287-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
References: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
Add a "vph-supply" property to indicate which regulator supplies
power for the PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..d8971ab99274 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -38,6 +38,9 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- vph-supply: Should specify the regulator in charge of VPH one of the three
+  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
+  supplies.
 
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
-- 
2.17.1

