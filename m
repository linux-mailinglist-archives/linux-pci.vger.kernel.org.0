Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6A3B4E83
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFZNAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 09:00:01 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:38851 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZNAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 09:00:01 -0400
Received: by mail-ej1-f46.google.com with SMTP id hq39so19806894ejc.5
        for <linux-pci@vger.kernel.org>; Sat, 26 Jun 2021 05:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsjHsDPdWs8TcY1m0N+2WCt8b2rnx8PsMgsqmc5Y+4A=;
        b=hapfOcYhLWlWFqFVxyZU12tEpoVklXWr+/NgYUNuNXeMHY6muQ/o7aKVHDNNi6fobS
         /OnlIJzAHgwWzdSVx7MBi5oJ4MuS1vw5tjcrnS5gRME5CjbPUMgepawnDc2W4f0yMab/
         rpySSSZ7HgP4qhokJ2tY74j8ezAFOiwW3NzhVAuQtZTltz4LBqgBkArRq/Biu7S9OTuF
         WWT0Ukz6keSpE2lkVkvB7rS0EVav/ztkmgFsjwzI592z8qvfRqekOD4BqvQtJA+Pd0eD
         GPtxAdkoo9dWexIbEKLAAblg9q33rm/dYYBxEYJ/3cG8wOfp0DHHj8S/WX148PvLnNbZ
         fg3Q==
X-Gm-Message-State: AOAM532eZ3lM7466tNcWr7o9yFemOQQnzQg0Xt1IKP/PUH0b6f6sl5x/
        Jr0tmm/F7vaoSRYgaNm64pA=
X-Google-Smtp-Source: ABdhPJzxEoD+LvlwKNwPPHNake4JrDGHfuTkH5IhghUt/R010KPmYuzVRMCHhxvS5TBCq9zVmB0NNQ==
X-Received: by 2002:a17:906:9bd5:: with SMTP id de21mr15741797ejc.554.1624712258438;
        Sat, 26 Jun 2021 05:57:38 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e7sm3755748ejm.93.2021.06.26.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 05:57:38 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
Date:   Sat, 26 Jun 2021 12:57:33 +0000
Message-Id: <20210626125735.2868256-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210626125735.2868256-1-kw@linux.com>
References: <20210626125735.2868256-1-kw@linux.com>
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

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
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

