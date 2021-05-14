Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4438034F
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 07:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhENFXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 01:23:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:46076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232535AbhENFX2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 01:23:28 -0400
IronPort-SDR: 95fziSeBNOX1UNlez815RjtQwvs8U3Y+K8PF4JZkerzwnuL6SFzU6/nzhkZS9f+MwxGEMqBrkG
 nmWckA+S4gMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="261356498"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="261356498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:22:16 -0700
IronPort-SDR: mzLojPWXW0A2pCxcU8hX77Zg4om6cOnGdBPyjACtHafgse3D3h00NiNjfQqAc7yqffP1kh/3ej
 0U37hqkAoogA==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="436180381"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:22:16 -0700
Subject: [PATCH v4 6/8] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 22:22:16 -0700
Message-ID: <162096973632.1865304.16599632599441411175.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Link: https://lore.kernel.org/r/162042791307.1202325.2513845748708305095.stgit@dwillia2-desk3.amr.corp.intel.com
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

