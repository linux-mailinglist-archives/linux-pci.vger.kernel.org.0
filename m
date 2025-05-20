Return-Path: <linux-pci+bounces-28160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB4ABE67A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839E7A0FF8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E77266B72;
	Tue, 20 May 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ZW88H4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC5266B52;
	Tue, 20 May 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777872; cv=none; b=fOlExScOIWw+Vuy9A+u8B9E6tALvt83lwU6gthRu8Mv34hsFDDPoCfrMruTXSJANJmlo5yBGjxM6LmsCq3ex6wp53n4g4rJCNLESGzmo5bZ8Ru5mA1xX2YdYUJ9W8zU9+ucT4TkdxBnFflx9ChTre7SCLdStMPeUJAuz5zTma0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777872; c=relaxed/simple;
	bh=TV22lSmYNsCCExGd1j0mHjuH4gWfFSn4U6wx2afxjL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1bw+SADR0tNBihI3eLSNtwr3+mgj9uZ5HYpX1D4LrPI8um9S8sKr7DdJnfgSf0BYBxUstEDyDwZnKhKkIa7zXUXsIcQHEVdLa5D7eXbLXzCMYyuFu2p8xRQAMH6FLdAG9zQhfyNqy9uoj2SVrx6Zvh/7KuLgmsCJL/MC4g3KQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ZW88H4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E06C4CEED;
	Tue, 20 May 2025 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777871;
	bh=TV22lSmYNsCCExGd1j0mHjuH4gWfFSn4U6wx2afxjL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4ZW88H4hxS326i1EeQIiK+H1Q+gArBBUrNWoPqbJZCa7HS3VJAat4rC4SB9BrI97
	 bpfxxDrVlLkV+juTBtt4xJLy6x3pcVZ07+ZQeAJXekdYFc7n5f4AqAqY6/NKF1d6x5
	 +Iv/LhgJcot8ng2Srn3XfmRj01V5uBS+49c+v18E2Ylf+lF1O0zCEC2APyRCgm8kah
	 KoCTWwtGFLR/mF65v0udZlw1FAZG5TqXKWE2EHktSbL3btLVsCXxRQqdddretuEgQk
	 Svx/0R2VTisy72B+o9bBlfKRmfeSOaRzCS2HDIS0QoW0S8WNgiSn3AIoA1c+3xXhDc
	 Kfq2CNJtmPkng==
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
Subject: [PATCH v7 13/17] PCI/AER: Make all pci_print_aer() log levels depend on error type
Date: Tue, 20 May 2025 16:50:30 -0500
Message-ID: <20250520215047.1350603-14-helgaas@kernel.org>
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

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity by default.
Convert them to depend on error type (consistent with rest of AER logging).

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f5e9961d2c63..4cdcf0ebd86d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -788,15 +788,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+		   status, mask);
 	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
 
+	/*
+	 * pcie_print_tlp_log() uses KERN_ERR, but we only call it when
+	 * tlp_header_valid is set, and info.level is always KERN_ERR in
+	 * that case.
+	 */
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 }
-- 
2.43.0


