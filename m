Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B306E6B43
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjDRRnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRRnx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3DF8A66;
        Tue, 18 Apr 2023 10:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4D363773;
        Tue, 18 Apr 2023 17:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0446CC433D2;
        Tue, 18 Apr 2023 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839831;
        bh=pEZfh99cq2P1zARfhUOHhO1PChw+njk2jDt6BjMYCjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mtp9TXED5GogTEZ8T49C1bheOxOdV13tPaZWyDtfEx6DRoVxxGH+UfWd1kjfVjF3U
         D2CtF9GF+5WKu9KitkXtLGlYniAk+03jjHy66aqxFg3smGQKfz76I8W5ZchkXCRxn4
         j2vPoHg9hd3wPpzBAkTaKp2sI2QDHiKpXp4Um+O/VFJFcNU7cBaRKzilGQAvbkhVUj
         A/GrXMkaIqQG483ajYufK3JxaJvgr/7PnrdakOpphr8Q4BGXFZFL322bf2ezBURaJU
         usDxfLVHxd0DF5/D/+zzDOFZ9hKO42zgwPyOMBoQXFLaXzdKyNa3RNukcE3UltO8C0
         hdRETNfVbE1bg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/7] PCI: hv: Add 'Microsoft' to Kconfig prompt
Date:   Tue, 18 Apr 2023 12:43:31 -0500
Message-Id: <20230418174336.145585-3-helgaas@kernel.org>
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

Add the "Microsoft" vendor name to the CONFIG_PCI_HYPERV_INTERFACE Kconfig
prompt so it matches other PCIe drivers and other Hyper-V prompts.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 42654035654a..8b1f9a3f83ea 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -285,11 +285,12 @@ config PCIE_BRCMSTB
 	  Broadcom STB based SoCs, like the Raspberry Pi 4.
 
 config PCI_HYPERV_INTERFACE
-	tristate "Hyper-V PCI Interface"
+	tristate "Microsoft Hyper-V PCI Interface"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
 	help
-	  The Hyper-V PCI Interface is a helper driver allows other drivers to
-	  have a common interface with the Hyper-V PCI frontend driver.
+	  The Hyper-V PCI Interface is a helper driver that allows other
+	  drivers to have a common interface with the Hyper-V PCI frontend
+	  driver.
 
 config PCI_LOONGSON
 	bool "LOONGSON PCI Controller"
-- 
2.25.1

