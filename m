Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8A4976B2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiAXAbp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:53077 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235278AbiAXAbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984304; x=1674520304;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqVKQ5U04jbeKgEnG55nQ7byEl0Rvm9oJ+OQpJT8NmA=;
  b=dBXm9lf3TwH/cXF5fH0G/xC79C3kVqv964Rwi//NIiIGGEJ79lzcF7f4
   vT/JuW5zg/U45xeqLvIW4dbp6TZ3c/OMXdLU2143rPEiRJLPu466hhjB8
   q1d36YT9GCnSl8jDIQTBDKaaAIFYdVZ3x7WQNCPD/fi/6T40Glmu+F1mW
   HBHI4G/0Ktr3gTuUXEgsrueBK/VNVVSDTUyvZFXYgVwcXnIfiKTOzNzIe
   cX9Tt9wr8PBOLaltmQxtP76M2fVCxNLYt2tfQqqlMiHDy+TEnZ0ZQBN2X
   JN1KeXqApjiLNVQsg8Z/gJAWfhVU51+XG39mpF8vALxZGi10jWd6BO6Bv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309256054"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309256054"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695240397"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:41 -0800
Subject: [PATCH v3 34/40] cxl/core: Move target_list out of base decoder
 attributes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:41 -0800
Message-ID: <164298430100.3018233.4715072508880290970.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for introducing endpoint decoder objects, move the
target_list attribute out of the common set since it has no meaning for
endpoint decoders.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 13027fc2441d..39ce0fa7b285 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -186,7 +186,6 @@ static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
-	&dev_attr_target_list.attr,
 	NULL,
 };
 
@@ -199,6 +198,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
+	&dev_attr_target_list.attr,
 	NULL,
 };
 
@@ -215,6 +215,7 @@ static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
 
 static struct attribute *cxl_decoder_switch_attrs[] = {
 	&dev_attr_target_type.attr,
+	&dev_attr_target_list.attr,
 	NULL,
 };
 

