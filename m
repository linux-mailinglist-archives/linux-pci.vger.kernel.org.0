Return-Path: <linux-pci+bounces-20034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C58AA14BDA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 10:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D921887C4F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFC1F7918;
	Fri, 17 Jan 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zTStbaWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CB35960;
	Fri, 17 Jan 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105095; cv=none; b=b8F5XMw51Jz0d0wia+aQIg76NNRdCkSV1Vr/sG9YID4sBafXNkbCEpwW6auq/xrTyO52EOSdox9b6c2IA+q18yrxUrukB59J9Rkrp3/BncPNyQjfI+KF1HTsA63nKkVD9MKVenAWpoQrSuVHxzKRhs+kqymHJN34iTllgEoAXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105095; c=relaxed/simple;
	bh=kgL3fTL5EN0FWmEPQhlZsAZQUi9WJf80xzmIDYnjNhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RVdpDF4xW/nj81KZSm/TBJ16JAT0eDzYw/x2dnQ8XHPAaY2vaWJPP1yV6RBQ2UEFMJGDNkPO3A9uDyGVpPiHmMGBKByPumyCDYz/iApMR9HreRbdAK6JLNLEEDJ9mLa25MsH3jQ6hnX7m+Qrf2GIIWvOt0W9eaOJIuXqvjia+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zTStbaWd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7318g003891;
	Fri, 17 Jan 2025 10:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=DIOjUT0QD2aDf1f9Bx0P56
	QpbttpXVW567xaLcOd9ds=; b=zTStbaWd/prdaDSA2ezJ/4DtYhdg9u0bREeCAd
	JccllCGoV70G2UsR0cmxsrwFmi5rIpssgf8TM4vlI77gtFBN10rg1xJDCECawP3y
	hUMo0U/jnY94M2cIgputKtpWTck+DFEFqnNBPTcN35ehb4VUynBKwyjRVsCG41Qt
	/QlcA94J2NQBfmiNAohg+PDkpgSaMEGy8qDccXzN7CY/9xBiq46CCobO0mKd+Trq
	D3US7rUGttJwzncLP9jqhQ332S1jOyH/fz7Z74s4A/NblCJxz2fzOuQ8B+DEeLxD
	m1yrwdNy9Wtoc7ED7UaLs4Qi6/djjg8DNPB+oKeSxyqEKNRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4477k52c29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 10:11:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1EF1B4002D;
	Fri, 17 Jan 2025 10:10:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF9E726818A;
	Fri, 17 Jan 2025 10:09:21 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 10:09:21 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <manivannan.sadhasivam@linaro.org>, <kw@linux.com>, <kishon@kernel.org>,
        <bhelgaas@google.com>, <cassel@kernel.org>, <Frank.Li@nxp.com>,
        <dlemoal@kernel.org>, <fabrice.gasnier@foss.st.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian
 Bruel <christian.bruel@foss.st.com>
Subject: [PATCH] PCI: endpoint: pci-epf-test: Fix double free Oops
Date: Fri, 17 Jan 2025 10:09:03 +0100
Message-ID: <20250117090903.3329039-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01

Fixes an oops found while testing the stm32_pcie ep driver with handling
of PERST# deassertion:

[   92.154549] ------------[ cut here ]------------
[   92.159093] Trying to vunmap() nonexistent vm area (0000000031e0f06f)
...
[   92.288763]  vunmap+0x58/0x60 (P)
[   92.292096]  dma_direct_free+0x88/0x18c
[   92.295932]  dma_free_attrs+0x84/0xf8
[   92.299664]  pci_epf_free_space+0x48/0x78
[   92.303698]  pci_epf_test_epc_init+0x184/0x3c0 [pci_epf_test]
[   92.309446]  pci_epc_init_notify+0x70/0xb4
[   92.313578]  stm32_pcie_ep_perst_irq_thread+0xf8/0x24c
...

During EP initialization, pci_epf_test_alloc_space allocates all BARs,
which are further freed if epc_set_bar fails (for instance, due to
no free inbound window).

However, when pci_epc_set_bar fails, the error path:
     pci_epc_set_bar -> pci_epf_free_space
does not reset epf_test->reg[bar].

Then, if the host reboots, PERST# deassertion restarts the BAR allocation
sequence with the same allocation failure (no free inbound window).

So, two subsequent calls to the sequence:

  if (!epf_test->reg[bar])
      continue;

  ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
  if (ret) {
      pci_epf_free_space(epf, epf_test->reg[bar], bar, PRIMARY_INTERFACE);
  }

create a double free situation since epf_test->reg[bar] was deallocated
and is still non-NULL.

This patch makes pci_epf_alloc_space/pci_epf_free_space symmetric
by resetting epf_test->reg[bar] when memory is deallocated.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ffb534a8e50a..b29e938ee16a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -718,6 +718,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
+			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
@@ -909,6 +910,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
 				   PRIMARY_INTERFACE);
+		epf_test->reg[bar] = NULL;
 	}
 }
 
-- 
2.34.1


