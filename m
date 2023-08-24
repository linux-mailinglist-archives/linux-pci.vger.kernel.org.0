Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D87878A5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbjHXThi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243297AbjHXTh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6C1BDF;
        Thu, 24 Aug 2023 12:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B7F63E83;
        Thu, 24 Aug 2023 19:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40EEC433C8;
        Thu, 24 Aug 2023 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905846;
        bh=FvE1bHfRSq51w6iPVI+P4zuQ2+MxIoKwCRP0Ix/yP+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g96co2jU1FMBovyFhehbgptyzNlsDEAqOgx7UEf7JnL/hPhLBHNM5GGQga0FETAZD
         cP4rU2av5pEMkeMzPYZNRb5HcBCp+HyytKrPO9rUXQZ7Um2Tc3VMhNC9jpKuIlWtgW
         ye4xZp/jitoGtGUrRGbC0rThujL4qeKvGEhUcPL+H8n6FYBfmpuXQTOFEyAnPvf97i
         8KXcGmemPrWNZb+plyoTl3isFImLmAemghhS2bz26LjwKoCYZpPuTWIkarZSXYHjdJ
         hXDGLCBBrOP+wxx5TJ7DawCa6NVkHhc1NJGrVjT+LqMHESvNFLxDeMcgzBn8CJVFpL
         pwT7FP1eOXipw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 02/12] PCI: Unexport pcie_port_bus_type
Date:   Thu, 24 Aug 2023 14:37:02 -0500
Message-Id: <20230824193712.542167-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_port_bus_type is used only in pci-driver.c and pcie/portdrv_core.c and
pcie/portdrv_pci.c.  None of these can be built as modules, so
pcie_port_bus_type doesn't need to be exported.  Unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ae9baf801681..1f9845377eff 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1705,7 +1705,6 @@ struct bus_type pcie_port_bus_type = {
 	.name		= "pci_express",
 	.match		= pcie_port_bus_match,
 };
-EXPORT_SYMBOL_GPL(pcie_port_bus_type);
 #endif
 
 static int __init pci_driver_init(void)
-- 
2.34.1

