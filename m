Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CAF44EF5C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhKLWiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:38:06 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57444 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236011AbhKLWh6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 906771A208F;
        Fri, 12 Nov 2021 23:35:06 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 52D0C1A2089;
        Fri, 12 Nov 2021 23:35:06 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B166440A77;
        Fri, 12 Nov 2021 15:35:05 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
Date:   Fri, 12 Nov 2021 16:34:57 -0600
Message-Id: <20211112223457.10599-12-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211112223457.10599-1-leoyang.li@nxp.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sahil Malhotra <sahil.malhotra@nxp.com>

Optee node is disabled in SoC dtsi.  We are enabling it on qds board.

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 0e2cc610d138..9c74be22d263 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -349,6 +349,10 @@ &mscc_felix_port4 {
 	status = "okay";
 };
 
+&optee {
+	status = "okay";
+};
+
 &sai1 {
 	status = "okay";
 };
-- 
2.25.1

