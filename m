Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B792AE83C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKKFoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:54147 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgKKFoJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:09 -0500
IronPort-SDR: Z09yrwLwcb1UcrEgoy+xxXQp1QhDhvRWkKHsygWmsIxePfiPaQOizJbcB1KTuqM1hnzXrcIc6C
 eqAaExmPEf4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372975"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:09 -0800
IronPort-SDR: UmJc0Z0R+ywJjvrS9sQhlLGXxukrPhbcAcbaMsq235opUrOzPvAPKfPJ47aXv4U7Fjrh/iVMZ7
 Avl9TnV+szrw==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414859"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:08 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 9/9] MAINTAINERS: Add maintainers of the CXL driver
Date:   Tue, 10 Nov 2020 21:43:56 -0800
Message-Id: <20201111054356.793390-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..25e294031376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4428,6 +4428,15 @@ F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	samples/configfs/
 
+COMPUTE EXPRESS LINK (CXL)
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Ira Weiny <ira.weiny@intel.com>
+M:	Ben Widawsky <ben.widawsky@intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/
+
 CONSOLE SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Supported
-- 
2.29.2

