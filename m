Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC103EA32C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhHLKy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhHLKyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 06:54:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA13C0613D3;
        Thu, 12 Aug 2021 03:54:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a8so8717594pjk.4;
        Thu, 12 Aug 2021 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Odt01punb17ITFlrIkGGB8hHCTznUelJjiAvTAKdxNI=;
        b=vfrDdL+5PqWsegVKDIXrbiWTQL7QR6VHOm7UT1PxnU6oqF0CqAFPkb+NLyTo+8w9Ms
         lME7b0GTtxn/JAzXRWRaTpm88R//Kp5DYx78I4SmSNAcRZtcxtFc4ILheCorn1IpvmAJ
         KpwRmf1zg4HZ16y0Xbf/vqKvSa7T4tw27J42gVLjlOVtpdZmyiaiCEe3FJ6OH+SEWpqG
         xgwbkXBWtsa8M7Oeg9nH9tx0DVHIeBdznAyBC7rzlfuxR6yBgQidzzAmsc8Vf6d9nWT0
         q1i4ZN6zu5LDKe8jBHmeOH3oh1WjqwnH9SyDLj4zaurmaNJVXSIYjjLCRy0/9os/SjYR
         waeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Odt01punb17ITFlrIkGGB8hHCTznUelJjiAvTAKdxNI=;
        b=fHj5KMiEAH6/5U9hOCootu75eAeEEzEDQcIeAQYDUWWA1XGf2WiehHYfA/E65AljXA
         malJoZdpXQMr/Cg7/sH+eWCY680Qm/2vWPHynwiD6dv5ziCXJrNmNNNUOQlYxRvpSlAQ
         Ic750caOFWm2inJzbwyNhEo5M/luI/BwOjMYTugFMb563a7jvGqcFjfs44J8U6xCq8Pt
         FtPWCJjbTaOZNTZKL3IYPxKYl+2npkEdAz+tULNVwsprLZJSx1fqW6eb/FKdjq22ve+f
         32QcS2TqIXkZrHu/3091LiMsDnnUBDUz64Wgn489DlYhWgXE9wPp3qCPAsa5R4+ny5ol
         warg==
X-Gm-Message-State: AOAM530/d8kp3RKhUgY52qbYVku+U+GQ/gaB5MjMY4/EHtGdbKQdWVZm
        Y6qBJfZgOx+8E7pjts06FBk=
X-Google-Smtp-Source: ABdhPJzt872/2bBcxuFIUUQb/AgGb70PXH8tioGbiuL2GZPWp4IFUlUB6RmzFeU0TszPZFLYe+8Xgg==
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr3807423pjt.84.1628765667913;
        Thu, 12 Aug 2021 03:54:27 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:73b9:7bc0:297c:e850])
        by smtp.gmail.com with ESMTPSA id j16sm3070866pfi.165.2021.08.12.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:54:27 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
        maz@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com,
        robin.murphy@arm.com, will@kernel.org, lorenzo.pieralisi@arm.com,
        dwmw@amazon.co.uk, Barry Song <song.bao.hua@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v2 2/2] platform-msi: Add ABI to show msi_irqs of platform devices
Date:   Thu, 12 Aug 2021 22:53:41 +1200
Message-Id: <20210812105341.51657-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812105341.51657-1-21cnbao@gmail.com>
References: <20210812105341.51657-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Just like pci devices have msi_irqs which can be used by userspace irq affinity
tools or applications to bind irqs, platform devices also widely support msi
irqs. For platform devices, for example ARM SMMU, userspaces also care about
its msi irqs as applications can know the mapping between devices and irqs
and then make smarter decision on handling irq affinity. For example, for
SVA mode, it is better to pin io page fault to the numa node applications
are running on. Otherwise, io page fault will get a remote page from the
node iopf happens.
With this patch, a system with multiple arm SMMUs in multiple different numa
node can get the mapping between devices and irqs now:
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

Applications can use the mapping and the numa node information to pin
irqs by leveraging the numa information which has also been exported:
root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.0.auto/numa_node
0
root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.4.auto/numa_node
2

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

