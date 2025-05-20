Return-Path: <linux-pci+bounces-28151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFAABE658
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8233E1B68434
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE525DCE9;
	Tue, 20 May 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH0tiDUO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF425FA3F;
	Tue, 20 May 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777858; cv=none; b=OXPJ4jllqztVCyrhVoUiUjmXsOL2mgaXJVTMYVnfKcKzIcNsWbFufFQ5OvgUYdqhnMkOlzE9JoBMphKY5MyI6dxBu7AmFYfsTLncQr5zJ4gKjUiMlLtioPZ5H5F9z5zqHZy6FJsVWPRkyEFblt9pIn10ARwhU7x5WXge4rBI3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777858; c=relaxed/simple;
	bh=KkXK+KIswYmf8YaOOqkzgFfbA3LUGmIctu6WeSPxqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahhTFpEhFHfBJLQ1mCqq4idGaj/0zBiJ3936PTQl25525kyHwPhcamYj1mpTsG+jQyffoASGyhfAnv9SHN5t6Nn1TfBSgCKtKjMMLj5pjD0VTg+6w+zOzfo9n8VAsa0MEft7ZqLiLHOSw+/8QcblqWbYso7umD0XJzpIDf/RVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH0tiDUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E74C4CEE9;
	Tue, 20 May 2025 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777857;
	bh=KkXK+KIswYmf8YaOOqkzgFfbA3LUGmIctu6WeSPxqmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eH0tiDUOrDcsXQpewlMH7cUV24aeTrVaKrG8fTciB/DAKgCioH8pwgMEgbxidBsqt
	 7fNcvNO+4XO1BM6gH8eBMPL2n0fXUhCxFys9vGH2dyYcFDdi3SYH2UgD13M0nomUD5
	 5IHp7t3QqQhe2bRdNE5TS7furM9BCRMe31tl5g3U5FkCf1+yMVIf3FUQOiWSPqgOBZ
	 9olD+ONOuw2C0JBR8vb/yQCi31dUVsniwtzs2Gur/A7fjGo/G6X/IGP46mu+L8SHgn
	 bABCaQRo51JgpWc1dqdn8w9dRGxj9x56HNqux7IABI4lq+94dZ87vJhXgfMW6SfX2X
	 QH4HC9019jkWg==
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
Subject: [PATCH v7 04/17] PCI/AER: Consolidate Error Source ID logging in aer_isr_one_error_type()
Date: Tue, 20 May 2025 16:50:21 -0500
Message-ID: <20250520215047.1350603-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we decoded the AER Error Source ID in aer_isr_one_error_type(),
then again in find_source_device() if we didn't find any devices with
errors logged in their AER Capabilities.

Consolidate this so we only decode and log the Error Source ID once in
aer_isr_one_error_type().  Add a "details" parameter so we can add a note
when we didn't find any downstream devices with errors logged in their AER
Capability.

This changes the dmesg logging when we found no devices with errors logged:

  - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
  - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
  + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 568229288ca3..488a6408c7a8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
+static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
+				const char *details)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+		 PCI_FUNC(devfn), details);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -926,15 +927,8 @@ static bool find_source_device(struct pci_dev *parent,
 	else
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
-	if (!e_info->error_dev_num) {
-		u8 bus = e_info->id >> 8;
-		u8 devfn = e_info->id & 0xff;
-
-		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
-			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
-			 PCI_FUNC(devfn));
+	if (!e_info->error_dev_num)
 		return false;
-	}
 	return true;
 }
 
@@ -1281,9 +1275,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 static void aer_isr_one_error_type(struct pci_dev *root,
 				   struct aer_err_info *info)
 {
-	aer_print_port_info(root, info);
+	bool found;
 
-	if (find_source_device(root, info))
+	found = find_source_device(root, info);
+	aer_print_port_info(root, info, found ? "" : " (no details found");
+	if (found)
 		aer_process_err_devices(info);
 }
 
-- 
2.43.0


