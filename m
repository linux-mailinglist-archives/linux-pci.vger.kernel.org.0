Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3402D37BC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgLIA10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:27:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:16959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbgLIA0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:26:18 -0500
IronPort-SDR: jHS6cGDz+WzsgWxmAW+hBKk2PsMZE4+nzVAnKpvxxaXHtCPe5BaxnNw3ZOyhwsdhGm+L1JRVRQ
 VOud9VcaqV7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142098"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:30 -0800
IronPort-SDR: mwDjNaklr2IkaDvmUxfIZO4BciR9JoTzFgaD2vhFIw7D7dIOr5UYFL6O8eEy24xgit5X/CJMr8
 pyvoU8Jel4hQ==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838524"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 13/14] MAINTAINERS: Add maintainers of the CXL driver
Date:   Tue,  8 Dec 2020 16:24:17 -0800
Message-Id: <20201209002418.1976362-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
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
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..d6aa4b684a1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4428,6 +4428,16 @@ F:	fs/configfs/
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
+F:	include/uapi/linux/cxl_mem.h
+
 CONSOLE SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Supported
-- 
2.29.2

