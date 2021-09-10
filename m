Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2192E40727B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhIJU1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:42 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45755 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhIJU1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:39 -0400
Received: by mail-lj1-f169.google.com with SMTP id l18so5095135lji.12
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBAyHIZsVPEUTgzr43vz1L6tRP5OB5mLLXAzlt1cbVI=;
        b=OItH+sHk8KZHF5encWNOFkwJ9hQLRdN0/Owg+439opEC6Z01YjyJMNJwSNGfb6NhhX
         4prTMvK0IRum27dg9W8HamWtLxKfPMByrA/xcsjX2+ct3B3Yh4lofCHofjOXO8ITmL6t
         mCXgScBo7RXbA4tIl1AuoNiISdpdHJfFABZFRxxF0TRTi8dhTcW57vvJCW9Bhs7HxWFq
         6X5JDUknVc+9ryDvi0jQ+HU9sZQTVIN2U/y4/kH8czzUNd2yQZYNgoh/tS9Dm+D8KOnu
         Vt/iZV3OvO8FpThXcwPFr2rZ00wmosIftp0bX2iTFOEU7+s/4wMy4epIeyWLQJMtvf0W
         b2oQ==
X-Gm-Message-State: AOAM530/ZD0mCwFSN2najzH3XQVnMQvs4yH+TnEG0BgiP54AJd+s/tfF
        A9VGakZb4un3OreScNF09x8=
X-Google-Smtp-Source: ABdhPJzl6A/kZjHACv3IpELTvOwRu2PLN+PtgjP26ULTvHT+/o8IMy2sm3FyJLI8NVcS+AkdsvSdFw==
X-Received: by 2002:a2e:7814:: with SMTP id t20mr5604852ljc.13.1631305586626;
        Fri, 10 Sep 2021 13:26:26 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:26 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/7] PCI/sysfs: Add pci_dev_resource_attr_is_visible() helper
Date:   Fri, 10 Sep 2021 20:26:17 +0000
Message-Id: <20210910202623.2293708-2-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This helper controls how a static sysfs attribute is exposed, where
depending on whether a particular resource is available (the BAR address
space requested has non-zero size) or whether the write-combine feature
is supported, the sysfs attribute will be made either visible or hidden.

After the conversion to use static sysfs objects when exposing each PCI
BAR address space this helper is to be called from the .is_bin_visible()
callback for each of the PCI resources attributes groups.

A single BAR will have a dedicated attribute group with two attributes
in it - one normal resource and one that can potentially support the
write-combine feature.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7fb5cd17cc98..4272d1aba205 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1237,6 +1237,30 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	}
 	return 0;
 }
+
+static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
+						struct bin_attribute *a,
+						int bar, bool write_combine)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	resource_size_t resource_size = pci_resource_len(pdev, bar);
+	bool prefetch;
+
+	if (!resource_size)
+		return 0;
+
+	prefetch = (pci_resource_flags(pdev, bar) &
+		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
+			(IORESOURCE_MEM | IORESOURCE_PREFETCH);
+
+	if (write_combine && !(prefetch && arch_can_pci_mmap_wc()))
+		return 0;
+
+	a->size = resource_size;
+
+	return a->attr.mode;
+};
+
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-- 
2.33.0

