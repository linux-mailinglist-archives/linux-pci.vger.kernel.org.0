Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47F03A1A7A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhFIQHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 12:07:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:18404 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhFIQHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 12:07:35 -0400
IronPort-SDR: HHjecPU5e2xlZXV7rKpZXo846vYTXZVakE0ORAQOUvetv/M+I5GCbN7KvbgbXZymcQWp38co8v
 lbH3ftX3OAYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="290731710"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="290731710"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:01:42 -0700
IronPort-SDR: cuVg8ArXz3w4PVLaXf0ovWN2OTszrvNd2bK+r321zkFrId2Ycdi7zpqcZtwipbcKS7EJTNiXm+
 xdGv0AZvFYyw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402486569"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:01:41 -0700
Subject: [PATCH v6 2/5] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 09 Jun 2021 09:01:41 -0700
Message-ID: <162325450105.2293126.17046356425194082921.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162325448982.2293126.16916114289970424561.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162325448982.2293126.16916114289970424561.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CONFIG_CXL_BUS is default 'n' as expected for new functionality. When
that is enabled do not make the end user hunt for all the expected
sub-options to enable. For example CONFIG_CXL_BUS without CONFIG_CXL_MEM
is an odd/expert configuration, so is CONFIG_CXL_MEM without
CONFIG_CXL_ACPI (on ACPI capable platforms). Default CONFIG_CXL_MEM and
CONFIG_CXL_ACPI to CONFIG_CXL_BUS.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index d2573f6aef91..1a44b173dcbc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -15,6 +15,7 @@ if CXL_BUS
 
 config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
+	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
@@ -49,6 +50,7 @@ config CXL_MEM_RAW_COMMANDS
 config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
+	default CXL_BUS
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See

