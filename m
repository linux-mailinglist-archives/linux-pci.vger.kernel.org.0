Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B946DC2C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhLHT2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:28:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36938 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhLHT2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:28:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E699CE232B;
        Wed,  8 Dec 2021 19:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1000C341CF;
        Wed,  8 Dec 2021 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638991512;
        bh=vP6f/W58TP3IqHAcgDPaq9RdV/xPL90lUKpkB6Lv618=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNOqjKq7ezrlERusPHPdRP9XugUOMPlfIQ4iSdbzrYdSDe/ejHEbZ8yn7W6HVOE6i
         aECrEKgA5A1JdZaeKiuHv5bLYBt23Dc4vKSUvbUpjRxxpOjMMdhWwrc53tvAOa6h7u
         4sNA9wEVcDYqW2sLsTbQHPqI40/noCEp3/+JdvVm680MQ+6kaqJqntknG5c+4jJkXW
         AB6QmECkW8aJMS5ifFiOMZg1cfyj85mQ8FmoZu2XSIGI2Pn/CH0coxWYTAypXp518K
         /DdLyDDDpqFtieYy10VoFwc0n97ihKmw81j52Wl+RfVON8dh8E9JsJa3NMMKRX/o9+
         grptupHmds9pg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 4/4] rsxx: Drop PCI legacy power management
Date:   Wed,  8 Dec 2021 13:24:49 -0600
Message-Id: <20211208192449.146076-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208192449.146076-1-helgaas@kernel.org>
References: <20211208192449.146076-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The rsxx driver doesn't support device suspend, so remove
rsxx_pci_suspend(), the legacy PCI .suspend() method, completely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/block/rsxx/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 8d9d69f5dfbc..19b85d16d711 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -1037,12 +1037,6 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 	kfree(card);
 }
 
-static int rsxx_pci_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	/* We don't support suspend at this time. */
-	return -ENOSYS;
-}
-
 static void rsxx_pci_shutdown(struct pci_dev *dev)
 {
 	struct rsxx_cardinfo *card = pci_get_drvdata(dev);
@@ -1083,7 +1077,6 @@ static struct pci_driver rsxx_pci_driver = {
 	.id_table	= rsxx_pci_ids,
 	.probe		= rsxx_pci_probe,
 	.remove		= rsxx_pci_remove,
-	.suspend	= rsxx_pci_suspend,
 	.shutdown	= rsxx_pci_shutdown,
 	.err_handler    = &rsxx_err_handler,
 };
-- 
2.25.1

