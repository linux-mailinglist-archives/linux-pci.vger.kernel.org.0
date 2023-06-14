Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9972F69A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbjFNHnJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjFNHnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 03:43:02 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 286B01727;
        Wed, 14 Jun 2023 00:43:00 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 490267A0158;
        Wed, 14 Jun 2023 09:42:58 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     helgaas@kernel.org
Cc:     rjw@rjwysocki.net, gottwald@igel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH] PCI/PM: Extend Elo i2 quirk to all systems using Continental Z2 board
Date:   Wed, 14 Jun 2023 09:42:53 +0200
Message-Id: <20230614074253.22318-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230608203158.GA1213764@bhelgaas>
References: <20230608203158.GA1213764@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The quirk for Elo i2 introduced in commit 92597f97a40b ("PCI/PM: Avoid
putting Elo i2 PCIe Ports in D3cold") is also needed by EloPOS E2/S2/H2
which uses the same Continental Z2 board.

Change the quirk to match the board instead of system.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215715
Signed-off-by: Ondrej Zary <linux@zary.sk>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..c779eb4d7fb8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2949,13 +2949,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif
-- 
2.39.2

