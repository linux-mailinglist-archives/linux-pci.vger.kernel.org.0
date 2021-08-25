Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAF3F7DA5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhHYVXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:23:47 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40507 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYVXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 17:23:47 -0400
Received: by mail-wr1-f49.google.com with SMTP id h4so1452116wro.7
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 14:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sg4irG8b5rch04tDw1TShjMU6M88smfUkwqMmMQ/f2o=;
        b=cjohMt1ug2p+yy0/MhhDWfi1p+Zi5ptPs+/gw8rY6yXvZ3/xzbSfALWrSdGlpokQGz
         1Hrxvfz7uYLs6nNy5zJbyw8K7zLlydLRSofyhiR8M7V2zsf5Dv7r/nQlLTESltyimNhN
         tRLEnCxbBCM+ifOJTqQWw3gqnoBrpBxs8Ezs1NeSXutT/8oIoekkjwsogG3U4R+oIPff
         gHDDXZDcNFqYsxKVzwIkAsGIX8azKINCET3V0Xv9n8Z2YZGkGb/MtYJj/a2l346pjnfA
         0DdJqiqXAJQshyi4ifD1C2A6VOqA1OdRLzYVKHO3u+JSlfHdtRvdf7PKT1avtceJmEP7
         Ydog==
X-Gm-Message-State: AOAM532sHp5L0y4fGawsxl0Y7HHxPwBrtDBmWpgcCakJ4TspQXknj6b7
        8GYOxPxjc23ifKtFhQvsvIg=
X-Google-Smtp-Source: ABdhPJz0Fi5safNNBl9zcCUD8DSisdncCLE6PSweAN2Sr8o3vZ6fm43gmmoc4bk7RZIlG+JNnJMiGg==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr147481wrt.283.1629926580481;
        Wed, 25 Aug 2021 14:23:00 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d24sm663527wmb.35.2021.08.25.14.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:23:00 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI/sysfs: Add pci_dev_resource_group() macro
Date:   Wed, 25 Aug 2021 21:22:54 +0000
Message-Id: <20210825212255.878043-4-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210825212255.878043-1-kw@linux.com>
References: <20210825212255.878043-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev_resource_group() macro will be used to reduce unnecessary
code repetition following the use of the pci_dev_resource_attr() macro
when adding each of the many newly created resource groups to the list
of other PCI sysfs objects stored in the pci_dev_groups array.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6eba5c0887df..97ab9da47dca 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1324,6 +1324,11 @@ attribute_group pci_dev_resource##_bar##_wc_attr_group = {		\
 	.bin_attrs = pci_dev_resource##_bar##_wc_attrs,			\
 	.is_bin_visible = pci_dev_resource##_bar##_wc_attr_is_visible,	\
 }
+
+#define pci_dev_resource_group(_bar)		\
+	&pci_dev_resource##_bar##_attr_group,	\
+	&pci_dev_resource##_bar##_wc_attr_group
+
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-- 
2.32.0

