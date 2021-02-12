Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8E31A79A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 23:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhBLW2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 17:28:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:60252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBLW2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 17:28:10 -0500
IronPort-SDR: 6dSG3IusaZuDIN9uNGbWz1dakpAnSSYGTh7pa0l+DeMcndML813Iu/0ts+/EhGyZkwOKJ9Fqr1
 d1iX9SBV76Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="182555597"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="182555597"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:57 -0800
IronPort-SDR: xjUiar3IsLO4iESzDz+mNOSz1uPZ8XGnTqCgS2ugttKiQLidHlKZXiwzw9puGx4pMnO4JgZufB
 Xo3Hsbl67rAg==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="587605396"
Received: from smandal1-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v3 8/9] MAINTAINERS: Add maintainers of the CXL driver
Date:   Fri, 12 Feb 2021 14:25:40 -0800
Message-Id: <20210212222541.2123505-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212222541.2123505-1-ben.widawsky@intel.com>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..93c8694a8f04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,6 +4444,17 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
 F:	include/linux/compiler_attributes.h
 
+COMPUTE EXPRESS LINK (CXL)
+M:	Alison Schofield <alison.schofield@intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Ira Weiny <ira.weiny@intel.com>
+M:	Ben Widawsky <ben.widawsky@intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/
+F:	include/uapi/linux/cxl_mem.h
+
 CONEXANT ACCESSRUNNER USB DRIVER
 L:	accessrunner-general@lists.sourceforge.net
 S:	Orphan
-- 
2.30.0

