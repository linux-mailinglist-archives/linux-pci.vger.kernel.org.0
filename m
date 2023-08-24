Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DA7878A9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbjHXThj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbjHXThg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C21B0;
        Thu, 24 Aug 2023 12:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6901C644D4;
        Thu, 24 Aug 2023 19:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A183C433C7;
        Thu, 24 Aug 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905853;
        bh=fSgKkOz6KJKW51DIFdH/cpNTVrz4ktudomud2D4E+30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTImTmQa3rgEXJUfnXB3J7KmfFGqi0sDbao4O/gRM0G30huBZ1Pv+2lhNaQzGl0E6
         2jPoal+4Pad7Qf9fuiZ9ajBTBjYQxqhUP3e3pFX6gNCeyb0beidOXPLCvQ/D9UI0vg
         Y9Yd/AYC6wRBIG0No310afDAoXGyZI46EYP0Uh0WfTtzlWZh7i33g+EtYqwLgg8mj3
         rAx9IJJQpUbZtabR07AnpauV4ZFW4EviZNbYoXefmwSGusRHHhRyiNxIDSDvALiG5y
         yLJXZF6UUkPaiPqVyF8kHghjBlFXNeDnaxGG9Ge47Hq+V6InF7+KbIUBwBTyNC7Iog
         DqPp9JnD7HFPQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 05/12] PCI: Use consistent put_user() pointer types
Date:   Thu, 24 Aug 2023 14:37:05 -0500
Message-Id: <20230824193712.542167-6-helgaas@kernel.org>
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

We used u8, u16, and u32 for get_user() pointer types, but "unsigned char",
"unsigned short", and "unsigned int" for put_user().

Use u8, u16, and u32 for put_user() for consistency.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/syscall.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 61a6fe3cde21..803acbf33eb2 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -52,13 +52,13 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 
 	switch (len) {
 	case 1:
-		err = put_user(byte, (unsigned char __user *)buf);
+		err = put_user(byte, (u8 __user *)buf);
 		break;
 	case 2:
-		err = put_user(word, (unsigned short __user *)buf);
+		err = put_user(word, (u16 __user *)buf);
 		break;
 	case 4:
-		err = put_user(dword, (unsigned int __user *)buf);
+		err = put_user(dword, (u32 __user *)buf);
 		break;
 	}
 	pci_dev_put(dev);
@@ -70,13 +70,13 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	   they get instead of a machine check on x86.  */
 	switch (len) {
 	case 1:
-		put_user(-1, (unsigned char __user *)buf);
+		put_user(-1, (u8 __user *)buf);
 		break;
 	case 2:
-		put_user(-1, (unsigned short __user *)buf);
+		put_user(-1, (u16 __user *)buf);
 		break;
 	case 4:
-		put_user(-1, (unsigned int __user *)buf);
+		put_user(-1, (u32 __user *)buf);
 		break;
 	}
 	pci_dev_put(dev);
-- 
2.34.1

