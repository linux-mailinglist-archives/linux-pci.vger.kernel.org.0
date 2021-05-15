Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC2381604
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhEOFZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:58 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34491 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhEOFZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:58 -0400
Received: by mail-ed1-f48.google.com with SMTP id l7so874933edb.1
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeL2FUARGxszhpfrtswg3uTFL3yp7K/KDjvHQpNvygA=;
        b=MpOHcu6+X96PDBYf3RHuK8iZqE5riPmBskBF/ZM8juOWQ72y7szNniKe206+RW6c+J
         5g86iFTjXPt7p/1mLlMtnaMYMlHLL0dlUcd7HTjssY9RpKK2GssTI2aVEyF6/3jKKzQp
         fvtF9/3ZLxLs1TCrVvAHU02zFpVBLq6tcLuix/HvE8iVnMlDg+aLKpiSuoE8TiIuPhMv
         GOzKpNqpJyqcthn9GK0efaMXTidNmnrV6st/4x5wItAmjcFg98X2+56Yr8prXvPEiTup
         eiZOyL/w5wuL/pJL1rvt0hYDU49+lYaVxpO8YEFxmRkHBQ4WFRWETWcCJgkdZDmaZU6W
         ZYEA==
X-Gm-Message-State: AOAM53086Sub3WhPVAG9sST3rG1DN05tupxh7avjEBEdSAMI81N6sy1x
        P1WE0ECi180mck9WgjPyzww=
X-Google-Smtp-Source: ABdhPJx+4BP4JtYzZtC8In7d/GJnnFuTFXS/SOuG81dzRIapdNn/ATBw6N6OxyoSxAEY6QITNhVGvw==
X-Received: by 2002:aa7:cc10:: with SMTP id q16mr39814486edt.53.1621056284880;
        Fri, 14 May 2021 22:24:44 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:44 -0700 (PDT)
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
Subject: [PATCH v2 09/14] PCI: rpadlpar: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:29 +0000
Message-Id: <20210515052434.1413236-9-kw@linux.com>
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

