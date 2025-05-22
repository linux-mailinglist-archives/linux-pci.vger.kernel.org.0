Return-Path: <linux-pci+bounces-28304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC6AC17DD
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15B77B36B7
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C522E3377;
	Thu, 22 May 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCs04wGp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70D2E3373;
	Thu, 22 May 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956251; cv=none; b=QlGoLIiN90WwOeYH71AXPEo+a4LQVx1Hja4Roy7hPtKIcsrMAxI8wTlLR/DzJEOjpj/QQa7s78FFgNCYIrfrPSqbqqLdKhKfTXp82L8GcDgq5ntEGmyPBdTME9/zhebB0Y+YP8R95TlRfJtODJuTpexRZrpkIFZghTa+LWygnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956251; c=relaxed/simple;
	bh=0NnXHK03v0YhVssp0Pj/KjB4v+bprwz3b10dhjyQmks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHCvJNh3+RcxSNA2w03SuOww4FGwVbRDIPiQuqOJlqmxSTovJ5twt/MWTPMn6JYs0G8/WtQC9KE4fxT+JXn7xvUqZ1arb9KMN+TNPvxjP72bFdm/d5SUsXoxvuDnF+Fu3ZjV197Egfmt4Wsy/kEQ3wC/0km4By6LbwkvnJ/iV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCs04wGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09553C4CEE4;
	Thu, 22 May 2025 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956251;
	bh=0NnXHK03v0YhVssp0Pj/KjB4v+bprwz3b10dhjyQmks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCs04wGpWOkY3jtNO+fB+6ZsGXB/XioC0of+kqL1hxl8syhgRhYiMaqQmnZtniwyd
	 moJfS0aQcI/FyGIct1THzFTNDwonDpCp6joPzbUlVCGn0NRZ1/IE9IH4bfdsLwbgDX
	 BerGyHGHspOeiMJ7VNsXFyOmqzV4Nmln/+byARXaXzCbwSXCVChkVBPgGVs57z89Nv
	 062m2+/cb+z91zaRErZecBCXRxrrvmJ7+EQrEELGP/Yu3ZWmJWe5MqziZBRyfuFRlf
	 npDwKQRkwVoeLvvCoDKFhXurR3RFG0ybw0K9/5n3mMC/uRyZrJQTE9ff7PTwHOiM/N
	 h7RnK/ushzdDg==
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
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 17/20] PCI/AER: Simplify add_error_device()
Date: Thu, 22 May 2025 18:21:23 -0500
Message-ID: <20250522232339.1525671-18-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Return -ENOSPC error early so the usual path through add_error_device() is
the straightline code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 237741e66d28..24f0f5c55256 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -816,12 +816,15 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
-	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
-		e_info->error_dev_num++;
-		return 0;
-	}
-	return -ENOSPC;
+	int i = e_info->error_dev_num;
+
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return -ENOSPC;
+
+	e_info->dev[i] = pci_dev_get(dev);
+	e_info->error_dev_num++;
+
+	return 0;
 }
 
 /**
-- 
2.43.0


