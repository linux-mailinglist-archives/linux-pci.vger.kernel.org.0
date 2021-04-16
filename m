Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA43629D2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbhDPU7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:31 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40814 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbhDPU73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:29 -0400
Received: by mail-ed1-f54.google.com with SMTP id o20so7548371edc.7
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeUgz7b7rXLxynuNSGprjbs9WcXU7kskGSfcqquriAo=;
        b=rW8f28aLJSUFhI+S10vhOWIbEnH3nEsI6CporQAeTj6XH24orW0al/xDw9ZaVU9Ria
         wvkUrix2bt5+K3OIWy22NMbXKHb/JMvHtT1fdNa7J5cPJaRXR0TjK0+2lZ2KiTbXGLJU
         1TjvxRqLuBmmWZ7UCjTmF+J9pZ+UQzNgeRwVOkEkbDpwkiUkWGlmXj5PsYxHY37+3MTO
         lMZAL188gobWjDTlfz2wFjKlEriJu/HBBzkbUAK5xQjwl/jA+0fV6/wnR7FyLYWL7Zin
         BEJjW5FB5ZAdHN1S5MMJxi75RBY97HUmFnYzIM+H9j8qRFUOl30xUq/t9z9Y7epfsoc2
         BG2Q==
X-Gm-Message-State: AOAM532z5VXAN95MqTDlfGQhO1UQPL0c/9MLrtkHIa6JRNJLaaGMBwqN
        3OUsLT8DJz381q9mhtthVKE=
X-Google-Smtp-Source: ABdhPJwVOkc6xSk37T2eHXQV6vW3+g077Om5a1OPNiB2/FC1ntKWNRjN+pE8ReGeKIrjo0EMw9X4/w==
X-Received: by 2002:aa7:c1c8:: with SMTP id d8mr12245446edp.236.1618606743761;
        Fri, 16 Apr 2021 13:59:03 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:03 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 06/20] sysfs: Introduce BIN_ATTR_ADMIN_RO and BIN_ATTR_ADMIN_RW
Date:   Fri, 16 Apr 2021 20:58:42 +0000
Message-Id: <20210416205856.3234481-7-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A very common use case is to limit read and/or write access to certain
sysfs objects to only root with the expectation that the CAP_SYS_ADMIN
capability is needed to access sensitive data exposed through such sysfs
objects.

The existing macros such as BIN_ATTR_RO and BIN_ATTR_RW are sadly
inadequate given the specific need to limit access only to the root
user, as they offer permissions that are too open e.g., 0444 and 0644,
thus a lot of users of binary attributes with this specific use case,
for example, the PCI "config", "rom" and "vps" sysfs objects, would opt
to use the BIN_ATTR macro directly specifying 0400 or 0600 as needed.

Add a new set of macros with an explicit "ADMIN" identifier catering to
this specific use case that also follows the semantic of other existing
macros such as e.g., BIN_ATTR_RO, BIN_ATTR_RW, BIN_ATTR_WO, etc.

No functional change intended.

Related:
  commit 60d360acddc5 ("driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 include/linux/sysfs.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d76a1ddf83a3..9f423dfa8494 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -205,6 +205,13 @@ struct bin_attribute {
 	.size	= _size,						\
 }
 
+#define __BIN_ATTR_RO_MODE(_name, _mode, _size) {			\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.read	= _name##_read,						\
+	.size	= _size,						\
+}
+
 #define __BIN_ATTR_WO(_name, _size) {					\
 	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
 	.write	= _name##_write,					\
@@ -214,6 +221,14 @@ struct bin_attribute {
 #define __BIN_ATTR_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
 
+#define __BIN_ATTR_RW_MODE(_name, _mode, _size) {			\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.read	= _name##_read,						\
+	.write	= _name##_write,					\
+	.size	= _size,						\
+}
+
 #define __BIN_ATTR_NULL __ATTR_NULL
 
 #define BIN_ATTR(_name, _mode, _read, _write, _size)			\
@@ -223,12 +238,20 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
 #define BIN_ATTR_RO(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
 
+#define BIN_ATTR_ADMIN_RO(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO_MODE(_name, 0400,	\
+					_size)
+
 #define BIN_ATTR_WO(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
 
 #define BIN_ATTR_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
+#define BIN_ATTR_ADMIN_RW(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW_MODE(_name, 0600,	\
+					_size)
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
 	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
-- 
2.31.0

