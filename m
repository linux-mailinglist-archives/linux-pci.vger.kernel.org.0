Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996187896A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfG2KOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40279 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so24414991lji.7;
        Mon, 29 Jul 2019 03:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dpd4bG4LMHeAuXOdMrtoCn/QAeMyQrruUgZF75ZQCJ8=;
        b=c0Xr6FBvqIjyFCA2ShVizzaXbeN6VyAsj6EDFRce79o0RGbnq3hVIq24Tn6tn7I8KZ
         tq82w8i2dJM5GMDWN9ddNqsZi1FtS9DPP7O7QAsAAAxY6drZds9mYvfue6xodrz4DCd0
         z9/qv4GdQF5+GSi8fF/iAf+es1FftfqRMZw6rQGKTmmz69g3hMnNtWKV3tPO6ieWDE1h
         Lj0fFgDBuiwiR5GLaNYIb08yXvObIcXUKFDmhpvttuImnrF/wL+k8uTU9oJvlmTz1Fac
         d7zRFJYgpyWZIM1sjnVWlb/gzvFsQWMe7QPCkkEXOFzAWhpQoYok+6GJ5ViptsPchAup
         ECXw==
X-Gm-Message-State: APjAAAWDoICcx9nqpALoUh4bO93OI3OFr6paG0o+cISlcg5tJ9jb2cnY
        jiTCdlFiNb8QPpPuD1hIAwI=
X-Google-Smtp-Source: APXvYqwEk2DknbB7kclA3P32EP96BIIMax8pcdBk+oaWSWKN8ffIkF+Ld5QCSkXWovB+komF1DZEFA==
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr57348496ljm.196.1564395267211;
        Mon, 29 Jul 2019 03:14:27 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:26 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] PCI: Convert pci_resource_to_user to a weak function
Date:   Mon, 29 Jul 2019 13:13:57 +0300
Message-Id: <20190729101401.28068-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
References: <20190729101401.28068-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The patch turns pci_resource_to_user() to a weak function. Thus,
architecture-specific versions will automatically override the generic
one. This allows to remove the HAVE_ARCH_PCI_RESOURCE_TO_USER macro and
avoid the conditional compilation for this single function.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/pci.c   |  8 ++++++++
 include/linux/pci.h | 12 ------------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..f9dc7563a8b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5932,6 +5932,14 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
+void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
+		const struct resource *rsrc, resource_size_t *start,
+		resource_size_t *end)
+{
+	*start = rsrc->start;
+	*end = rsrc->end;
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..dbdfdab1027b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1870,25 +1870,13 @@ static inline const char *pci_name(const struct pci_dev *pdev)
 	return dev_name(&pdev->dev);
 }
 
-
 /*
  * Some archs don't want to expose struct resource to userland as-is
  * in sysfs and /proc
  */
-#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end);
-#else
-static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-		const struct resource *rsrc, resource_size_t *start,
-		resource_size_t *end)
-{
-	*start = rsrc->start;
-	*end = rsrc->end;
-}
-#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
-
 
 /*
  * The world is not perfect and supplies us with broken PCI devices.
-- 
2.21.0

