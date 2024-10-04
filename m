Return-Path: <linux-pci+bounces-13847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3E990C6F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DFA1C22761
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89E1F780B;
	Fri,  4 Oct 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K876QZYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B21F7808;
	Fri,  4 Oct 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066195; cv=none; b=PT2W/0iwv92GDzfLvA+02t5FVIeFPNjGYLj3+qdK6aWAYFd1dKxyQ1Zc9i9xXKYj6bCOOy8pObhOCxchjMYjAm5EdToybNfP6IRNBUdqRAEXEMzhMxL/E12YuN7qkm7QSDFSmgYGSQf2SSqgjMpxQXb70aupTg4koNqGbsAKajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066195; c=relaxed/simple;
	bh=dPelZsrz963rJ7yqfdRQroR1gmL4IW4pvZrgvpQucvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THRwc8Uw+t176tDdvjXe0YAkKBYHnGc7eW0buVOjPufbt6PTOktm4cD3X0u2Zc3PSIUA4QGbOo9hy2wo+hjbsm5xMk7usjI7Ea1+PZIpusQAkt9ObEoToueO12LjpKXgZ1rL6bYQrzMXivBVGEadF4JXGSbI6H6m1b7y07hWlis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K876QZYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE4C4CECD;
	Fri,  4 Oct 2024 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066194;
	bh=dPelZsrz963rJ7yqfdRQroR1gmL4IW4pvZrgvpQucvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K876QZYHi3vdrjLxpFWsXVsiVgcYATgDJkS49O3JzHBmUnN44PtVB0nEUXthMb8r5
	 XdgVRiuIObu0Hxh5z+IltkOXxrwsQVESILw4gjZtmN+O0LF4kR9JcwhhYqGv9Bk09u
	 XIW6b7fBlHpQT1ohsfLPtGlI699flpTwxN4f+XYdd+Ae/H1IOcpObSck7+Svkv0J+E
	 9iirCXuyfPBYa1+P1aQCzQnvuLoKjCPgAC0IAmcs0VU5t0SOfH25lU+Fb50T5AtOdH
	 ARyq9phEAMMHGc3cYq2OjF25sMYwRu/R4LkpdeQfD4SzgCFjcaQVwhG2Zv9q99CeTK
	 AvRJe4J/tqblA==
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
Subject: [PATCH AUTOSEL 6.10 38/70] PCI: endpoint: Assign PCI domain number for endpoint controllers
Date: Fri,  4 Oct 2024 14:20:36 -0400
Message-ID: <20241004182200.3670903-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 47d27ec7439d9..141840fceb798 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -810,6 +810,10 @@ void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
 	device_unregister(&epc->dev);
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	pci_bus_release_domain_nr(NULL, &epc->dev);
+#endif
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 
@@ -872,6 +876,16 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
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
index acc5f96161fe1..cac04ce7f2ed7 100644
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


