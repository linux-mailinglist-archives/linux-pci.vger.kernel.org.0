Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8EC7092F8
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjESJZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESJZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 05:25:29 -0400
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 02:25:16 PDT
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C228B10D2;
        Fri, 19 May 2023 02:25:15 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5C6AF7A025C;
        Fri, 19 May 2023 10:59:23 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     rjw@rjwysocki.net
Cc:     gottwald@igel.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: [PATCH] PCI: PM: Extend Elo i2 quirk to all systems using Continental Z2 board
Date:   Fri, 19 May 2023 10:58:53 +0200
Message-Id: <20230519085853.1079-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <11980172.O9o76ZdvQC@kreacher>
References: <11980172.O9o76ZdvQC@kreacher>
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

The quirk for Elo i2 is also needed by EloPOS E2/S2/H2 which uses the
same Continental Z2 board. Change the quirk to match the board instead
of system.
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

