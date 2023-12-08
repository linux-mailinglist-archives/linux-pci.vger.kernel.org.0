Return-Path: <linux-pci+bounces-672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75C80A036
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E693228148E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B487125D3;
	Fri,  8 Dec 2023 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYNOF8tU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184E171E
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702030003; x=1733566003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LGKMon9f9AnAW/W3uLVQv6uqlC3UWkieBCNn8Wv8Sk8=;
  b=LYNOF8tUyowxsHz+Wqo57RlYeYjlC/uYJiGTBOnd7SsV8pJnLzTFHpxH
   R7N5wpMzL/FKGkOabPymwMaPHncierhGHphyfufhgsRfiEhxwwokLijGO
   NRRa3tEUXGXhk1kXX4/s39Gl0NHf84IOOmNoBwMEjUqzQbw1KcsUdIjrT
   p3skCMQcmwpqRRpxdLFiOv9U7RJaMnD2wu8e7gS4TLuZVC4bdVkjKJCx1
   RPXcArH+8dEVpPTi/xqLzPk3fRqK4OB46VpCHeOS2oTJMiAJp5WHNEPtY
   /8MWBvKo4the/te5jHRR9W7kfNH6CStoJRlloDrYdbBoZxKqwwHrpSTaM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1206800"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1206800"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1019291010"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1019291010"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.180])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:06:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] lspci: Add PCIe 6.0 data rate (64 GT/s) also to LnkCap2
Date: Fri,  8 Dec 2023 12:06:31 +0200
Message-Id: <20231208100631.2169-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While commit cecfc33d9c8a ("lspci: Add PCIe 6.0 data rate (64 GT/s)
support") added 64 GT/s support to some registers, LnkCap2 Supported
Link Speeds Vector was not included.

Add PCIe 6.0 data rate bit check also into
cap_express_link2_speed_cap().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 ls-caps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index fce9502bd29a..2c99812c4ed2 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1191,8 +1191,10 @@ static const char *cap_express_link2_speed_cap(int vector)
    * permitted to skip support for any data rates between 2.5GT/s and the
    * highest supported rate.
    */
-  if (vector & 0x60)
+  if (vector & 0x40)
     return "RsvdP";
+  if (vector & 0x20)
+    return "2.5-64GT/s";
   if (vector & 0x10)
     return "2.5-32GT/s";
   if (vector & 0x08)
-- 
2.30.2


