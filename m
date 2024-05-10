Return-Path: <linux-pci+bounces-7333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E78C21A7
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD67F285039
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21285165FBA;
	Fri, 10 May 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMdD1rT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC88165FC4;
	Fri, 10 May 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335696; cv=none; b=stDqeP0n3ZBfWCfQG5urLxcGbuFwj75jsQFpHtcQTIoeIZaz6pGa1sKZ1T3Gsca1SGz2fA0afpxngwDv4r+VakSjIDbZxiFf4PCtYVxIJ6+WNhL930+d4EeZDSJ5OHcxe2W59bGrGeccdytevvmD0mZFRXOl0Nd6HLJtagH29mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335696; c=relaxed/simple;
	bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF8qjQrsgSuZR8YYcf5UkrAdXJGGu/lvs571DS/gtx+Chw4ABeNztfY3nTfTE4kXt1VJtYg/S3RbMFGl/E/claqtpunm1cLAFLNRM1/dhDm060oOh+N2DM4rOwvDmogWXcs8bX8/YGwvv2d932p6EAoeYTN2MfiQFZXdwjwKRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMdD1rT1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335694; x=1746871694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
  b=dMdD1rT1wCXjknL6u3kVdpgSWShI3n7smQ46V/Hc4ovqBPzSGZPiONL3
   5JEhk0cE3kki0WMYUtK2o0JpbIW5mxfihjUAdLa+0YmAPmSWjbAbs/lAk
   1Q3CxCmcid8xkYINBJ4fgm1x4OJybQjTMgj20y9OLWYoEGt+FEkVEYVpV
   qeU6KJ5aCNRU6OfulF5GE283ds9tkZccQGKUIp4pBhJziEMyJ/wd6+glO
   bnRnlqfjy9BxZMOGgJAPTlSXO7FE/kRFpXLVumZHffRcqF3cGZk3LcuX6
   nYOSzljsLoeINxZX87dmhKOzPNHby8qzKfvxaiETI5BN8gVTxfzzdIJA8
   Q==;
X-CSE-ConnectionGUID: eesOHA6wTHqc0KQKKtpQUw==
X-CSE-MsgGUID: 0PY78xEdRoKXbp9UAbU2Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="36687482"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="36687482"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:14 -0700
X-CSE-ConnectionGUID: LCOPFPlFQIG/MpZZyDUn+A==
X-CSE-MsgGUID: gs9lu6idT8WLMHgAx9nHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29571419"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 4/7] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Fri, 10 May 2024 13:07:27 +0300
Message-Id: <20240510100730.18805-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
References: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
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
---
 drivers/pci/pcie/tlp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 2bf15749cd31..65ac7b5d8a87 100644
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
2.39.2


