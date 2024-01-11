Return-Path: <linux-pci+bounces-2033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6382A865
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B252E1F24E27
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68787D271;
	Thu, 11 Jan 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6HeL22L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F5D2F3
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958407; x=1736494407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqK6Cw62H3exvcqS+8v+d8bFV2q3iUZMa7UqCuF15OM=;
  b=b6HeL22L2Dud4Fk6fz82sgHU5r6CsDXvBf0B+JH2zyKYK0rIEFFQ/UeM
   gm4eLDTDxPzw2r1cSNB5BSv/4i81eMU1PcLu3ROUy/6Mas/DjCeKPbd+L
   DqSGqg2N7dST4OYso4m5BJLGXtWJHZ2MdEgLvcv2WrWTy/kfoadKnirFr
   Pi8wliucJkdoOEvoq8Iqcc3Fk1Zf1IwG/C+pGaRKgUwxtpGhwziVd4eFI
   jEytleeydP8kzCjjp9HmtmwxQYRQd33zKd+dt+8DMDmsd7exjXCGPNQkN
   h31D+H2VR4zhHQYd144F3zeUj3hqvcqGBQPTTYPrNQrseaUm1+nw/cY2g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6126061"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6126061"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905856031"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905856031"
Received: from shijiel-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.211.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:23 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH 4/4] ras: Trace more information in aer_event
Date: Thu, 11 Jan 2024 15:32:19 +0800
Message-ID: <20240111073227.31488-5-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
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
- uncor_status		(Uncorrectable Error Status)
- uncor_severity	(Uncorrectable Error Severity)
- uncor_mask		(Uncorrectable Error Mask)
- aer_cap_ctrl		(AER Capabilities and Control)
- link_status		(Link Status)
- device_status		(Device Status)
- device_control_2	(Device Control 2)

In addition to the raw register value, value of following fields are
extracted and logged for better observability:

- "First Error Pointer" and "Completion Timeout Prefix/Header Log Capable"
  from "AER Capabilities and Control"
- "Completion Timeout Value" and "Completion Timeout Disable"
  from "Device Control 2"

Reviewed-by: "Tsaur, Erwin" <erwin.tsaur@intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/pci/pcie/aer.c        | 17 +++++++++++--
 include/ras/ras_event.h       | 48 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b5d4ea8e5f8d..52ca9bf26e84 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -754,6 +754,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
+	struct aer_capability_regs aer_caps;
 
 	if (info->severity == AER_CORRECTABLE) {
 		status = info->cor_status;
@@ -790,8 +791,18 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
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
@@ -867,7 +878,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		__print_tlp_header(dev, &aer->header_log);
 
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
+			aer_severity, tlp_header_valid, &aer->header_log,
+			aer, info.link_status,
+			info.device_status, info.device_control_2);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..9bece6edec28 100644
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
+		  "Completion Timeout Disable=%s\n",
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


