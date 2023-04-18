Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE16E6B40
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDRRnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjDRRnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E147A85;
        Tue, 18 Apr 2023 10:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1A9663773;
        Tue, 18 Apr 2023 17:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B8C433D2;
        Tue, 18 Apr 2023 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839829;
        bh=MdyZykpiq5BpjDBeaDgyaG0Z5BebUvCvzDO8pMjMAmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+RcpWgdQeMdEkeQ1O9fcSc6bduSv61oX5qUnVu6cCs1Z8sBdsertOHGCiaYTrlUC
         ebXlgJUmgAe4Gcy6RiThLpm4S8ScoLbYBTbENHl6Y7wxzakHMlpmxxBVWMv+0m0Yqo
         adLqiCEp46M/vE1oFWHdDq/GCjGlOr38pD78YZGPejKOqGG8Yz1uDBLFaY2znBUVHy
         rSZ3rO8mTCMwuE3JfleZ7ogFRHqKNsqE1N9BlThAmnZ+MUPRHq/BcxV/wGicIUwIeH
         tJebQRPHQ2ZQeuuNvDxoxn1g63LqzN+3DwW3lMNG24nOf8ojwm9Q/mkCdVDEpO1FB0
         6Q0t3vLcWD+gA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 1/7] PCI: meson: Add 'Amlogic' to Kconfig prompt
Date:   Tue, 18 Apr 2023 12:43:30 -0500
Message-Id: <20230418174336.145585-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
References: <20230418174336.145585-1-helgaas@kernel.org>
MIME-Version: 1.0
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

From: Bjorn Helgaas <bhelgaas@google.com>

Add the "Amlogic" vendor name to the CONFIG_PCI_MESON Kconfig prompt to
match other PCIe drivers.  Capitalize "Meson" to match other Meson Kconfig
prompts.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yue Wang <yue.wang@Amlogic.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d29551261e80..617fcc7563ae 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -321,7 +321,7 @@ config PCIE_HISI_STB
 	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
 config PCI_MESON
-	tristate "MESON PCIe controller"
+	tristate "Amlogic Meson PCIe controller"
 	default m if ARCH_MESON
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-- 
2.25.1

