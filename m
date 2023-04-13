Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA26E1551
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDMTlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDMTll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 15:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECA465B6
        for <linux-pci@vger.kernel.org>; Thu, 13 Apr 2023 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681414856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hS3zAlwUKHt4i9Sj3OqwJTrufrugLSA6n35uNDz5V0=;
        b=G9poOaCvRj0qGa/qBr0XhJpasEC+JuuhC/riKtGmJBEC5hozY5up5JUsEbEmfOjzeCVFca
        A5Vsy16CqHlcUvPoUqkX8c9lDBBqAdA96dEjLM/Lx6EyHbHwMVYK+8hhPnSMGc7aPCIoUt
        b825KVOWO10XN4vxxy+bdOPxrXluPSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-FlsL602-M2Kn7T8cxqnHEw-1; Thu, 13 Apr 2023 15:40:52 -0400
X-MC-Unique: FlsL602-M2Kn7T8cxqnHEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE758314E9;
        Thu, 13 Apr 2023 19:40:52 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0976E492C14;
        Thu, 13 Apr 2023 19:40:51 +0000 (UTC)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     abhsahu@nvidia.com, targupta@nvidia.com, zhguo@redhat.com,
        alex.williamson@redhat.com, sdalvi@google.com
Subject: [PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
Date:   Thu, 13 Apr 2023 13:40:42 -0600
Message-Id: <20230413194042.605768-1-alex.williamson@redhat.com>
In-Reply-To: <168004421186.935858.12296629041962399467.stgit@omen>
References: <168004421186.935858.12296629041962399467.stgit@omen>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assignment of NVIDIA Ampere-based GPUs have seen a regression since the
below referenced commit, where the reduced D3hot transition delay appears
to introduce a small window where a D3hot->D0 transition followed by a bus
reset can wedge the device.  The entire device is subsequently unavailable,
returning -1 on config space read and is unrecoverable without a host reset.

This has been observed with RTX A2000 and A5000 GPU and audio functions
assigned to a Windows VM, where shutdown of the VM places the devices in
D3hot prior to vfio-pci performing a bus reset when userspace releases the
devices.  The issue has roughly a 2-3% chance of occurring per shutdown.

Restoring the HDA controller d3hot_delay to the effective value before the
below commit has been shown to resolve the issue.  NVIDIA confirms this
change should be safe for all of their HDA controllers.

Cc: Abhishek Sahu <abhsahu@nvidia.com>
Cc: Tarun Gupta <targupta@nvidia.com>
Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
Reported-by: Zhiyi Guo <zhguo@redhat.com>
Reviewed-by: Tarun Gupta <targupta@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Unfortunately Tarun's reply with confirmation doesn't show up on lore,
possibly due to html email, or else I'd provide that as a Link:.

 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..f4e2a88729fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1939,6 +1939,19 @@ static void quirk_radeon_pm(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
+/*
+ * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
+ * reset is performed too soon after transition to D0, extend d3hot_delay
+ * to previous effective default for all NVIDIA HDA controllers.
+ */
+static void quirk_nvidia_hda_pm(struct pci_dev *dev)
+{
+	quirk_d3hot_delay(dev, 20);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
+			      quirk_nvidia_hda_pm);
+
 /*
  * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
  * https://bugzilla.kernel.org/show_bug.cgi?id=205587
-- 
2.39.2

