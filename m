Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180A60D5AE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 22:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiJYUjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJYUjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 16:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0267D25A6;
        Tue, 25 Oct 2022 13:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3630B81EAC;
        Tue, 25 Oct 2022 20:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F874C433D6;
        Tue, 25 Oct 2022 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666730350;
        bh=LL+baUOB7lW6465yZqZsrPVV98M/NczV4Of/t7DTfVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOKB+YW0cPiewh7GS3QZKPXq613lrbQWi1B3nMzqMfeEhLc79CcMmWIn3+ANnFhl1
         I24wya5Zq4J98LnRl8s669mcQ0LUw55+ed9lK7oay/GGxciBzRAfBhBnVzspCUhbzp
         4XTuuLd1KyncAWYC1/04s6rBHwk0mq7fL5IhVF4Y3l1C7885iAPum54cNNpc6VTVi9
         zR4ejQTYLw5r8TLPFmQe0B9eOOTyMW4MhW4/u9ffoZX6WKZy5bPr87GmpeAuMJfTCV
         HLc8qoJxlCME77dC2hR+eAAqXpFqh9/b9SUABTN9bMxRPyFCXFqGP1/z1IWhlCs854
         fPb+JSJE6jEuQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@redhat.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 6/8] agp/amd64: Update to DEFINE_SIMPLE_DEV_PM_OPS()
Date:   Tue, 25 Oct 2022 15:38:50 -0500
Message-Id: <20221025203852.681822-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025203852.681822-1-helgaas@kernel.org>
References: <20221025203852.681822-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

As of 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old
ones"), SIMPLE_DEV_PM_OPS() is deprecated in favor of
DEFINE_SIMPLE_DEV_PM_OPS(), which has the advantage that the PM callbacks
don't need to be wrapped with #ifdef CONFIG_PM or tagged with
__maybe_unused.

Convert to DEFINE_SIMPLE_DEV_PM_OPS().  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/amd64-agp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 84a4aa9312cf..ce8651436609 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -588,9 +588,7 @@ static void agp_amd64_remove(struct pci_dev *pdev)
 	agp_bridges_found--;
 }
 
-#define agp_amd64_suspend NULL
-
-static int __maybe_unused agp_amd64_resume(struct device *dev)
+static int agp_amd64_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -727,7 +725,7 @@ static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
 	{ }
 };
 
-static SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, agp_amd64_suspend, agp_amd64_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, NULL, agp_amd64_resume);
 
 static struct pci_driver agp_amd64_pci_driver = {
 	.name		= "agpgart-amd64",
-- 
2.25.1

