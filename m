Return-Path: <linux-pci+bounces-10282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC393198E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAD6283289
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E184131E38;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz8UW8mr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AC5EE97;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=ojzdhOdpX6+B2LQSzc0nhkaG5G/clfVBpnDzjd9PYYql6mD1NLcJGn/Eav6W6SFnZbSQaWYz34DO0uc5mh0SnhJ9FWRXBWzE0xB+vBs/UXO2Mb/HtelrPgGwF8ZWdimFpSbgI2B6T+083a7Qgo/J7WhuUGPIrT93+O097hf8Psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=AqLKtDzeOWTpfLlD5Nunw5Lx2M3YMLzkFuSgYFTXBK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfSrcdG0C21S+D96Q8kDl4jHZ4DM8cJ2W9v+jpzJjHzU1iKkXcvoznQ8p8hCrZn4mEuFNxZa1RukwCQ2DWIXYPJsnSHpoNobdhDeOAVZ+3m7o3KK+uVsWjIYUO30g4JJWl/7RsZhG6aEPLLtrMddtRU9cBj+C9iyxPwayfz4d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz8UW8mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFCCFC4AF68;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=AqLKtDzeOWTpfLlD5Nunw5Lx2M3YMLzkFuSgYFTXBK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cz8UW8mrn7ilYlUyn/ZEjHnPBbOTbPqmvtEZOEMr0dxoJvZ9/8fIMn8y8VfzPR/nD
	 oKQ7YmIxp281g9QGtVH0EeO+omxQ/AqDv3KJYXLbIiW5GlhzvSSfwHdS1PycRGNW7T
	 rd5QvH4vOwgdI6Cm/Hlibkm2Pqjj1VoBFcQoDLNTAJpUlQexYq7ncADIhpduaUp8IL
	 mu+4VCX4zsIYUjWjonIqDWBnL/6yJ4kEycvP59oX7knbN/hGeLT0eHqPyZ6bewqslF
	 CNZZMdYGYSPLsD4M4VVlSHBuJEXQ9ebGpRjTiDMniwlDpMrGlPao/OENZ7ZZo74jaH
	 Wny2zli0OjYHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371EC3DA4A;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:48 +0530
Subject: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for endpoint
 controllers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-6-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=BECkU4Os6kOoCK6Qfv68t/qW5FxIjT+Q5kndhCEtOC8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV15F+kcwS5+/FEQPBlLHWbPgXesdW/M72MTi
 jRCb9LZ6RqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeQAKCRBVnxHm/pHO
 9RpyCACSS3TlQfGlFVAKsoeJSe8dQG6CTaoBm5QHJxDiod8PIj9/kepgh3unKrlSjKH3NrHA8LW
 T3mT1GOAXHTeIculrZKZ2LCZSTWEWutKG/mDGXR3oNv2GC5E2EY5cF32Yrwd/RMWpHG0vuKkrpx
 yKjDMh3zTPOZDOzDIPe1F27RsgmoQVqgxdk9+DwrluZJjz9eXfKaWj76Axnupy6Nc1TPRFbhO53
 6zbJvq121HlgtYIRoChhSY0o7vopBiQk74jL4WKtUgZzh336aWq2cUi9+7mjkNaB9zRIV13FAGZ
 jWFYl5ADIqCZIGgQKl6raghKvnk0G5DqL7/UB1lI+BkxYv7W
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 1 +
 include/linux/pci-epc.h             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c68..7e8bf4ac003a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -899,6 +899,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	epc->dev.parent = dev;
 	epc->dev.release = pci_epc_release;
 	epc->ops = ops;
+	epc->domain_nr = pci_bus_find_domain_nr(NULL, dev);
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
 	if (ret)
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



