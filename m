Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC73672E41
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjASBeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjASBbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:31:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D26C56D;
        Wed, 18 Jan 2023 17:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091759; x=1705627759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Txos19R8DyvDzhERcj8uKGox4wLE09dcHL2zQgioezU=;
  b=mzbI3w4OcbcTydS5LbrNrf1WUybgd4bXfsssC0iDOCyf9EBupRSbEafO
   NwkCiguYwrqhU/hyMG1JXJpvNKV4o3TQi6CIboyhb4AbZE1aPJJtHAAAW
   RhA+IESmlmfDoZ+zjOM/OROXQWHliONfh7uO2uj6rEAAJwlNA3YwPmKmm
   qzVjCuPZ7/Y6aIxwaGgkrq8d1XS7p7H6wI9Is6Z3VjDebKgSCtDBbUgME
   NvKden6Ho+Kx4VFIGBqPmptk/lPAzhgNIEGBzM7HTyWW0xtIVyBFFTNvH
   +ekwmJF9sEqGt2a0tbEQ8r0nfl9327bP5i3EzSQwMyS4xtYggVjtzeHYu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847637"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847637"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995719"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995719"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:29:07 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 12/12] Documentation: fpga: add description of fpgahp driver
Date:   Wed, 18 Jan 2023 20:36:02 -0500
Message-Id: <20230119013602.607466-13-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the description of fpgahp driver.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/fpgahp.rst | 29 +++++++++++++++++++++++++++++
 Documentation/fpga/index.rst  |  1 +
 MAINTAINERS                   |  1 +
 3 files changed, 31 insertions(+)
 create mode 100644 Documentation/fpga/fpgahp.rst

diff --git a/Documentation/fpga/fpgahp.rst b/Documentation/fpga/fpgahp.rst
new file mode 100644
index 000000000000..3ec34bbffde1
--- /dev/null
+++ b/Documentation/fpga/fpgahp.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+FPGA Hotplug Manager Driver
+===========================
+
+Authors:
+
+- Tianfei Zhang <tianfei.zhang@intel.com>
+
+There are some board managements for PCIe-based FPGA card like burning the entire
+image, loading a new FPGA image or BMC firmware in FPGA deployment of data center
+or cloud. For example, loading a new FPGA image, the driver needs to remove all of
+PCI devices like PFs/VFs and as well as any other types of devices (platform, etc.)
+defined within the FPGA. After triggering the image load of the FPGA card via BMC,
+the driver reconfigures the PCI bus. The FPGA Hotplug Manager (fpgahp) driver manages
+those devices and functions leveraging the PCI hotplug framework to deal with the
+reconfiguration of the PCI bus and removal/probe of PCI devices below the FPGA card.
+
+This fpgahp driver adds 2 new callbacks to extend the hotplug mechanism to
+allow selecting and loading a new FPGA image.
+
+ - available_images: Optional: called to return the available images of a FPGA card.
+ - image_load: Optional: called to load a new image for a FPGA card.
+
+In general, the fpgahp driver provides some sysfs files::
+
+        /sys/bus/pci/slots/<X-X>/available_images
+        /sys/bus/pci/slots/<X-X>/image_load
diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f95667ca2..8973a8a3f066 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    fpgahp
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 85d4e3a0e986..569c7f680229 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8169,6 +8169,7 @@ L:	linux-fpga@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-fpgahp
+F:	Documentation/fpga/fpgahp.rst
 F:	drivers/pci/hotplug/fpgahp.c
 F:	include/linux/fpga/fpgahp_manager.h
 
-- 
2.38.1

