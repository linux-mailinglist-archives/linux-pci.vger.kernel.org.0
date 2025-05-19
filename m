Return-Path: <linux-pci+bounces-28017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D882ABCA05
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF017A7E3B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C4221D80;
	Mon, 19 May 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDLiRZen"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76F22173A;
	Mon, 19 May 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690614; cv=none; b=g1OPu/3SFWrFxTQD5VS+th2CTwXeiItudVYnr5DMW4sXSG67uAN/wVYOavs8MLzir0xJ3kABAPjqWTrlttRpeX5TOyvn0t47JyOnLah/eGeyAjj5CDSQC1P6dKZ/eGvwR0As+9OH1jnNGmRKBpxz5ap67g0tj9cn2t8xnzVEOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690614; c=relaxed/simple;
	bh=+bqxRBjhgwSoTFiDYStp5ueMmN82QsImzLSTRRiEMWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw6mg0LuXu9Fp3CAhARuU6N5E7+W1WuIpyCbv7FHfoA730RtGrnFtOiLaODeOecr1O4hYx0F9eTYJfkSWA+lqjIntrhkrr3imJ919aiT5J4OIgNC/L9HmkhrUNakP1WuB0FSVqkf64TiuSH21ow8SJ0h5IZ5+j9ErABse1mpTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDLiRZen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9287BC4CEEB;
	Mon, 19 May 2025 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690613;
	bh=+bqxRBjhgwSoTFiDYStp5ueMmN82QsImzLSTRRiEMWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDLiRZenfvqKwifJYzTamJzuhJ1agNDwCXkYwMZEMv2Srorta8c1cGqCf0yxstMFW
	 X/TWtWIbwXunZP7Pj3foV7nPc5bOv90eWWp4RczOrIFyjVpd99A3aHh7LN5rxF4Oo+
	 eD+/GRgmt81Pw4Bs2c26xYu7/4lSa3a9ZWwsux/sUfl8rQYmAqdLmG/DUm9gydcDSG
	 I3qBsBg5xSIfPQhAOimqMY4/Dg+Wmmxlg62iPYSY3R4C3nCSQSgvvcYZD7lLQV4WV2
	 VMVZ7m3TdA98NXehGK1m6mke9uxfmGe9mrcSOd22y4Ytwy1s8+F8z9Z5NM2n604iq5
	 y59RovsT1PPGg==
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
Subject: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
Date: Mon, 19 May 2025 16:35:44 -0500
Message-ID: <20250519213603.1257897-3-helgaas@kernel.org>
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

DPC Error Source ID is only valid when the DPC Trigger Reason indicates
that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
Message (PCIe r6.0, sec 7.9.14.5).

When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
log the Error Source ID (decoded into domain/bus/device/function).  Don't
print the source otherwise, since it's not valid.

For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
logging changes:

  - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
  - pci 0000:00:01.0: DPC: ERR_FATAL detected
  + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0

and when DPC triggered for other reasons, where DPC Error Source ID is
undefined, e.g., unmasked uncorrectable error:

  - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
  - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
  + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected

Previously the "containment event" message was at KERN_INFO and the
"%s detected" message was at KERN_WARNING.  Now the single message is at
KERN_WARNING.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fe7719238456..315bf2bfd570 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -261,25 +261,36 @@ void dpc_process_error(struct pci_dev *pdev)
 	struct aer_err_info info = { 0 };
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-
-	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
 
 	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
-	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
-	pci_warn(pdev, "%s detected\n",
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
-		 "unmasked uncorrectable error" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
-		 "ERR_NONFATAL" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
-		 "ERR_FATAL" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
-		 "RP PIO error" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
-		 "software trigger" :
-		 "reserved error");
+
+	switch (reason) {
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR:
+		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
+			 status);
+		break;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
+				     &source);
+		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
+			 status,
+			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
+				"ERR_FATAL" : "ERR_NONFATAL",
+			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
+			 PCI_SLOT(source), PCI_FUNC(source));
+		return;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
+		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
+		pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
+			 status,
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
+			 "RP PIO error" :
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
+			 "software trigger" :
+			 "reserved error");
+		break;
+	}
 
 	/* show RP PIO error detail information */
 	if (pdev->dpc_rp_extensions &&
-- 
2.43.0


