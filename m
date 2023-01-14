Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A366ACAB
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jan 2023 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjANQmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjANQmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 11:42:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582FBA5C5
        for <linux-pci@vger.kernel.org>; Sat, 14 Jan 2023 08:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFAD60B31
        for <linux-pci@vger.kernel.org>; Sat, 14 Jan 2023 16:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFAC433D2;
        Sat, 14 Jan 2023 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673714557;
        bh=i4YCkHIgF+UiVY/A3tiDYFmQuR8+E9GPempqnLVpPOo=;
        h=From:To:Cc:Subject:Date:From;
        b=N1ibEUysyKpj+Kmqkjv2/hzif5Zi965CRj73/pV/QgODRcof2BI0UAKhDeMacxlvG
         MJwK99/xOyQIXHgcXgEmG9GickjOExUaxa9OLSSWGnvBIp/DZK1nVsHGmx7ESv4rKP
         c279JBacwDZ2kWDfY1b88RmD8vcnwMepHJAlm5DUKq2jbtSgliFbibVxAaYrZ5G1Hp
         40VwPAH6FM0sc8tlc7NvBZsjdKJkKXiSWPrde3IS1AqRnjUNgpFkxeKyJeoSXEI4Gi
         685pqEi3kCQ/rjj50nXbJY/hTOJ1LFej/2A8hHdUBTQHJ72fHIr/DR/QSU/4DuHfDe
         eoZTOJGs2Mx+g==
Received: by pali.im (Postfix)
        id 22965650; Sat, 14 Jan 2023 17:42:34 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Mark driver as BROKEN
Date:   Sat, 14 Jan 2023 17:41:25 +0100
Message-Id: <20230114164125.1298-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

People are reporting that pci-mvebu.c driver does not work with recent
mainline kernel. There are more bugs which prevents its for daily usage.
So lets mark it as broken for now, until somebody would be able to fix it
in mainline kernel.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Bjorn: I would really appreciate if you take this change and send it in
pull request for v6.2 release. There is no reason to wait more longer.


I'm periodically receiving emails that driver does not work correctly
anymore, PCIe cards are not detected or that they crashes during boot.

Some of the issues are handled in patches which are waiting on the list for
a long time and nobody cares for them. Some others needs investigation.

I'm really tired in replying to those user emails as I cannot do more in
this area. I have asked more people for help but either there were only
promises without any action for more than year or simple no direction how
to move forward or what to do with it.

So mark this driver as broken. Users would see the real current state
and hopefully will stop reporting me old or new bugs.
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 1569d9a3ada0..b4a4d84a358b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -9,6 +9,7 @@ config PCI_MVEBU
 	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
+	depends on BROKEN
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
-- 
2.20.1

