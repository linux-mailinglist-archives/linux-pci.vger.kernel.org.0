Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0A1DFD8B
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEXHfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 03:35:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbgEXHfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2020 03:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590305736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZOhN0iKxkeEUT3qGZkLgYezZQrTZHrY1P4Iryg7SGJg=;
        b=Jio8wmDZ1JTDXFFwQxYLBSSlcydjHgjxja00S12P6VsSUcHIGmx2NQ5a5sNTPRDNHJYdw7
        tRXVfHiubfUeX5pAoqBuwLBgJA8Pzjsz5uBiMqT7fq2HJzPr+SsriLMwtu3JarRkLNIyC/
        9wyNiNqkY2DsNIRuFnGdz4pMD1e8Ch8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-RKTGnOAxOoeulatV3BiCPQ-1; Sun, 24 May 2020 03:35:33 -0400
X-MC-Unique: RKTGnOAxOoeulatV3BiCPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45B2800D24;
        Sun, 24 May 2020 07:35:32 +0000 (UTC)
Received: from f31-4.lan (ovpn-115-18.phx2.redhat.com [10.3.115.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0D1419C4F;
        Sun, 24 May 2020 07:35:29 +0000 (UTC)
Date:   Sun, 24 May 2020 00:35:29 -0700
From:   Kevin Buettner <kevinb@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com
Subject: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Message-ID: <20200524003529.598434ff@f31-4.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds an entry to the quirk_no_flr table for the AMD
Starship USB 3.0 host controller.

Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
motherboard with an AMD Ryzen Threadripper 3970X.

Without this patch, when attempting to assign (pass through) an AMD
Starship USB 3.0 host controller to a guest OS, the system becomes
increasingly unresponsive over the course of several minutes,
eventually requiring a hard reset.

Shortly after attempting to start the guest, I see these messages:

May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready 1023ms after FLR; waiting
May 23 22:59:48 mesquite kernel: vfio-pci 0000:05:00.3: not ready 2047ms after FLR; waiting
May 23 22:59:51 mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR; waiting
May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not ready 8191ms after FLR; waiting

And then eventually:

May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready 65535ms after FLR; giving up
May 23 23:01:05 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744 > 2500), lowering kernel.perf_event_max_sample_rate to 1000
May 23 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 82.270 msecs
May 23 23:01:08 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
May 23 23:01:08 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 100.952 msecs
...
 kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
May 23 23:01:25 mesquite kernel: watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]

The above log snippets were obtained using the aforementioned hardware
running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
fix was applied to a local copy of the F32 kernel package, then
rebuilt, etc.

With this patch in place, the host kernel doesn't exhibit these
problems.  The guest OS (also Fedora 32) starts up and works as
expected with the passed-through USB host controller.

Signed-off-by: Kevin Buettner <kevinb@redhat.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 43a0c2ce635e..b1db58d00d2b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5133,6 +5133,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  * FLR may cause the following to devices to hang:
  *
  * AMD Starship/Matisse HD Audio Controller 0x1487
+ * AMD Starship USB 3.0 Host Controller 0x148c
  * AMD Matisse USB 3.0 Host Controller 0x149c
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
@@ -5143,6 +5144,7 @@ static void quirk_no_flr(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);

