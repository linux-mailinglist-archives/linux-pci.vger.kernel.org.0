Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6849106F97
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfKVKuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:50:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40342 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfKVKuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so4724922wro.7
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnM7tdmIuTsFG/gPDSUiRJmc1F37mgdxvtHO3FtFylE=;
        b=Bn+Nr/ytUk5YMVm1sQH/UVWhb/mMA2dE72H0//SsVqGsJ9g8ztbjNMl03n+vqtDgX1
         BVKT3vkBXC/ScqOu1f0iF7XkX6lsqaoR5LUZxq0mZatIZOz7WNO1g8raGl67VngxgyW9
         Zn2kqX9vdxYlDvCmxLBCm2xmeGhSiwiljE+9lmgXsFsgUPRpHuMCsvvuNYY6NigcTHtB
         6RIo/Qb2nm8M3urPlnZCBvaTaniwiuU4Ty9DcH8MlFxUi10bX7AZqP19/YZ8ro/tJBja
         iDFhce9IQReQ91LQ4rr7HwA94Ofb7+RxgCw7sMyVwzrXEjrM0k5Wqz6UJ8AMXLdvEArk
         /QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnM7tdmIuTsFG/gPDSUiRJmc1F37mgdxvtHO3FtFylE=;
        b=i3Rkn/kc8kfBGzXwe9cZ9mNmEOIy7ikg5clRbSjhgDnEZUrUpRJPHbnU61YtOkduMh
         B7of9oN35Ca233MTvtClqKL0v2vyLGB6HUG6vFlFxJjdoB0s9BgqNRVgzTnarNx/l2vl
         nnhbRERS2DsODJcIEMdnDmwlmBzZrpp2KilLW6P/ERpFepDjRcx+rNW+Y/i1/bRTtmSM
         z5qJB5wHJ1VoeJ+TGGhll5f+QATpncBHyuqK0u2t3lxHAz6x+zfd/UgAkaGuvfaYUE91
         nPB3mwsqYkNJoRWwEFhHWuJ2AFlrP4vTmpcVZRWB/gh/g7Wrip3wcPVWLD4mPkKGsM+6
         Adhg==
X-Gm-Message-State: APjAAAVNu8/L5eU6tv+8NcNwLfLc2cNux++C4ceDD1EdrgIi0mH0I+gK
        +e6EuDFDjShxRotVLu+yWCq9qQ==
X-Google-Smtp-Source: APXvYqwkrBA1P0X6qMijtc1m/IkH374uodkpj4sCzTHsq7FVgmjD/iynOAUZy7h3h+1OHmfVUN05+Q==
X-Received: by 2002:adf:c611:: with SMTP id n17mr17357418wrg.317.1574419852465;
        Fri, 22 Nov 2019 02:50:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:52 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 01/13] ACPI/IORT: Move IORT to the ACPI folder
Date:   Fri, 22 Nov 2019 11:49:48 +0100
Message-Id: <20191122105000.800410-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IORT can be used (by QEMU) to describe a virtual topology containing an
architecture-agnostic paravirtualized device.

In order to build IORT for x86 systems, the driver has to be moved outside
of arm64/. Since there is nothing specific to arm64 in the driver, it
simply requires moving Makefile and Kconfig entries.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 MAINTAINERS                     | 9 +++++++++
 drivers/acpi/Kconfig            | 3 +++
 drivers/acpi/Makefile           | 1 +
 drivers/acpi/arm64/Kconfig      | 3 ---
 drivers/acpi/arm64/Makefile     | 1 -
 drivers/acpi/{arm64 => }/iort.c | 0
 6 files changed, 13 insertions(+), 4 deletions(-)
 rename drivers/acpi/{arm64 => }/iort.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..9153d278f67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,15 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/i2c-multi-instantiate.c
 
+ACPI IORT DRIVER
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Hanjun Guo <guohanjun@huawei.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/acpi/iort.c
+
 ACPI PMIC DRIVERS
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..548976c8b2b0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,9 @@ config TPS68470_PMIC_OPREGION
 	  region, which must be available before any of the devices
 	  using this, are probed.
 
+config ACPI_IORT
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..9d1792165713 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -123,3 +123,4 @@ video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
+obj-$(CONFIG_ACPI_IORT) 	+= iort.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..d0902c85d46e 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -3,8 +3,5 @@
 # ACPI Configuration for ARM64
 #
 
-config ACPI_IORT
-	bool
-
 config ACPI_GTDT
 	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 6ff50f4ed947..38771a816caf 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/iort.c
similarity index 100%
rename from drivers/acpi/arm64/iort.c
rename to drivers/acpi/iort.c
-- 
2.24.0

