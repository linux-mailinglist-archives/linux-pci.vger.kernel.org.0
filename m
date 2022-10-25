Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6760D5B2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiJYUjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiJYUjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 16:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CEAD03AA;
        Tue, 25 Oct 2022 13:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9635561939;
        Tue, 25 Oct 2022 20:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65BC433C1;
        Tue, 25 Oct 2022 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666730354;
        bh=eKHajaFPUWFcahp2dCsnvEJvSfJoqHc/LouZANgGWxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue1ItoRnu0SGGKifXtX8/BOQCE5RlSxjOh72lh1UAlf7++SLT1PIXarNnwTHdSLI4
         CtzCDgMAD0/cK7zpVttgolq67WApv/pz94yGPGjEbOpMnxn+UrSQ7ZfKmGnBZtCxV8
         Cc/NncDWwMwztb4RfVBL0wka5Mklf6flf9LpvCRJ5Ge3InJJ7+wifnLdqcB55Lxb5f
         6KWI8y4SD+5Vek7NNCXL6OwnGB4W/wbT6DI3K92qdPuJZ7+AqTSW6ZftpiMjTSqqpU
         dS6Y79nwfSt2Z0BngaTp3zKD7zAybnZrWgAET0/W12O/9E/qopzxJ9eDxVsftE9g0c
         mKHoFjOoDg5Fw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@redhat.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 8/8] agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()
Date:   Tue, 25 Oct 2022 15:38:52 -0500
Message-Id: <20221025203852.681822-9-helgaas@kernel.org>
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
 drivers/char/agp/via-agp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index b2f484f527fb..bc5140af2dcb 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -489,9 +489,7 @@ static void agp_via_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#define agp_via_suspend NULL
-
-static int __maybe_unused agp_via_resume(struct device *dev)
+static int agp_via_resume(struct device *dev)
 {
 	struct agp_bridge_data *bridge = dev_get_drvdata(dev);
 
@@ -551,7 +549,7 @@ static const struct pci_device_id agp_via_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
 
-static SIMPLE_DEV_PM_OPS(agp_via_pm_ops, agp_via_suspend, agp_via_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(agp_via_pm_ops, NULL, agp_via_resume);
 
 static struct pci_driver agp_via_pci_driver = {
 	.name		= "agpgart-via",
-- 
2.25.1

