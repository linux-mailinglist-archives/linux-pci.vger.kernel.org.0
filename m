Return-Path: <linux-pci+bounces-19744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C367A10D1C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0371666E6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA331CF7AF;
	Tue, 14 Jan 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwOdli0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A761B2199;
	Tue, 14 Jan 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874576; cv=none; b=QC5oEjhfLB+xuD2wvanUvAKVcoM199RJtM3bXBOuTW55P9BrQmtzqxtGlxqIk8O0F4UpirjdnyDDItJp/WhBce1JhbImcebQrWcFkyl5geVDmcwXYB9TAnyW1/0v7KPmV9/HYp9tKqry0QUIWTZKC+2Z1xwlO6v4lKhVBOWVWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874576; c=relaxed/simple;
	bh=9L+iZAVFCEGiNvBJzVf+Cu0qerXaRfJ3Hc7GFO41lLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1MOYKdcJ0rlSYO21C+PZ01DwEZ4W4Rj9jAqwXhRM89ep6kviurztkPJgS8lhNlH2MfScW8E2+SaUX1AGIeqA++AsPUboTlEEMDrnnZPmTwNsvYulHg3pZaa9IF/9wYNvDDi74n3WCeCR0c8ksdaTUwHRIKtjj9rx3m5lxc5kIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwOdli0i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874575; x=1768410575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9L+iZAVFCEGiNvBJzVf+Cu0qerXaRfJ3Hc7GFO41lLQ=;
  b=mwOdli0ikv1gI2veEOmZDeCx8/rRx61JBYNwqoAtnLzV/ouQL9/lasPH
   obwMQC2pTO/4JH0ddvILs9vUDMkElkoP1fmYKylzZOFbeJDh6jFLEkovo
   AXojxbcNfe8Nb3joUkAHON1BdnBNahmu6qja6NXik81KhSXmGH1wOqoOR
   EuPUZNiQPChHiyzCjFWxTBgrnTl1dHqPR9P8aVgXqIuXanx2hAnUfxMDq
   cy96qnBI9MUchiBSzuuuMI9JvBpo5l/KwBB2T6DqXCO3hD0O+TJJqD7/x
   Phd3jLNbYCSxyNImK7GFR+w0SWcKrEIrvb6w2lZ3g3yaaz6PkjmlNwWvA
   g==;
X-CSE-ConnectionGUID: zHzGlaZHSh6cmm2FHW6T4Q==
X-CSE-MsgGUID: zrNGWBfWQ7GCh+87BdFL8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36465829"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36465829"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:34 -0800
X-CSE-ConnectionGUID: hLYWA7Q8RcKZJfdbYv9hIg==
X-CSE-MsgGUID: Fkc4ijeuQ26OJ9iOgQ0xVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105452792"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 5/8] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Tue, 14 Jan 2025 19:08:37 +0200
Message-Id: <20250114170840.1633-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
References: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Loop variable i counting from 0 upwards does not need to be signed so
make it unsigned int.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/tlp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index f0cfe7e39078..d7ad99f466b9 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -24,7 +24,8 @@
 int pcie_read_tlp_log(struct pci_dev *dev, int where,
 		      struct pcie_tlp_log *log)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	memset(log, 0, sizeof(*log));
 
-- 
2.39.5


