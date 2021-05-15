Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162EC381607
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhEOF0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:26:02 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:33514 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhEOF0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:26:01 -0400
Received: by mail-ej1-f49.google.com with SMTP id z12so158784ejw.0
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3UpkKoHQG0tf/oaVD2LnuLhgOWE3b/n2dCLRadGIF4=;
        b=ahth2oomvySxlOPGd0F0TyfCqfxt0RteEPKUxzAkRn41OL/6XkMAbBNdNP2rYLYfJE
         ZM4+Ga7k6K1VPU90w3frcK9QcxLyseLhtidLreZUOSZ6qjQ7u2/Ztr56ieP8T3MWqhVq
         fPZr0Eu/5aR+lqYnSm75WhbE7ZwLiu6u7mzEPTsqHjUtqK2gxFLeUrkcZ51pNQ4tNaHU
         vk1QWcGoiX1kkfEDBCoO31vdgMpAR8LRa13rg+CppkZPzzS2iiiTNcR3wDVg6YSvxb6X
         I/KBCrt+hCRnCRzQ8RLC+ecpR7xnel+W2G7EieS4aM9ABw/rd9kEwLFWrUIlODmy05Jr
         E1GQ==
X-Gm-Message-State: AOAM531I7Dx4BhnIMeVcb3jhXxUy1hBC79E1Vs5Bm+z8Xz9ab7NMWwgA
        kTBLil5d6Nh2hTPSaRLp5Ic=
X-Google-Smtp-Source: ABdhPJyGXrwiw6AUEQkiZNiiFMo18eHtQ1pD3BH99lSq0gDTyHGjespN0d9GO5o1Cd76Qnuv/DwQMA==
X-Received: by 2002:a17:907:2646:: with SMTP id ar6mr19927960ejc.293.1621056288007;
        Fri, 14 May 2021 22:24:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:47 -0700 (PDT)
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
Subject: [PATCH v2 12/14] PCI: Fix trailing newline handling of resource_alignment_param
Date:   Sat, 15 May 2021 05:24:32 +0000
Message-Id: <20210515052434.1413236-12-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of the "resource_alignment" can be specified using a kernel
command-line argument (using the "pci=resource_alignment=") or through
the corresponding sysfs object under the /sys/bus/pci path.

Currently, when the value is set via the kernel command-line argument,
and then subsequently accessed through sysfs object, the value read back
will not be correct, as per:

  # grep -oE 'pci=resource_alignment.+' /proc/cmdline
  pci=resource_alignment=20@00:1f.2
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.

This is also true when the value is set through the sysfs object, but
the trailing newline has not been included, as per:

  # echo -n 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.

When the value set through the sysfs object includes the trailing
newline, then reading it back will work as intended, as per:

  # echo 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.2

To fix this inconsistency, append a trailing newline in the show()
function and strip the trailing line in the store() function if one is
present.

Also, allow for the value previously set using either a command-line
argument or through the sysfs object to be cleared at run-time.

Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ed316ea5831..7cde86bdcc8e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,34 +6439,37 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = sysfs_emit(buf, "%s", resource_alignment_param);
+		count = sysfs_emit(buf, "%s\n", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
-	/*
-	 * When set by the command line, resource_alignment_param will not
-	 * have a trailing line feed, which is ugly. So conditionally add
-	 * it here.
-	 */
-	if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
-		buf[count - 1] = '\n';
-		buf[count++] = 0;
-	}
-
 	return count;
 }
 
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	char *param = kstrndup(buf, count, GFP_KERNEL);
+	char *param, *old, *end;
 
+	param = kstrndup(buf, count, GFP_KERNEL);
 	if (!param)
 		return -ENOMEM;
 
+	end = strchr(param, '\n');
+	if (end)
+		*end = '\0';
+
 	spin_lock(&resource_alignment_lock);
-	kfree(resource_alignment_param);
-	resource_alignment_param = param;
+	old = resource_alignment_param;
+	if (strlen(param)) {
+		resource_alignment_param = param;
+	} else {
+		kfree(resource_alignment_param);
+		resource_alignment_param = NULL;
+	}
 	spin_unlock(&resource_alignment_lock);
+
+	kfree(old);
+
 	return count;
 }
 
-- 
2.31.1

