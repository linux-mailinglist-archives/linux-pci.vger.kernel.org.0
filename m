Return-Path: <linux-pci+bounces-18030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669C9EB27C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D1A28420F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E21AAE1A;
	Tue, 10 Dec 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zY5+BEnc"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C961AAA39
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839286; cv=none; b=Nl2ToF+07OgFQKpIWWbMyQlCtL92ywgSiOMXonbaw1pjizpuIxbVNyO6/ym//qBomgTZyE3tYCFDYYP9WkHqSOJ5H3Dei2+Vv9XCRJ7hhAXru4XY3sIp1OYh2JH9+t76eaed2PzAslS6FhlaaKogDb6iez/TQXQJSEu0Tl6GJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839286; c=relaxed/simple;
	bh=aWKzwVPvKOYneYMrossW9cUyH+eV/Nmu2u8dB+8D8C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peIcEI0G3QVwqFUEL9K3tte3Sa4Nq9lywUjkcVWh4gtu/oaouvZWro3A7ye2TlCfxXsNFlZBw+1FoP7aTRmrMCH+iSTdKr+c3gfykO3Y2wYgqPXvZY1Tl/yEl/sdLWmo7aXMpsI0Pio9BAe/J+9cCk1dP0H0Cush8wY6iUdkyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zY5+BEnc; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733839284;
	bh=2XgjciLmb9VvLIB6D35kVbv07FFJrHP7xi93H6P3zng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=zY5+BEncTiXe8mUyhf6kgUMP8Ffyrtsc8p3az5ceBDeMYlsBSr22uBBcMUYFD7Lao
	 FqgxsaLbWcjH5PorAxQ1ym6IbTut35KNN5gWzvsY67JFKQWvN2B2ILR63sfCP/nt5h
	 D+YudlZxZQLrUwdQQ4UE0VKGaQSoyqq33fdkAzCTh8bzVxpyVAotMTp280hXKC377L
	 S4XndZkfZnAZQiNwrvzc9GkawPvjkb6pnT6OHUA9ql+TpOvIcQ7uA6siO4ZvKX303n
	 5Ibm1j2j9X/O1bnnfSr9G4FRQYwcP9wrsNtp1RRaYBk/vhoyvCHn0JQ88v4cNg9HjU
	 SDX2KXrpIMBsQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 7886A800417;
	Tue, 10 Dec 2024 14:01:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 10 Dec 2024 22:00:19 +0800
Subject: [PATCH v3 2/3] PCI: endpoint: Simplify API pci_epc_get()
 implementation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-epc-core_fix-v3-2-4d86dd573e4b@quicinc.com>
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
X-Proofpoint-GUID: w2B-dCiFi428P6b6Rq8BXWtkFRTfIE8j
X-Proofpoint-ORIG-GUID: w2B-dCiFi428P6b6Rq8BXWtkFRTfIE8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify pci_epc_get() implementation by API class_find_device_by_name().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 71b6d100056e54438d0554f7ee82aaa64e0debb5..eb02d477bc7ca43a91b8a4a13c6ce96dab0b02fd 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -60,26 +60,17 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	int ret = -EINVAL;
 	struct pci_epc *epc;
 	struct device *dev;
-	struct class_dev_iter iter;
 
-	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
-	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
-			continue;
+	dev = class_find_device_by_name(&pci_epc_class, epc_name);
+	if (!dev)
+		goto err;
 
-		epc = to_pci_epc(dev);
-		if (!try_module_get(epc->ops->owner)) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		class_dev_iter_exit(&iter);
-		get_device(&epc->dev);
+	epc = to_pci_epc(dev);
+	if (try_module_get(epc->ops->owner))
 		return epc;
-	}
 
 err:
-	class_dev_iter_exit(&iter);
+	put_device(dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);

-- 
2.34.1


