Return-Path: <linux-pci+bounces-2538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2C83B9DD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 07:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D661C24C41
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E31B7EE;
	Thu, 25 Jan 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIxU5pXy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90412B6E;
	Thu, 25 Jan 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164193; cv=none; b=t/ekeA2aY02KbcrB8V30gVdoOre+mVtzBRyK4QtgnmU9cVa504ivq95wAEKnzzAETE4fzZLCGsACHc60bJuNAIiUugvur2Ep2zFyhs45XuuhGBBYTQs4nZvXkc0FDRWPRYJjAUjE2K6tqiiw4hiuAZMT8S257Tt4AtP4TvIyli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164193; c=relaxed/simple;
	bh=x32LOme0VCi24BOXE0bhRSdLzmkLr19AHRZy9FC+YGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/jLyuIqsCG6KkgGEbDbIAk96orftdB86kbrPUpF/6RCn1hYHCxDk7avFAgf/FQiTvQwh2KJFoiHPahhcjYUmuIwhgILzCLOqVz85b1rJVawSUKF0TnIZEXUjnzbuzsoA/uSTlNXpipxwEpi3M+YGKgFdX8hWk5q7EYO2epiPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIxU5pXy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706164191; x=1737700191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x32LOme0VCi24BOXE0bhRSdLzmkLr19AHRZy9FC+YGQ=;
  b=CIxU5pXy8hoGyw+0r/UeLVYxkSZFTw1/OtpLmEb/weyahrYi3Fxt4o95
   k6gv36b+ckzBi+TfMe4dEw9L/cRdPosYg6eEDur0tR9uieFGrmREe29QY
   rXx2yPG95luUzUjaHvOK1gN4F9A6r+4Mleuv5InxY/kl0XSKLPF8TjMaW
   qyUB9ElEcIEmrFGtFKagoZ+SiP4lb6PuCV5ugzAWhic43Y69J7E7ThPkF
   jBsAo5huO4BMjQb9AnzE33D/7BbJ0P9wnvfstO2nbt6QY1HCyAk4ySNJW
   U2+63s27aSWlwWsczRsr0mPzLZC7QoLTkdfE/Rt/ieg8iLau/ZxFZBM74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="976651"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="976651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28658999"
Received: from linchen5-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.209.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:29:38 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Adam Preble <adam.c.preble@intel.com>,
	Li Yang <leoyang.li@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Robert Richter <rrichter@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH v2 4/4] RAS: Trace more information in aer_event
Date: Thu, 25 Jan 2024 14:28:02 +0800
Message-ID: <20240125062802.50819-5-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
References: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add following fields in aer_event to better understand Advisory
Non-Fatal and other errors for external observation:

  - cor_status		(Correctable Error Status)
  - cor_mask		(Correctable Error Mask)
  - uncor_status	(Uncorrectable Error Status)
  - uncor_severity	(Uncorrectable Error Severity)
  - uncor_mask		(Uncorrectable Error Mask)
  - aer_cap_ctrl	(AER Capabilities and Control)
  - link_status		(Link Status)
  - device_status	(Device Status)
  - device_control_2	(Device Control 2)

In addition to the raw register value, value of following fields are
extracted and logged for better observability:

  - "First Error Pointer" and "Completion Timeout Prefix/Header Log
    Capable" from "AER Capabilities and Control"
  - "Completion Timeout Value" and "Completion Timeout Disable"
    from "Device Control 2"

Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/pci/pcie/aer.c        | 17 +++++++++++--
 include/ras/ras_event.h       | 48 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index eec3406f727a..2f5639f6c40f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -757,6 +757,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
+	struct aer_capability_regs aer_caps;
 
 	if (info->severity == AER_CORRECTABLE) {
 		status = info->cor_status;
@@ -793,8 +794,18 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
+	aer_caps = (struct aer_capability_regs) {
+	  .cor_status = info->cor_status,
+	  .cor_mask = info->cor_mask,
+	  .uncor_status = info->uncor_status,
+	  .uncor_severity = info->uncor_severity,
+	  .uncor_mask = info->uncor_mask,
+	  .cap_control = info->aer_cap_ctrl
+	};
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
+			info->severity, info->tlp_header_valid, &info->tlp,
+			&aer_caps, info->link_status,
+			info->device_status, info->device_control_2);
 }
 
 static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
@@ -870,7 +881,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		__print_tlp_header(dev, &aer->header_log);
 
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
+			aer_severity, tlp_header_valid, &aer->header_log,
+			aer, info.link_status,
+			info.device_status, info.device_control_2);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..a94997073d90 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -300,9 +300,14 @@ TRACE_EVENT(aer_event,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
-		 struct aer_header_log_regs *tlp),
+		 struct aer_header_log_regs *tlp,
+		 struct aer_capability_regs *aer_caps,
+		 const u16 link_status,
+		 const u16 device_status,
+		 const u16 device_control_2),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp,
+		aer_caps, link_status, device_status, device_control_2),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
@@ -310,6 +315,10 @@ TRACE_EVENT(aer_event,
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
 		__array(	u32, 		tlp_header, 4	)
+		__field_struct(struct aer_capability_regs, aer_caps)
+		__field(	u16,		link_status	)
+		__field(	u16,		device_status	)
+		__field(	u16,		device_control_2)
 	),
 
 	TP_fast_assign(
@@ -317,6 +326,10 @@ TRACE_EVENT(aer_event,
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
+		__entry->aer_caps	= *aer_caps;
+		__entry->link_status	= link_status;
+		__entry->device_status	= device_status;
+		__entry->device_control_2 = device_control_2;
 		if (tlp_header_valid) {
 			__entry->tlp_header[0] = tlp->dw0;
 			__entry->tlp_header[1] = tlp->dw1;
@@ -325,7 +338,20 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
+	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s, "
+		  "Correctable Error Status=0x%08x, "
+		  "Correctable Error Mask=0x%08x, "
+		  "Uncorrectable Error Status=0x%08x, "
+		  "Uncorrectable Error Severity=0x%08x, "
+		  "Uncorrectable Error Mask=0x%08x, "
+		  "AER Capability and Control=0x%08x, "
+		  "First Error Pointer=0x%x, "
+		  "Completion Timeout Prefix/Header Log Capable=%s, "
+		  "Link Status=0x%04x, "
+		  "Device Status=0x%04x, "
+		  "Device Control 2=0x%04x, "
+		  "Completion Timeout Value=0x%x, "
+		  "Completion Timeout Disable=%sn",
 		__get_str(dev_name),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
@@ -335,7 +361,21 @@ TRACE_EVENT(aer_event,
 		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
 		__entry->tlp_header_valid ?
 			__print_array(__entry->tlp_header, 4, 4) :
-			"Not available")
+			"Not available",
+		__entry->aer_caps.cor_status,
+		__entry->aer_caps.cor_mask,
+		__entry->aer_caps.uncor_status,
+		__entry->aer_caps.uncor_severity,
+		__entry->aer_caps.uncor_mask,
+		__entry->aer_caps.cap_control,
+		PCI_ERR_CAP_FEP(__entry->aer_caps.cap_control),
+		__entry->aer_caps.cap_control & PCI_ERR_CAP_CTO_LOGC ? "True" : "False",
+		__entry->link_status,
+		__entry->device_status,
+		__entry->device_control_2,
+		__entry->device_control_2 & PCI_EXP_DEVCTL2_COMP_TIMEOUT,
+		__entry->device_control_2 & PCI_EXP_DEVCTL2_COMP_TMOUT_DIS ?
+					    "True" : "False")
 );
 
 /*
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..54160ed2a8c9 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -787,6 +787,7 @@
 #define  PCI_ERR_CAP_ECRC_GENE	0x00000040	/* ECRC Generation Enable */
 #define  PCI_ERR_CAP_ECRC_CHKC	0x00000080	/* ECRC Check Capable */
 #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
+#define  PCI_ERR_CAP_CTO_LOGC	0x00001000	/* Completion Timeout Prefix/Header Log Capable */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
 #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
-- 
2.42.0


