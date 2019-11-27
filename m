Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8596210AA46
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 06:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfK0Fim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 00:38:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40153 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfK0Fim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 00:38:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id i187so6219989pfc.7
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 21:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYfy1OGYsmHuR36W7MzFL9PBKNRJbvSfEwDa+a4Yg3I=;
        b=eQHCrbNnB5S/Vsv4VaieHevHPmhY9piE14RhEqo4eyUuYbcmeRI/GIyn9U76ow/97G
         FqEbs/wEG5R2bimSNtRjlUcpNEqf68UqPZI0/B2RCdNRzfyArrDo2cvTC6Xo5kT1gnSb
         Q9pzd+BKdPc0JS40hEuyBIFscmOLPzqq+6JcQ6L97e9JaZ7PalzRJpDT/c5nEfQKM9H8
         ILFaAFITWcJ01KO1JK/1NtZ9E48Mnhs7DcWRkdVMbBYaZAzQSurQqVXJXiUC9YjLaJGL
         aJXrkhw1z6ODMkfMwIS8HeILrnlxTICSja6UW37jIFPH4AqScrTRdx6AiK8vkhr1tjRy
         yr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYfy1OGYsmHuR36W7MzFL9PBKNRJbvSfEwDa+a4Yg3I=;
        b=XJtwEuY95DAe4eZMkDDgfwVOOhPhp1LPOmYOan9coLR1rtbiUJOc10qCJ2HDy2yd6r
         qsygNp2hSz3N3SNiHjdMZ1kzFulKYmgwT4QCNGmvC16UZyPdFyivnUURSyEZtbPf7y3N
         hi3WmHHh5EgcHQaSM3MTPZ8W7eEZYEN6aVAWODZ1IZ2wBsPxtZc523esruML3APuCdo9
         G+P5/1iTmqkVO9o01KtD0Xyu5xpx8tR/uKthfXVV5szJqNsvxXAr3JmgodcCiBP9C6zn
         z/E6FBg1wnpEd55JkUBHcVuz0loa2EVIrGauj0sGo55KKzDVUhEiOR/IrzoxL3LICyl3
         6+Cg==
X-Gm-Message-State: APjAAAVl9LgkA5RWDxihl2A4zg+Wo9F/a6arrW0jO4ReffiAVK/LL+h8
        k3Yeu+GDGTAVQcsN5iOEmZ/MLP6s2mc=
X-Google-Smtp-Source: APXvYqwkIc1tIyZp/lCw1pjR+6d5K/sfpjcR2fpqPtdQSCf/JXdaMAJ1a/B4Quf/UWy1UT4dIWQE2A==
X-Received: by 2002:a63:6dcf:: with SMTP id i198mr2741882pgc.86.1574833121503;
        Tue, 26 Nov 2019 21:38:41 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id y8sm14088008pfl.8.2019.11.26.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:38:40 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: [PATCH v2 1/2] PCI: add generic quirk function for increasing D3hot delay
Date:   Wed, 27 Nov 2019 13:38:35 +0800
Message-Id: <20191127053836.31624-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Separate the D3 delay increase functionality out of quirk_radeon_pm() into
its own function so that it can be shared with other quirks, including
the AMD Ryzen XHCI quirk that will be introduced in a followup commit.

Tweak the function name and message to indicate more clearly that the
delay relates to a D3hot-to-D0 transition.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/pci/quirks.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

v2: tweaked function name and message to emphasize D3hot state

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f89..3b4021e719530 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1871,16 +1871,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
+static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
+{
+	if (dev->d3_delay >= delay)
+		return;
+
+	dev->d3_delay = delay;
+	pci_info(dev, "extending delay after power-on from D3hot to %d msec\n",
+		 dev->d3_delay);
+}
+
 static void quirk_radeon_pm(struct pci_dev *dev)
 {
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    dev->subsystem_device == 0x00e2) {
-		if (dev->d3_delay < 20) {
-			dev->d3_delay = 20;
-			pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
-				 dev->d3_delay);
-		}
-	}
+	    dev->subsystem_device == 0x00e2)
+		quirk_d3hot_delay(dev, 20);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
-- 
2.20.1

