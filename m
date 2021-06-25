Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B533B4AF0
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFYXdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 19:33:43 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35467 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFYXdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 19:33:42 -0400
Received: by mail-ej1-f54.google.com with SMTP id gn32so17686377ejc.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vG+NOqMTvgE/MrGwqlyoFMFVmU3GLHtwmmG0GVPzgE=;
        b=UMeo9je+ABGj/DOjfUAkZnwv/ndR8O7P4uY9tMxdZisxc/js3zI4JsijSrxN+0z0rS
         8F5eGxBxv1jS8W79Dwl45xhU1e1hafdaYUtwDJDQBDZyJ+EjZQybGNLQbxRxG7lp7SRU
         Vip9Nxxj6HtyqRtxmmucwJihc16CdcRUVjvvYWNurCd4H9MT/DZ+Txpjh4wRTkQ+Mq05
         kFQl7DOqAUmQSdgGvDvZ9IjFuW0ZVvL5Dv4ldFvzyQ3gWkHmIn8Q/zA6Nqgz97W5hKOf
         Gd8iZm9MJGByErtbYjFD4G7nA0in7EWCUb/EouuYPhBEb9100ZsSdDc9jQrou+gf2Wfo
         V9+g==
X-Gm-Message-State: AOAM532S2jC6yoferbRkBUCSBdszg16d6ZikX8u6qgdXQKzDJW4SxgaE
        syKKAGTSEqwdtE0A0RR/SFs=
X-Google-Smtp-Source: ABdhPJyhzLSmbfepP9uTnTKlqSbzsBTAMJbFE6jFTi5A9gyDsHLFm18ozXZr4vGXOIubIGSGZmZTxA==
X-Received: by 2002:a17:906:698a:: with SMTP id i10mr13342417ejr.499.1624663880713;
        Fri, 25 Jun 2021 16:31:20 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b8sm4741015edr.42.2021.06.25.16.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:31:20 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
Date:   Fri, 25 Jun 2021 23:31:17 +0000
Message-Id: <20210625233118.2814915-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625233118.2814915-1-kw@linux.com>
References: <20210625233118.2814915-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defer invocation of the iomem_get_mapping() to the sysfs open callback
so that it can be executed as needed when the binary sysfs object has
been accessed.

To do that, convert the "mapping" member of the struct bin_attribute
from a pointer to the struct address_space into a function pointer with
a signature that requires the same return type, and then updates the
sysfs_kf_bin_open() to invoke provided function should the function
pointer be valid.

Thus, this change removes the need for the fs_initcalls to complete
before any other sub-system that uses the iomem_get_mapping() would be
able to invoke it safely without leading to a failure and an Oops
related to an invalid iomem_get_mapping() access.

Co-authored-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 fs/sysfs/file.c       | 2 +-
 include/linux/sysfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..a3ee4c32a264 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -175,7 +175,7 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 	struct bin_attribute *battr = of->kn->priv;
 
 	if (battr->mapping)
-		of->file->f_mapping = battr->mapping;
+		of->file->f_mapping = battr->mapping();
 
 	return 0;
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d76a1ddf83a3..fbb7c7df545c 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -170,7 +170,7 @@ struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
 	void			*private;
-	struct address_space	*mapping;
+	struct address_space *(*mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-- 
2.32.0

