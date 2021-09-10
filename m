Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0840727D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhIJU1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:44 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:46599 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhIJU1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:42 -0400
Received: by mail-lf1-f47.google.com with SMTP id t19so6390861lfe.13
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCWGEafDm9+a2Gvdto/l8SUM0CdXaX/vrNhpnx0tOGg=;
        b=oiLg2BBp8CeqstP4eRMYLD73yQK8nbprLpEXvxroqiuPr4kfCzYtGuJxGdvVkoZYw0
         YNwQTEoH8HP9LmjdYuHPL6xtXXWucRop7De/DeevzxfsnEngseN7EwVlFSrGYsT5BgfT
         j5XXtW//hB5ZrqgPRCocT4yYxup9n2UdVQnuOkzgFN0jhDjBAQDT/PZcBJnENlTLvVt3
         e/sG+pmDRXHJ7G5FhexJP6P0qc4C5/4eu3euQ8JK5+1r922/4Npz3ax1e5FSFta2f4vC
         yu967JpR4wPBDU9WZNJKUCX6Ux6plvQOUWtdUJQV0T1xgqlvJDucH2Kkvz3ZTZSGwsNV
         oaFA==
X-Gm-Message-State: AOAM531AyDJ8O+NSfY9xDvlihQYWWNN/efhTPbraXSeDOOqksOpZwDJH
        +it9zdXqtp1jgJ5CsWC4/Rs=
X-Google-Smtp-Source: ABdhPJw9PsY3v1dNQCjFlM2XHn3SHsklA6wQYVyWe/n3qp0lbcsdZdAb2gHMJc/v6w/NIxZjjdMZIg==
X-Received: by 2002:a05:6512:96f:: with SMTP id v15mr5083269lft.455.1631305589686;
        Fri, 10 Sep 2021 13:26:29 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:29 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/7] PCI/sysfs: Only allow supported resource type in pci_mmap_resource()
Date:   Fri, 10 Sep 2021 20:26:20 +0000
Message-Id: <20210910202623.2293708-5-kw@linux.com>
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
dynamically, the mmap() callback will only ever be set when the
underlying resource (a given BAR) has either the IORESOURCE_MEM (which
currently is implied) or IORESOURCE_IO flag set and where the latter
requires that the underlying architecture supports mmap() for I/O BARs,
otherwise the callbacks are set to NULL and any attempt to read from
such sysfs attribute will inherently fail.

Following the conversion to the static sysfs objects, the mmap()
callbacks will be always set for a given binary attribute (a particular
sysfs object). Thus, a check is added to the pci_mmap_resource()
function to ensure that a read against the underlying resource is
supported and that either the IORESOURCE_MEM or IORESOURCE_IO flag is
set with the platform supporting mmap() for I/O BARs as required.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e151d635fe04..2031b5da6bcf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1051,6 +1051,10 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (!(res->flags & IORESOURCE_MEM ||
+	    ((res->flags & IORESOURCE_IO) && arch_can_pci_mmap_io())))
+		return -EIO;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-- 
2.33.0

