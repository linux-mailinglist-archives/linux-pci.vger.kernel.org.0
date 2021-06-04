Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5639B9EC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDNen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:43 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42610 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFDNek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:40 -0400
Received: by mail-qk1-f169.google.com with SMTP id o27so9256028qkj.9
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeeHNCauFmswUDoqniVsTD5Y6l0ADeVu3kWVNWDJXJs=;
        b=R4XRcoH9HjGxXGZbToYAbzOb+voOdLnrnOMQYg5gv8lvWzeR5Mkw6K1u5MguyxiF8h
         Lu+ubFcnKq0nHvDDcGyNPdAhDynbebSp3cj0xJ8DlBr0vXT3puLhmctg2uvmRd8cw9XO
         gWkIXzAyu857Hof82vAEEYllxeK/fKUDzRiAULX+bRTHBO5/2AwvIuCEJD+5s/1/G0Ix
         /utjp4zj+cp7deDz2NPxQH3xHqw7INDgPyOrMAdyE3/fReg+jojJGs6G4r8SHeh1dZYE
         /Rxwu1m2fOA1NMdBV0ZegkRtykQg85iYdT6n+rc61OlRB2uKPrz8lcGVdd9Nxhz5JqVC
         rUyg==
X-Gm-Message-State: AOAM532P77htH7ZtEVH4CSBX/7IClvAQtkodPH9jnqaq2YZ+onhk8rff
        i/K/rLUfSHc82BH060/B9Xw=
X-Google-Smtp-Source: ABdhPJxx2WUm9TRk0WEqYv2itSoZF4mMO24oJDpYgWymm3QPib5R3Ox3tD+OCjNZvADINLl2pNSA4g==
X-Received: by 2002:a37:4392:: with SMTP id q140mr4428544qka.49.1622813561855;
        Fri, 04 Jun 2021 06:32:41 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:41 -0700 (PDT)
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
Subject: [PATCH v7 3/6] PCI/sysfs: Fix trailing newline handling of resource_alignment_param
Date:   Fri,  4 Jun 2021 13:32:27 +0000
Message-Id: <20210604133230.983956-4-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604133230.983956-1-kw@linux.com>
References: <20210604133230.983956-1-kw@linux.com>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/pci.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ed316ea5831..68f57d86b243 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,34 +6439,40 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
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
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
 
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
+		kfree(param);
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

