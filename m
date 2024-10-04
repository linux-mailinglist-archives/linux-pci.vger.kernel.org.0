Return-Path: <linux-pci+bounces-13840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB892990B74
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE5280D0D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D731DE3A1;
	Fri,  4 Oct 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki2Bghxc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F51DD520;
	Fri,  4 Oct 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065986; cv=none; b=aE3p8nabUBmoBD2Gc2GFACx15M6b/sHbri8czYjP+HpEP2w2ag8/w7p4M0xbQkTW5jOf0q+FHnDnxpTYhmoa4lV8biW+v4PRid6Pwtw0JRgrumbvChfoOaLirpjFS94IFZvR8957mnXXVibHEeRC2qvRq4t8Xbh+ay9OLO++lMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065986; c=relaxed/simple;
	bh=eL6erAPQ2OQ5cr6NNxjU6qVGwNpyMTEPO03Df0e86wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0YywvSvX/1VtYiYx1rONPyazdmwQlQ88VL44ATYyMpyAzWGkObTUUVnBnPIvX9rQZK+e9+OjWXgrlzEZDqkqwOnFdHjAf3edQagFyLEcSb3vyuDm7tBEtjejn6+HzS7TUm6XsLDPkfRzClTW8pGtA/sgU9PL8n4/PEc6CH8v3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki2Bghxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A0C4CEC6;
	Fri,  4 Oct 2024 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065986;
	bh=eL6erAPQ2OQ5cr6NNxjU6qVGwNpyMTEPO03Df0e86wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ki2Bghxc8JNvVv++AojZqKRbqDY8eC+qZwprASJ1IPCrk9OQSN7HzmB7lffsmJ6z2
	 oTohVOxbxJRrdLiYALCeKK1EfXlEUA5uinvWOx/AYAhbbC/pfG4+b8+3nc3LfpuiH1
	 lnsFK/OoMbEJAVdIpAYeW69W6buaUI9PoBcT4whL7sTZF4rpSVlXwFiNKx9wDf4IJx
	 rjCjXP+6n/Sj8dGjQ6t+pliFM2nWt3HYgwbWnvmMN/PtyQfVRUn0ORDf+qGQBh6iiz
	 EWVwbZFqqC5NyCz6ptgt1l4yLlBSi7xr1kAMufRLL/fPOI+YiGE14BpnMuqECsdAfw
	 Wx0Ah+Sc/oMhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 41/76] PCI: endpoint: Assign PCI domain number for endpoint controllers
Date: Fri,  4 Oct 2024 14:16:58 -0400
Message-ID: <20241004181828.3669209-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 0328947c50324cf4b2d8b181bf948edb8101f59f ]

Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
PCI endpoint controllers. But this domain number could be useful to the EPC
drivers to uniquely identify each controller based on the hardware instance
when there are multiple ones present in an SoC (even multiple RC/EP).

So let's make use of the existing pci_bus_find_domain_nr() API to allocate
domain numbers based on either devicetree (linux,pci-domain) property or
dynamic domain number allocation scheme.

It should be noted that the domain number allocated by this API will be
based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
property is present, then the domain number represents the actual hardware
instance of the PCI endpoint controller. If not, then the domain number
will be allocated based on the PCI EP/RC controller probe order.

If the architecture doesn't support CONFIG_PCI_DOMAINS_GENERIC (rare), then
currently a warning is thrown to indicate that the architecture specific
implementation is needed.

Link: https://lore.kernel.org/linux-pci/20240828-pci-qcom-hotplug-v4-5-263a385fbbcb@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 14 ++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c684..085a2de8b923d 100644
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
index 85bdf2adb7607..8e3dcac55dcd5 100644
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
2.43.0


