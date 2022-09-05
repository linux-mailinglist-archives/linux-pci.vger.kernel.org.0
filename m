Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247A45AD946
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 20:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiIESwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIESwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 14:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B3275E3;
        Mon,  5 Sep 2022 11:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9DC0B81369;
        Mon,  5 Sep 2022 18:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4526FC433C1;
        Mon,  5 Sep 2022 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662403934;
        bh=V3DhFxwkMch9V2j0LUuXL2Z76OR6gdn4dJaqm2PVFrA=;
        h=From:To:Cc:Subject:Date:From;
        b=D8ZX/7+6iZhkm7DwdyXnnAUNzjMMjFr600fMjbbqj6JCiqX/uMRKAW08L1eh96dVM
         pztQTMKUi0MMS9SIfBxS9E68k8SVFZ8JScoc0wPjAk9MVu4TylXvBXB0IfdgjV2ddM
         VWtDoXN2Uq2KrHmYNPwJwiY3tNMlOtIsAa8DFASBrczcHrgpB94fWDgJVG4vk32twt
         DeOAEKl/CnsJBFaztcxsWC5tQrZqRNTNIGM+xXk1u+whduyrpjliDFY62vZkWnWaaz
         asRH6kz471je4aKjgDNgHThxhrRHpSdbzg8rq/2VIdOtkNJb0EVQmM1WhRKUAzIPXO
         3y4fX8uF9i6Ag==
Received: by pali.im (Postfix)
        id C5AF47D7; Mon,  5 Sep 2022 20:52:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCI: mvebu: use BIT() and GENMASK() macros instead of hardcoded hex values
Date:   Mon,  5 Sep 2022 20:51:49 +0200
Message-Id: <20220905185150.22220-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 8bde4727aca4..c222dc189567 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -44,7 +44,7 @@
 #define PCIE_WIN5_BASE_OFF	0x1884
 #define PCIE_WIN5_REMAP_OFF	0x188c
 #define PCIE_CONF_ADDR_OFF	0x18f8
-#define  PCIE_CONF_ADDR_EN		0x80000000
+#define  PCIE_CONF_ADDR_EN		BIT(31)
 #define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
 #define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
 #define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
@@ -70,13 +70,13 @@
 #define  PCIE_INT_ERR_MASK		(PCIE_INT_ERR_FATAL | PCIE_INT_ERR_NONFATAL | PCIE_INT_ERR_COR)
 #define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
-#define  PCIE_CTRL_X1_MODE		0x0001
+#define  PCIE_CTRL_X1_MODE		BIT(0)
 #define  PCIE_CTRL_RC_MODE		BIT(1)
 #define  PCIE_CTRL_MASTER_HOT_RESET	BIT(24)
 #define PCIE_STAT_OFF		0x1a04
-#define  PCIE_STAT_BUS                  0xff00
-#define  PCIE_STAT_DEV                  0x1f0000
 #define  PCIE_STAT_LINK_DOWN		BIT(0)
+#define  PCIE_STAT_BUS			GENMASK(15, 8)
+#define  PCIE_STAT_DEV			GENMASK(20, 16)
 #define PCIE_SSPL_OFF		0x1a0c
 #define  PCIE_SSPL_VALUE_SHIFT		0
 #define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
-- 
2.20.1

