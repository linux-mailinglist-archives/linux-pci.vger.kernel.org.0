Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A8387043
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhERDme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:34 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37686 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhERDmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:32 -0400
Received: by mail-lj1-f177.google.com with SMTP id e2so3469464ljk.4
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKjtHEVtxnLS8r1kymvkicKwzLKGSRDQgyjURpCSGE4=;
        b=KvXZ3oA/eGRi2icy2728g8LdxHr4NpRmC7nb/g1lxh9chlReWL8Q6qUCAXvFc5d7c2
         k6aW7tOrN+K8Cmb4kfSlAF+WZyZknnFyUeebCJDaFucpzxs6i/y+EuRyzbv9UMMS+HxJ
         wf60iABeaDgRjJvsadR4/w3wZXkWMdzmjfP95sr38kZfUvjloXfgDLlVwmOvty9IGZ+E
         sxToOYQekuUzyk/wj1r915FaQ0XjpzOqcHsCKNqvXgF08KAxklVpp/Q3CSOIumDz+fz5
         2UivhQLji90ApglCKyP088vxeb4sxYRPVg3XL5IDE2fa9/j2nm6oPkhUYV6iwh8srFFm
         /wfQ==
X-Gm-Message-State: AOAM531vRXlYFrRjjJGqlCIBPWHv8BUgDyxuom5oG8Nn4UYmMRngq3CR
        HKO3MAwQrorSauCDNIqVnp0=
X-Google-Smtp-Source: ABdhPJxneHdUKCsFTAaoh4RJwYcn7zjWDxwvTeEGtdFkCKVVSdyq9+WBH5yZFOylpAYViMdON+dLrQ==
X-Received: by 2002:a2e:9796:: with SMTP id y22mr2390310lji.70.1621309272657;
        Mon, 17 May 2021 20:41:12 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:12 -0700 (PDT)
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
        linux-pci@vger.kernel.org
Subject: [PATCH v3 02/14] PCI/AER: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:40:57 +0000
Message-Id: <20210518034109.158450-2-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

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

