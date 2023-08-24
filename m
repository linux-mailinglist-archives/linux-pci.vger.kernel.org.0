Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA07878B4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbjHXTiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbjHXThm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC81BEC;
        Thu, 24 Aug 2023 12:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE14D644D4;
        Thu, 24 Aug 2023 19:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CEAC433C8;
        Thu, 24 Aug 2023 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905860;
        bh=WR2uedX12o42zNbFz6fgtElpTuw94brHNwE/D7VPvTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv9/wf8IS8ngbCjOeqQElMRhTWXevKFp7vBIsnGG5CvvoM+kGeveDGeUW3gKwLLOX
         zRdG3tfGR7hGGV5XBU7jOyg0L68jK6HTeIW7D4WytFcUivSNy2oM8KOjcVXUQx0doT
         pg7Of/MlZ5bjwT+qh/XQk4DtuskzMVKKrw19bDI8+mTEoTjm2hzK+bx8dV1ze5UsmY
         TQ8tX0lapV6C374epB6eBvNeQUoisIqz+JMjt1h0fCKxcNcFtoMA0UHxfF3VS9mmmY
         PSUAOgnb4hdZdLxQ0VGEoABUpjQqikAMOBNDoT6t/QyTQyr2CvhQVSzih2+I4jmy/4
         1ZuL4qiw3sfKg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 08/12] PCI: Simplify pci_dev_driver()
Date:   Thu, 24 Aug 2023 14:37:08 -0500
Message-Id: <20230824193712.542167-9-helgaas@kernel.org>
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

Simplify pci_dev_driver() by removing the "else".  The "if" case always
returns, so the "else" is superfluous.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a44ecf6bf5d2..a79c110c7e51 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1474,14 +1474,15 @@ static struct pci_driver pci_compat_driver = {
  */
 struct pci_driver *pci_dev_driver(const struct pci_dev *dev)
 {
+	int i;
+
 	if (dev->driver)
 		return dev->driver;
-	else {
-		int i;
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-			if (dev->resource[i].flags & IORESOURCE_BUSY)
-				return &pci_compat_driver;
-	}
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
+		if (dev->resource[i].flags & IORESOURCE_BUSY)
+			return &pci_compat_driver;
+
 	return NULL;
 }
 EXPORT_SYMBOL(pci_dev_driver);
-- 
2.34.1

