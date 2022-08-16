Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A8596347
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiHPTkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiHPTkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 15:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C685F90
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJVt87I+RkFO3jUAhHrJxKBqiCZ7HeO0w2k1yZLam5o=;
        b=FNx7gBNrCuZKARxOy8qBuRAS4G8epEEe/HcdNyI3y671HCXjhTxVLSsKOyejLSWOTT8uFJ
        Jn1vNmaUBlbIXSlCIk2pPVxbic0pap7oPXkcXQg2ICqHUq3tiiLBOI5ddiD1V+geJh4Tbp
        CI3fyPYNpdpNaqBlfWRl/P0Sg1o5LdU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-uFEVRtW1MFW4FV7_cbTngg-1; Tue, 16 Aug 2022 15:40:05 -0400
X-MC-Unique: uFEVRtW1MFW4FV7_cbTngg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDFBD18A6524;
        Tue, 16 Aug 2022 19:40:04 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84E761415128;
        Tue, 16 Aug 2022 19:40:04 +0000 (UTC)
Subject: [PATCH 1/3] PCI: Fix double-free in resource attribute error path
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 13:40:04 -0600
Message-ID: <166067879638.1885802.1955389738707186135.stgit@omen>
In-Reply-To: <166067824399.1885802.12557332818208187324.stgit@omen>
References: <166067824399.1885802.12557332818208187324.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If pci_create_attr() fails the remaining resource bin attributes are
removed and freed based on the pointer entries which are not cleared
in the case that creation of the bin attribute fails.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-sysfs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fc804e08e3cb..9ac92e6a2397 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1196,8 +1196,14 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	res_attr->size = pci_resource_len(pdev, num);
 	res_attr->private = (void *)(unsigned long)num;
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-	if (retval)
+	if (retval) {
+		if (write_combine)
+			pdev->res_attr_wc[num] = NULL;
+		else
+			pdev->res_attr[num] = NULL;
+
 		kfree(res_attr);
+	}
 
 	return retval;
 }


