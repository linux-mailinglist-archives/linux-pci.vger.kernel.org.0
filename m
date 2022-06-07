Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0648D542524
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiFHBCs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588478AbiFGXym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FECA47075;
        Tue,  7 Jun 2022 16:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4A461745;
        Tue,  7 Jun 2022 23:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9DCC3411E;
        Tue,  7 Jun 2022 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654643479;
        bh=y+QVg0F3fAIYsNxlSyZ9c31L5KgrkSOzkMmIiNJ4tBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J708mHBcV3ASHhE64eucN/0OCRphrtgeh9kQjlGhSOT4U0ZFoUwBXKyPChkTBPfxA
         ngybZp2fvbz4/wudpP1WJxvoCNDimmb6mbgkZbqy2q+gO+Nz2gAqPM55dQGq1aExVM
         LidHotx7s6IOD0qTW0RFSluJ9NT5PSFwO2ljiECXNMOQcx/9bhkEyszMDuyyckSK0X
         15EyOC0uyANxJSj9C1Xq9vPm6nwT4mxLoyZD6+9m+202W7iJcIQ1FWjxLzP/J3CnPp
         AzWyeBFiQ0pwINv6cS72lOUOISDxHl1PKxKVwHgGeIN8NbHEMnD3cF1GpRirUsubQ4
         QbS0GdsPbc4KA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] video: fbdev: cirrusfb: Remove useless reference to PCI power management
Date:   Tue,  7 Jun 2022 18:11:11 -0500
Message-Id: <20220607231112.354165-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607231112.354165-1-helgaas@kernel.org>
References: <20220607231112.354165-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
deprecated.  The cirrusfb driver has never implemented power management at
all, but if it ever does, it should use the generic power management
framework, not the PCI-specific hooks.

Remove the commented-out references to the PCI-specific power management
hooks.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/video/fbdev/cirrusfb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 3d47c347b897..51e072c03e1c 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2184,12 +2184,6 @@ static struct pci_driver cirrusfb_pci_driver = {
 	.id_table	= cirrusfb_pci_table,
 	.probe		= cirrusfb_pci_register,
 	.remove		= cirrusfb_pci_unregister,
-#ifdef CONFIG_PM
-#if 0
-	.suspend	= cirrusfb_pci_suspend,
-	.resume		= cirrusfb_pci_resume,
-#endif
-#endif
 };
 #endif /* CONFIG_PCI */
 
-- 
2.25.1

