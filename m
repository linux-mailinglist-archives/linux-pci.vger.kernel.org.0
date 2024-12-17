Return-Path: <linux-pci+bounces-18673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC029F59E2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 23:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3200E166F31
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00581E009D;
	Tue, 17 Dec 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KAPgXgn5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B08v8+NT"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593614B08E;
	Tue, 17 Dec 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476184; cv=none; b=WbRiY0k+sM6t6mQWSSC29lZQll9BWCVS+9pQk4ux3gL/4aLa88ANraFDUrz9dtrPjz8pLV+iF9l5S7u4pCnUM50xK4kpK/lcm2k0GDVVPvZIFulPj3UaqC2T4gPdDzDNrHiNASvscQ/yOpa5TmZpA8vi830WtlBMJGo2p0VeeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476184; c=relaxed/simple;
	bh=APmnuAqVtmosZCF5vYqDRXyKNNDn48FlDZur8YGudyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJTJIJV5WeCmJJ4p7chlwhVDCF63t0YK5JOtH8uyzN7Mod/zDDNge5hZncqDANz7mSraX6YM+duFvUC9diunallJjeX8yBUTQvGxeo4W7kpOFOoBjNGQq/nrK3reS56HFIxiB6nde9AOi0LIW6LygbyCwvS+W/EzyB4ptnB56pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KAPgXgn5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B08v8+NT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734476179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5js8+VEP7CRYYqILc+dNJA/mdcaQogNcYqwc5JH5i0=;
	b=KAPgXgn5IDlBZ/hn38oZRvAwHUhITH49umZDTdPMYy2FoSNUVI9Jbs4+HPU0+WRBcqiyJf
	iQSQ2ygvr6gav+qYZSDupLz439uLKRXffBmVZVioOHvMYLpq6sPpC7jiRzUd1UQN9HDNg6
	kbjT1janPBJWQrk9CRe832GwUsGqyRw1W/L03MuLKd4q+9juOkhCSW/gDkMVyV4QKj9Y12
	tgTs33I7j65fyQ6BMdAE7fR+9a0xdsfy+pEKphMEdi/U102i4KdqSKTAOGfBs3cN5p/tct
	tvD7BPMN6PX3aE3GhnnO6F/TLGShMGPmYigk+R6gNZbm60ZpfQoojfFuF/0lcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734476179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5js8+VEP7CRYYqILc+dNJA/mdcaQogNcYqwc5JH5i0=;
	b=B08v8+NTgmIDCuodRxS19EOhhaTfBHbQ3C+o6KHiBzW3Az4IBhP+6wEpgaYGWBnyOeRrf7
	E7Udkz5qfHCnORBQ==
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, jdmason@kudzu.us,
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 2/9] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
In-Reply-To: <20241211-ep-msi-v12-2-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
 <20241211-ep-msi-v12-2-33d4532fa520@nxp.com>
Date: Tue, 17 Dec 2024 23:56:18 +0100
Message-ID: <87o7197wbx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 11 2024 at 15:57, Frank Li wrote:
> +static int pci_epf_msi_prepare(struct irq_domain *domain, struct device *dev,
> +			       int nvec, msi_alloc_info_t *arg)
> +{
> +	struct pci_epf *epf = to_pci_epf(dev);
> +	struct msi_domain_info *msi_info;
> +	struct pci_epc *epc = epf->epc;
> +
> +	memset(arg, 0, sizeof(*arg));
> +	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
> +					      (epf->func_no << 8) | epf->vfunc_no);
> +
> +	/*
> +	 * @domain->msi_domain_info->hwsize contains the size of the device
> +	 * domain, but vector allocation happens one by one.
> +	 */
> +	msi_info = msi_get_domain_info(domain);
> +	if (msi_info->hwsize > nvec)
> +		nvec = msi_info->hwsize;
> +
> +	/* Allocate at least 32 MSIs, and always as a power of 2 */
> +	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
> +
> +	msi_info = msi_get_domain_info(domain->parent);
> +	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, arg);

While I was trying to make sense of the change log of patch [1/9] I
looked at this function to understand why this needs an override.

This is a copy of its_msi_prepare() except for the scratchpad[0].ul
part. But that's a GIC-V3 implementation specific detail, which has
absolutely no business in code which claims to be a generic library for
PCI endpoints.

Worse you created a GIC-V3 only PCI endpoint library under the
assumption that the underlying ITS/MSI implementation is immutable. Of
course there is no safety net either to validate that the underlying
parent domain is actually GIC-V3-ITS. That's wrong in every aspect.

So let's take a step back and analyze what is actually required to make
this a proper generic library.

The endpoint function device needs its own device ID which is required
to set up a device specific translation in the interrupt remapping unit.

Now you decided that this is bound to a DT mapping, which is odd to
begin with. What's DT specific about this? The cirumstance that your
hardware is DT based and the endpoint controller ID map needs to be
retrieved from there? How is this generic in any way? How is this
supposed to work with ACPI enumerated hardware? Not to ask the question
how this should work with non GIC-V3-ITS based hardware.

That's all but generic, it's an ad hoc hack to support your particular
setup implemented by layering violations.

In fact the mapping ID is composed by the parent mapping ID and the
function numbers, right?

The general PCIe convention here is:

    domain:bus:slot.func

That's well defined and if you look at real devices then lspci shows:

0000:3d:00.1 Ethernet controller: Ethernet Connection for 10GBASE-T
0000:3d:06.0 Ethernet controller: Ethernet Virtual Function
0000:...
0000:3d:06.7 Ethernet controller: Ethernet Virtual Function
0000:3d:07.0 Ethernet controller: Ethernet Virtual Function
0000:...
0000:3d:07.7 Ethernet controller: Ethernet Virtual Function

In PCI address representation:

   domain:bus:slot:function

which is usually condensed into a single word based on the range limits
of function, device and bus:

   function:    bit 0-2         (max. 8)
   device:      bit 3-7         (max. 32)
   bus:         bit 8-15        (max. 256)
   domain:      bit 16-31       (mostly theoretical)

Endpoint devices should follow exactly the same scheme, no?

Now looking at your ID retrieval:

> +	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
> +					      (epf->func_no << 8) | epf->vfunc_no);

I really have to ask why this is making up its own representation
instead of simply using the standard PCI B/D/F conventions?

Whatever the reason is, fact is that the actual interrupt domain support
needs to be done differently. There is no way that the endpoint library
makes assumption about the underlying interrupt domain and copies a
function just because. This has to be completely agnostic, no if, no
but.

So the consequence is that the underlying MSI parent domains needs to
know about the endpoint requirements, which is how all MSI variants are
modeled, i.e. with a MSI domain bus.

That also solves the problem of immutable MSI messages without any
further magic. Interrupt domains, which do not provide them, won't
provide the endpoint MSI domain bus and therefore the lookup of the
parent MSI domain for the endpoint fails.

The uncompilable mockup below should give you a hint.

Thanks,

        tglx
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c |   50 ++++++++++++++++++++--------
 drivers/irqchip/irq-msi-lib.c               |    5 ++
 drivers/irqchip/irq-msi-lib.h               |   12 +++++-
 include/linux/irqdomain_defs.h              |    2 +
 4 files changed, 51 insertions(+), 18 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -126,20 +126,9 @@ int __weak iort_pmsi_get_dev_id(struct d
 	return -1;
 }
 
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
+static int __its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			      int nvec, msi_alloc_info_t *info, u32 dev_id)
 {
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
-	else
-		ret = iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
-
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = dev_id;
 
@@ -159,6 +148,36 @@ static int its_pmsi_prepare(struct irq_d
 					  dev, nvec, info);
 }
 
+static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
+				  int nvec, msi_alloc_info_t *info)
+{
+	u32 dev_id = dev_get_pci_ep_id(dev);
+	struct msi_domain_info *msi_info;
+	int ret = -ENOTSUPP;
+
+	if (dev->of_node)
+		ret = do_magic_ep_id_map();
+	if (ret)
+		return ret;
+	return __its_pmsi_prepare(domain, dev, nvec, info, dev_id);
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+	else
+		ret = iort_pmsi_get_dev_id(dev, &dev_id);
+	if (ret)
+		return ret;
+	return __its_pmsi_prepare(domain, dev, nvec, info, dev_id);
+}
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
@@ -183,6 +202,9 @@ static bool its_init_dev_msi_info(struct
 		 */
 		info->ops->msi_prepare = its_pci_msi_prepare;
 		break;
+	case DOMAIN_BUS_PCI_DEVICE_EP_MSI:
+		info->ops->msi_prepare = its_pci_ep_msi_prepare;
+		break;
 	case DOMAIN_BUS_DEVICE_MSI:
 	case DOMAIN_BUS_WIRED_TO_MSI:
 		/*
@@ -204,7 +226,7 @@ const struct msi_parent_ops gic_v3_its_m
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
-	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_PCI_EP_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -55,8 +55,11 @@ bool msi_lib_init_dev_msi_info(struct de
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
 			return false;
-
 		break;
+	case DOMAIN_BUS_DEVICE_PCI_EP_MSI:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_ENDPOINT)))
+			return false;
+		fallthrough;
 	case DOMAIN_BUS_DEVICE_MSI:
 		/*
 		 * Per device MSI should never have any MSI feature bits
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -10,12 +10,18 @@
 #include <linux/msi.h>
 
 #ifdef CONFIG_PCI_MSI
-#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#define MATCH_PCI_MSI			BIT(DOMAIN_BUS_PCI_MSI)
 #else
-#define MATCH_PCI_MSI		(0)
+#define MATCH_PCI_MSI			(0)
 #endif
 
-#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+#ifdef CONFIG_PCI_ENDPOINT
+#define MATCH_PLATFORM_PCI_EP_MSI	BIT(DOMAIN_BUS_PLATFORM_PCI_EP_MSI)
+#else
+#define MATCH_PLATFORM_PCI_EP_MSI	(0)
+#endif
+
+#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
 
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -15,6 +15,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_GENERIC_MSI,
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_PLATFORM_PCI_EP_MSI,
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
@@ -27,6 +28,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_DEVICE_PCI_EP_MSI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

