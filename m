Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3940740727C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhIJU1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:44 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33349 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhIJU1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:41 -0400
Received: by mail-lj1-f169.google.com with SMTP id s12so5189731ljg.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqfQt5c1SW21pKtEyRPySF5oZi27MiZQXZzAu2FFZCs=;
        b=xf+GSJ+U+cJsVHC77uoxMRPbt3m7F3hSN6i3zGJ64sa7gFTUWOCaMucdHiB0aSf8Tx
         7ovu/dC4YbIoh0Turx9zqCmoQDJdUbCogHLmtZRJRrr/3BvaU8yOMmudoUW5XAh5y2yT
         C3Lyx1ezAlOhHZLQbBeGuPkTU9DFOpfC/9O49B6K1s37zO9EddoE5lL9mqUjSt8T6CSJ
         aRzJulg/uoZOMrMw6j3rqCZrsF6GoGDoZzOBEPHTBPjrj+kb79sqxZXz9SiqzV2Wp2q0
         NzqM+iQ6YCNKW/hLbS1+voVzeFj8h1P7sL9ZNHFD4NA6CnRCtTvpF0FSvFyfMJp2m37a
         nhcg==
X-Gm-Message-State: AOAM532AE2ofiJ1lHIQQ76WZY5FOtaRU7z9GzfLXxc7KZ4K2sAPuJ5QQ
        wey/7NjkHaOb+O/Xj8TJ0ZQ=
X-Google-Smtp-Source: ABdhPJyHb9iCBzQqvKdtEMAbq6f5qnyv+c6gxyOPfoA9wMsYxylQ9/BVkcdEgT1Gw/hYO4dd/R2LXw==
X-Received: by 2002:a2e:6c05:: with SMTP id h5mr5771787ljc.42.1631305588678;
        Fri, 10 Sep 2021 13:26:28 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:28 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/7] PCI/sysfs: Only allow IORESOURCE_IO in pci_resource_io()
Date:   Fri, 10 Sep 2021 20:26:19 +0000
Message-Id: <20210910202623.2293708-4-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, when the sysfs attributes for PCI resources are added
dynamically, the read() and write() callbacks will only ever be set when
the underlying resource (a given BAR) has the IORESOURCE_IO flag set,
otherwise the callbacks will be NULL and any attempt to read from such
sysfs attribute will inherently fail.

After the conversion to the static sysfs objects, the read() and write()
callbacks will be always set for a given binary attribute (a particular
sysfs object). Thus, a check is added to the pci_resource_io() function
to ensure that a read against the underlying resource is supported and
that the IORESOURCE_IO flag is set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ccdd1e34aeee..e151d635fe04 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1084,6 +1084,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_IO))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.33.0

