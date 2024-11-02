Return-Path: <linux-pci+bounces-15845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB39BA0C0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC147B21742
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14119CC27;
	Sat,  2 Nov 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="n7US4EuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC919E97B
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557606; cv=none; b=fxOnLYqiBBmyq11k9z+1rzO1qlbyIFK+JECzPrKOAi7KsJBHD1TCYMBdZ3+XlEacqbVsH77LhkJiHeF4dioHf22CStq+HLYy4mdUGTveysst4xSGjHnGwEHZKOz3EwhvJHyHBf0L0VGiU7PIU+U2sGZ/QW4m02/NVDumqeN7Xr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557606; c=relaxed/simple;
	bh=YH4WCUvDQhlA5V+tnKNDDpoeRGfjbdZu7ibbvodAJKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Brcx2cC/aqgwHiC0oE+U6USxscV7pRPG2s+Na4p6DJm2hgiEGLppq+0DJz/5vTI68XxfoBn4UNpmj2fPzkW/mwcCA86NJ96n/+dP9xRilzb+7Jf73i5O/UB8dluv6/Pk/fNMgsOAuXYbsmdfUQa0wgYI7fdJAY17/5qrd1kWCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=n7US4EuC; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730557605;
	bh=hJBRC+np90ciARpNEUyZqydq1Md0VJimI1Ghc+A/vug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=n7US4EuCibIETCrnEc5GpPySEKOmcZ3YSSZ74ljZtioCEoWnpRrJCHVJjDK1UCd9w
	 DQpjjAF7R4fQGSOrWeeEW7qIRSqL0R22HYHvcKcUFYjidAZUdRIafUbFcg5GQH+lx5
	 Y87XXKuBGTCFi64mNyVCzFCZtcSL9t9syF7/0KLgVb7+tPwOi8VSTfnRDAsCMEnBBs
	 XZK43wQQrra6zNTCWqaWqDuu9fqCKzDfc/DqiUWxHhNROj41V9hs0JCB5pcD4QBM87
	 Mv/yKEjr3cD23AQ8wBqI9o0ZHl+A9LUATxVO5AECZUB+wFjoUz5PtO05PjbqEDi5v4
	 8eh8S8dAxCwuQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 25AC6C80136;
	Sat,  2 Nov 2024 14:26:38 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 22:26:14 +0800
Subject: [PATCH RFC 1/2] PCI: endpoint: Fix API pci_epc_destroy() releasing
 domain_nr ID faults
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-epc_rfc-v1-1-5026322df5bc@quicinc.com>
References: <20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com>
In-Reply-To: <20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: raVYR2rXgJaA_OrzGV8qOKSp4QcGVPJk
X-Proofpoint-ORIG-GUID: raVYR2rXgJaA_OrzGV8qOKSp4QcGVPJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_12,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxscore=0 mlxlogscore=872 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020128
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

pci_epc_destroy() invokes pci_bus_release_domain_nr() to release domain_nr
ID, but the invocation has below 2 faults:

- The later accesses device @epc->dev which has been kfree()ed by previous
  device_unregister(), namely, it is a UAF issue.

- The later frees the domain_nr ID into @epc->dev, but the ID is actually
  allocated from @epc->dev.parent, so it will destroy domain_nr IDA.

Fix by freeing the ID to @epc->dev.parent before unregistering @epc->dev.

Fixes: 0328947c5032 ("PCI: endpoint: Assign PCI domain number for endpoint controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f007109255..bcc9bc3d6df5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -837,11 +837,10 @@ EXPORT_SYMBOL_GPL(pci_epc_bus_master_enable_notify);
 void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
-	device_unregister(&epc->dev);
-
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(&epc->dev, epc->domain_nr);
+	pci_bus_release_domain_nr(epc->dev.parent, epc->domain_nr);
 #endif
+	device_unregister(&epc->dev);
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 

-- 
2.34.1


