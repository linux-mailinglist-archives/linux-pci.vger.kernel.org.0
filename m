Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1D31C51C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBPBr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 20:47:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:3274 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhBPBrR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 20:47:17 -0500
IronPort-SDR: EiikaceDU6bym8DTRGCnCgFIPQvmZwyMd4JlD46R2UWLEGHuxJbct4jzsf9UKL8Nbmga9p2aGS
 s1Ll1s6zcTXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246852889"
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="246852889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:58 -0800
IronPort-SDR: C44FxgDbAk1nl89V8wndHhTxE+hYnLG+EDeyXKACYsVkrlgfRRz3L9UVEluHATuy1AwM9Br4UQ
 +TmauHcwnFhg==
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="399296117"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 17:45:58 -0800
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
Subject: [PATCH v4 8/9] MAINTAINERS: Add maintainers of the CXL driver
Date:   Mon, 15 Feb 2021 17:45:37 -0800
Message-Id: <20210216014538.268106-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210216014538.268106-1-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
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
2.30.1

