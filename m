Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50C376D02
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEGWwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 18:52:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:33170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhEGWwy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 18:52:54 -0400
IronPort-SDR: /IceLBQd1ZAF3JAfBgJIABnEFsjXEtLedAqqAfmwgmk9L2KRjrvFPFxwNTj0ejKvF3a/X6Cyit
 hS5HDR2er7NQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="284290002"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="284290002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:53 -0700
IronPort-SDR: tvmuAuxoalOBgvgxiNZhhRRdhxOJ63QJbPSu5nIQWw49+1+TZhctp5f9Z4WcuAPX4Ywdz4Bq2+
 j0AtepNVX9Cw==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="465900959"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:53 -0700
Subject: [PATCH 6/8] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 07 May 2021 15:51:53 -0700
Message-ID: <162042791307.1202325.2513845748708305095.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index fb282af84afd..1da7970a5e55 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -15,6 +15,7 @@ if CXL_BUS
 
 config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
+	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
@@ -54,6 +55,7 @@ config CXL_MEM_RAW_COMMANDS
 config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
+	default CXL_BUS
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.

