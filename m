Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750B3405DD3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhIIUDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 16:03:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:56359 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhIIUDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 16:03:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220945673"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="220945673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 13:02:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="539848341"
Received: from jmoawad-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.0.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 13:02:28 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] MAINTAINERS: Add Nirmal Patel as VMD maintainer
Date:   Thu,  9 Sep 2021 15:02:21 -0500
Message-Id: <20210909200221.29981-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change my email to my unaffiliated address and move me to reviewer
status.

Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@linux.dev>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Nirmal will be taking over my position as maintainer

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f35ada234e3..860a9b3bf5f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14207,7 +14207,8 @@ F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 F:	drivers/pci/controller/pci-ixp4xx.c
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
-M:	Jonathan Derrick <jonathan.derrick@intel.com>
+M:	Nirmal Patel <nirmal.patel@linux.intel.com>
+R:	Jonathan Derrick <jonathan.derrick@linux.dev>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/controller/vmd.c
-- 
2.26.3

