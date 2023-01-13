Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A02668834
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 01:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbjAMAM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 19:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjAMALn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 19:11:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E239228;
        Thu, 12 Jan 2023 16:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D93E3B8203F;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC89C4331D;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=OLEBLqHH4bCdLtcu6EWaCDE8DoFoBtvYvEr/xhgnxAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPoaqT1FehOp1LBHAmkfdd4LFvYnB2WCJuO9nk0LRxttWsQZcsqs1Lb31Px+MZssC
         7LowPRVcwUDUnzSq+xvfNyu8U4euiESns26jfBaGsdZoCNjhVU98MmYHgVyP/mdimF
         vvWuZOoZ8tINYJnzvmZ2HLt780zdkU4ibkOOSHWVTh9VBg12SHodnrAnZw8APD47vS
         8Uc9RP1K/Cb27OESL0jS44ZGk6qB/r+wWEP1csW9EXRklmYD2hyVD0FfQF/eMuN0fp
         mjWfUgG7WaiIjnnJG/1dSFTPVakVOdBnTfV74Et5Gnpohjjq+bvEamPUOqXEQYDvUM
         OXpWx2CWuIT9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A49985C13DF; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 08/20] drivers/pci/controller: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:20 -0800
Message-Id: <20230113001132.3375334-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
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

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 1569d9a3ada0b..b09cdc59bfd02 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -258,7 +258,7 @@ config PCIE_MEDIATEK_GEN3
 	  MediaTek SoCs.
 
 config VMD
-	depends on PCI_MSI && X86_64 && SRCU && !UML
+	depends on PCI_MSI && X86_64 && !UML
 	tristate "Intel Volume Management Device Driver"
 	help
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
-- 
2.31.1.189.g2e36527f23

