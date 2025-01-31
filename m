Return-Path: <linux-pci+bounces-20591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB4A23E33
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 14:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0266E3A315E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2151C1F0D;
	Fri, 31 Jan 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcvm43wf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337B1DFF0;
	Fri, 31 Jan 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329190; cv=none; b=lUEc7rI03nALnuQBbv/LP5ygi6u0wBV/7plT8Sm9X3aNbqQkwOc5SFhtNajhbCdFrSZiIiBGFsRTQH+gnSSSnz/VkyuwbVc/bbxc38gGf93jh2D941rMWYm8unynomilIROiQhvEbGU7LLDbekr54MjGpvoC/vtzJhrmi0oxTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329190; c=relaxed/simple;
	bh=/MUniiE0dGVEQ0M5rByOa3nWbgHI7zpjqSXKU9kQKe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crQU9BkNyDY4JmfExKPgTakSWoNYc2F1P9Zw6TVm8pmmF7RmDKqSUdhYRBX4BOZ2db+xraGZpDatb29UlZhZTMVVzyJXDK4SPXu4scYUc1OJDNi6PrxioBGIk5K+av9/Y7NBi2mWHSqu0yRbOoOoVllD4cMt9qyukd7EyZGyXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcvm43wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC6CC4CED1;
	Fri, 31 Jan 2025 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738329190;
	bh=/MUniiE0dGVEQ0M5rByOa3nWbgHI7zpjqSXKU9kQKe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcvm43wf/U7ZRKf61BsOtETmytr+LoysnswBRuoQAECPYXmJOZbW6PGiWEoMH6WJB
	 veZdYeQH0uebiH/DCxK9fx0tNXpemsa7I5rAYg8V+H8Tir8DAfi+uNzeNn3ejkQtrI
	 7fdhSSjYx+ufOYCAxWRqoeTPfJenab9qUJIMmSyyTjrQbEW/TLSzOgF0LVWAFFlQTo
	 qtVOHgxTJ49HehuMtNUCxWoRr+uM61Z0mmb1nLZLR10lI0qZ4PfXn175RnkKSflgEu
	 ZpXSoSQ8umoml+88lrVRcYHw2zcvdR9yT4VaQzTgthoOvSW1her312rWnr7gR1CYjT
	 P9aB2Z5EA/KXA==
Date: Fri, 31 Jan 2025 14:13:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z5zMYQAduf58ZXPJ@ryzen>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad>
 <Z5oX5Fe5FY2Pym0u@ryzen>
 <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com>
 <Z5y9zpFGkBnY2TG1@ryzen>
 <Z5zAFhEJzwOQUccM@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0zbjT5a9d7kNHMUA"
Content-Disposition: inline
In-Reply-To: <Z5zAFhEJzwOQUccM@ryzen>


--0zbjT5a9d7kNHMUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2025 at 01:20:38PM +0100, Niklas Cassel wrote:
> On Fri, Jan 31, 2025 at 01:10:54PM +0100, Niklas Cassel wrote:
> > > 
> > > If SET_IRQTYPE is AUTO, how will test->irq_type be set?
> > 
> > I was thinking something like this:
> > 
> > pci_endpoint_test_set_irq()
> > {
> > 	u32 caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> > 
> > 	...
> > 
> > 	if (req_irq_type == IRQ_TYPE_AUTO) {
> > 		if (caps & MSI_CAPABLE)
> > 			test->irq_type = IRQ_TYPE_MSI;
> > 		else if (caps & MSIX_CAPABLE)
> > 			test->irq_type = IRQ_TYPE_MSIX;
> > 		else
> > 			test->irq_type = IRQ_TYPE_INTX;
> > 
> > 	}
> > 
> > 	...
> > }
> 
> 
> Or even simpler (since it requires less changes to
> pci_endpoint_test_set_irq()):
> 
> 	if (req_irq_type == IRQ_TYPE_AUTO) {
> 		if (caps & MSI_CAPABLE)
> 			req_irq_type = IRQ_TYPE_MSI;
> 		else if (caps & MSIX_CAPABLE)
> 			req_irq_type = IRQ_TYPE_MSIX;
> 		else
> 			req_irq_type = IRQ_TYPE_INTX;
> 
> 	}
> 
> 	...
> 
> 	/* Sets test->irq_type = req_irq_type; on success */
> 	pci_endpoint_test_alloc_irq_vectors();


See attached patch.

Mani, removing the global irq_type would go on top of this.


Kind regards,
Niklas

--0zbjT5a9d7kNHMUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="auto_irq.patch"

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..5e42930124e2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -32,6 +32,7 @@
 #define IRQ_TYPE_INTX				0
 #define IRQ_TYPE_MSI				1
 #define IRQ_TYPE_MSIX				2
+#define IRQ_TYPE_AUTO				3
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
@@ -71,6 +72,8 @@
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
+#define CAP_MSI					BIT(1)
+#define CAP_MSIX				BIT(2)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -126,6 +129,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	u32 ep_caps;
 	const char *name;
 };
 
@@ -805,11 +809,20 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_MSIX) {
+	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_AUTO) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return -EINVAL;
 	}
 
+	if (req_irq_type == IRQ_TYPE_AUTO) {
+		if (test->ep_caps & CAP_MSI)
+			req_irq_type = IRQ_TYPE_MSI;
+		else if (test->ep_caps & CAP_MSIX)
+			req_irq_type = IRQ_TYPE_MSIX;
+		else
+			req_irq_type = IRQ_TYPE_INTX;
+	}
+
 	if (test->irq_type == req_irq_type)
 		return 0;
 
@@ -895,13 +908,12 @@ static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
-	u32 caps;
 
-	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
-	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", caps);
+	test->ep_caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	dev_dbg(dev, "PCI_ENDPOINT_TEST_CAPS: %#x\n", test->ep_caps);
 
 	/* CAP_UNALIGNED_ACCESS is set if the EP can do unaligned access */
-	if (caps & CAP_UNALIGNED_ACCESS)
+	if (test->ep_caps & CAP_UNALIGNED_ACCESS)
 		test->alignment = 0;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b94e205ae10b..8917f7c6c741 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -45,6 +45,8 @@
 #define TIMER_RESOLUTION		1
 
 #define CAP_UNALIGNED_ACCESS		BIT(0)
+#define CAP_MSI				BIT(1)
+#define CAP_MSIX			BIT(2)
 
 static struct workqueue_struct *kpcitest_workqueue;
 
@@ -753,6 +755,12 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
 	if (epc->ops->align_addr)
 		caps |= CAP_UNALIGNED_ACCESS;
 
+	if (epf_test->epc_features->msi_capable)
+		caps |= CAP_MSI;
+
+	if (epf_test->epc_features->msix_capable)
+		caps |= CAP_MSIX;
+
 	reg->caps = cpu_to_le32(caps);
 }
 
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index acd261f49866..1edbd4357470 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -23,6 +23,11 @@
 #define PCITEST_BARS		_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
+#define PCITEST_IRQ_TYPE_INTX	0
+#define PCITEST_IRQ_TYPE_MSI	1
+#define PCITEST_IRQ_TYPE_MSIX	2
+#define PCITEST_IRQ_TYPE_AUTO	3
+
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
 struct pci_endpoint_test_xfer_param {
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c267b822c108..c820a67e6437 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -97,7 +97,7 @@ TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
 {
 	int ret;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_INTX);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
 
 	pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);
@@ -108,7 +108,7 @@ TEST_F(pci_ep_basic, MSI_TEST)
 {
 	int ret, i;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSI);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
 	for (i = 1; i <= 32; i++) {
@@ -121,7 +121,7 @@ TEST_F(pci_ep_basic, MSIX_TEST)
 {
 	int ret, i;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 2);
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_MSIX);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI-X IRQ type");
 
 	for (i = 1; i <= 2048; i++) {
@@ -170,8 +170,8 @@ TEST_F(pci_ep_data_transfer, READ_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -189,8 +189,8 @@ TEST_F(pci_ep_data_transfer, WRITE_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];
@@ -208,8 +208,8 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 	if (variant->use_dma)
 		param.flags = PCITEST_FLAGS_USE_DMA;
 
-	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
-	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
 	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
 		param.size = test_size[i];

--0zbjT5a9d7kNHMUA--

