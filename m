Return-Path: <linux-pci+bounces-28148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD13ABE64C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3549B4C171C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70125E834;
	Tue, 20 May 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlHUMTGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBF25E821;
	Tue, 20 May 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777853; cv=none; b=Chpw3k8eCcuw3n54Lh+rhcwhr7DTzR72eOdTsp4yYBjvjUdNphGjCWlB9MzKHJip+Nm3jjx9+WZxt7b0CTaE0saIsMX3M5pWsZUmWc+3CS6kfB+8Lk3ZrXQoMN+S16JAOtUtB9GyscMtmOc7f7rVl8f7rlEmTyriUiAJ3tkFjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777853; c=relaxed/simple;
	bh=IPMbbOcFFDi3G9kSOU1LeCM9xJi4UaBswiex0tdbMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFW/UeYSdgxNTKxA+CowZQmT06qm5DZLoJRVc1m4bFthYslAAikJ+hb0uzfPtpLBChKAFaEkdFcTMYLL2sEbNo0Kypb9jthy/pGcFvs7XXRXhtll38hzkC1IBsiJYgHYHAU9zFjEsAnIQBl9ZtnpLWnShdVibLfhfN+VmfhXhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlHUMTGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB0DC4CEF0;
	Tue, 20 May 2025 21:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777852;
	bh=IPMbbOcFFDi3G9kSOU1LeCM9xJi4UaBswiex0tdbMIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlHUMTGLWmpM22fL61Vds0cpKCxjl3zGYlayGT6PKSn/Rpexo1WJs5gFt9PABLjUl
	 d6B+v/zhU9oufqMfBlQhry88S71PfAKH7ErQmQ7WH8GaahjHUJX7PJbK4MmbaZdggP
	 Lt9Pfxeev2ikn6wrWWuQxTOjDL1v9wUaGy++wa4V+pR03m+gug9Jw9J3fKYl5DJdnT
	 Z26N/+lRxCNGS7rkSInhz4T78PjFX+jSb2NbkhiI//4vKvoJUW8vQOKEZLGAi29qXC
	 an7FAU6tyOU+udoBYSMj87RtxRu8qbVvrnX4rmyTZ/wUpHTyVRD/S87bF7lZp00vFy
	 EAbwhMLV908zw==
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
Subject: [PATCH v7 01/17] PCI/DPC: Initialize aer_err_info before using it
Date: Tue, 20 May 2025 16:50:18 -0500
Message-ID: <20250520215047.1350603-2-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the struct aer_err_info "info" was allocated on the stack
without being initialized, so it contained junk except for the fields we
explicitly set later.

Initialize "info" at declaration so it starts as all zeros.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df42f15c9829..3daaf61c79c9 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 void dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
-	struct aer_err_info info;
+	struct aer_err_info info = {};
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-- 
2.43.0


