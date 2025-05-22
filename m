Return-Path: <linux-pci+bounces-28288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82375AC17AB
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9E7A7434
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B372D1923;
	Thu, 22 May 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3FVszZr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0B2D191F;
	Thu, 22 May 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956227; cv=none; b=o6JR+dazSssrvJoT4rXJw5pHVZx0Ajri5D4lF7IjDYBXcXXOswvgjRPkdKHR4tUIzPybKhFAHkGiakMgMimvXab77YY3QFpe8orLLBtkvD1o8vCGd6N+yQMcwNTZkI1Flyodi/4/M/LzPIX3658wGJm5jH5+dqOr6kT2uuH1jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956227; c=relaxed/simple;
	bh=IpozNL8P1/qwMOXg42wi4u8eXPEwz1FArxo4wownd8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXu98LuvJynB7PL3FAVR2lHC5cPnXpZZbnqeTPEevQWHUzt8SpOTtEN0iglIDrP4Z1yQmzMyuDcxlyS7AYH7K7v+q81dTCAGRlI+bFGFbqp5gvgb6WJGU0qN+jiZCnlizZUj2dz4DtPKrjg8ETBoW4vVFkPI3EyLWtEKdQJNny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3FVszZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8485CC4CEE4;
	Thu, 22 May 2025 23:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956226;
	bh=IpozNL8P1/qwMOXg42wi4u8eXPEwz1FArxo4wownd8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3FVszZrWQ8AwjTu2VrLM7kQ3E5+zH+9fiWnTLc6A+EJ7XMcNeAbNqj1RvW4EVcdl
	 41XMXVpTMQ/MM/W2H7lafTdHo3jBL69KeAt7OpmwXQ3sKJpuX2tgMCduJx8d/z+ZCn
	 802n1BH3bTsqqwE4cjwB9T08orGdn6g59EPE2nATihd/N/xRGkqt7squYugq9LgMFr
	 QGhDGGqzWzoD7ZJRZxREa/piwSZ7XN/SJKNUBX4g0dH7ErzL1IlvLwQRP+3AbsNApQ
	 C1sW73uQD37I1fbt0nVu524HnqzQdBA4yBuzNO2RRkA/DWpsDlYQqIh4BzbfbBhfIY
	 rHNhT0hUKPA/Q==
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
Subject: [PATCH v8 01/20] PCI/DPC: Initialize aer_err_info before using it
Date: Thu, 22 May 2025 18:21:07 -0500
Message-ID: <20250522232339.1525671-2-helgaas@kernel.org>
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

Previously the struct aer_err_info "info" was allocated on the stack
without being initialized, so it contained junk except for the fields we
explicitly set later.

Initialize "info" at declaration so it starts as all zeros.

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-2-helgaas@kernel.org
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


