Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44378171
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfG1UXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 16:23:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44648 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:23:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so56449988ljc.11;
        Sun, 28 Jul 2019 13:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svIZnH3LFn3SCsAf3hZ7NcuCk5uSXQPw/o877w6XO80=;
        b=eMFeppMRMFt/PfqKwzpNzERlfcQ6h72DB+BzrL7nDe/URd0PolGXPL7GsJsqo0oSn+
         sz+gQydnhVQrz2cNHgS2qik1VK+L/rOdiFur9neMpbqu69bReubr2DswQM8AOogAr2T1
         7Qnfe/MayCrHf0kNX0D/TTsbs7Fbb+pHhhxDoV2vSk+NNTo8FR/HydTN+uP/RlkNkK7C
         IDjAd78vxUlcsmfE+LFhQILeexPWpY9jwCh3uS3JwfyTs282vDVNWbiGSofPRMtr71kQ
         b1k4YooMbgTm3iNsZvUwffVXpGhoYFGowd9OPF38kUc1e0KBXVvioemkKIepzg1jk3Z8
         Fqww==
X-Gm-Message-State: APjAAAVMYcINoOHqR3MnhlFczLSn7nvati9HvN+WFRYoCoRxgEjWpV+Y
        TuWN3OUfOrkEablHAIR/ZMYsIUmQwnw=
X-Google-Smtp-Source: APXvYqwiuHhdBpv2paJX0RbGJe6B84YT/HQ+J9VmSQk0WANqERsY6PXq3IkxDXDz0lW7cj/3nr+4EA==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr54104888ljp.202.1564345393166;
        Sun, 28 Jul 2019 13:23:13 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:23:12 -0700 (PDT)
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
Subject: [PATCH 1/5] PCI: Convert pci_resource_to_user to a weak function
Date:   Sun, 28 Jul 2019 23:22:09 +0300
Message-Id: <20190728202213.15550-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190728202213.15550-1-efremov@linux.com>
References: <20190728202213.15550-1-efremov@linux.com>
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
 include/linux/pci.h | 18 +++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

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
index 9e700d9f9f28..1a19d0151b0a 100644
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
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end);
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
+void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 resource_size_t *start, resource_size_t *end);
 
 /*
  * The world is not perfect and supplies us with broken PCI devices.
-- 
2.21.0

