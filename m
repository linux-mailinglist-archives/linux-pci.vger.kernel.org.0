Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2265D28847E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbgJIIAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbgJIIAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 04:00:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2AC0613D8
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 01:00:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so9221292wrp.10
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPr3++TkgD7opBHxWri6P050gTocJAeikYQ/tt45kKI=;
        b=DVC+VHNwYKVtqSii5lIVeaydDB6BLYuTeAJ5rwW+S55nTxLLBIyrPBVsS/L9PHMkF1
         q3uw+XyygTSKEzljnhrtd+uqW+UWrHLzIjTm4/9nOxCepU5EL5HwS+mIoRk0TD6zsvng
         eZRy5dYaQjR4QunmQxA3SCZhsE7Sk5d3j+0PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPr3++TkgD7opBHxWri6P050gTocJAeikYQ/tt45kKI=;
        b=ZcTnw/2nkYsRSwlz3QEOkgIxnmPxwkU2s+3LKrVF3bJo5xddrk3N/i3BbzMrfHEds3
         JBDLqaMuapLT3qJUvkPci7+eKKdR7mpIavL6Na3Z3My0eH5GjkcQUzMO909oQU7QrFfN
         GIB3XXVWNyNLJ2padeDKjdC3rwugWDf+kvRNrBCgSgu+Dd0fR8VqxkeH2s6or/5Qd+aC
         WuLWrAjV00TJsTHSDEawtqGVx0+0UwSKeuRCDPc+E/28Dllpo96xBabsbW4SVJzwAAlM
         9UYoQ7EZfVtiZxouzmEyekxq3KPGe+OBVtOCjrEHc8pA0l60v5Pf/xMEzh7F/KIqxgky
         bFDA==
X-Gm-Message-State: AOAM530aUfOJZQL5368k78Grk2Q3uQgEnZpNyw3/KeVvhRDvBeePdHDY
        C762AljGv9ZNis0DfVxjUF45IA==
X-Google-Smtp-Source: ABdhPJxjabNt7y3Fk149R7K1e+u9DjBsacewwbIgtRCFyrwVNWJDFlQJblhvJ+EjdKe0cN5lfI2azA==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr6435975wro.56.1602230413759;
        Fri, 09 Oct 2020 01:00:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm11634118wri.45.2020.10.09.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 01:00:13 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 15/17] sysfs: Support zapping of binary attr mmaps
Date:   Fri,  9 Oct 2020 09:59:32 +0200
Message-Id: <20201009075934.3509076-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We want to be able to revoke pci mmaps so that the same access rules
applies as for /dev/kmem. Revoke support for devmem was added in
3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the
region").

The simplest way to achieve this is by having the same filp->f_mapping
for all mappings, so that unmap_mapping_range can find them all, no
matter through which file they've been created. Since this must be set
at open time we need sysfs support for this.

Add an optional mapping parameter bin_attr, which is only consulted
when there's also an mmap callback, since without mmap support
allowing to adjust the ->f_mapping makes no sense.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
---
 fs/sysfs/file.c       | 11 +++++++++++
 include/linux/sysfs.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..9d8ccdb000e3 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -169,6 +169,16 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 	return battr->mmap(of->file, kobj, battr, vma);
 }
 
+static int sysfs_kf_bin_open(struct kernfs_open_file *of)
+{
+	struct bin_attribute *battr = of->kn->priv;
+
+	if (battr->mapping)
+		of->file->f_mapping = battr->mapping;
+
+	return 0;
+}
+
 void sysfs_notify(struct kobject *kobj, const char *dir, const char *attr)
 {
 	struct kernfs_node *kn = kobj->sd, *tmp;
@@ -240,6 +250,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.read		= sysfs_kf_bin_read,
 	.write		= sysfs_kf_bin_write,
 	.mmap		= sysfs_kf_bin_mmap,
+	.open		= sysfs_kf_bin_open,
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..a17a474d1601 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -164,11 +164,13 @@ __ATTRIBUTE_GROUPS(_name)
 
 struct file;
 struct vm_area_struct;
+struct address_space;
 
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
 	void			*private;
+	struct address_space	*mapping;
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-- 
2.28.0

