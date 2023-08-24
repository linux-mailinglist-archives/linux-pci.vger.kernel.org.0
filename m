Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA47878BE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbjHXTiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbjHXThi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403F1B0;
        Thu, 24 Aug 2023 12:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E6E644D4;
        Thu, 24 Aug 2023 19:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BAC433C8;
        Thu, 24 Aug 2023 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905856;
        bh=1t2ILVttvG2baHxYO98XJvw4Fig3WnypnrHpCN9ddyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOutsIpLq8bf8j3nxL6eCa8Al5TsCQhqNQAvgRIOorLBNx5vMo9jpjCGM45grTGBc
         kXeMvwCl1BdVQQXg1XszUU3QV3WDbuoLTkM96H1OBDBt4com6BFkdm34LEwtLgSfO8
         MWJ7GDvfc13KR/Hajcl33CyWWLq1XYd1bNqXdEfG3N7LNyr9BlYaNqs3+1uYBGUP48
         O5DLZdSffx0yC1qg0DgEVuGNlX6+i5bOn197gEedw14lnTZ5xSvhlcAlry69l1bTAg
         eHWErwzd5i+tvSKeXoKxm3gU/LSgbA/eUiO3jrCh4Nq8as6nnlTxu77PnmS02biGxx
         uZND+HvvRPvfQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 06/12] PCI/AER: Simplify AER_RECOVER_RING_SIZE definition
Date:   Thu, 24 Aug 2023 14:37:06 -0500
Message-Id: <20230824193712.542167-7-helgaas@kernel.org>
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

ACPI Platform Error Interfaces (APEI) convey error information to the OS.
If the APEI GHES driver receives information about PCI errors, it queues it
in aer_recover_ring for processing by the PCI AER code.

AER_RECOVER_RING_SIZE is the size of the aer_recover_ring FIFO and is
arbitrary, with no direct connection to hardware.

AER_RECOVER_RING_ORDER was only used to compute AER_RECOVER_RING_SIZE.
Remove it and define AER_RECOVER_RING_SIZE directly.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2bc03937452b..a30784dabdd7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -981,8 +981,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 
-#define AER_RECOVER_RING_ORDER		4
-#define AER_RECOVER_RING_SIZE		(1 << AER_RECOVER_RING_ORDER)
+#define AER_RECOVER_RING_SIZE		16
 
 struct aer_recover_entry {
 	u8	bus;
-- 
2.34.1

