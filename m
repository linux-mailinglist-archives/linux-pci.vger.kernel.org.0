Return-Path: <linux-pci+bounces-21083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86727A2ECBC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357DF163836
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBC222588;
	Mon, 10 Feb 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N52TpGkr"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B2153BC1
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191223; cv=none; b=uhiLFl4tj8CL3w2gMPzEUVWQf4hUoGTorfDyuABlY4+CfrPHx5DfaxIHTvNmb2b0kHwluDgc8y0BOKYRuyifl0Qb3uoEYiyob0zXqwW171pijy84Xs+XNNR60UNTsIl0RGvrLFxo7xMX5jqr52kqD862GnT51GEtwC97lp2lvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191223; c=relaxed/simple;
	bh=Yaj8fqOglkS3iOOnKEAW1Jb4zD/d4qG3IVFyO3VCHb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eO/SR74uPHe5nPXA+hvcRnLc3dxKvTXJ21PexSuhcdhGIRmySO4cXZeb6USAdzeArteW/F3Xs72IyYN2JozJFvTbmQ+EFuLIvWEEAVQtpHVAV5ACYIAK/hsjjGFTdRb+T2iKFW+Dct0XbtRmUFKDVc5QeO8hiDyQ5U5eOfsU7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N52TpGkr; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=l9pahT3RXJ+ISB76Fj4wpfGgtAA5bRerlsHnpTButD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=N52TpGkryogkIDj/CIPXYMnX9SvA/Qj9H0r91yVnRtHrcW4IaUnYl8VaAlB8i0N8G
	 jJj6aU7svOG7EZJkjEZvvDAH7cRgfuO1HjNgagZrV5A0GfyzHMdM0ECTRE8KefnNOp
	 Jfb4Q1xwWXdxvhccjKE8QBkWJ6nxomeeYhd1PRa6IfGkoMp2IlXtPuRsAY+8SQ5YJ+
	 D48kChRUrAIufxUAjPVwM9qDcOnyTwwWuK70cjSXHTs9XDhrVQ6J6ucNEIwheXbnAK
	 WbIYemyrxfhgFenx/heIBsIe0KCIR/wXXQHXkDA3y+uXItAAbrs8VyoPYkQqu33N0b
	 ZlcEKbNAD2XCQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id D8DD7740190;
	Mon, 10 Feb 2025 12:40:14 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 10 Feb 2025 20:39:53 +0800
Subject: [PATCH] PCI: endpoint: Remove API devm_pci_epc_destroy()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-remove_api-v1-1-8ae6b36e3a5c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJjzqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3aLU3Pyy1PjEgkxdy+Q0w9RES1NLA8NUJaCGgqLUtMwKsGHRsbW
 1AFC0Q8JcAAAA
X-Change-ID: 20250210-remove_api-9cf1ea95901e
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: jrihuWMNevOcXl3v441CMgRu87qWnNPT
X-Proofpoint-ORIG-GUID: jrihuWMNevOcXl3v441CMgRu87qWnNPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=791
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502100106
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Static devm_pci_epc_match() is only invoked by API devm_usb_put_phy(), and
the API has not had callers since 2017-04-10 when it was introduced.

Remove both the API and the static function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  7 +++----
 drivers/pci/endpoint/pci-epc-core.c         | 25 -------------------------
 include/linux/pci-epc.h                     |  1 -
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 35f82f2d45f5ef155b657e337e1eef51b85e68ac..599763aa01ca9d017b59c2c669be92a850e171c4 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -57,11 +57,10 @@ by the PCI controller driver.
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
 
-* devm_pci_epc_destroy()/pci_epc_destroy()
+* pci_epc_destroy()
 
-   The PCI controller driver can destroy the EPC device created by either
-   devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
-   pci_epc_destroy().
+   The PCI controller driver can destroy the EPC device created by
+   pci_epc_create() using pci_epc_destroy().
 
 * pci_epc_linkup()
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 9e9ca5f8e8f860a57d49ce62597b0f71ef6009ba..cf2e19b80551a2e02136a4411fc61b13e1556d7a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -25,13 +25,6 @@ static void devm_pci_epc_release(struct device *dev, void *res)
 	pci_epc_destroy(epc);
 }
 
-static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
-{
-	struct pci_epc **epc = res;
-
-	return *epc == match_data;
-}
-
 /**
  * pci_epc_put() - release the PCI endpoint controller
  * @epc: epc returned by pci_epc_get()
@@ -931,24 +924,6 @@ void pci_epc_destroy(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 
-/**
- * devm_pci_epc_destroy() - destroy the EPC device
- * @dev: device that wants to destroy the EPC
- * @epc: the EPC device that has to be destroyed
- *
- * Invoke to destroy the devres associated with this
- * pci_epc and destroy the EPC device.
- */
-void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
-{
-	int r;
-
-	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
-			   epc);
-	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
-}
-EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
-
 static void pci_epc_release(struct device *dev)
 {
 	kfree(to_pci_epc(dev));
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index e818e3fdcded95ca053db074eb75484a2876ea6b..82a26945d038d3e45e2bbbfe3c60b7ef647f247a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -257,7 +257,6 @@ __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 struct pci_epc *
 __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		 struct module *owner);
-void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
 void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250210-remove_api-9cf1ea95901e

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


