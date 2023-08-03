Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64176F069
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHCRNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHCRNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA32D64
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4rNHvY4SBHV3GZTxHfmC+xvKSqh+4xt/RUop3WDQyg=;
        b=IunNoGDIKzFYTekbjV+BCbTpEe8fnqjTNeGXo6uw1mBGTcZKFg6TY3v/DEKlm9oUfyL1xb
        yXHjECVyidy66HMxd/celMUZUaCiM0tZqyT6cLhAYewsjDkhIjmHOUxrJBTCgEaQihZp8G
        93+e1iPbiXFzZ61JnUrPzl4TfvnnSFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-it8Yw8nBOjSFtKIOfzR0Dg-1; Thu, 03 Aug 2023 13:12:45 -0400
X-MC-Unique: it8Yw8nBOjSFtKIOfzR0Dg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02099104458B;
        Thu,  3 Aug 2023 17:12:44 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1004021CE;
        Thu,  3 Aug 2023 17:12:43 +0000 (UTC)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com
Subject: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Date:   Thu,  3 Aug 2023 11:12:33 -0600
Message-Id: <20230803171233.3810944-3-alex.williamson@redhat.com>
In-Reply-To: <20230803171233.3810944-1-alex.williamson@redhat.com>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Testing that a device is not currently in a low power state provides no
guarantees that the device is not immenently transitioning to such a state.
We need to increment the PM usage counter before accessing the device.
Since we don't wish to wake the device for PME polling, do so only if the
device is already active by using pm_runtime_get_if_active().

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..bc266f290b2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2415,10 +2415,13 @@ static void pci_pme_list_scan(struct work_struct *work)
 
 	mutex_lock(&pci_pme_list_mutex);
 	list_for_each_entry_safe(pme_dev, n, &pci_pme_list, list) {
-		if (pme_dev->dev->pme_poll) {
-			struct pci_dev *bridge;
+		struct pci_dev *pdev = pme_dev->dev;
+
+		if (pdev->pme_poll) {
+			struct pci_dev *bridge = pdev->bus->self;
+			struct device *dev = &pdev->dev;
+			int pm_status;
 
-			bridge = pme_dev->dev->bus->self;
 			/*
 			 * If bridge is in low power state, the
 			 * configuration space of subordinate devices
@@ -2426,14 +2429,20 @@ static void pci_pme_list_scan(struct work_struct *work)
 			 */
 			if (bridge && bridge->current_state != PCI_D0)
 				continue;
+
 			/*
-			 * If the device is in D3cold it should not be
-			 * polled either.
+			 * If the device is in a low power state it
+			 * should not be polled either.
 			 */
-			if (pme_dev->dev->current_state == PCI_D3cold)
+			pm_status = pm_runtime_get_if_active(dev, true);
+			if (!pm_status)
 				continue;
 
-			pci_pme_wakeup(pme_dev->dev, NULL);
+			if (pdev->current_state != PCI_D3cold)
+				pci_pme_wakeup(pdev, NULL);
+
+			if (pm_status > 0)
+				pm_runtime_put(dev);
 		} else {
 			list_del(&pme_dev->list);
 			kfree(pme_dev);
-- 
2.40.1

