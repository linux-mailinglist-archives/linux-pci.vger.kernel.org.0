Return-Path: <linux-pci+bounces-12360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD51962CD9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77671F22F3F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BB1A4F3A;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+gTKry5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61841A38FC;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=uIDLXCzxbNvzQaEkMqFOwAoDbr7CwGJt5LlZpUiV/c7O9cw10SAhagPoW3nKtIgIET+3K3mn7ccv34JxvIgPmyCKGECljTuvSYrq4Vt8EhW0NJhuVnRhPM6n3I1PEp9Y0JbTrd8UfHM+wA1K3gGH46T5EDs4B8KvX+fEpDkWBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=xZou4yYTmrNODLhCzXW2Q/Fu7bpHNuL+kgj7Jhe8ZXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxBIcxaL2itBfBiPFwQ420uockdT3CWYuvVV/srwiNB4OD7OOiEB1qRRqAUMwjl3JVnQDpWoTfWiiqvUm/pnqeb/W7eLRE/QMK//wCs3Psc7aCXXdR1jWW7MKKtRUUTVN2gxzG1oeq3Mr3LBTZ4nMEgZCzWmqwUx44L/d60KxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+gTKry5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1CEC4CEDB;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=xZou4yYTmrNODLhCzXW2Q/Fu7bpHNuL+kgj7Jhe8ZXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V+gTKry5Ve807aOn5WR479TpGgrA1NSOdZgvx4Vi0r90t5+1Umnrsi+oiipHsaZBQ
	 U0FbAHnEBM3KsoQQDApFhBnze8OrzkBNyGoVrU08xgcFqEcLZQe3lApLUw9xqcZowt
	 247Y2azLLa8jLY3v+95JVRsxRAWXCn+Dbd75cw2WRMUOaxBNfSZjpQR109htP371Uj
	 uoeA12h5pILt3UP3xD5cPxqPsTw2tJPnOzws8ag0yossyiGKxFeVhaJ+jCMu6TEc4n
	 JuPWyYewxta6PkC0qMAjWCgQWxFGZVw09f0SxQxGg0W340dq+v1BEHygc5r1KShRZo
	 avRUtCTjB3wVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61936C63685;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:15 +0530
Subject: [PATCH v4 05/12] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-5-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5oeMGhfukDvga7v0phuNZcmCcF8YceRyJh0rWzD+y8Y=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZLMf4c60sIeK74cdHIg0yL5hYSc4llzQR4Y
 atcIdalTDuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GSwAKCRBVnxHm/pHO
 9ZNRB/9Nmlg/e7/yWhzNE70DQZ3sD6X3ZNNWNXP3QiZI3eTyxL3sL52VAr8qBP7dYF6gIMvDt+j
 ZxL/EmnrHNI2IU7/TM4AiL0lwBdf8v8/e1+wX5+eFgdNOy1MuIreVI96czTDDgKC/1XcilPzs1A
 REas1z53pYxuDsgyOdyiPpNBWgMyNhykp7Xbdy7/noruzAqiZwgu0+cmTp0nQctuMcUbPe6Ke3Q
 e/IiItuCxWHQz2zy6dkJs7NEsJ3NfgJRTctBK08Eh74STgTM4PTTW0reqkk/haPvpZZn26+gnHV
 R2zGO1hI06vFFAzao2IbKNm4yQLgJoREtlSnltxo2G9qoDrC
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
PCI endpoint controllers. But this domain number could be useful to the EPC
drivers to uniquely identify each controller based on the hardware instance
when there are multiple ones present in an SoC (even multiple RC/EP).

So let's make use of the existing pci_bus_find_domain_nr() API to allocate
domain numbers based on either Devicetree (linux,pci-domain) property or
dynamic domain number allocation scheme.

It should be noted that the domain number allocated by this API will be
based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
property is present, then the domain number represents the actual hardware
instance of the PCI endpoint controller. If not, then the domain number
will be allocated based on the PCI EP/RC controller probe order.

If the architecture doesn't support CONFIG_PCI_DOMAINS_GENERIC (rare), then
currently a warning is thrown to indicate that the architecture specific
implementation is needed.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 14 ++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c68..085a2de8b923 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -838,6 +838,10 @@ void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
 	device_unregister(&epc->dev);
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	pci_bus_release_domain_nr(NULL, &epc->dev);
+#endif
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 
@@ -900,6 +904,16 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	epc->dev.release = pci_epc_release;
 	epc->ops = ops;
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
+#else
+	/*
+	 * TODO: If the architecture doesn't support generic PCI
+	 * domains, then a custom implementation has to be used.
+	 */
+	WARN_ONCE(1, "This architecture doesn't support generic PCI domains\n");
+#endif
+
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
 	if (ret)
 		goto put_dev;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 85bdf2adb760..8e3dcac55dcd 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -128,6 +128,7 @@ struct pci_epc_mem {
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
+ * @domain_nr: PCI domain number of the endpoint controller
  * @init_complete: flag to indicate whether the EPC initialization is complete
  *                 or not
  */
@@ -145,6 +146,7 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
+	int				domain_nr;
 	bool				init_complete;
 };
 

-- 
2.25.1



