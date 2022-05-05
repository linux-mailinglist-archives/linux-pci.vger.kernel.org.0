Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142DC51B9F5
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347175AbiEEIUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiEEIU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 04:20:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC249901;
        Thu,  5 May 2022 01:16:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 527911F896;
        Thu,  5 May 2022 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZPJLwAsgzNCCroRjeE9JafH9BIwjuth4vqOa5N14pw=;
        b=L9AkWL0xVkfyaETjQQnwkqUS5khHtDMf+yhkFrQWWVGL/FhZgqSqJiD6oFcqjNRK/K9rtz
        6R8uVePLGLABT2Xwd4pNjgXpVO+mNjheueg8SMDJ1wu3KzgWpc+QQ1S9WmzuZ1sM5HFo3U
        g/h5qKh9aDov7yLDD/Pzd+iMPkafJ5k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BA3413B11;
        Thu,  5 May 2022 08:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SE5QBfCHc2K1BwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 05 May 2022 08:16:48 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 17/21] xen/pcifront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu,  5 May 2022 10:16:36 +0200
Message-Id: <20220505081640.17425-18-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220505081640.17425-1-jgross@suse.com>
References: <20220505081640.17425-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pcifront's shared page creation and removal via
xenbus_setup_ring() and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/pci/xen-pcifront.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 3edc1565a27c..689271c4245c 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -709,9 +709,8 @@ static struct pcifront_device *alloc_pdev(struct xenbus_device *xdev)
 	if (pdev == NULL)
 		goto out;
 
-	pdev->sh_info =
-	    (struct xen_pci_sharedinfo *)__get_free_page(GFP_KERNEL);
-	if (pdev->sh_info == NULL) {
+	if (xenbus_setup_ring(xdev, GFP_KERNEL, (void **)&pdev->sh_info, 1,
+			      &pdev->gnt_ref)) {
 		kfree(pdev);
 		pdev = NULL;
 		goto out;
@@ -729,7 +728,6 @@ static struct pcifront_device *alloc_pdev(struct xenbus_device *xdev)
 	spin_lock_init(&pdev->sh_info_lock);
 
 	pdev->evtchn = INVALID_EVTCHN;
-	pdev->gnt_ref = INVALID_GRANT_REF;
 	pdev->irq = -1;
 
 	INIT_WORK(&pdev->op_work, pcifront_do_aer);
@@ -754,11 +752,7 @@ static void free_pdev(struct pcifront_device *pdev)
 	if (pdev->evtchn != INVALID_EVTCHN)
 		xenbus_free_evtchn(pdev->xdev, pdev->evtchn);
 
-	if (pdev->gnt_ref != INVALID_GRANT_REF)
-		gnttab_end_foreign_access(pdev->gnt_ref,
-					  (unsigned long)pdev->sh_info);
-	else
-		free_page((unsigned long)pdev->sh_info);
+	xenbus_teardown_ring((void **)&pdev->sh_info, 1, &pdev->gnt_ref);
 
 	dev_set_drvdata(&pdev->xdev->dev, NULL);
 
@@ -769,13 +763,6 @@ static int pcifront_publish_info(struct pcifront_device *pdev)
 {
 	int err = 0;
 	struct xenbus_transaction trans;
-	grant_ref_t gref;
-
-	err = xenbus_grant_ring(pdev->xdev, pdev->sh_info, 1, &gref);
-	if (err < 0)
-		goto out;
-
-	pdev->gnt_ref = gref;
 
 	err = xenbus_alloc_evtchn(pdev->xdev, &pdev->evtchn);
 	if (err)
-- 
2.35.3

