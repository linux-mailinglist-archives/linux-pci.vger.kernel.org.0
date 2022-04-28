Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119585136E0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbiD1OcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbiD1OcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 10:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D13C8CD9D;
        Thu, 28 Apr 2022 07:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE79561CF4;
        Thu, 28 Apr 2022 14:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFC8C385A9;
        Thu, 28 Apr 2022 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651156139;
        bh=tqmZpepQTSrjezIVAf1jMbIb58zms9yz66f0qz6khaE=;
        h=From:To:Cc:Subject:Date:From;
        b=MSinTon0eN8qsamfJrrrtoKfCuSmnKgG9FtzT3PC4JKOG1j0CtuP7XniOza5iLFrM
         /0K+KtGyuJw2UyFe8ujIzx9ZJ77/ZLpU57k0L5KLA8aVe4Qiy9YkRqHQW+22+CL2mo
         dfz0qyyqdDtTTAwq3//X2s8gB39ZiELJ6S5bRt9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     bhelgaas@google.com, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, whitehat002 <hackyzh002@gmail.com>
Subject: [PATCH] PCI/ACPI: do not reference a pci device after it has been released
Date:   Thu, 28 Apr 2022 16:28:53 +0200
Message-Id: <20220428142854.1065953-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=gregkh@linuxfoundation.org; h=from:subject; bh=tqmZpepQTSrjezIVAf1jMbIb58zms9yz66f0qz6khaE=; b=owGbwMvMwCRo6H6F97bub03G02pJDElZS5b97X1bzy3C9KeiiYdn/T/u3WfXPsvk5Ow7PdeEw7Hi 7zb/jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIlwzDgtPTVPVYZtYWpPzk5PI7E8 Z1TOrsP4Z5SlM3FYhEzrE6ve7m5ulZ7OUGy3h1AQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
not found uses a pointer to a pci device whose reference has just been
dropped.  The chance that this really is a device that is now been
removed from the system is almost impossible to happen, but to be safe,
let's print out the debugging message based on the acpi root device
which we do have a valid reference to at the moment.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Reported-by: whitehat002 <hackyzh002@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/pci_root.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6f9e75d14808..ecda378dbc09 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 		 * case pdev->subordinate will be NULL for the parent.
 		 */
 		if (!pbus) {
-			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
+			dev_dbg(&root->device->dev,
+				"dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
 			pdev = NULL;
 			break;
 		}
-- 
2.36.0

