Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A376CCDCA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1XAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC1XAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 19:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3CB172B
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680044373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UOHvDkKx1/FNkj2vxenEwIYz8eWC9U9sbsJgP7N9Oik=;
        b=JZ1fNvRQR99mRhxLi6tGeMUlyBkN1tDbWp4nl2Kj2Ugkv88za5KfoBMqnWaykEoxXSoREE
        dijWyoG97KJBIjCBCAUO3kmaA6eBm8ZyJb5jCMBQsB+JWakLv63Kszz3OOkfltVs4Zne+Q
        qRu+0hoV6i3kWoG+9hHTFT2+q3brK+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-b7YT1_x2PwGfPWv3jYOmJg-1; Tue, 28 Mar 2023 18:59:31 -0400
X-MC-Unique: b7YT1_x2PwGfPWv3jYOmJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F85B801210;
        Tue, 28 Mar 2023 22:59:31 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.16.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF05440C6E67;
        Tue, 28 Mar 2023 22:59:30 +0000 (UTC)
Subject: [RFC PATCH] PCI: Extend D3hot delay for NVIDIA HDA controllers
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     abhsahu@nvidia.com, targupta@nvidia.com, zhguo@redhat.com,
        alex.williamson@redhat.com
Date:   Tue, 28 Mar 2023 16:59:30 -0600
Message-ID: <168004421186.935858.12296629041962399467.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
below commit has been shown to resolve the issue.

I'm looking for input from NVIDIA whether this issue is unique to
Ampere-based HDA controllers or should be assumed to linger in both older
and newer controllers as well.  Currently we've not been able to reproduce
the issue other than on Ampere HDA controllers, however the implementation
here includes all NVIDIA HDA controllers based on PCI vendor and device
class.

If we were to limit the quirk to Ampere HDA controllers, I think that would
include:

1aef	GA102 High Definition Audio Controller
228b	GA104 High Definition Audio Controller
228e	GA106 High Definition Audio Controller

Cc: Abhishek Sahu <abhsahu@nvidia.com>
Cc: Tarun Gupta <targupta@nvidia.com>
Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
Reported-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c |   13 +++++++++++++
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


