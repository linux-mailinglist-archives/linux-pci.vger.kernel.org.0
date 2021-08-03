Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE43DF617
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhHCUI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 16:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239007AbhHCUIz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 16:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B995F601FD;
        Tue,  3 Aug 2021 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628021324;
        bh=Kiad+fbB9uZ7a8K4bpylS6fqOKOGuHXtNDretFVJfgI=;
        h=From:To:Cc:Subject:Date:From;
        b=BLfrZWpWaYxY9Z63D1CfD4ycAPsAFJdvciJ30oHwKL43l3gvIiRPXanLKfzXMCTeg
         l/GENU9v9rF0TZSEdOtxY7XtZQLICTzxpra35X4xW9Q+PQZdeBAX5rQkTc9aMzhxsW
         UNrOJ1hmxiflv7l7kjpbaLKWFpbdNNEYXMcchmXy6map/bX0XDkyX6eA4agPmeHJcy
         xk/QLLEj3ftW8+0UL8KIBL0z5XzQU413jvN7mW+Zu9gg2ttMfZvhHgsyHpe8jV9nln
         +sujSLqNmWWdEZQF2hAIKwsLjEziQM4flvIWaqizMLrTlY7JQxtOLgUcfcHfqx9/Ub
         b5gcvxaYkytFw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] PCI: Always initialize dev in pciconfig_read
Date:   Tue,  3 Aug 2021 13:08:36 -0700
Message-Id: <20210803200836.500658-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clang warns:

drivers/pci/syscall.c:25:6: warning: variable 'dev' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
        if (!capable(CAP_SYS_ADMIN))
            ^~~~~~~~~~~~~~~~~~~~~~~
drivers/pci/syscall.c:81:14: note: uninitialized use occurs here
        pci_dev_put(dev);
                    ^~~
drivers/pci/syscall.c:25:2: note: remove the 'if' if its condition is
always false
        if (!capable(CAP_SYS_ADMIN))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pci/syscall.c:18:21: note: initialize the variable 'dev' to
silence this warning
        struct pci_dev *dev;
                           ^
                            = NULL
1 warning generated.

pci_dev_put accounts for a NULL pointer so initialize dev to NULL before
the capability check so that there is no use of uninitialized memory.

Fixes: 61a6199787d9 ("PCI: Return ~0 data on pciconfig_read() CAP_SYS_ADMIN failure")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pci/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 525f16caed1d..61a6fe3cde21 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -22,6 +22,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	int err, cfg_ret;
 
 	err = -EPERM;
+	dev = NULL;
 	if (!capable(CAP_SYS_ADMIN))
 		goto error;
 

base-commit: 21d8e94253eb09f7c94c4db00dc714efc75b8701
-- 
2.33.0.rc0

