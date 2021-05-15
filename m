Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C978E3815FF
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEOFZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:54 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43649 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhEOFZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:53 -0400
Received: by mail-ed1-f45.google.com with SMTP id s6so830227edu.10
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQ3R2W3kyD0ic+vfu4svsuSqjX5xIeVtIEqsI3c2288=;
        b=DpRrOO3AZ5PJE8/gObClbb9i6AaESRu2TNY9LBZakbGz2O/xj7u29DrcxLlhIXZt2c
         qw4JWaNtos4giZi7NECQqtGaj8LohJID1JDEBst0wNXderw9nt8id6HrCFePiWw7IaPp
         h2AGGLwejQEENKMNxpeHBosz1jHei1M0RSJrCy8exmdPs1FC79XBISx80Ki0pCajWhzN
         DIa/WsjlHQ5NcsvkxlqbxpVhlJo2fkhejuPjm6MrkdQgq6U7L+GLmLm9CUOpHCFDuiUZ
         eQAKBPBMRbWxPo5foCEcKsS2GNGvt9sTp5pLjXlmEdWw40/dWWE+3fkNq2728jD/AaXH
         fIPw==
X-Gm-Message-State: AOAM531wdqi/iezyM3fObXM6D98kU8uMWRee0URCq6PK0vBnWiFMuu/d
        3101r8qlJ9eA4NA3QYFoYaU=
X-Google-Smtp-Source: ABdhPJxnsAptxOx/HBJpYKJDCOzTTrrz2+pFB3BqgI1f0hBvz5p50K52vu7dJoKs7QYOOJjk4VYp9w==
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr42219916edu.165.1621056279708;
        Fri, 14 May 2021 22:24:39 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:39 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/14] PCI/MSI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:24 +0000
Message-Id: <20210515052434.1413236-4-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 217dc9f0231f..dbfec59dfe41 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -465,8 +465,8 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 
 	entry = irq_get_msi_desc(irq);
 	if (entry)
-		return sprintf(buf, "%s\n",
-				entry->msi_attrib.is_msix ? "msix" : "msi");
+		return sysfs_emit(buf, "%s\n",
+				  entry->msi_attrib.is_msix ? "msix" : "msi");
 
 	return -ENODEV;
 }
-- 
2.31.1

