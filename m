Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2033BC464
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 02:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhGFAe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 20:34:26 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35343 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGFAe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 20:34:26 -0400
Received: by mail-lj1-f177.google.com with SMTP id k21so26767656ljh.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 17:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccPFbKnCL0vqJKSNgDvGtjUz+mDTRjkYHngf11L3LJs=;
        b=LNcBWwQZCDXTh1eTbxRr2wBwwAYzW7S4vIK+kF7IO6M0bP0Kos7xRNrUOfrtLFRL0N
         k4xtU3lA4/PKY+DAUhnE/VBdBKArx7PQ06vE67Hp+YWW6+sefZLPZ7cD7WLHmiz68rj8
         xBzTJMFEh1Pla46XQQLstGm+G8G2Wisr84sAoTym6Fenxt8jmib1Yc0EtPG1/uYjBRap
         H7/4V//Se2dDMM2iGI0kYO4N+tJhxXRqADMBeN4ASAF/HDm6kU4BXzs9uYUoU76A1Ib9
         ZX0eGsmCwHDtWlQfu88QnKXwJdyjG3Pm+/DizlRRiVBa6bnCyKvzcxj/rCjvAYLAB1DY
         B2FA==
X-Gm-Message-State: AOAM530Vws3AFt6WeAfsz5aiBxjvBUOGDDhV1aoBb9mLD0aJGBA7Qwtl
        eRkx27hgAVri4T4pEACx56Y=
X-Google-Smtp-Source: ABdhPJyKPVcM8qtgGvcFxG/iLUBirRhqiBNTzdFipDS8sqNvbHh9bkhZYRySR8vf2/F6Izo4uEMwFQ==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr12928780ljc.464.1625531507352;
        Mon, 05 Jul 2021 17:31:47 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y3sm1533094ljj.121.2021.07.05.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:31:46 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Only declare struct pci_filp_private when HAVE_PCI_MMAP is set
Date:   Tue,  6 Jul 2021 00:31:45 +0000
Message-Id: <20210706003145.3054881-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, the struct pci_filp_private does not have any other users
outside of the drivers/pci/proc.c file, and additionally its also only
ever used (alongside all of its users) when the macro HAVE_PCI_MMAP is
set.

Thus, enclose struct pci_filp_private in an preprocessor condition so
that it's only declared when the HAVE_PCI_MMAP macro is set, which
otherwise would be unused should the macro hasn't been set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9bab07302bbf..3467a8e019f9 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -187,10 +187,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	return nbytes;
 }
 
+#ifdef HAVE_PCI_MMAP
 struct pci_filp_private {
 	enum pci_mmap_state mmap_state;
 	int write_combine;
 };
+#endif /* HAVE_PCI_MMAP */
 
 static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long arg)
-- 
2.32.0

