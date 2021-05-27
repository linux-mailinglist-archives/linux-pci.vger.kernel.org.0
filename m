Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D263936F0
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhE0US3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 16:18:29 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40898 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhE0US3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 16:18:29 -0400
Received: by mail-ej1-f53.google.com with SMTP id jt22so2008549ejb.7
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 13:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNxzDq2xY8dnUJ64MvViy+wB2IKXRy1JRa7aGjaRnQE=;
        b=eMLe8t2Xkp4hytqqo0+SLkrHpodnAlym7au7CcBHvcJysgAym3JL4Gr+PfSDcK7WPI
         +HKpMyJfSA00lH7PkqmiO50zGAHpbTTGPHT0J0Ep09hWdSxv1ZJm/qInVE8kU/qLGrFt
         42yCNhfSumRFRsCRghuNlpld5XkPcoiwXXUXcF0Dhm3FKJjoJtqiFaxX4ViciHAV6QgN
         hhEXwXYTu9Tgb6Q/E4G4DVWWGzvFruiQ2dYzkZkPc1f3KgJZ2Tg3VnEgqW+AcAIRm37T
         Hz/f5E78Yu36ReyGzmMfpn46svXjsOfbGUquzJxqlhjltUnnIiSvuVk5D/FtyYTUcPOH
         ie8Q==
X-Gm-Message-State: AOAM531uTh01vC8oE2dYi02DwMqdR0T0vpHnQ1JX2g5n6cEUSg9dS6Kl
        39EPxFgi5mm0klgXXK65mUY=
X-Google-Smtp-Source: ABdhPJy9jQFm2yS6uLlChglhd6jwpJ0rS0ZGrwwJUr97ehv8QsKDuJeuhso7++smmeegqRbQ1elJYg==
X-Received: by 2002:a17:907:98a9:: with SMTP id ju9mr5663966ejc.257.1622146614847;
        Thu, 27 May 2021 13:16:54 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o64sm492739eda.83.2021.05.27.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:16:54 -0700 (PDT)
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
Subject: [PATCH v5 3/5] PCI/sysfs: Fix trailing newline handling of resource_alignment_param
Date:   Thu, 27 May 2021 20:16:48 +0000
Message-Id: <20210527201650.221944-3-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201650.221944-1-kw@linux.com>
References: <20210527201650.221944-1-kw@linux.com>
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
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".
Changes in v4:
  None.
Changes in v5:
  Added check to ensure that there is an extra space left in the buffer
  for the newline character, assuming that it might be provided.

 drivers/pci/pci.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ed316ea5831..b46445a49543 100644
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

