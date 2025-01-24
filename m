Return-Path: <linux-pci+bounces-20335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4244A1B60D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 13:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB333188FC18
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76221A45F;
	Fri, 24 Jan 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2XJCSebw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649814B956;
	Fri, 24 Jan 2025 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721994; cv=none; b=RGtxzBtPXFQ8ujGMiNsosl+x5IcgmKmYbptmZMGRcLfM9QeNMx4WER1aU4P7Qogb3mBW7O4YW3ClWfAfBNaUGXZf4/dm9KP87xYXTD9MhL6ZeaXoXrJPX2U1v0ZjxjaSDzw2n0/3f6daPAGwadVk18AuwHJbLiIkkoWjki6PeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721994; c=relaxed/simple;
	bh=RytWdY66bLssizcmezRbOoQf/HdbOglI0M4FL+x3zIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQNMeV+okmdRbl43UCY3wne6F/coeMaPqSRa45ZJob9MeLWCH1d5HwM3SMSWEgFkvE85GkBg8RR3i6xXnNs9ZhEauwEn5miwuqy1qygO0xV3nypv1TnxNeiTqzNGosiS35uLfkxIPktsn7HV/h9s/kYtAJARj0r0gnZs27pdYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2XJCSebw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8q9EQ020913;
	Fri, 24 Jan 2025 13:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=lNNkivl7k/CkURxfqCXbd+
	2dZiyh6Py/zV2yV2nO6mE=; b=2XJCSebw3UtWutTCn601q3pARIA7of40XOUGeV
	hLm1bSjn6CD2eziAHXcuj4W1fizEVLG+UGSZwqzvWSUVeoWm33BxXFrNtjU/8QHA
	WraQrO/spMYyYrfhzGOu0Km8kxaqbm7VvN7ANeXzz8cUc45fyX7YEPyDOhHV+lZ0
	XVfYCHnmGDHOf41rwxF1qlId/JRpo4sjdVzNPjL6NVA1/FIZgRvz519/F3n1mGj2
	9Jg3BG/tXAnrEIn/eR5gWkFQekIU+GsQFnVEV2iNrH1g8O/CfhMrez7bup086qap
	g80y7oT94JpUNeXGhwvR1bxwATujfI2jLxTgU/39XKMexFzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44c7qw8x5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 13:32:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CFF604002D;
	Fri, 24 Jan 2025 13:31:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF2B1266401;
	Fri, 24 Jan 2025 13:31:05 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 13:31:05 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <manivannan.sadhasivam@linaro.org>, <kw@linux.com>, <kishon@kernel.org>,
        <bhelgaas@google.com>, <cassel@kernel.org>, <Frank.Li@nxp.com>,
        <dlemoal@kernel.org>, <fabrice.gasnier@foss.st.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian
 Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v2] PCI: endpoint: pci-epf-test: Fix double free Oops
Date: Fri, 24 Jan 2025 13:30:43 +0100
Message-ID: <20250124123043.96112-1-christian.bruel@foss.st.com>
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
 definitions=2025-01-24_05,2025-01-23_01,2024-11-22_01

Fixes an oops found while testing the stm32_pcie ep driver with handling
of PERST# deassertion:

During EP initialization, pci_epf_test_alloc_space allocates all BARs,
which are further freed if epc_set_bar fails (for instance, due to
no free inbound window).

However, when pci_epc_set_bar fails, the error path:
     pci_epc_set_bar -> pci_epf_free_space
does not reset epf_test->reg[bar].

Then, if the host reboots, PERST# deassertion restarts the BAR allocation
sequence with the same allocation failure (no free inbound window),
creating a double free situation since epf_test->reg[bar] was deallocated
and is still non-NULL.

Make sure that pci_epf_alloc_space/pci_epf_free_space are symmetric
by resetting epf_test->reg[bar] when memory is deallocated.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
v2: Cleanup commit message after Niklas comments and add Reviewed-by
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


