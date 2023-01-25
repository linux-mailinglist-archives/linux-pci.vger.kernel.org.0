Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E967C0A6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 00:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjAYXOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 18:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAYXOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 18:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20A442E0
        for <linux-pci@vger.kernel.org>; Wed, 25 Jan 2023 15:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674688431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZxXC6RkcbYR55zhaEzAPuw/LbFxa4LSYY65NGg5ryZY=;
        b=GUSMigd3BsLLEdBfG4lOtUTR9c3iOEzzsM7t89cHG6bu/N1ZOFa1nxQDCvKeg+A0O0Twl8
        9+hOzdS51sCEHceB3+vZcnPgjvFuAxt1BdpSY5GV9s36TGNkbJhhbVY34ylaAAUwRPI/rQ
        toxbN6/2mBzFNIDM6vEwDo7IGtRDbdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-hmWo8uBOObCoE9yJ5FisXg-1; Wed, 25 Jan 2023 18:13:49 -0500
X-MC-Unique: hmWo8uBOObCoE9yJ5FisXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AE13801779;
        Wed, 25 Jan 2023 23:13:49 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.32.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F399040C1141;
        Wed, 25 Jan 2023 23:13:48 +0000 (UTC)
Subject: [PATCH] genirq/msi: Fix fwnode leak
From:   Alex Williamson <alex.williamson@redhat.com>
To:     maz@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com
Date:   Wed, 25 Jan 2023 16:13:48 -0700
Message-ID: <167468839713.2297784.1309086853550595503.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

kmemleak is reporting pairs of leaked buffers when PCI devices are
unbound from their drivers.  One of these buffers contains the name of
the interrupt as generated for the msi_domain_template bundle in
msi_create_device_irq_domain().  This name is passed through
irq_domain_alloc_named_fwnode(), where an irqchip_rwid is allocated,
along with a separate allocation via kasprintf() for another copy of
the name.  These are the two leaked buffers.

Resolve this by adding the missing call to irq_domain_free_fwnode() in
msi_remove_device_irq_domain().

Fixes: 27a6dea3ebaa ("genirq/msi: Provide msi_create/free_device_irq_domain()")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 kernel/irq/msi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 955267bbc2be..66dc956505b8 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1015,6 +1015,7 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 {
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
+	struct fwnode_handle *fwnode;
 
 	msi_lock_descs(dev);
 
@@ -1025,7 +1026,9 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
+	fwnode = domain->fwnode;
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
 
 unlock:


