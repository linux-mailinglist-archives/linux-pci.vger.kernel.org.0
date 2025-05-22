Return-Path: <linux-pci+bounces-28293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC56AC17BF
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0D3BEF2D
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6642D3226;
	Thu, 22 May 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiKpbKUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659D2D3224;
	Thu, 22 May 2025 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956235; cv=none; b=WvXI7gNJm6pJCeqG+sO/GSlrfJNoJQ+/ya/kDZfwR286f0ED8G1VTHNLh+Al3NA40hxFTIa6Yq0Z1JB9m//AJo6ieSOFnwU1J9xg5quPSTEjaATm59w4b8fnvaJxk8qU3FCWfSkxWqmkvpZrzS5nKe0qw4RBN1C5l0XkPHNGZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956235; c=relaxed/simple;
	bh=72ogOQFoNYoErezHSM2HOyMq9JkgXUt0lHiiW5Jloq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9NtAXwrfLH0TKqpg0X4K1VDMNGywSecu2HUNd72sThMmgzXKKdKIGiDusUjp16XJs0buakKksJOE3M1Vt2Xy570fxAEvhnyCHZqfzvQtRpu9lGsLSs6+oBsvvrAFCbjinnJPqXf54o1qZlh/N4baRvzsageizkrGQBcYgrAUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiKpbKUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456AFC4CEE4;
	Thu, 22 May 2025 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956234;
	bh=72ogOQFoNYoErezHSM2HOyMq9JkgXUt0lHiiW5Jloq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiKpbKUkclRjRz6bmLk3KaL3qYb3DXBNwgqeHb05bYhyZi36g31fUcepMNALoORCQ
	 NG+nX7xT+hGufOLJHE4+aUt4eP42VPsWhrLptBPfdaK9R5XMLRqWRzMZFs+JMyUPA9
	 /jA+yXfvAFGNgEGMwi+OajpL4W4RJDwIlBXhdDfNRkbKwy5oW2P33VWjHvud+V85is
	 nwNcoG2DoHOCqoWotJcrmNAivZbX3elzq5LuuhlVwYVckkLcDewqvptgge24zky1Wp
	 /Lx6KOaAyDzteuVBF/tltKh/vi97LB8CIXeo62UfYS3cAzPgfC2LdDQsLzCaoqvcoy
	 4NLLES9EFUNBg==
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 06/20] PCI/AER: Rename aer_print_port_info() to aer_print_source()
Date: Thu, 22 May 2025 18:21:12 -0500
Message-ID: <20250522232339.1525671-7-helgaas@kernel.org>
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

From: Jon Pan-Doh <pandoh@google.com>

Rename aer_print_port_info() to aer_print_source() to be more descriptive.
This logs the Error Source ID logged by a Root Port or Root Complex Event
Collector when it receives an ERR_COR, ERR_NONFATAL, or ERR_FATAL Message.

[bhelgaas: aer_print_rp_info() -> aer_print_source()]

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250520215047.1350603-7-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 18005615d376..8b23ef90345b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,8 +733,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
-				bool found)
+static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
+			     bool found)
 {
 	u16 source = info->id;
 
@@ -1278,7 +1278,7 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 	bool found;
 
 	found = find_source_device(root, info);
-	aer_print_port_info(root, info, found);
+	aer_print_source(root, info, found);
 	if (found)
 		aer_process_err_devices(info);
 }
-- 
2.43.0


