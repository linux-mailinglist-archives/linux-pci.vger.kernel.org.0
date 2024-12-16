Return-Path: <linux-pci+bounces-18556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C89F386E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5198F1894EF5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802C206F3A;
	Mon, 16 Dec 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ/OboEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B59206F18;
	Mon, 16 Dec 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371978; cv=none; b=uK1o9hM/cZ8YziLVqm0qpIjaejM4Njoa9AjhK2uF/cz9RLIGqtv6mrPXOwZZuDL6t4fmZ4xiosbTPFzj2e8ifxCT1COMgp9VqpcvaI2CDxcmwwzZa1ciI6AzM4xmDwMD0jEnSsJXu/0cR20HMXeH2N8KssoiFzurxbdX7/r1H0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371978; c=relaxed/simple;
	bh=iiA6P/YkhdJ4pvGq0xbbcwj5wE9nJL6JxPlffU4UsMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VY0/GrQgsxlOSae9TgvdB+AjuleHUMTRpuOfiMo9jX33uLeZlwh6rAk4MBEGSCSLJ5XbvUFPyZt4iarbJva0ZV5sqAcICVGQ0jwet/Ak3BzKqjgjBZ1TCabRMqlyI6kNkIsTKQ0koZpOQ/kODgcSkfffp8SZD7Cfvbf0jUGo2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ/OboEb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371977; x=1765907977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiA6P/YkhdJ4pvGq0xbbcwj5wE9nJL6JxPlffU4UsMQ=;
  b=ZJ/OboEb3uN//Gjy0bEnZFaJbaPxa0XahFEDnDHOYoJFXZiVw8RqnYQV
   dryMtbdl8SXdTEmWs0+Ex/J3klbeHhNh4YCXw7SiNhgN2B6nfHpBzmxRk
   4aY9ACpqjQIWgQhggGqGJwcGSLhld5l7oC0S81eVr27xNdUGVSFRdWZNM
   quRCmy/jcOHp6EuooeChJIHfTDSFXoCv1V+MCpIQSr6x0ByzWlKHGrjCa
   CWi5rykZmy0cGYQ2ADi9Vh1B/JqhfwxbIJbOa75owbxhiwr/3DCCMTTv4
   UurUP3GGzG1qUm6Mq5p+dsnBh2Tby3vgzb3eD43RnlbG1uTLyjpC1xkay
   A==;
X-CSE-ConnectionGUID: XZ1qk5pBSpSQl8h//sb1Iw==
X-CSE-MsgGUID: WAQxmxXQQaOUjfRhZb3VrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52293344"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52293344"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:36 -0800
X-CSE-ConnectionGUID: RQXSrU0DSeaw6WkTKYaLsA==
X-CSE-MsgGUID: C3zLler0SNK5VJgJ2n21ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120532048"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 21/25] PCI: Indicate optional resource assignment failures
Date: Mon, 16 Dec 2024 19:56:28 +0200
Message-Id: <20241216175632.4175-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add pci_dbg() to tell the an assignment failure was for an optional
resource and reword existing one about resource resize to tell the
change was optional.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a10acf4671ef..500652eef17b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -273,13 +273,17 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		align = add_res->min_align;
 		if (!resource_size(res)) {
 			resource_set_range(res, align, add_size);
-			if (pci_assign_resource(dev, idx))
+			if (pci_assign_resource(dev, idx)) {
+				pci_dbg(dev,
+					"%s %pR: ignoring failure in optional allocation\n",
+					res_name, res);
 				reset_resource(res);
+			}
 		} else {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
-				pci_info(dev, "%s %pR: failed to add %llx\n",
+				pci_info(dev, "%s %pR: failed to add optional %llx\n",
 					 res_name, res,
 					 (unsigned long long) add_size);
 		}
-- 
2.39.5


