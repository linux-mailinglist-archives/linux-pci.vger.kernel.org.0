Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3A7ACF11
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 06:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjIYEX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 00:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjIYEXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 00:23:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7D92;
        Sun, 24 Sep 2023 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ILGZAfdelVgoTP+HxOb4cMyS2JXCc5vOiwjWFc+TAx4=; b=BNFEnifCAjgxh2RF+vXKaqjzDZ
        GRupHL37U4qUc6ifu4iShlMqaAp0tT6cZNPOP3jxC83eb+PEWzaa8VIC7s5lBHJesUuU/SErRAimb
        /Si67+b8F88x905/e+5+0z6TzR8Fw+PnJi62FTpe3NYnDTCTACduytwgekPUX59UhJIkR64eodcmc
        2o/aaz8dYrGwvyhERBms0QB0ErjaBC4gLyyJ5CSEbJTY8vZ287ilNOMJjL9sKiUdCaTj1b9Iwu1/v
        YNmVrOihwAeOAwBEFzHtu041L1j6sWyeGH84JdHph4srWBdkz7wW6XaWO/53ri6RUYRgRM3nUlHjO
        RM+9hRXQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkd7t-00DI3i-2o;
        Mon, 25 Sep 2023 04:23:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] PCI: make pci_assign_unassigned_resources() non-init
Date:   Sun, 24 Sep 2023 21:23:16 -0700
Message-ID: <20230925042316.15415-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a section mismatch warning on Sparc 32-bit:

WARNING: modpost: vmlinux: section mismatch in reference: leon_pci_init+0xf8 (section: .text) -> pci_assign_unassigned_resources (section: .init.text)

This is due to this comment from arch/sparc/kernel/leon_pci.c:
 * The LEON architecture does not rely on a BIOS or bootloader to setup
 * PCI for us. The Linux generic routines are used to setup resources,
 * reset values of configuration-space register settings are preserved.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/pci/setup-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2129,7 +2129,7 @@ dump:
 	pci_bus_dump_resources(bus);
 }
 
-void __init pci_assign_unassigned_resources(void)
+void pci_assign_unassigned_resources(void)
 {
 	struct pci_bus *root_bus;
 
