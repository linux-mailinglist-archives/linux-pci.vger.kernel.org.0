Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B913EAF08
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 05:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhHMD5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 23:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhHMD50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 23:57:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0BC0617AF;
        Thu, 12 Aug 2021 20:57:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bo18so13523523pjb.0;
        Thu, 12 Aug 2021 20:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afELPIh8J30U75rhJhY8tI3oPOuBLSl/0lGnJPYz3fo=;
        b=IrLZ2cN0N8QGITqIznkMkCdMdmbVal7yBdHqMbCYZXunGlR32MCjHwh66vPG0CYRuv
         hV3POu2XlrgISwtRco+WcqumMVXT/mAZUl4bzKm/YlDNgdiWDsJvDQoH55Wlhc7htjjr
         GIyV9wT1eecIV9saT4cvyPQHyi/zX8M8ubTU/1nDYk40iiLFpzrAoqf8KOIjulbTYprA
         Qro0SRIq2kBkRV3X1cHlKxygLrBj5f+QIpeaNbdOvnAoUOF1XKwJNH2WLzXk2Ase4vz1
         dRkqnDzk8hXEWsktY8RZZVTA0eax9O7Gt++CbdXuzoiPmc5C5U/nOejl2/mK5XlFVfgL
         xxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afELPIh8J30U75rhJhY8tI3oPOuBLSl/0lGnJPYz3fo=;
        b=NrjTUEvZuEhoxIDN8IhInWw+p8ZU2klu9beWuR5jYn86K4hKEeupNo9Rk4qErg/cKg
         Dsgmbw2Btgrz1Lnqpq7bB6iaPPdpRiMgpfy8N4vtDaOj9zHKlu7rULnOdE0tktApw6uC
         kwY4erl9SEYZA9XPxY5yjn2PcalL7femzb6Oz1dBtc9///jNW9KTLxm3AENH8sOCFvme
         elId0h7DPhmab6fVRWldvH3wJQWsn8eSCS47es3kvm9aWHfamMWWb/w4IIzy2MJitw//
         Dds6/3S+p6imiFchR3S5AExhTZnsJJfWshT35vC7hIcDtG/j8RGvmGcTrGjsscYQyluB
         XWVQ==
X-Gm-Message-State: AOAM5313bglH4Gia43iE2dcgzppuI0gf2znjtevNo48Db7CUr1C0o5wG
        dHv8HErVwgeKyiWF4f/lVY5zFW46D+GEqjMq
X-Google-Smtp-Source: ABdhPJw35cqiSqLFCGUqyYmhlXj/CcFDJueOXhlB8GNZi0ALm4Up6XyLQHZkqC/kh5Yt6UIPGvpY6w==
X-Received: by 2002:a65:5acf:: with SMTP id d15mr417664pgt.217.1628827020085;
        Thu, 12 Aug 2021 20:57:00 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:f39c:9aee:21bf:36f5])
        by smtp.gmail.com with ESMTPSA id n25sm297791pfa.26.2021.08.12.20.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 20:56:59 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     bhelgaas@google.com, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, will@kernel.org,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v3 2/2] platform-msi: Add ABI to show msi_irqs of platform devices
Date:   Fri, 13 Aug 2021 15:56:28 +1200
Message-Id: <20210813035628.6844-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813035628.6844-1-21cnbao@gmail.com>
References: <20210813035628.6844-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Just like PCI devices have msi_irqs which can be used by userspace IRQ
affinity tools or applications to bind IRQs, platform devices also widely
support MSI IRQs. For some platform devices such as ARM SMMU, userspaces
also care about its MSI IRQs as applications can know the mapping between
devices and IRQs and then make smarter decision on handling IRQ affinity.
For example, in SVA mode, it is better to pin I/O page fault to the NUMA
node applications are running on. Otherwise, I/O page fault will get a
remote page from the node IOPF happens.
With this patch, a system with multiple ARM SMMUs in multiple different
NUMA nodes can get the mapping between devices and IRQs now:

  root@ubuntu:/sys/devices/platform# ls -l arm-smmu-v3.*/msi_irqs/*
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/25
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/26
  -r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/27
  -r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/28
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/29
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/30
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/31
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/32
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/33
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/34
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/35
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/36
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/37
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/38
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/39
  -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/40

Applications can use the mapping and the NUMA node information to pin
IRQs by further leveraging the numa information which has also been
exported:

  root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.0.auto/numa_node
  0
  root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.4.auto/numa_node
  2

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-platform | 14 ++++++++++++++
 drivers/base/platform-msi.c                  | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
index 194ca70..ff30728 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -28,3 +28,17 @@ Description:
 		value comes from an ACPI _PXM method or a similar firmware
 		source. Initial users for this file would be devices like
 		arm smmu which are populated by arm64 acpi_iort.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		The /sys/devices/.../msi_irqs directory contains a variable set
+		of files, with each file being named after a corresponding msi
+		irq vector allocated to that device.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/<N>
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		This attribute will show "msi" if <N> is a valid msi irq
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b13..a3bf910 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -23,6 +23,7 @@
 struct platform_msi_priv_data {
 	struct device		*dev;
 	void 			*host_data;
+	const struct attribute_group    **msi_irq_groups;
 	msi_alloc_info_t	arg;
 	irq_write_msi_msg_t	write_msg;
 	int			devid;
@@ -272,8 +273,16 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		goto out_free_desc;
 
+	priv_data->msi_irq_groups = msi_populate_sysfs(dev);
+	if (IS_ERR(priv_data->msi_irq_groups)) {
+		err = PTR_ERR(priv_data->msi_irq_groups);
+		goto out_free_irqs;
+	}
+
 	return 0;
 
+out_free_irqs:
+	msi_domain_free_irqs(dev->msi_domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -293,6 +302,7 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		struct msi_desc *desc;
 
 		desc = first_msi_entry(dev);
+		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 
-- 
1.8.3.1

