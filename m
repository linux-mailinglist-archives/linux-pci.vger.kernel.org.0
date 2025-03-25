Return-Path: <linux-pci+bounces-24677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0EA7049B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0568D3ABF11
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130925A34E;
	Tue, 25 Mar 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWWdRn2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3327706;
	Tue, 25 Mar 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915331; cv=none; b=bJKDrVRc80k1xKXM59Rp/IgJEYhiwGEt7G7PahMIWkFq0Ogh6fvN5MnKS8SN6YmdjdkS+ln3B8yTVy8MxiYtoFirHszNjiWhD3HHQVlkvnfpzIQ5BVVtlXOqJ9QCv3bXweiTrEhi68gM9L42WUo685Ctu/6du+c7ex10ywMZx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915331; c=relaxed/simple;
	bh=D+gJE+BgoJHFY+2QR+wwmhv93dFRwJgFNuy/vrLwQmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IK7tR+2vDVvnOFJWbxIjdViU1WJKdxDPGB0zhAehvZGCzYSAYCANhhGTf8bx1mUyDXMG+8CqIgh5mMj71gCvAn1jfD0kVML8Mr0mSCDo2o1KXlerZbgghpJkloo0GF70lDbeZVErjQrFUO8kMUerFQBlqcSxbet6sRLfLh9YROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UWWdRn2u; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBftiQ028252;
	Tue, 25 Mar 2025 15:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=49WQ0+VXvpw4t+yWVOTCQc5o2SAhj
	y8/rSQGINzSnNY=; b=UWWdRn2ub03OvX5H3iHewoVtc5od3yhgwLDTe80FEwj36
	1s7Tj5DkK4eOLM/BlloTOorrR8lzKBO7Babdu+iw98/6XCGXtCI6c2yzBSmvZqQd
	bxmo4GsQszlgPQPItPEFRrcRt7BU5VZlxuI0SNtxbyCw23pVLrPEYOa8EQv9QtMQ
	8NmjJXXDb46mBxZ4LqRn5L6j3mZzGmNz5fu414HA3R2zCYpJHQu9QasKYER2KSVB
	kKiGerzM+NmBuWwyhpi+aIT9DC37VrXfCMbzA/LFD7yG5H5ZHeNbU3h5n0c3tWei
	+OcBSDXo69z/DWyQp759GH5m6uGxFqg2aIMJIThiA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd67ae5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 15:08:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PEimXC015178;
	Tue, 25 Mar 2025 15:08:01 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45jj921a63-1;
	Tue, 25 Mar 2025 15:08:01 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jon Pan-Doh <pandoh@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER reporting paths
Date: Tue, 25 Mar 2025 15:07:47 +0000
Message-ID: <81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250106
X-Proofpoint-ORIG-GUID: Vtkg1UMxfgyZJT3N2TsIkXeD8M33rmCb
X-Proofpoint-GUID: Vtkg1UMxfgyZJT3N2TsIkXeD8M33rmCb

Currently, CXL and GHES feature use pci_print_aer() function to
log AER errors. Its implementation is pretty similar to aer_print_error(),
duplicating the way how native PCIe devices report errors. We shouldn't
log messages differently only because they are coming from a different
code path.

Make CXL devices and GHES to call aer_print_error() when reporting
AER errors. Add a wrapper, aer_print_platform_error(), that translates
aer_capabilities_regs to aer_err_info so we can use pci_print_aer()
function.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
v2:
  - Don't expose aer_err_info to the world; as aer_recover_queue()
    is tightly connected to the ghes code, introduce a wrapper for
    aer_print_error()
  - Move aer_err_info memset to the wrapper, don't expect the
    caller to clean it for us

  I'm still working on the logs; in the meantime, I think, we can
  continue reviewing the patch.

 drivers/cxl/core/pci.c |  2 +-
 drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++----------------------
 include/linux/aer.h    |  4 +--
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 013b869b66cb..9ba711365388 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -885,7 +885,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
 		return;
 
-	pci_print_aer(pdev, severity, &aer_regs);
+	aer_print_platform_error(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
 		cxl_handle_rdport_cor_ras(cxlds, dport);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..ec34bc9b2332 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -760,47 +760,42 @@ int cper_severity_to_aer(int cper_severity)
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+static void populate_aer_err_info(struct aer_err_info *info, int severity,
+				  struct aer_capability_regs *aer_regs)
 {
-	int layer, agent, tlp_header_valid = 0;
-	u32 status, mask;
-	struct aer_err_info info;
-
-	if (aer_severity == AER_CORRECTABLE) {
-		status = aer->cor_status;
-		mask = aer->cor_mask;
-	} else {
-		status = aer->uncor_status;
-		mask = aer->uncor_mask;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
-	}
-
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
+	int tlp_header_valid;
 
 	memset(&info, 0, sizeof(info));
-	info.severity = aer_severity;
-	info.status = status;
-	info.mask = mask;
-	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	info->severity = severity;
+	info->first_error = PCI_ERR_CAP_FEP(aer_regs->cap_control);
 
-	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+	if (severity == AER_CORRECTABLE) {
+		info->id = aer_regs->cor_err_source;
+		info->status = aer_regs->cor_status;
+		info->mask = aer_regs->cor_mask;
+	} else {
+		info->id = aer_regs->uncor_err_source;
+		info->status = aer_regs->uncor_status;
+		info->mask = aer_regs->uncor_mask;
+		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
+
+		if (tlp_header_valid) {
+			info->tlp_header_valid = tlp_header_valid;
+			info->tlp = aer_regs->header_log;
+		}
+	}
+}
 
-	if (tlp_header_valid)
-		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
+void aer_print_platform_error(struct pci_dev *pdev, int severity,
+			      struct aer_capability_regs *aer_regs)
+{
+	struct aer_err_info info;
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
+	populate_aer_err_info(&info, severity, aer_regs);
+	aer_print_error(pdev, &info);
 }
-EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
+EXPORT_SYMBOL_NS_GPL(aer_print_platform_error, "CXL");
 
 /**
  * add_error_device - list device to be handled
@@ -1146,7 +1141,8 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+
+		aer_print_platform_error(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..5593352dfb51 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -64,8 +64,8 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer);
+void aer_print_platform_error(struct pci_dev *pdev, int severity,
+			      struct aer_capability_regs *aer_regs);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
-- 
2.43.5


