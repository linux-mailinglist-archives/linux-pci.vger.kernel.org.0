Return-Path: <linux-pci+bounces-28153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050FABE662
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11531885640
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8522620F5;
	Tue, 20 May 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAgC9mfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E325FA3F;
	Tue, 20 May 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777861; cv=none; b=KK259Jhl3dKpyQ7Tqp8pQiPM8ZkRbNNVh05UHc8iOlbZWRKGabZh5Hi7jYBgfRqlewykfuLCt/s5hlCeOqxIqG1jdsz/ehzPrZygwUwAdo/82DHWZjpCpSUz3okUS/3zLIUfwSbLGyo/iSja00CD9cUbRwbo3DdtEjMy5WQQ5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777861; c=relaxed/simple;
	bh=BWAUnCgTWnneKjfd1/r1cYKXjXgMZ6b37PyuTZ5lIYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0IfjplaiqS8+DcXGfDHiXBt58Ke6lUDisEQ4wHDBsqyMwl05jrkz/T9F1afjUa35mF72A9GWq2n2J09ybD81Bv1uep6UXYXVmX5WfVV0ZU3UXtX4SbiDpSxVJWk3vVarH3BKtSzHv42p5xrZh9iTqnJo7WxxeUR023zMXBSDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAgC9mfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48675C4CEEF;
	Tue, 20 May 2025 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777860;
	bh=BWAUnCgTWnneKjfd1/r1cYKXjXgMZ6b37PyuTZ5lIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAgC9mfAxpktIzcXhdxJvW/QwRet7aKuX903/9PFw93O51KaxMlf+SbOHfjyXmxNB
	 4WFHVTCuDcO89wolGrL0mPJSrF3elaqGzCExeeUnCTvK+RHfZhvUOT/V0q91hD33Qx
	 QDEZl6wAjzz76ZRXRuVyneUK5IY2DNnPAx1kXulPFvvmUMKicpzPo6LUBtvIMf8V7i
	 2psUATWIltbaepe0RVdQ2NdtnoGzhKUlW5Lp1Tef2dSwVnBJ8rACyWf0b6a6WWYfdR
	 vdmIt00TLSz+wIM+pSTpPhGJXdxN5bCtGg1BLfNynFm4w7PYY2mO+YTfr9KEgHsGZX
	 zomuH3otIc6ow==
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
Subject: [PATCH v7 06/17] PCI/AER: Rename aer_print_port_info() to aer_print_source()
Date: Tue, 20 May 2025 16:50:23 -0500
Message-ID: <20250520215047.1350603-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jon Pan-Doh <pandoh@google.com>

Rename aer_print_port_info() to aer_print_source() to be more descriptive.
This logs the Error Source ID logged by a Root Port or Root Complex Event
Collector when it receives an ERR_COR, ERR_NONFATAL, or ERR_FATAL Message.

[bhelgaas: aer_print_rp_info() -> aer_print_source()]
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65f9277c822c..4f2527d9a365 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,8 +733,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
-				const char *details)
+static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
+			     const char *details)
 {
 	u16 source = info->id;
 
@@ -1277,7 +1277,7 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 	bool found;
 
 	found = find_source_device(root, info);
-	aer_print_port_info(root, info, found ? "" : " (no details found");
+	aer_print_source(root, info, found ? "" : " (no details found");
 	if (found)
 		aer_process_err_devices(info);
 }
-- 
2.43.0


