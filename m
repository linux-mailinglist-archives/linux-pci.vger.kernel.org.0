Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0270010A
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbjELHIz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjELHIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 03:08:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51011B65;
        Fri, 12 May 2023 00:06:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34C75G8h125729;
        Fri, 12 May 2023 02:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683875117;
        bh=qrcAD5FB7M7FMMCKbVwpO1WbxqwiY986JY7vFr3TIUE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JIYYyK+HO/z9iJJJBMFBGb9gEPU81TF22pkqM7kOU3EQ5FXzG83WKHlezpZbz4444
         EtN29gQDw69eF+DnbaED6kfjAXShMI5mbTTGtceUkoe1+JsJlsN2JNATxdO+ao561Y
         t2MLspfqkkYcQFTYTtnTPAtioTlam8fHrptVb7rE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34C75Gl3007289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 May 2023 02:05:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 May 2023 02:05:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 May 2023 02:05:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34C75E1w085112;
        Fri, 12 May 2023 02:05:15 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 3/3] arm64: defconfig: enable J721e PCIe controller
Date:   Fri, 12 May 2023 12:35:10 +0530
Message-ID: <20230512070510.1873171-4-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512070510.1873171-1-a-verma1@ti.com>
References: <20230512070510.1873171-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable Cadence PCIe controller and pci-j721e drivers to be built as
kernel modules.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..a4cf973e0aaa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -230,9 +230,16 @@ CONFIG_PCIE_HISI_STB=y
 CONFIG_PCIE_TEGRA194_HOST=m
 CONFIG_PCIE_VISCONTI_HOST=y
 CONFIG_PCIE_LAYERSCAPE_GEN4=y
+CONFIG_PCIE_CADENCE=m
+CONFIG_PCIE_CADENCE_HOST=m
+CONFIG_PCIE_CADENCE_EP=m
+CONFIG_PCI_J721E=m
+CONFIG_PCI_J721E_HOST=m
+CONFIG_PCI_J721E_EP=m
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_EPF_NTB=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.25.1

