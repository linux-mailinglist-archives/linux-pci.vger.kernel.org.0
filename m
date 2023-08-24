Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF17878A2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbjHXThj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbjHXThb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351781B0;
        Thu, 24 Aug 2023 12:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C781D62F30;
        Thu, 24 Aug 2023 19:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB6AC433C7;
        Thu, 24 Aug 2023 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905849;
        bh=6dM5htjtuz3wYC09SylqU1yXQX9msSG6lGcCCxKAt6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fn+ehaV0/RbQC0DvyBVHKcvkixkdD9xx2cL1ADIPUoRtHQqQnxTwXmu8cYramlh5Q
         dLajzUyk/gVPAZfY063PWlZgPHzOSZxHhzrENyY4PJ3rnFhkscDO7tmAmHydxvIS7W
         F9Wxe0M3RBvkmuk3H2/iCXNlZIzJnk/rKBEIojd0VVnc1pODITYtl+d9IdTlEklPi8
         8VpCFTWNcrsYovHLDDWMyV1KWYmo0iSO7tSD7foz2d741czmihufXtNZ9tyWfidJpN
         G3yybza14PT9fP1xXA4raYAHvqWsQfru9DXojOSc75K3nCQdDQEjkzBIiDpo3KiIEB
         vCg0qISdN87AQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 03/12] PCI: Remove unnecessary initializations
Date:   Thu, 24 Aug 2023 14:37:03 -0500
Message-Id: <20230824193712.542167-4-helgaas@kernel.org>
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

We always assign "fields" immediately, so remove the unnecessary
initializations.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1f9845377eff..a44ecf6bf5d2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -193,7 +193,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
 	unsigned long driver_data = 0;
-	int fields = 0;
+	int fields;
 	int retval = 0;
 
 	fields = sscanf(buf, "%x %x %x %x %x %x %lx",
@@ -260,7 +260,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
-	int fields = 0;
+	int fields;
 	size_t retval = -ENODEV;
 
 	fields = sscanf(buf, "%x %x %x %x %x %x",
-- 
2.34.1

