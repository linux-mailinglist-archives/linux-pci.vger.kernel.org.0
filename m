Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEE957AB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfHTGv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 02:51:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36733 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTGv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 02:51:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so1581020wme.1;
        Mon, 19 Aug 2019 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHMvwwjCFDHUoBdNporEs9m3cfxy8SuBzzm+vPiCqbY=;
        b=NC7ZXBDyj0zacep+JRrl9D5/vlSG8B+pwH/fsEfZLTkbP+HuPvrXhqakmMfUY/aVaq
         7lIczetA3vOjVPflQUHyxbr6Df/7NjRh9dIQnseOIYgIpiSGCZR7wlVMoJAvJkjywmOs
         qSGvfWT7rFEomqVhIwrrGyWmmz37k3cIJ6dzMPzGLI0DT3N5P07HtxiUkdKY9W8mhi4B
         +g/KYHNUpCyFtO9E6uTaWvK0dOFGb/fFnXJvB2zWownHGrXbP+JZJSvBiLi32szQzTCp
         cs5Qwi7HAAflPCAQF3WBKm0lA8axUkNlfkeK9zuLQiX5lKznYOPzW1YKAOocJeAtQf/Y
         xeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dHMvwwjCFDHUoBdNporEs9m3cfxy8SuBzzm+vPiCqbY=;
        b=bfAz6mEmgzG14714pVJYNyatazAYc6Uaoa/xcOaWXme+94wEJJbtJfdfJ1rdICera1
         NubhdDK2A7rjUliisyv+qZpF6gORVoh7PHngX5JhO9yg1D+6dzBAMsTR7GoERuu3Igu/
         T44xptPIBTobXLH7AjKbomm9CQTTQ+KUj2h8kQDk+GmY2VMVH8x3ak7wgM811ceAtNdQ
         5ANMjhhgj5HgYtUgpCMwnCN0ItgDC3vzOAuXf4LHg3w/otQ3IgY2XgnRQM1xeiPin6zS
         HIi5SItEpkuOBS5pRYO4lxXS699ukJRBXh5ZrmAML5tE6AES5iX01lbnrut3iRoxOYuC
         /V6Q==
X-Gm-Message-State: APjAAAWpae3uakIq26Yp2rqst2aNpo5qRuZBHa7Ls7JIyT4+NQ2T5n9D
        3U6hs7BRKN8Wo/DHj+ymSgsXdNFp0aZ9Eg==
X-Google-Smtp-Source: APXvYqyMokm8ag/bbYBCT0yDvXeSG7eRaXpoQxvGmAIcyLtDP58UFmdThS8EV/NVLkXY8+KKTX+4nA==
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr22753202wmt.147.1566283883732;
        Mon, 19 Aug 2019 23:51:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aef41.dynamic.kabel-deutschland.de. [95.90.239.65])
        by smtp.gmail.com with ESMTPSA id p10sm13922257wma.8.2019.08.19.23.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 23:51:23 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Remove surplus return from a void function
Date:   Tue, 20 Aug 2019 08:51:21 +0200
Message-Id: <20190820065121.16594-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary empty return statement at the end of a void
function in the arch/x86/kernel/quirks.c.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 arch/x86/kernel/quirks.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 8451f38ad399..1daf8f2aa21f 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -90,8 +90,6 @@ static void ich_force_hpet_resume(void)
 		BUG();
 	else
 		printk(KERN_DEBUG "Force enabled HPET at resume\n");
-
-	return;
 }
 
 static void ich_force_enable_hpet(struct pci_dev *dev)
@@ -448,7 +446,6 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
 	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
 		force_hpet_address);
 	cached_dev = dev;
-	return;
 }
 
 /* ISA Bridges */
@@ -513,7 +510,6 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
 	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
 	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
 		"0x%lx\n", force_hpet_address);
-	return;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
 			 e6xx_force_enable_hpet);
-- 
2.22.1

