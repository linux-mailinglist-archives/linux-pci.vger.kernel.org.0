Return-Path: <linux-pci+bounces-10445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D768934103
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8691F24B26
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C518412C;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY4cL4l3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AF18306D;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=IS5WDe7xcQGuH+Nn6nXWD7BBtX1SIW4w5maOD/G3FovrlF8NtFibAc+/zYtmN2GXDYLMJlFns41idiIIzACjNIFcUJu2dNuWP/dPW7DyGeFgbQpedtdK897quTHhQDoCWcy6XlMZn8iEFF9OeAfDbm0X35DQSW8eilpBMDaCZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=0rGn+aPcpL0pLEHeouG5eEtAwVJpEH+6CnS4Upe21fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx2WSfEIt/p7zU7rODwmyYlAbTV2rkBYEULHOPmWxw6jatE0RQPS0DD/jzGUaKnht9oKJm6DrSELlXU0r0A/o4edW+ZHUoXki+XAEY4WxTVy+1g+xR+nTWhZYbsUWiyJzAXqp7h1TUGHE4I5cjcElAVOzN22EDfx+ykvZEDZAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY4cL4l3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15403C4AF1D;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=0rGn+aPcpL0pLEHeouG5eEtAwVJpEH+6CnS4Upe21fc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pY4cL4l3zdbNEZ7t+o1w6YgflZVzGNhFpjj3dzt/QpJ5RKSgj9gUddvDXn2GhXIc0
	 q9vhZwWrG9aaK7VKUfXop4iOF5bPOwGImb+GR8NLLSRxGWa4nJAQQW9s2GWRx+3LoR
	 xgB/hIRx3CAbpF3e4vfDooH5fkxXL5WTyW4PELr5RdQw+XNjQ0k/Yt7/cV8R82YA2b
	 u6wYgjQayvQDhyDTajrznJ+PRH14V4mSNXuasBMY76LFixpfvVhojwL6He6Cm96ium
	 9/kDomnK9fy/7pnfPkfiv8AT/43vMIrXWu8GQXQCvdZEQe2s1Es1ycJERoQ2wiTrvi
	 9nD/4GIsKRS6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087EAC3DA62;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:10 +0530
Subject: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3043;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=RgNx60ASNj1W+S8yTFl/XDFmb63UnDz74gKp1lFMkIw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lNJr0HPlA1u3KlDHSrQVmia8YznHXb4MGCI
 eq+KVVpCtqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TQAKCRBVnxHm/pHO
 9c1MCACf1G9ULGICZoGu33tG6Da4yMhnoVZQjnNzAGUwjufpNwuc57Ze/yb8vcYtVdyV2KjvcjX
 o+sBZj0mbpbo5lOVD3A8/MLJppD2S1Bb3OEmPpHHkS5T8fIDxxgs+RBXEUriO6Ebl1hNkplz/c4
 7LT1QmMbpF5+94YFGvgalfAy3rsjOZFp5rVxHC023qBvNY6CAQkjbic6wEFJOgjMsBM9BQA3CdJ
 w74vH+FZ2zuG3n1wCXTgMQBa9xfgFTuCD3ycjuaS/YzakIwGTi8WNH8s6n62TKSD2Dj7OjTmZXP
 HEi3phA1+SkPddEz41ZiSCOp0YYI3o5DnWg4FjV1KdJcnBfT
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
 drivers/pci/endpoint/pci-epc-core.c | 10 ++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c68..7fa81b91e762 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -838,6 +838,9 @@ void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
 	device_unregister(&epc->dev);
+
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		pci_bus_release_domain_nr(NULL, &epc->dev);
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 
@@ -900,6 +903,13 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	epc->dev.release = pci_epc_release;
 	epc->ops = ops;
 
+	/*
+	 * TODO: If the architecture doesn't support generic PCI domains, then
+	 * a custom implementation has to be used.
+	 */
+	if (!WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC)))
+		epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
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



