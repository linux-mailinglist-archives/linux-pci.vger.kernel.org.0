Return-Path: <linux-pci+bounces-18029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D59EB27A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAE816A51E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196A1A9B3B;
	Tue, 10 Dec 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aLFk5nra"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD019DF9A
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839279; cv=none; b=XqyYx/E+BmCFtPd+pwIZWbhYEN9icIdD5uwfRcbbEADA5xn/4OSOdDfJtWNjCMrLgvHR5ON4rrDmxCdXcBquhHj0L6pWoui9hVueH9sWrrWirws7JJCvtKRVlVFGFbnzidOvnSc7RVLdqBgecVuKZWSPxtfO2/dFAbTTeSXC6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839279; c=relaxed/simple;
	bh=tK7rZbLoQvNiDdgkAsAwSYlJ2Gfx7u83qMTM3MkGxk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LP+IVp6JG0kDcRVS1NE8VvYTOQm/JSeBm038JtAIZogMYxwXmGPTAKbuAIV4/brtRgrZH8j/Ikl/il690hKTDapm7r6mrzDILrp93OICid1z4eQhF8CtKH2JHhRH2PDygXYY7jy11BbO7j1saW6ll370WWgC+UvcRsTWDKE2Jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aLFk5nra; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733839277;
	bh=rGFnfqeRPLXBCcmO1a9Wq+Zj8abJbRph+itROXdepDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=aLFk5nrabL+rP16WNke0pAboL8AxP2fDbsMMcFABfcukKQU//62d6MwmXjvt8kd2N
	 EOMw0aH91Z3x2BNRK2sbKbB+jRno2+k0hHl61A72HAjjc0f0THDvjxxiDzK82M36Ye
	 xQVExXFsoFVfTVc7dliod9kJ9j43dm+tEBnhbN9DZpGNTrC9bzqavj6KdN9liDPS9J
	 6AN9W0/ykT8UhjGTxfkk7paqbDdEGQhnQKILiJI34Nb9wCqjlH0subPamwaxgcYby1
	 uj1wn+RsPuEGd6PSuwNF6NJJg88p7OZMtgaD5TEhvZBIEW9S7OHC1/Ov1kGmXz8//i
	 ZnWTij6Fy5aLw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id AB99A800405;
	Tue, 10 Dec 2024 14:01:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 10 Dec 2024 22:00:18 +0800
Subject: [PATCH v3 1/3] PCI: endpoint: Fix that API devm_pci_epc_destroy()
 fails to destroy the EPC device
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-epc-core_fix-v3-1-4d86dd573e4b@quicinc.com>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
In-Reply-To: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Wei Yongjun <weiyongjun1@huawei.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: i-jtWEAaGeDiX9uwlHZyAwk6BH8kDaNJ
X-Proofpoint-ORIG-GUID: i-jtWEAaGeDiX9uwlHZyAwk6BH8kDaNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=664 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_pci_epc_destroy(), its comment says it needs to destroy the EPC
device, but it will not actually do that since devres_destroy() does not
call devm_pci_epc_release(), and it also can not fully undo what the API
devm_pci_epc_create() does, so it is faulty.

Fortunately, the faulty API has not been used by current kernel tree.
Fixed by using devres_release() instead of devres_destroy() within the API.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f00710925508e60fbd21116af5b424abdcd3e7..71b6d100056e54438d0554f7ee82aaa64e0debb5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -857,7 +857,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }

-- 
2.34.1


