Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E86F075A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjD0O3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjD0O3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 10:29:12 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616CC1FE6;
        Thu, 27 Apr 2023 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605750; x=1714141750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ds9/wjMM0PLi1AVS093HPsnv7S1iVHOpqdUFFwjwWNA=;
  b=aRDJnYIs6BSGz+H8xZcyZZW+5SgtWCavWxX0TtbX050+hrU1hUvGZXSN
   n1S6pkdxYbt/Bg8Z2ViIgTt0D7ls2ACf1PFdwCZ9EZJltoEUnRCVnKYRB
   gzq+8fAEh+X+lOj1V1HTtUWWyXBO5a9R/h+i2DbZN1y4GMKJA2Uudpiia
   Y2Uwpy4PY/+JINuLeYlt4e9X9ZQOJDPLAPXbDdPsoCegYviMOceilfRlq
   Sl/XjPRO2aIHAnf/d/qDBOHuKIAm4k+dB4n876lYojU0R5kNlYvgKatRk
   NeQnEW8i8go7IUX+ZPD2BEAYyb0rc12ggWridICIQufyXwhE7eGDE3H1y
   g==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607876"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Apr 2023 16:29:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Apr 2023 16:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605748; x=1714141748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ds9/wjMM0PLi1AVS093HPsnv7S1iVHOpqdUFFwjwWNA=;
  b=Lf3pZ+ea6b614EGfAExzt9LtkoOJHhiswD3PWBQSZsIWGv6tfZ3/6qGL
   0TYgZNuEHS3HTdLWRf2culOpckhf/koWsgPgI+61NM2W0TGaMuq4WwCQT
   BkWkhyXcSg2oBwabsaTSgM9DOhNFQ10C/rdYX97w1jL2wpw9Jt/dBeAhG
   r/u5e0o7WGfq+QqL7vNXkpNRvMdwC17/GbzYes8o4NNjBxjIMoRmRxiRV
   Ue0p9GTLypeKWc2LUKfzdDIsAzcLJKrW19YTmPgQ5wuvPJEAToMkWw6JG
   OUw+cAapmw8Jk795tka/sLi8oeCh0RplRg9b2LXtX8pQbwBZETqO9e6E0
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607874"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 44DD7280072;
        Thu, 27 Apr 2023 16:29:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/3] PCI/sysfs: sort headers alphabetically
Date:   Thu, 27 Apr 2023 16:28:59 +0200
Message-Id: <20230427142901.3570536-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
References: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The includes were not sorted alphabetically. Sorts them properly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/pci-sysfs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..289c1c17b41f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -13,22 +13,22 @@
  */
 
 
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/stat.h>
+#include <linux/aperture.h>
+#include <linux/capability.h>
 #include <linux/export.h>
-#include <linux/topology.h>
-#include <linux/mm.h>
 #include <linux/fs.h>
-#include <linux/capability.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/topology.h>
 #include <linux/vgaarb.h>
-#include <linux/pm_runtime.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/aperture.h>
 #include "pci.h"
 
 static int sysfs_initialized;	/* = 0 */
-- 
2.34.1

