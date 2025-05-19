Return-Path: <linux-pci+bounces-28018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3090ABCA07
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E165C7A5D72
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DE22173D;
	Mon, 19 May 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1bwFFIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E73221DB1;
	Mon, 19 May 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690616; cv=none; b=LFxVVaAmJw6AteQAXACGufhS9SKm51+I0tKr0qVH2l4FXYvsnIVHGPMseB+Vl85RKRBsRa8OiuHfUi02Zu/c4v8+evmlKPm0gG+79Y6fyKDx/KP9vT8Y1ZzmibY+fzFLSmn7HdjXdkusne6lSoZvRsxWe0rLeGTgF33S9F9y3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690616; c=relaxed/simple;
	bh=caXZ1WGEnf9oWC5EzQaaFcADISQqBUgQ3akXbu0NKUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUoRCAuRXsMwK1U3XqoBTQE5jwPogIzoNvwRAp5W+ZsOzOkp9aLemIw1UuRlQN8R9V+usy7lf/jw4kMNMxOIMiIfe5nbJfvtPUpmVymBHL80gudoTciin4BzQvSIxPOJ01oPEUxT32F7CV6trv9HSfzQf28or0Taon4VUeS1EWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1bwFFIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443CAC4CEE9;
	Mon, 19 May 2025 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690615;
	bh=caXZ1WGEnf9oWC5EzQaaFcADISQqBUgQ3akXbu0NKUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1bwFFIuLBwn5HIOUVuCokpM2sEveKn2NklZUFgfQ7lD/iNGSPcoRPewAynMtBUCG
	 h/gb+5z4+AiMoNEGS1rcvxwxio/DIRI/nuTk5D0SW/0N48+kwEGdkcFa+KHPRogRbr
	 jGCfJDg48RyHiT3mgC818ltUZ1GeSJ7e32nx4RmFPfdSFEzxgnUv0DaNCtWTdGJnoU
	 5iU2Lm1K8znsMmiG/0VdPN3T84yVZXAen8gdlVe69On8qDmCdmW1gflcrvheAkm8KV
	 uAEQGhUPGll4/QyfQ4sVz1eDw3CSRTjfA/q/SZvlwx4RCXa2ikLUvOb7BeUQEeYMD0
	 zygUgypXYL3bQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
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
Subject: [PATCH v6 03/16] PCI/AER: Consolidate Error Source ID logging in aer_print_port_info()
Date: Mon, 19 May 2025 16:35:45 -0500
Message-ID: <20250519213603.1257897-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we decoded the AER Error Source ID in two places.  Consolidate
them so both places use aer_print_port_info().  Add a "details" parameter
so we can add a note when we didn't find any downstream devices with errors
logged in their AER Capability.

When we didn't read any error details from the source device, we logged two
messages: one in aer_isr_one_error() and another in find_source_device().
Since they both contain the same information, only log the first one when
when find_source_device() has found error details.

This changes the dmesg logging when we found no devices with errors logged:

  - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
  - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
  + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..b8494ccd935b 100644
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
@@ -926,13 +927,13 @@ static bool find_source_device(struct pci_dev *parent,
 	else
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
+	/*
+	 * If we didn't find any devices with errors logged in the AER
+	 * Capability, just print the Error Source ID from the Root Port or
+	 * RCEC that received an ERR_* Message.
+	 */
 	if (!e_info->error_dev_num) {
-		u8 bus = e_info->id >> 8;
-		u8 devfn = e_info->id & 0xff;
-
-		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
-			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
-			 PCI_FUNC(devfn));
+		aer_print_port_info(parent, e_info, " (no details found)");
 		return false;
 	}
 	return true;
@@ -1297,10 +1298,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info, "");
 			aer_process_err_devices(&e_info);
+		}
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1316,10 +1318,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
-
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info, "");
 			aer_process_err_devices(&e_info);
+		}
 	}
 }
 
-- 
2.43.0


