Return-Path: <linux-pci+bounces-14858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5729A4099
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3368D1F241C2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141C1DF24F;
	Fri, 18 Oct 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpK9/3aX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED826AFA;
	Fri, 18 Oct 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260072; cv=none; b=kC/jsMpGNNHRk8Y3ifQL+2c3RV5gtAbLWPdjmZjnJPQthNbZv535JMfdygs1+OZcE4yLpKWqCmCyktQZvMNTYWpwHSrcRrTWMuDWhcd7CKhb+pms6bKQHiZ8oo78ZCuNAuC8RcOuAR9K0MpBrMcK/IXS/t+9B65o1yEpPVlDBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260072; c=relaxed/simple;
	bh=w1KFwbjeawOEyuk6ibo4Ts2M3c2Y1JCeveZ6DlkK/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaJ1byMOIxL8oLgdpyZjgQVOAFi0psbpWPtqyietU7PccUifKIS+reP5e8SPdQE/TZI1XoeFIcar4+jHO4L3i4Eh6X86itufCxAVy9vnvILBEv5uANR0ZSTv4uFoi9xpweHxVnnE97Byx4No17m5srkFd+63qQ/Gt5+lrmb4cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpK9/3aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB277C4CECF;
	Fri, 18 Oct 2024 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260071;
	bh=w1KFwbjeawOEyuk6ibo4Ts2M3c2Y1JCeveZ6DlkK/w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpK9/3aXgTYel3/ATsWrxz5Baq18wZVHokz8/A8Tg8/a/2mncZiwLejfIGn0L9NIH
	 jsRlIq6s5S5paHOGU4nmGJBc17Tsp/RFqp9KhHBfvDkbON5B7USKmTLjU40VOaPS+f
	 QqkgUWwJD+Me4bxUR/lvaDPdkPxbvTAqA2uepKeJv4oAsxHSFigKe56FloI7yGFHeB
	 o5gnDL8QkSBRpqPcdexawtHY0w+lOtqE9wLwUtJIhu1Aj2/W8de761VFfmJo1e5hvh
	 UrTu+SzHnWS4Ug4mmpJOVsvt8IjdmuKsQphRMbxUKQTrCEeAC91d0YkuQLopiPbNpW
	 e9MkoKagNVb2g==
Date: Fri, 18 Oct 2024 16:01:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxJqITunljv0PGxn@ryzen.lan>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>

Hello Frank,

On Tue, Oct 15, 2024 at 06:07:17PM -0400, Frank Li wrote:
> Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> doorbell address space.
> 
> Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> callback handler by writing doorbell_data to the mapped doorbell_bar's
> address space.
> 
> Set doorbell_done in the doorbell callback to indicate completion.
> 
> To avoid broken compatibility, use new PID/VID and set RevID bigger than 0.
> So only new pcitest program can distinguish with/without doorbell support
> and avoid wrongly write test data to doorbell bar.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 58 ++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53ad..c054d621353a6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -11,12 +11,14 @@
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  #include <linux/slab.h>
>  #include <linux/pci_ids.h>
>  #include <linux/random.h>
>  
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> +#include <linux/pci-ep-msi.h>
>  #include <linux/pci_regs.h>
>  
>  #define IRQ_TYPE_INTX			0
> @@ -39,6 +41,7 @@
>  #define STATUS_IRQ_RAISED		BIT(6)
>  #define STATUS_SRC_ADDR_INVALID		BIT(7)
>  #define STATUS_DST_ADDR_INVALID		BIT(8)
> +#define STATUS_DOORBELL_SUCCESS		BIT(9)
>  
>  #define FLAG_USE_DMA			BIT(0)
>  
> @@ -50,6 +53,7 @@ struct pci_epf_test {
>  	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
>  	enum pci_barno		test_reg_bar;
> +	enum pci_barno		doorbell_bar;
>  	size_t			msix_table_offset;
>  	struct delayed_work	cmd_handler;
>  	struct dma_chan		*dma_chan_tx;
> @@ -74,6 +78,9 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	doorbell_bar;
> +	u32	doorbell_addr;
> +	u32	doorbell_data;
>  } __packed;
>  
>  static struct pci_epf_header test_header = {
> @@ -695,7 +702,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> -		if (!epf_test->reg[bar])
> +		if (!epf_test->reg[bar] && bar != epf_test->doorbell_bar)
>  			continue;
>  
>  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> @@ -810,11 +817,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +
> +	reg->status |= STATUS_DOORBELL_SUCCESS;
> +	pci_epf_test_raise_irq(epf_test, reg);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.epc_init = pci_epf_test_epc_init,
>  	.epc_deinit = pci_epf_test_epc_deinit,
>  	.link_up = pci_epf_test_link_up,
>  	.link_down = pci_epf_test_link_down,
> +	.doorbell = pci_epf_test_doorbell,
>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> @@ -853,7 +873,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (bar == NO_BAR)
>  			break;
>  
> -		if (bar == test_reg_bar)
> +		if (bar == test_reg_bar || bar == epf_test->doorbell_bar)
>  			continue;
>  
>  		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
> @@ -887,7 +907,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	const struct pci_epc_features *epc_features;
>  	enum pci_barno test_reg_bar = BAR_0;
> +	enum pci_barno doorbell_bar = NO_BAR;
>  	struct pci_epc *epc = epf->epc;
> +	struct msi_msg *msg;
> +	u64 doorbell_addr;
> +	u32 align;
>  
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
> @@ -905,10 +929,40 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
>  
> +	align = epc_features->align;
> +	align = align ? align : 128;
> +
> +	/* Only revid >=1 support RC-to-EP Door bell */
> +	ret = epf->header->revid > 0 ?  pci_epf_alloc_doorbell(epf, 1) : -EINVAL;

I really, really don't like this idea.

This means that you would need to write a revid > 1 in configfs to test this.
I also don't think that it is right that pci-epf-test takes ownership of "rev".

How about something like this instead:

My thinking is that you add a doorbell_capable struct member to epc_features,
and then populate CAPS_DOORBELL_SUPPORT based on epc_features in
pci_epf_test_init_caps() (similar to how my proposal sets CAPS_MSI_SUPPORT).


From 0f6bb535c6d56e03e9b3550194deec04a1c1d370 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 18 Oct 2024 10:32:39 +0200
Subject: [PATCH] PCI: endpoint: pci-epf-test: Add support for exposing EPC
 capabilities

Currently, there is no way for the pci-endpoint-test driver (RC side),
to know which features the EPC supports.

Expose some of the EPC:s capabilities in the test_reg_bar, such that
the pci-endpoint-test driver can know if a feature (e.g. MSI-X or DMA)
is supported before attempting to test it.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c              | 34 +++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 43 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..7eb045dc81b6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -69,6 +69,20 @@
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
 #define FLAG_USE_DMA				BIT(0)
 
+#define CAPS_MAGIC				0x25ccf687
+#define PCI_ENDPOINT_TEST_CAPS_MAGIC		0x30
+#define PCI_ENDPOINT_TEST_CAPS_VERSION		0x34
+#define PCI_ENDPOINT_TEST_CAPS			0x38
+
+#define CAPS_MSI_SUPPORT		BIT(0)
+#define CAPS_MSIX_SUPPORT		BIT(1)
+#define CAPS_DMA_SUPPORT		BIT(2)
+#define CAPS_DMA_IS_PRIVATE		BIT(3) /* only valid if DMA_SUPPORT */
+#define CAPS_DOORBELL_SUPPORT		BIT(4)
+#define CAPS_DOORBELL_BAR_MASK		GENMASK(7, 5) /* only valid if DOORBELL_SUPPORT */
+#define CAPS_DOORBELL_BAR_SHIFT		5
+#define CAPS_DOORBELL_BAR(x)		(((x) & CAPS_DOORBELL_BAR_MASK) >> CAPS_DOORBELL_BAR_SHIFT)
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -805,6 +819,24 @@ static const struct file_operations pci_endpoint_test_fops = {
 	.unlocked_ioctl = pci_endpoint_test_ioctl,
 };
 
+static void pci_endpoint_get_caps(struct pci_endpoint_test *test)
+{
+	u32 caps_magic, caps;
+
+	/* check if endpoint has CAPS support */
+	caps_magic = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS_MAGIC);
+	if (caps_magic != CAPS_MAGIC)
+		return;
+
+	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
+	pr_info("CAPS: MSI support: %u\n", (caps & CAPS_MSI_SUPPORT) ? 1 : 0);
+	pr_info("CAPS: MSI-X support: %u\n", (caps & CAPS_MSIX_SUPPORT) ? 1 : 0);
+	pr_info("CAPS: DMA support: %u\n", (caps & CAPS_DMA_SUPPORT) ? 1 : 0);
+	pr_info("CAPS: DMA is private: %u\n", (caps & CAPS_DMA_IS_PRIVATE) ? 1 : 0);
+	pr_info("CAPS: DOORBELL support: %u\n", (caps & CAPS_DOORBELL_SUPPORT) ? 1 : 0);
+	pr_info("CAPS: DOORBELL BAR: %lu\n", CAPS_DOORBELL_BAR(caps));
+}
+
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
@@ -906,6 +938,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_kfree_test_name;
 	}
 
+	pci_endpoint_get_caps(test);
+
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
 	misc_device->name = kstrdup(name, GFP_KERNEL);
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a73bc0771d35..2dd90e2e8565 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -44,6 +44,18 @@
 
 #define TIMER_RESOLUTION		1
 
+#define CAPS_MAGIC			0x25ccf687
+#define CAPS_VERSION			0x1
+
+#define CAPS_MSI_SUPPORT		BIT(0)
+#define CAPS_MSIX_SUPPORT		BIT(1)
+#define CAPS_DMA_SUPPORT		BIT(2)
+#define CAPS_DMA_IS_PRIVATE		BIT(3) /* only valid if DMA_SUPPORT */
+#define CAPS_DOORBELL_SUPPORT		BIT(4)
+#define CAPS_DOORBELL_BAR_MASK		GENMASK(7, 5) /* only valid if DOORBELL_SUPPORT */
+#define CAPS_DOORBELL_BAR_SHIFT		5
+#define CAPS_DOORBELL_BAR(x)		(((x) & CAPS_DOORBELL_BAR_MASK) >> CAPS_DOORBELL_BAR_SHIFT)
+
 static struct workqueue_struct *kpcitest_workqueue;
 
 struct pci_epf_test {
@@ -74,6 +86,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	caps_magic;
+	u32	caps_version;
+	u32	caps;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -741,6 +756,32 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
 	}
 }
 
+static void pci_epf_test_init_caps(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features = epf_test->epc_features;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 caps = 0;
+
+	reg->caps_magic = cpu_to_le32(CAPS_MAGIC);
+	reg->caps_version = cpu_to_le32(CAPS_VERSION);
+
+	if (epc_features->msi_capable)
+		caps |= CAPS_MSI_SUPPORT;
+
+	if (epc_features->msix_capable)
+		caps |= CAPS_MSIX_SUPPORT;
+
+	if (epf_test->dma_supported)
+		caps |= CAPS_DMA_SUPPORT;
+
+	if (epf_test->dma_private)
+		caps |= CAPS_DMA_IS_PRIVATE;
+
+	reg->caps = cpu_to_le64(caps);
+}
+
 static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -765,6 +806,8 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 		}
 	}
 
+	pci_epf_test_init_caps(epf);
+
 	ret = pci_epf_test_set_bar(epf);
 	if (ret)
 		return ret;
-- 
2.47.0


