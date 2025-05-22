Return-Path: <linux-pci+bounces-28291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D9AC17B6
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28D71B66D67
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC72C17B8;
	Thu, 22 May 2025 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8cea/ZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054872D29BD;
	Thu, 22 May 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956232; cv=none; b=PlxYdq/gYNda4PV2OR3J1K7MPZxk59VoNiaXkNymqpQzT5biiEZOGpLkFRehEVOFYXI4DMxa9kgahhd20qMaJm5G2Lo99BczFk0BJTZRBJHSPNiJXdzGiMRHfeIZZ3+YD0aRRvlN9WzzSxOdpC/pkGNncF2pV38xLuMbZmCrWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956232; c=relaxed/simple;
	bh=IyT4U5/iqZgzUKeFOOcx1oYJyd04a97M+SJOfXDWhxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stxreIkrOjTLo6QlOIkKLF/ODeJEokI7dEyDNmC9s2F0tOfyVrTMBAdOlRkAus8hpyTukpTYY82v4s625ZGfxL2sjqedY5vywt21kseIypy79qGs80TruXD+8aUKCqjFjj0oV9q/wzlMqYaEaTJ/845o3a8M/sQ7aZG14swvBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8cea/ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B521C4CEEB;
	Thu, 22 May 2025 23:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956231;
	bh=IyT4U5/iqZgzUKeFOOcx1oYJyd04a97M+SJOfXDWhxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8cea/ZZo+kZBPVQH3/QFcU0GOtPhlN7dG5M37kBSG5Ku/NVOq6WTsW6FxftLrst6
	 IF7hR/Iyh3eunltNFyVge8AcDp7YbEICE80Mq3gSTja31X3iGmrclhKsz/Cnrl86rO
	 dfd6EQtwRkSnxUHeU7YpjJb+TffKrgTiNmhZlmyLjUmWm/PDDYTX/hcm3U1lvK8Mnu
	 2E6lYtAGY+/xBOdW447+fabbwJluktHF3CtJT2Bj3Dia6PcLQWrY1ON3i6igjBYjxZ
	 uDU2OcmztDJ7zBGmIxkgL+0n87izDRbsC0eDeAqr0bL5qP/cEZsnaD/5/taNym5pRk
	 sK2qjzHt9cy1w==
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
Subject: [PATCH v8 04/20] PCI/AER: Consolidate Error Source ID logging in aer_isr_one_error_type()
Date: Thu, 22 May 2025 18:21:10 -0500
Message-ID: <20250522232339.1525671-5-helgaas@kernel.org>
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

Previously we decoded the AER Error Source ID in aer_isr_one_error_type(),
then again in find_source_device() if we didn't find any devices with
errors logged in their AER Capabilities.

Consolidate this so we only decode and log the Error Source ID once in
aer_isr_one_error_type().  Add a "found" parameter so we can add a note
when we didn't find any downstream devices with errors logged in their AER
Capability.

This changes the dmesg logging when we found no devices with errors logged:

  - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
  - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
  + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20250520215047.1350603-5-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 568229288ca3..fe6d323306a0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
+static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
+				bool found)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+		 PCI_FUNC(devfn), found ? "" : " (no details found");
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
+	aer_print_port_info(root, info, found);
+	if (found)
 		aer_process_err_devices(info);
 }
 
-- 
2.43.0


