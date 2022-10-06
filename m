Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81D5F63A0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJFJ3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFJ3e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 05:29:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82968FD5B;
        Thu,  6 Oct 2022 02:29:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 772132197F;
        Thu,  6 Oct 2022 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665048571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L7RZFM5d4dnIi1GRTKhMwES2/uyXuvfgoPRuTe96ogM=;
        b=Ci/J0VnfozSfW1tn8VrgOAeBJ0GslTmfAaoB/QDoi2AQB8js+3KZ7nxA6MxMpRSmow6xVi
        j2hmf+j+RbkQkmXnOztnb/pndUnWf44vQX6nrfx02GbaRGavkRcfPmN3RY6FOYJjL0o+cN
        1YtXQlXJfn1PeYjiWilheBlS/EyqdzM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D0A51376E;
        Thu,  6 Oct 2022 09:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Plt5DfufPmNIVAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 09:29:31 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen/pcifront: move xenstore config scanning into sub-function
Date:   Thu,  6 Oct 2022 11:29:29 +0200
Message-Id: <20221006092929.30041-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcifront_try_connect() and pcifront_attach_devices() share a large
chunk of duplicated code for reading the config information from
Xenstore, which only differs regarding a function call.

Put that code into a new sub-function. While at it fix the error
reporting in case the root-xx node had the wrong format.

As the return value of pcifront_try_connect() and
pcifront_attach_devices() are not used anywhere make those functions
return void. As an additional bonus this removes the dubious return
of -EFAULT in case of an unexpected driver state.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/pci/xen-pcifront.c | 133 +++++++++++--------------------------
 1 file changed, 40 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 689271c4245c..a68e47dcdd7e 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -819,76 +819,79 @@ static int pcifront_publish_info(struct pcifront_device *pdev)
 	return err;
 }
 
-static int pcifront_try_connect(struct pcifront_device *pdev)
+static void pcifront_connect(struct pcifront_device *pdev, bool rescan)
 {
-	int err = -EFAULT;
+	int err;
 	int i, num_roots, len;
 	char str[64];
 	unsigned int domain, bus;
 
-
-	/* Only connect once */
-	if (xenbus_read_driver_state(pdev->xdev->nodename) !=
-	    XenbusStateInitialised)
-		goto out;
-
-	err = pcifront_connect_and_init_dma(pdev);
-	if (err && err != -EEXIST) {
-		xenbus_dev_fatal(pdev->xdev, err,
-				 "Error setting up PCI Frontend");
-		goto out;
-	}
-
 	err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend,
 			   "root_num", "%d", &num_roots);
 	if (err == -ENOENT) {
 		xenbus_dev_error(pdev->xdev, err,
 				 "No PCI Roots found, trying 0000:00");
-		err = pcifront_scan_root(pdev, 0, 0);
+		if (rescan)
+			err = pcifront_rescan_root(pdev, 0, 0);
+		else
+			err = pcifront_scan_root(pdev, 0, 0);
 		if (err) {
 			xenbus_dev_fatal(pdev->xdev, err,
 					 "Error scanning PCI root 0000:00");
-			goto out;
+			return;
 		}
 		num_roots = 0;
 	} else if (err != 1) {
-		if (err == 0)
-			err = -EINVAL;
-		xenbus_dev_fatal(pdev->xdev, err,
+		xenbus_dev_fatal(pdev->xdev, err >= 0 ? -EINVAL : err,
 				 "Error reading number of PCI roots");
-		goto out;
+		return;
 	}
 
 	for (i = 0; i < num_roots; i++) {
 		len = snprintf(str, sizeof(str), "root-%d", i);
-		if (unlikely(len >= (sizeof(str) - 1))) {
-			err = -ENOMEM;
-			goto out;
-		}
+		if (unlikely(len >= (sizeof(str) - 1)))
+			return;
 
 		err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend, str,
 				   "%x:%x", &domain, &bus);
 		if (err != 2) {
-			if (err >= 0)
-				err = -EINVAL;
-			xenbus_dev_fatal(pdev->xdev, err,
+			xenbus_dev_fatal(pdev->xdev, err >= 0 ? -EINVAL : err,
 					 "Error reading PCI root %d", i);
-			goto out;
+			return;
 		}
 
-		err = pcifront_scan_root(pdev, domain, bus);
+		if (rescan)
+			err = pcifront_rescan_root(pdev, domain, bus);
+		else
+			err = pcifront_scan_root(pdev, domain, bus);
 		if (err) {
 			xenbus_dev_fatal(pdev->xdev, err,
 					 "Error scanning PCI root %04x:%02x",
 					 domain, bus);
-			goto out;
+			return;
 		}
 	}
 
-	err = xenbus_switch_state(pdev->xdev, XenbusStateConnected);
+	xenbus_switch_state(pdev->xdev, XenbusStateConnected);
+}
 
-out:
-	return err;
+static void pcifront_try_connect(struct pcifront_device *pdev)
+{
+	int err;
+
+	/* Only connect once */
+	if (xenbus_read_driver_state(pdev->xdev->nodename) !=
+	    XenbusStateInitialised)
+		return;
+
+	err = pcifront_connect_and_init_dma(pdev);
+	if (err && err != -EEXIST) {
+		xenbus_dev_fatal(pdev->xdev, err,
+				 "Error setting up PCI Frontend");
+		return;
+	}
+
+	pcifront_connect(pdev, false);
 }
 
 static int pcifront_try_disconnect(struct pcifront_device *pdev)
@@ -914,67 +917,11 @@ static int pcifront_try_disconnect(struct pcifront_device *pdev)
 	return err;
 }
 
-static int pcifront_attach_devices(struct pcifront_device *pdev)
+static void pcifront_attach_devices(struct pcifront_device *pdev)
 {
-	int err = -EFAULT;
-	int i, num_roots, len;
-	unsigned int domain, bus;
-	char str[64];
-
-	if (xenbus_read_driver_state(pdev->xdev->nodename) !=
+	if (xenbus_read_driver_state(pdev->xdev->nodename) ==
 	    XenbusStateReconfiguring)
-		goto out;
-
-	err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend,
-			   "root_num", "%d", &num_roots);
-	if (err == -ENOENT) {
-		xenbus_dev_error(pdev->xdev, err,
-				 "No PCI Roots found, trying 0000:00");
-		err = pcifront_rescan_root(pdev, 0, 0);
-		if (err) {
-			xenbus_dev_fatal(pdev->xdev, err,
-					 "Error scanning PCI root 0000:00");
-			goto out;
-		}
-		num_roots = 0;
-	} else if (err != 1) {
-		if (err == 0)
-			err = -EINVAL;
-		xenbus_dev_fatal(pdev->xdev, err,
-				 "Error reading number of PCI roots");
-		goto out;
-	}
-
-	for (i = 0; i < num_roots; i++) {
-		len = snprintf(str, sizeof(str), "root-%d", i);
-		if (unlikely(len >= (sizeof(str) - 1))) {
-			err = -ENOMEM;
-			goto out;
-		}
-
-		err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend, str,
-				   "%x:%x", &domain, &bus);
-		if (err != 2) {
-			if (err >= 0)
-				err = -EINVAL;
-			xenbus_dev_fatal(pdev->xdev, err,
-					 "Error reading PCI root %d", i);
-			goto out;
-		}
-
-		err = pcifront_rescan_root(pdev, domain, bus);
-		if (err) {
-			xenbus_dev_fatal(pdev->xdev, err,
-					 "Error scanning PCI root %04x:%02x",
-					 domain, bus);
-			goto out;
-		}
-	}
-
-	xenbus_switch_state(pdev->xdev, XenbusStateConnected);
-
-out:
-	return err;
+		pcifront_connect(pdev, true);
 }
 
 static int pcifront_detach_devices(struct pcifront_device *pdev)
-- 
2.35.3

