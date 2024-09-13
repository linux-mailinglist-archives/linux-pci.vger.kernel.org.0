Return-Path: <linux-pci+bounces-13181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA309782BE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F3F1C22597
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BC10A0D;
	Fri, 13 Sep 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHdCBy6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BB39FCF;
	Fri, 13 Sep 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238299; cv=none; b=Iej5OLuPjK/p3v/nu3Ai30pmajqTLaEIeWR97+xkYqpq+iucczMbVkZK0BspVbIFZmV0MGV2pUrc705KTnjW6UW2KyeNd0YK8kfOKJj5tEjqJglGVRCQKAvEsRx8l7YqaSJRt7wxSqaA67a7LcZielCq4o/lgZzK34NQZHGCt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238299; c=relaxed/simple;
	bh=p905XjkSjos0WgEwd4QQCME86XX012WwpCpIcSNX38A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuWfdIspdQwL0t2timn536ulifqpLK151r0Opl+sm+/WjdYuwmdTwtvB58jU2CjF3mnEQvVbJzL1xqZjgetiqpcweJtatyjZXC7lcnMaFMyopBDAEOZpQU9SX/e0cxCdF64wrFUKp/OpAUHoFUeh5bwRg9/4tpj6OIAb5NsA7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHdCBy6D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726238298; x=1757774298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p905XjkSjos0WgEwd4QQCME86XX012WwpCpIcSNX38A=;
  b=RHdCBy6DZfoRv1npjFptL61/0QLhvaEvg/dP01tKgX71FBAop5/XZL4C
   UgNdbRNgmwiKG0Xw7SyFM9dVxSSwJHhSNh6k/98jBfnNWXB+qwfCdDZaO
   YDHvqnb+w7s+n5+PRA++HDApNbs0MmmGuPTsc/rSUVCzi2P9MrTVhdEAF
   /fUQIgSsl34Gki5CgD9QBLdp2WtQY7w715vrqA0uswzND9/DFLgsAfAPH
   5m5HZ5kG6iJ9UgndngxFtq2BwZDjPvZhbkuqAoV5hZrIqlsHc4KKojNDA
   rOwG9jDZulgtwfZMrDLHzd+vaOY7aO++HuQMYyUkcoUmEk2nbQOW2GxZY
   A==;
X-CSE-ConnectionGUID: 7wsR6qkBSC6NoipRZ0BvPA==
X-CSE-MsgGUID: 54jFHck8R5CZWHafAgH2dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24963026"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24963026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:38:17 -0700
X-CSE-ConnectionGUID: yWxhfe7nRE+e1eFl2JlU+g==
X-CSE-MsgGUID: 0SUxrdAUT9e/Xq5f8t8Jlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98764513"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:38:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 8/8] PCI/AER: Add prefixes to printouts
Date: Fri, 13 Sep 2024 17:36:32 +0300
Message-Id: <20240913143632.5277-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only part of the AER diagnostic printouts use "AER:" prefix because
they use low-level pci_printk() directly to allow selecting level.

Add "AER:" prefix to lines that are printed with pci_printk().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6484e3a66a41..c4ba4396a8dc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -685,8 +685,8 @@ static void __aer_print_error(struct pci_dev *dev,
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
-				info->first_error == i ? " (First)" : "");
+		pci_printk(level, dev, "%s   [%2d] %-22s%s\n", dev_fmt(""), i,
+			   errmsg, info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
 }
@@ -708,12 +708,12 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%sPCIe Bus Error: severity=%s, type=%s, (%s)\n",
+		   dev_fmt(""), aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "%s  device [%04x:%04x] error status/mask=%08x/%08x\n",
+		   dev_fmt(""), dev->vendor, dev->device, info->status, info->mask);
 
 	__aer_print_error(dev, info);
 
-- 
2.39.2


