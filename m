Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE111298B0E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772860AbgJZK6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 06:58:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772848AbgJZK6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 06:58:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id w23so10050865wmi.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkmJ6ZmKgmcd6yJ6bv+WDWEfAJ+atBjrBRrq3Oi6xEA=;
        b=AyLC83NYGpnIvuLIFq1n+EYb5RD2pj+8NwDHlA6VA5HNxtYkzMI28Z+nvka4pfH0sh
         7KSsyqM99nYdq6/YaTlJmbbjYh4uyOjgl1qj0NJ0XKlEnX0r9gulONO+zSqW5ASovylx
         roszmSmlQTJoMIlY94WrJZfxbZNLo6JFHhNE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkmJ6ZmKgmcd6yJ6bv+WDWEfAJ+atBjrBRrq3Oi6xEA=;
        b=LiwTDnnAkVasYOFqE0VNeUiGMpCH7A8LUF5eJEbO8HQK/6JLJ8Bw+Dqu792po8Siop
         WBbjmBd8THYcw4/nBX3pepg8yPQQDJp94fM70SRF3UaNayAoUWPXvBBGwwWD/jXPD855
         FEiXTxT4hls288CQ2Lrhf/nC46SGg63WUaeEnDMAkPop7aegsi6ETlDCJvUWCfMZ/Jxf
         aPEpK2Nz6VOlgxMYYygutPz0Al6364mF1fnWxsirHXXGmVfhHNiuXq1Y3jE6Y29pkxH4
         WVYmg/bcPvbeGPWHfxbviV2ZPizlZ1d//3KSq5ymEtKmaECneGjTuEGJWyJTfc+xabOs
         PjSA==
X-Gm-Message-State: AOAM531d0tnOL+NVbRVn6+mGGvqHGSUZ5ENlH2Adi9y1ju46yMvCNTxd
        /NGO4pf6W1Wnu/UtdggZ9011Ng==
X-Google-Smtp-Source: ABdhPJytw73HXFA7BGESL3jqxl9OmapvxqxjO7CWItldlXvB0eWL3Kk5ZZkwwQloESg/WFGowlh1eg==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr16417557wma.189.1603709925752;
        Mon, 26 Oct 2020 03:58:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w83sm21165156wmg.48.2020.10.26.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 03:58:45 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 14/15] sysfs: Support zapping of binary attr mmaps
Date:   Mon, 26 Oct 2020 11:58:17 +0100
Message-Id: <20201026105818.2585306-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
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

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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

