Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265DF65E1C4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbjAEAlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 19:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjAEAix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 19:38:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDCDE2;
        Wed,  4 Jan 2023 16:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB71618BC;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F88C4332E;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=UjkrzubYnsQygg5xUFcf0zzRRPdEO1lA8NbpaEs5Q3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ka31L00eyKKuwmjxEQfuPzindN6L982vKDLeYcs5CqFzznr2US1FdPPZGWI6RNCtt
         kIaSdU7QLvxIA0Ct0SbEVEuTk4A1RwDtZgT5mqh5eD07DktJnn3TZV73fhMB7+jB0o
         Pw3nDIQOh4XvBiarU0nsq85ZUtvEZVJuX13KRpL7Y7e2TxfRmUXhLRibixbJknQTdd
         9cgjP4kvahLo5X8fifk8m2U7zmuhH8U2Mq3BC0og6GoakLn5fzEa3yYnOihpnQelhV
         /mAENSBTNHcbfxgU+NUf3ztwXlPj3++PpnRsQNps1QJHj1JUYCWNY6LKzQu/lONyJn
         QUvWoVN/opOuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D48045C1C9B; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH rcu 17/27] drivers/pci/controller: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:03 -0800
Message-Id: <20230105003813.1770367-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
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

