Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D896E6DF0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjDRVRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjDRVRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:17:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8594688;
        Tue, 18 Apr 2023 14:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE1BA61527;
        Tue, 18 Apr 2023 21:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F87C433EF;
        Tue, 18 Apr 2023 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681852655;
        bh=/WN+jSvvaiPgz9D3hM879Tv3AkpeCRe7ftdrJ4uxz7c=;
        h=From:To:Cc:Subject:Date:From;
        b=uCiGf+PQUM+hYkkkDjrrl0zqs/NVGHbafTX0s0bHgSxzQ8dY3lfahQQB7UnTUDDQW
         FgI9Ehh1zPVgsgLWzA3eQS8XkfajUegdGQYfe1PMCdbItKeLyJhqnLPynzSPEzMtQF
         F4FW2NOvOiOYr6hPwGLx6CLBNS9CnPyT1qMbynx7KwsqJcUKUGWWCzAvIcxOGIs95G
         WNggdS4wcnUhUt9hKMQJvlI/sw+mKxW44Sp++5dG0QwX7HRt+NOxxKtEtYNfffERd9
         ymf5FS5GdFBelamIGqIqR8Qz4SI/XbgYoiBlDt2aAWesVathVzcrSYfB7KpE84m6gW
         +TpB4W5PKKOzQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Patrick McLean <chutzpah@gentoo.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Expand comment about sorting entries
Date:   Tue, 18 Apr 2023 16:17:31 -0500
Message-Id: <20230418211731.162149-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Clarify the request to sort Vendor ID and Device ID entries by numeric
value, not alphabetically.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..4d2001b86e6b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2,7 +2,7 @@
 /*
  *	PCI Class, Vendor and Device IDs
  *
- *	Please keep sorted.
+ *	Please keep sorted by numeric Vendor ID and Device ID.
  *
  *	Do not add new entries to this file unless the definitions
  *	are shared between multiple drivers.
-- 
2.25.1

