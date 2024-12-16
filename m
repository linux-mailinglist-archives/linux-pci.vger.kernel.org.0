Return-Path: <linux-pci+bounces-18555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40549F3862
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E478116DD57
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78720967E;
	Mon, 16 Dec 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cm2qMyO2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F1206F13;
	Mon, 16 Dec 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371968; cv=none; b=TLQMEWah7OrvT5Ykp6sxvRnOlwhLVleVpfG2IvrowiQ+NTHXvC4dHmrpI3V4EmyQ3C91jsOmyBjVJn4SZhvaS1VsZCAb+KqoEDkEc2Jw3yRs+tfEsw+Yeo1piLovVMdOZEfBHdofaMgpyx7mO2hkBYXTbs183DH8zjpycoiTWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371968; c=relaxed/simple;
	bh=jD/R4WdYznjP//mxQ/nU5C7p4YIhHA4eurXwh152t0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaTXGFZHTCr7IgXwP+xe1zFBZT8UOvfBLWQSbHVAMF1zB4c5SafZ6oW4Tse/2BwauI6iBxb+DPcDQGz4oJMGukV5EnOVcF+PdWhwMFau0d++ztoxudP7fhIKC/DcEupcSwOY5eppncAXOd8TNkr0IUwjK18BqBoawSmPTALjz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cm2qMyO2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371967; x=1765907967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jD/R4WdYznjP//mxQ/nU5C7p4YIhHA4eurXwh152t0k=;
  b=cm2qMyO2/zy5tVTUUSW7Lt+SdEJWxt4HT5ac+mMhPx8A5WeDmYnLG2Ic
   gbkDREZUMIRNV9bjzpKldK6bZF3PiHs5Y+gaxCyy2S/L2l4FhyYmZFNZL
   dlTTTssjhHztM9P6aQrlCIibZAK1Owsk3V6GtM1+gF4K2xEsH8jtU/Xj5
   mwNjOepgxAmMOIR6Ocm+iFLfc9Oh9y6jnl/viDbpbtHAoWbPi0gF1tdaM
   bLlbL89GGgyusbsp2B+HWaHhgC4ZRpE4TRCFDUzBzU3tSMnnwSKvdHFzK
   H1/b6Z/6uIp3B0xQIkK49cqN5cGmyj4ywvIRgbtjtfUNkpT+iDWYmPgsT
   g==;
X-CSE-ConnectionGUID: nYo1KttWTs6HLkBZ2tvhVw==
X-CSE-MsgGUID: qf5xZGBTTiCTZOBRZtuVqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52183852"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52183852"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:27 -0800
X-CSE-ConnectionGUID: vpAziNwBSMaeKhTXXw/VOw==
X-CSE-MsgGUID: nczcrmswTCWlVmAXSRTfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="128075891"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 20/25] PCI: Always have realloc_head in __assign_resources_sorted()
Date: Mon, 16 Dec 2024 19:56:27 +0200
Message-Id: <20241216175632.4175-21-ilpo.jarvinen@linux.intel.com>
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

Add a dummy list to always have a non-NULL realloc head in
__assign_resources_sorted() as it allows only checking list_empty().

In future, it would be good to ensure all callers provide a valid
realloc_head but that is relatively complex to do in practice and not
necessary for the subsequent optional resource handling fix.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a4e40916e2fc..a10acf4671ef 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -400,14 +400,18 @@ static void __assign_resources_sorted(struct list_head *head,
 	 */
 	LIST_HEAD(save_head);
 	LIST_HEAD(local_fail_head);
+	LIST_HEAD(dummy_head);
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	struct resource *res;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
+	if (!realloc_head)
+		realloc_head = &dummy_head;
+
 	/* Check if optional add_size is there */
-	if (!realloc_head || list_empty(realloc_head))
+	if (list_empty(realloc_head))
 		goto requested_and_reassign;
 
 	/* Save original start, end, flags etc at first */
@@ -503,7 +507,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	assign_requested_resources_sorted(head, fail_head);
 
 	/* Try to satisfy any additional optional resource requests */
-	if (realloc_head)
+	if (!list_empty(realloc_head))
 		reassign_resources_sorted(realloc_head, head);
 
 out:
-- 
2.39.5


