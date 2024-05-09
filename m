Return-Path: <linux-pci+bounces-7285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041A8C0CDF
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0301282635
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CE14A4DF;
	Thu,  9 May 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3x05SIU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6411149E1A;
	Thu,  9 May 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244709; cv=none; b=u0xlrlaskNKCVHCYGXuw3Ipsbf1SDn810f2cVMAEvoWw33Tp8qRtU/sA6tu8gql/aUm3jqEpe5rECGXCdgBlh9rOYksYvcuVr3chBy0m3yDic5oKbfTQrIblZzCJVSSuSE4a9kJzX90M4z/dKA5y4Pj4IonaZpJpNVFBIvONS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244709; c=relaxed/simple;
	bh=Az9fax1STcMENsVQEQmFXQ/rTEnN4aysqC/HQhN2KX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYkAGnlsR73Ena4YXiG3tpaSpkwHEkTflaIaQFZPhX0VWUSWk7CdlJFglj6I77rQlGxg3nq3u2rIXUvJ87ZfqC524ZPXitVlF5l/wf0EC6iQh0oe20+Ffrr262LgL5USMefkYxrp9lZX80Isx7z7kkT5nL8kP5EJ4HntU3PnpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3x05SIU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715244707; x=1746780707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Az9fax1STcMENsVQEQmFXQ/rTEnN4aysqC/HQhN2KX8=;
  b=d3x05SIU2hvo1DIQFYIxG24xxi+LlW3kbn3q8mc3i2snUrQmHt+mWFVG
   XIvo/0j2yPOGTj3onN2YPhyMlqqsISgb3VMRLUlPNhHlkC67C9qe4oKGJ
   qN73beUBp3CwkU0ojFOarwptCqAmx6SfE2knKDk+DCuDRvFMCG8zV26A/
   n2wtonqhbvG3i0UYxZrlzFrhOkVFXeGk2Em6dIW3DfUixbYd7E9g1FjwT
   P/UbSAzKOQVINUJF1ujJbfzOaP+nZwtNgcZ7BRGI8cWhH6Av91qu4Wqm6
   pUR1m4zyDp+2IIUU+QOMYRGaEGGvXAwckvyMZG0tG1+VQschzBbOB/s/L
   w==;
X-CSE-ConnectionGUID: /o/pwH88RqK6QnNAKJF6Qw==
X-CSE-MsgGUID: 2sdG1kPUSVqlf6BugKrZKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14104021"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="14104021"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:47 -0700
X-CSE-ConnectionGUID: WNz+ekTQRHqKX3HNhu576w==
X-CSE-MsgGUID: T4JtGmhySwqhx4RJWSIPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29061096"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	bhelgaas@google.com,
	helgaas@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	adam.c.preble@intel.com,
	lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com,
	dan.j.williams@intel.com,
	feiting.wanyan@intel.com,
	yudong.wang@intel.com,
	chao.p.peng@intel.com,
	qingshun.wang@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 3/3] PCI/AER: Clear UNCOR_STATUS bits that might be ANFE
Date: Thu,  9 May 2024 16:48:33 +0800
Message-Id: <20240509084833.2147767-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing an ANFE, ideally both correctable error(CE) status and
uncorrectable error(UE) status should be cleared. However, there is no
way to fully identify the UE associated with ANFE. Even worse, Non-Fatal
Error(NFE) may set the same UE status bit as ANFE. Treating an ANFE as
NFE will bring some issues, i.e., breaking softwore probing; treating
NFE as ANFE will make us ignoring some UEs which need active recover
operation. To avoid clearing UEs that are not ANFE by accident, the
most conservative route is taken here: If any of the NFE Detected bits
is set in Device Status, do not touch UE status, they should be cleared
later by the UE handler. Otherwise, a specific set of UEs that may be
raised as ANFE according to the PCIe specification will be cleared if
their corresponding severity is Non-Fatal.

For instance, previously when kernel receives an ANFE with Poisoned TLP
in OS native AER mode, only status of CE will be reported and cleared:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr

If the kernel receives a Malformed TLP after that, two UEs will be
reported, which is unexpected. Malformed TLP Header is lost since
the previous ANFE gated the TLP header logs:

  PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00041000/00180020
     [12] TLP                    (First)
     [18] MalfTLP

Now, for the same scenario, both CE status and related UE status will be
reported and cleared after ANFE:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [18] TLP

Tested-by: Yudong Wang <yudong.wang@intel.com>
Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/pci/pcie/aer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ed435f09ac27..6a6a3a40569a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1115,9 +1115,14 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
+		if (aer) {
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
+			if (info->anfe_status)
+				pci_write_config_dword(dev,
+						       aer + PCI_ERR_UNCOR_STATUS,
+						       info->anfe_status);
+		}
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
-- 
2.34.1


