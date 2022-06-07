Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E6542686
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbiFHBDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588482AbiFGXym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88BCEF045;
        Tue,  7 Jun 2022 16:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41DA96164B;
        Tue,  7 Jun 2022 23:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10924C3411C;
        Tue,  7 Jun 2022 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654643482;
        bh=q/o80BpaLgRq9iVSp9QC1eQiLILACxZY1sBOydVH6c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSdiaQ8MPODZjy5tDCOevIDkXOoy9Rr3/RmUG+ckiC5TfPZsA1nM06aziSbFsTNRs
         jiczumAUXXeAqcsQUKVCqrNEiTOzLsAxvVlaofM0VxH86Mk0rncLhIjSpRjVaOA8pV
         yBgMr53BFgdhKNzguNpDfTAt/XgQ4ggsAlzKmN7WzwC+EIF6+rUJ1WDYsL4w0b/7oX
         3zS16NTTje4k6E60swxizXIxmNAmlj5otazvKI8Ll3RxrDKTAwZtueLgqgMcUl1owK
         QaplqBmQsZGJuh6XDxembUwbwKeh391b2pG1oj0ENjoN9Lg9pjqvdYCHFV0YlPuytd
         CNin5j+D8q3cQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] video: fbdev: skeletonfb: Convert to generic power management
Date:   Tue,  7 Jun 2022 18:11:12 -0500
Message-Id: <20220607231112.354165-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607231112.354165-1-helgaas@kernel.org>
References: <20220607231112.354165-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
deprecated.  If drivers implement power management, they should use the
generic power management framework, not the PCI-specific hooks.

Convert the sample code to use the generic power management framework.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/video/fbdev/skeletonfb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index bcacfb6934fa..70ba78450837 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -838,9 +838,9 @@ static void xxxfb_remove(struct pci_dev *dev)
  *
  *      See Documentation/driver-api/pm/devices.rst for more information
  */
-static int xxxfb_suspend(struct pci_dev *dev, pm_message_t msg)
+static int xxxfb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct xxxfb_par *par = info->par;
 
 	/* suspend here */
@@ -853,9 +853,9 @@ static int xxxfb_suspend(struct pci_dev *dev, pm_message_t msg)
  *
  *      See Documentation/driver-api/pm/devices.rst for more information
  */
-static int xxxfb_resume(struct pci_dev *dev)
+static int xxxfb_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct xxxfb_par *par = info->par;
 
 	/* resume here */
@@ -873,14 +873,15 @@ static const struct pci_device_id xxxfb_id_table[] = {
 	{ 0, }
 };
 
+static SIMPLE_DEV_PM_OPS(xxxfb_pm_ops, xxxfb_suspend, xxxfb_resume);
+
 /* For PCI drivers */
 static struct pci_driver xxxfb_driver = {
 	.name =		"xxxfb",
 	.id_table =	xxxfb_id_table,
 	.probe =	xxxfb_probe,
 	.remove =	xxxfb_remove,
-	.suspend =      xxxfb_suspend, /* optional but recommended */
-	.resume =       xxxfb_resume,  /* optional but recommended */
+	.driver.pm =	xxxfb_pm_ops, /* optional but recommended */
 };
 
 MODULE_DEVICE_TABLE(pci, xxxfb_id_table);
-- 
2.25.1

