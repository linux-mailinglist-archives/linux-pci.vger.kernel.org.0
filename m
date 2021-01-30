Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4685D30944D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 11:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhA3KTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 05:19:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:38336 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhA3Aeh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 19:34:37 -0500
IronPort-SDR: zKpMLDk3hh7efYcJtfOD1XP3oAnoUs3gcVMRPQ9hNnsDTjxTRoqW7612lQms2pv1ghacvq4WaG
 sodkUifdRbrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199350700"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199350700"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:53 -0800
IronPort-SDR: gr8fqKu2GofH9PjzJ5GvxttPPioPE7BRNJYapZOe+qDsoCgN4hNJYIR4btV+HbRgySgUpt5NSi
 P3SRLyjr6MRg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370591717"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:53 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [PATCH 14/14] MAINTAINERS: Add maintainers of the CXL driver
Date:   Fri, 29 Jan 2021 16:24:38 -0800
Message-Id: <20210130002438.1872527-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
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

