Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0438704B
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbhERDmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:39 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45857 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbhERDmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:39 -0400
Received: by mail-lj1-f171.google.com with SMTP id v5so9762524ljg.12
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wjg3DIlrANENTm1zkcOPGunwcpnmhITeO03CihxYRc8=;
        b=BtM9qjv0/cEHAVJOzTVEmZylYv/oYDiAH65kCg71hTt6VTk9par2/JuVAl2CBrZcqi
         RPcDxOCHEdsGX4c9l+KwoC3kotxXvDp1Ng/EqKNw3SZcKqxXAI4jByWpwaCL0b3avkCF
         95tI6nBn907Fd5SmoxEesDre2IQUGoFVRaDthCeATrMk+ILqkklrzBg16FpSW4x0+DIx
         MkWymS29vU1hA30G/HVK+XDRLvxYSbpADzWLIMEv76SFlGwozFQGtQ+6RGCy9iE33a8n
         KMZNgNud970FuiVobz5frC4/31RdE86elPUoqllDsw8QQw0XvXbj3Zll1L2c3DR5ijgR
         MCIQ==
X-Gm-Message-State: AOAM532bQ6GvbuyZUKJx5xZrEmZR9/O26pB9ZYrrUi7nOqYfzQE9trgt
        ZtNxgak6yTidcSuKVLBrVMY=
X-Google-Smtp-Source: ABdhPJz4rV3Dp89mOuLSi0uuAmmbwXMQq8KL1Gv9VuMb0QMRiaA1fw4PMXFPki52hZ79du8RHdjd+w==
X-Received: by 2002:a2e:580d:: with SMTP id m13mr2179947ljb.31.1621309280759;
        Mon, 17 May 2021 20:41:20 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:20 -0700 (PDT)
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
Subject: [PATCH v3 10/14] PCI: hotplug: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:41:05 +0000
Message-Id: <20210518034109.158450-10-kw@linux.com>
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

 drivers/pci/hotplug/pci_hotplug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 5ac31f683b85..058d5937d8a9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t power_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -130,7 +130,7 @@ static ssize_t attention_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -175,7 +175,7 @@ static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_latch = {
@@ -192,7 +192,7 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
-- 
2.31.1

