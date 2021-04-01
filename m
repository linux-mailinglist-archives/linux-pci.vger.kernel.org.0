Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C953351A06
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhDAR5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:57:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:59470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235775AbhDARyJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 13:54:09 -0400
IronPort-SDR: oPYdm5a3hvU9ZFU3tSnscttG8zez5XgcA861oT+1F/+yUsS/Ll6aO+xIIETSWMCTrefHqn7I88
 BLLoWJqf19zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192358815"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192358815"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:16 -0700
IronPort-SDR: VlkxHpADrWxKLQ7uW4OP5bNGYq9BvAe3SFQ/2C1dFGjm8KS3YTQXbP4VjKB2KTJRc1t/Xtmuqw
 DeH89cgPMbbg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="610944085"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:15 -0700
Subject: [PATCH v2 6/8] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 07:31:15 -0700
Message-ID: <161728747507.2474040.14555987395226963128.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
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

