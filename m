Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89139C02B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFDTHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:48569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhFDTHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:36 -0400
IronPort-SDR: TNsCLdvjeYbHPEq/T5W31wNusLgRe9/3onM2tnW19ZDEEKIZjp6JYQrLH88POR1Udy1iNIOzjW
 LdpDWT5esY0A==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513944"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513944"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:47 -0700
IronPort-SDR: h8aBLckqNqjM7/uZ1yYSm85K2auNXkv6S9EuSufXx5isu2a21RRue61j22JC0yOuORDw954a3/
 PFCXWACujDJQ==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049134"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 9/9] cxl: Add placeholder for undecoded DVSECs
Date:   Fri,  4 Jun 2021 12:05:41 -0700
Message-Id: <20210604190541.175602-10-ben.widawsky@intel.com>
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
 ls-ecaps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index a0ef83d..2d064be 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -868,6 +868,21 @@ cap_dvsec_cxl(struct device *d, int id, int where)
 
       dvsec_cxl_register_locator(d->config + where, len, rev);
       break;
+    case 2:
+      printf("\t\tNon-CXL Function Map DVSEC\n");
+      break;
+    case 4:
+      printf("\t\tGPF DVSEC for Port\n");
+      break;
+    case 5:
+      printf("\t\tGPF DVSEC for Device\n");
+      break;
+    case 7:
+      printf("\t\tPCIe DVSEC Flex Bus Port\n");
+      break;
+    case 9:
+      printf("\t\tMLD DVSEC\n");
+      break;
     default:
       break;
   }
-- 
2.31.1

