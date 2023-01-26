Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAE67D76A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 22:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjAZVKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 16:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjAZVKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 16:10:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5DB2B622;
        Thu, 26 Jan 2023 13:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3984CE2383;
        Thu, 26 Jan 2023 21:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC032C433D2;
        Thu, 26 Jan 2023 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674767405;
        bh=tkiSABT0UAWsdqybXkYF62lpD7oaHL03zSEHpnUw/fU=;
        h=From:To:Cc:Subject:Date:From;
        b=UVMWHP66VSWqHnxcspBeVcXEndXXWiZ6sTmIiOgygIpouWreE7a1pVXifdoI+og3C
         A4OtBCxGauRtrS6DxIwN2Lhps1L/5IYcKncr45NPWNuHuQbXYVtbjDfE+Dvk+4iqwt
         KUfclzlHpZ3Qrvz/Rpw/3l294xY2Eicf5iJA08snfX+IUMj+HveLXrJV8bIZpBigSt
         4Tky8YmSm54pN9uAg5dO+DUbBf9kZNFB+J5Sc++CKA29YwQEDL77eW+wZJEprmockm
         TkB3GBDZfAIjeCD3AaDX6n/j/XcsUsD5Tjbkp4MbP0StOVSIHds9eLEimF7o70AKww
         ckltf65ZWneUw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Move to shared PCI tree
Date:   Thu, 26 Jan 2023 15:10:03 -0600
Message-Id: <20230126211003.1310916-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move PCI subsystem maintenance to a shared git tree to make it easier for
maintainers to collaborate.  Update MAINTAINERS accordingly.  No change to
patch submission and patchwork tracking.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..14c0b3e89c63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16115,7 +16115,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
@@ -16150,7 +16150,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	Documentation/driver-api/pci/p2pdma.rst
 F:	drivers/pci/p2pdma.c
 F:	include/linux/pci-p2pdma.h
@@ -16179,7 +16179,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	Documentation/devicetree/bindings/pci/
 F:	drivers/pci/controller/
 F:	drivers/pci/pci-bridge-emul.c
@@ -16192,7 +16192,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
 F:	arch/x86/kernel/early-quirks.c
-- 
2.25.1

