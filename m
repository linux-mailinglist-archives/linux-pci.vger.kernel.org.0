Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7406C377AE2
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhEJEPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:32 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45869 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhEJEPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:31 -0400
Received: by mail-ed1-f43.google.com with SMTP id s7so12387788edq.12
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZSUDlxK2gpwJ+aSZRfjJrhrQ1Sy5cBzVVlZ7n5R5NA=;
        b=WNB48lVtvEVMwM4pUB9RXkW3mcnq3MZLR9ZzxFeezag95bWSS9JQXZfEc0+2SS6INf
         36UNvG0ONIVho9h+YrDvH7cJZ5SECp7xJdTSrtTninqM9ix4Mv4ebWnC62S0GR361cHg
         gVPamZOKG5tR0rM2p07uzUNfmBjvnO7wHjnuZieHuVu+XGqZiYdThYZhpq2WufcXSziX
         5P0ig17e+DwxA0QPJ4m4uXLSu7gteFsrxEmiDASI8x5ks4hYaSd9ux1NRD0PqdPvH6CO
         1ZXCNDLrX5M+deKc8O92HEQY6BwYwOg9k6j6MznILYC4H6Slqe1fyqUCzINgrx6XlBct
         h9zg==
X-Gm-Message-State: AOAM532cWUOYQft667u6E199eZGqo9kNSQ3aMFldke/oODrJF2OgKdom
        3fELU+JHv+NjO+Wsp4YUF6s=
X-Google-Smtp-Source: ABdhPJzjRlML1R2TXCeBRMzLDCX2uNffVP+dQfLVtBadXh+oftHPbvObA941zYSEx/GUSBeeW2GWDg==
X-Received: by 2002:a50:ee85:: with SMTP id f5mr27463192edr.8.1620620066936;
        Sun, 09 May 2021 21:14:26 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:26 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/11] PCI/AER: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:15 +0000
Message-Id: <20210510041424.233565-2-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
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
 drivers/pci/pcie/aer.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ec943cee5ecc..40ef7bed7a77 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -529,21 +529,23 @@ static const char *aer_agent_string[] = {
 		     char *buf)						\
 {									\
 	unsigned int i;							\
-	char *str = buf;						\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
 	u64 *stats = pdev->aer_stats->stats_array;			\
+	size_t len = 0;							\
 									\
 	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
 		if (strings_array[i])					\
-			str += sprintf(str, "%s %llu\n",		\
-				       strings_array[i], stats[i]);	\
+			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
+					     strings_array[i],		\
+					     stats[i]);			\
 		else if (stats[i])					\
-			str += sprintf(str, #stats_array "_bit[%d] %llu\n",\
-				       i, stats[i]);			\
+			len += sysfs_emit_at(buf, len,			\
+					     #stats_array "_bit[%d] %llu\n",\
+					     i, stats[i]);		\
 	}								\
-	str += sprintf(str, "TOTAL_%s %llu\n", total_string,		\
-		       pdev->aer_stats->total_field);			\
-	return str-buf;							\
+	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
+			     pdev->aer_stats->total_field);		\
+	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -563,7 +565,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sprintf(buf, "%llu\n", pdev->aer_stats->field);		\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
-- 
2.31.1

