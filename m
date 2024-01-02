Return-Path: <linux-pci+bounces-1605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891E822063
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE111B20A52
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE714F94;
	Tue,  2 Jan 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwKms2rI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E415AC0;
	Tue,  2 Jan 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704216431; x=1735752431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P/W8NmfXSUPg8X+gbwPNv1aFNN6rCN+8ZpEpptPdyh8=;
  b=nwKms2rIOzTyU/OTP1SuG4HA1XMAwq+F3ZiHTrQ0VVDffwKMTkinrFuP
   /LDTlYVl7EOutrO7OMzQPQSmuZl9oyDk35G4Fs9pXK2C2E7JXi6XRFriW
   hXHdGr4n+voCbYatrXoyfcYdOl0/hJ6mLJHhJVuFiVr/5ZlX7jqtmOOVL
   kPM9uK640ZHsJw9eorO9zqK0K5S3VhXduIrNcnCsD6WpZohYrqdP7QBog
   2BBDlZKHiq5raWWwAT5fEppJYrnJT3DcS1Au3p+K0a52ZnGlZzfiuDBN3
   TTR47X2oh+ztyvJZg6x8TBQdY5jjHYuMH2bUkRKGyTurQcqCcKkVZ0kv8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="396631325"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="396631325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="813992428"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="813992428"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.17])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:27:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: 64GT/s uses 1b/1b encoding
Date: Tue,  2 Jan 2024 19:27:00 +0200
Message-Id: <20240102172701.65501-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe 64GT/s Data Rate uses 1b/1b encoding, not 128b/130b (PCIe r6.1 sec
1.2, Table 1-1).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..d9132029d658 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,7 +272,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
-- 
2.39.2


