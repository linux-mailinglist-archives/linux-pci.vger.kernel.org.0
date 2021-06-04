Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2150B39C026
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFDTHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhFDTHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:35 -0400
IronPort-SDR: iutIhCEes9pFAMl2eaWLHx+3AcvA8J5h2qhbMncA8EwbNbJmNCDeWSnrLdowJ01Islq4TRnnuB
 NuSfrZPEo5nQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513935"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: z/HlabLCIGXnyuUr/Ijry5oAQxW/MPzwADybkkJ9wCM4/3l+kr3vhEePEh5JGiEkxxpDctKGLw
 MQfk5i9uWUCg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049113"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 3/9] cxl: Collect all DVSEC Device fields
Date:   Fri,  4 Jun 2021 12:05:35 -0700
Message-Id: <20210604190541.175602-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 ls-ecaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index 83ca93e..2b3f0f9 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -701,7 +701,7 @@ cap_dvsec_cxl(struct device *d, int id, int where)
   if (id != 0)
     return;
 
-  if (!config_fetch(d, where + PCI_CXL_CAP, 12))
+  if (!config_fetch(d, where + PCI_CXL_CAP, 0x38 - 0xa))
     return;
 
   w = get_conf_word(d, where + PCI_CXL_CAP);
-- 
2.31.1

