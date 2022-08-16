Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A1596346
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiHPTkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiHPTkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 15:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ED86FFC
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejPyL03exSUyv1sSmQS6RpycXfqdQ91zc3yteXbW3HE=;
        b=O5XTCm5/bAXxFP+eiw+/VyI4Qjc5OpE9W+w0ztKZH2rKufNnCg6A38TT3SBrw8OHQGdAYv
        oODiDZ1L2Gj/SunNJPdNTqKs8+dI0XaRD+A0oXC0eJw958iJzQnE7qxXRVS58b/RS/KQ87
        pwqz0yFg2Z4aZBQuLFBdNQoz+XPqqqY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-h7lRGLixPaON3uAu49SmIw-1; Tue, 16 Aug 2022 15:40:31 -0400
X-MC-Unique: h7lRGLixPaON3uAu49SmIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDD301C04B63;
        Tue, 16 Aug 2022 19:40:30 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86B4B1121314;
        Tue, 16 Aug 2022 19:40:30 +0000 (UTC)
Subject: [RFC PATCH 2/3] PCI: Skip reassigning bridge resources if reducing
 BAR size
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 13:40:30 -0600
Message-ID: <166067880991.1885802.3339740933334886723.stgit@omen>
In-Reply-To: <166067824399.1885802.12557332818208187324.stgit@omen>
References: <166067824399.1885802.12557332818208187324.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

More work is probably necessary here, pci_reassign_bridge_resources()
has heavy weight requirements that the aperture windows are unused,
without even testing if the requested resize is possible in the
existing aperture.  One case we can clearly skip is when reducing the
size of a BAR.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/setup-res.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 439ac5f5907a..7a8e1e4f4d33 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -450,7 +450,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
-	if (dev->bus->self) {
+	if (size > old && dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
 		if (ret)
 			goto error_resize;


