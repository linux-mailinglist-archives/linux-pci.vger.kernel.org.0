Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F940727F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhIJU1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:45 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:44964 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhIJU1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:44 -0400
Received: by mail-lj1-f170.google.com with SMTP id s3so5088390ljp.11
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZuH0jzBV51o66YWzpZ25xw+RCnaMfe3266VXxf4r4w=;
        b=ZRs+rgqBMsVB6eJCgFhqgoDeBthnH0I7I6z/ZjyxU1zzeO9kiKnD8G4GdTvixSOMdb
         II6ndVxjUXpGH57jXK1x9aYj1xnFoBrtNBQo9cAZ9b4X+igHxcY4Nlo5jyY/fHEOPWpn
         6UjrL1kabxMrv763Z+gNBqeRhbg0pwLrb7GrzJ0BtRr493JiMHLPhHUUxKA/IgiYEBcK
         Ky/iEwTrhEoHfJJAnsQmMvMqCH5p/t4Zje+9gIuLLu0Fj5QTaL6tcAHr6Up2X453S7+g
         mx1TXylcHoFRq0GbXmZ1aAm79posNA51xwePy+Q2pIHJUNaN2wn949fNykQhfp+2Uzpq
         GnNQ==
X-Gm-Message-State: AOAM53375Zb3PghAb08d8d3yyBQMHWeTLk4tBnxnlX1MgksYeafmhHEi
        LHehg4Vy/V1kKMsuzIODpEHCJmP5Mk0=
X-Google-Smtp-Source: ABdhPJyJ5nQ0M2joP/C5/jOXMjoCLgrgemyY8etqh7DkT9YVvc48+FNnDrdXGPlVtFUajovrqxyJWg==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr5596080ljp.492.1631305591818;
        Fri, 10 Sep 2021 13:26:31 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:31 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 6/7] PCI/sysfs: Rename pci_read_resource_io() and pci_write_resource_io()
Date:   Fri, 10 Sep 2021 20:26:22 +0000
Message-Id: <20210910202623.2293708-7-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_read_resource_io() and pci_write_resource_io() functions are
used for the corresponding read() and write() callbacks when declaring
and defining a static sysfs object for a given PCI resource.

Currently, only reading and writing against an I/O BARs is supported,
but we might change this in the future to also include memory-mapped
resources.

Thus, rename to read() and write() callbacks to be more generic and drop
the I/O BARs-specific suffix from them.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 084c386c94c4..17535f4028af 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1122,16 +1122,16 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	return -EINVAL;
 }
 
-static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr, char *buf,
-				    loff_t off, size_t count)
+static ssize_t pci_read_resource(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *attr, char *buf,
+				 loff_t off, size_t count)
 {
 	return pci_resource_io(filp, kobj, attr, buf, off, count, false);
 }
 
-static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
-				     loff_t off, size_t count)
+static ssize_t pci_write_resource(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *attr, char *buf,
+				  loff_t off, size_t count)
 {
 	int ret;
 
@@ -1168,8 +1168,8 @@ static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
 #define pci_dev_bin_attribute(_name, _mmap, _bar)		\
 struct bin_attribute pci_dev_##_name##_attr = {			\
 	.attr = { .name = __stringify(_name), .mode = 0600 },	\
-	.read = pci_read_resource_io,				\
-	.write = pci_write_resource_io,				\
+	.read = pci_read_resource,				\
+	.write = pci_write_resource,				\
 	.mmap = _mmap,						\
 	.private = (void *)(unsigned long)_bar,			\
 	.f_mapping = iomem_get_mapping,				\
-- 
2.33.0

