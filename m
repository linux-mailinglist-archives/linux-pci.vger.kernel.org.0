Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC0377AE9
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEJEPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:39 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36463 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEJEPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:38 -0400
Received: by mail-ej1-f48.google.com with SMTP id r9so22417106ejj.3
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeL2FUARGxszhpfrtswg3uTFL3yp7K/KDjvHQpNvygA=;
        b=i4LgpO8fDPrONA80FHWOwGwl6VQ502QYYQP1rMLk+mpQ2qVtjkjmWq4A4fdpPcWjXF
         PzXFPTKey5aFKYGnZFtcOTnh2nJhRYtwDflheRhWjoQXYJbeCLw5NOudleEi2P1Qj3JL
         DqsWu77jTpDXI5cOsY/G+uaxzrpiak8GrZdw/TuVqGb57XzShcEe3qJxb5fVB492Ni2s
         kcS4UNd3/eVbC6H0uZ/x2C6p/ZrWJ3XgF5QZzPQYWjNiAKNlLom/XlbV9pMCDxRr721T
         1cy8Hsttg1/h19ixFGwFQJ57E9CXY3UA67uefA7ofDeuEKGepwWza3YZLIimCqnqrWeB
         YqKg==
X-Gm-Message-State: AOAM530geo4f2NWkbSidK6JuJEUhZm+L3xTsdkpfJ4K3N8K+dr9E/Zma
        jsaVVrJ5E6HbJ8wwwywEf7M=
X-Google-Smtp-Source: ABdhPJws1APHRRa1UWb9NsEgDv3LVgdap2nv9ZT1B1HRkR88aNny+SIIgzZqUzA5rUM83wj3tLM7tA==
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr23674832ejc.502.1620620074022;
        Sun, 09 May 2021 21:14:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:33 -0700 (PDT)
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
Subject: [PATCH 09/11] PCI: rpadlpar: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:22 +0000
Message-Id: <20210510041424.233565-9-kw@linux.com>
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
 drivers/pci/hotplug/rpadlpar_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index dbfa0b55d31a..068b7810a574 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -50,7 +50,7 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t add_slot_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t remove_slot_store(struct kobject *kobj,
@@ -80,7 +80,7 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 static ssize_t remove_slot_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static struct kobj_attribute add_slot_attr =
-- 
2.31.1

