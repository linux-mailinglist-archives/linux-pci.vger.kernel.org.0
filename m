Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B039CD97
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFGHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 02:07:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:11759 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhFFGHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 02:07:02 -0400
IronPort-SDR: DwWQC0JuwrS6V3XDGBgs1PKehbVaoqkXdroMoTz4De1AenOEMKGkb5zRpAb8AINA60dDGmSEaw
 WN/dE9wNbeng==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191594731"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191594731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:12 -0700
IronPort-SDR: 8bhZx7V7NYDf9o77JZeyYwDA4l52Ty69TKKYGF51nYSMSClcxQSPuHYq9deiAVcafvD7WXVYkM
 fqNvXxSaauOw==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="636960661"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:12 -0700
Subject: [PATCH v5 3/6] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Sat, 05 Jun 2021 23:05:10 -0700
Message-ID: <162295951009.1109360.5116868030465500710.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
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

