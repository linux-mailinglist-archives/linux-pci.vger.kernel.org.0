Return-Path: <linux-pci+bounces-28297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89CAC17CE
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA3B1C04C23
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE12D4B55;
	Thu, 22 May 2025 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFx8zZ9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B672D4B53;
	Thu, 22 May 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956240; cv=none; b=ux+Th19im8bodfoRGH4o95wyWcib4FTjZVqfb/2CMuvuqcZuofL6JhqeDCBkV4TT2EczAUucRqqNoPbCIuR3rFiuA2ZsGLo5baGrQio0ms2es0ZmL38Y9ycTbxDCkOrcTfoJz3oc4R9T8ZYp1CRI8AxNSq5buczjSIgUYIz7bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956240; c=relaxed/simple;
	bh=vMqIejXWrlK9YxYbwyOyBG/YD596/rgWjQHdO+zCV/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImGSCpFpZ6TTN8fgOHxfcW17BxVCUMOSZTB+RVaoSUEwlDNDYiiq3iEf77cylq1M1SepMsXqfsGwgKGjXEBri5jvl5N8bnKo4Qm3fzjffl6FfDxWsWLjo0cf+4CBPaYuI7gR+481jPE2xLH2H5VjyINOqgT5TYCmA5ouodQDDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFx8zZ9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7012AC4CEE4;
	Thu, 22 May 2025 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956240;
	bh=vMqIejXWrlK9YxYbwyOyBG/YD596/rgWjQHdO+zCV/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFx8zZ9gtzz+M+TQIukhFM31oXy1KvmvxRKSfpeVN+zdenOX4OlIJ4FGPbr0pOebp
	 qkSbyvWrkkq9j/w6e+Qh/BR08bJnyTX1XtdLSB5HXXffRqqMvSIxUDzFy4XFKx1Xi2
	 OCvRmNktga4eU8xbxTlChXAB9T/8J5OLOY/SR1BvkJN5Cz1FYzTg0vaRAfATp+RKnI
	 wsh2ubsFLsue9r4++yf80kyMlXgkRKJ80CGbwoMACHcssxDh8nP5eDeFxCYExlX6Va
	 m0v5RUX0j8fHN8bSkOq9Y5jKLCAoTGFL7Ed1gRn6jHs4qDHemLEWg2jUEmbHH7Id+R
	 SaPaWumEZxKBw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 10/20] PCI/AER: Update statistics before ratelimiting
Date: Thu, 22 May 2025 18:21:16 -0500
Message-ID: <20250522232339.1525671-11-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

There are two AER logging entry points:

  - aer_print_error() is used by DPC (dpc_process_error()) and native AER
    handling (aer_process_err_devices()).

  - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
    (cxl_handle_rdport_errors())

Both use __aer_print_error() to print the AER error bits.  Previously
__aer_print_error() also incremented the AER statistics via
pci_dev_aer_stats_incr().

Call pci_dev_aer_stats_incr() early in the entry points instead of in
__aer_print_error() so we update the statistics even if the actual printing
of error bits is rate limited by a future change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-11-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index dc5f4bebd613..53f460bb7e6c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -693,7 +693,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
@@ -715,6 +714,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = pci_dev_id(dev);
 	const char *level;
 
+	pci_dev_aer_stats_incr(dev, info);
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -783,6 +784,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-- 
2.43.0


