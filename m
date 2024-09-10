Return-Path: <linux-pci+bounces-12999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C523973D9D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130B7287C38
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00F19E7E0;
	Tue, 10 Sep 2024 16:47:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF21755C;
	Tue, 10 Sep 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986877; cv=none; b=XaDXp5kWw9W+IGwZgGiw+YkpV7WiGR0YWlmRVRDv2m1TUurVKueGtPaVZ3ce+NlUh9Pwm6HBy7j0XNip8pQ6/+HaSWr1BoNdwRxB3rROrdhBOa+CizkpAxQci/9ePyC5UkupGwBD311Y5w2eUTZJCjlaXll/rv8nWcJsbj5SxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986877; c=relaxed/simple;
	bh=tyHBoaMhxKYDhKrrXyJTZ6YTlcpNHsZBqJsYr/vSixI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/x6qYeEmfztdVJLfwtoO9c+BTbNlC1YnzAMeSzwkpgHOyE4A/Ech5yr5cf3nJFlcQ9iaHJWAk2h84SEg0E5utL7Uh66mLq75jupDuNAJBoiCpZIb/zg5SjXGU9Y3TS/heE5UZBpSFOztrbQG+RKiXaGeZzEGlMWN2khsNBFBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X38fy2Q0zz6J6kK;
	Wed, 11 Sep 2024 00:44:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 33BFC1400CA;
	Wed, 11 Sep 2024 00:47:46 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Sep
 2024 18:47:45 +0200
Date: Tue, 10 Sep 2024 17:47:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, "Dave Jiang" <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, <terry.bowman@amd.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240910174743.000037c7@huawei.com>
In-Reply-To: <20240906181832.00007dc7@Huawei.com>
References: <20240905122342.000001be@Huawei.com>
 <87jzfpdrc7.ffs@tglx>
 <20240906181832.00007dc7@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 6 Sep 2024 18:18:32 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 06 Sep 2024 12:11:36 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> > On Thu, Sep 05 2024 at 12:23, Jonathan Cameron wrote: =20
> > >> Look at how the PCI device manages interrupts with the per device MSI
> > >> mechanism. Forget doing this with either one of the legacy mechanism=
s.
> > >>=20
> > >>   1) It creates a hierarchical interrupt domain and gets the required
> > >>      resources from the provided parent domain. The PCI side does not
> > >>      care whether this is x86 or arm64 and it neither cares whether =
the
> > >>      parent domain does remapping or not. The only way it cares is a=
bout
> > >>      the features supported by the different parent domains (think
> > >>      multi-MSI).
> > >>     =20
> > >>   2) Driver side allocations go through the per device domain
> > >>=20
> > >> That AUXbus is not any different. When the CPMU driver binds it want=
s to
> > >> allocate interrupts. So instead of having a convoluted construct
> > >> reaching into the parent PCI device, you simply can do:
> > >>=20
> > >>   1) Let the cxl_pci driver create a MSI parent domain and set that =
in
> > >>      the subdevice::msi::irqdomain pointer.
> > >>=20
> > >>   2) Provide cxl_aux_bus_create_irqdomain() which allows the CPMU de=
vice
> > >>      driver to create a per device interrupt domain.
> > >>=20
> > >>   3) Let the CPMU driver create its per device interrupt domain with
> > >>      the provided parent domain
> > >>=20
> > >>   4) Let the CPMU driver allocate its MSI-X interrupts through the p=
er
> > >>      device domain
> > >>=20
> > >> Now on the cxl_pci side the AUXbus parent interrupt domain allocation
> > >> function does:
> > >>=20
> > >>     if (!pci_msix_enabled(pdev))
> > >>     	return pci_msix_enable_and_alloc_irq_at(pdev, ....);
> > >>     else
> > >>         return pci_msix_alloc_irq_at(pdev, ....);   =20
> >=20
> > Ignore the above. Brainfart.
> >  =20
> > > I'm struggling to follow this suggestion
> > > Would you expect the cxl_pci MSI parent domain to set it's parent as
> > > msi_domain =3D irq_domain_create_hierarchy(dev_get_msi_domain(&pdev->=
dev),
> > > 					 IRQ_DOMAIN_FLAG_MSI_PARENT,
> > > 					 ...
> > > which seems to cause a problem with deadlocks in __irq_domain_alloc_i=
rqs()
> > > or create a separate domain structure and provide callbacks that reac=
h into
> > > the parent domain as necessary?
> > >
> > > Or do I have this entirely wrong? I'm struggling to relate what exist=
ing
> > > code like PCI does to what I need to do here.   =20
> >=20
> > dev_get_msi_domain(&pdev->dev) is a nightmare due to the 4 different
> > models we have:
> >=20
> >    - Legacy has no domain
> >=20
> >    - Non-hierarchical domain
> >=20
> >    - Hierarchical domain v1
> >=20
> >          That's the global PCI/MSI domain
> >=20
> >    - Hierarchical domain v2
> >=20
> >       That's the underlying MSI_PARENT domain, which is on x86
> >       either the interrupt remap unit or the vector domain. On arm64
> >       it's the ITS domain.
> >=20
> > See e.g. pci_msi_domain_supports() which handles the mess.
> >=20
> > Now this proposal will only work on hierarchical domain v2 because that
> > can do the post enable allocations on MSI-X. Let's put a potential
> > solution for MSI aside for now to avoid complexity explosion.
> >=20
> > So there are two ways to solve this:
> >=20
> >   1) Implement the CXL MSI parent domain as disjunct domain
> >=20
> >   2) Teach the V2 per device MSI-X domain to be a parent domain
> >=20
> > #1 Looks pretty straight forward, but does not seemlessly fit the
> >    hierarchical domain model and creates horrible indirections.
> >=20
> > #2 Is the proper abstraction, but requires to teach the MSI core code
> >    about stacked MSI parent domains, which should not be horribly hard
> >    or maybe just works out of the box.
> >=20
> > The PCI device driver invokes the not yet existing function
> > pci_enable_msi_parent_domain(pci_dev). This function does:
> >=20
> >   A) validate that this PCI device has a V2 parent domain
> >=20
> >   B) validate that the device has enabled MSI-X
> >=20
> >   C) validate that the PCI/MSI-X domain supports dynamic MSI-X
> >      allocation
> >=20
> >   D) if #A to #C are true, it enables the PCI device parent domain
> >=20
> > I made #B a prerequisite for now, as that's an orthogonal problem, which
> > does not need to be solved upfront. Maybe it does not need to be solved
> > at all because the underlying PCI driver always allocates a management
> > interrupt before dealing with the underlying "bus", which is IMHO a
> > reasonable expectation. At least it's a reasonable restriction for
> > getting started.
> >=20
> > That function does:
> >=20
> >      msix_dom =3D pci_msi_get_msix_domain(pdev);
> >      msix_dom->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
> >      msix_dom->msi_parent_ops =3D &pci_msix_parent_ops;
> >=20
> > When creating the CXL devices the CXL code invokes
> > pci_msi_init_subdevice(pdev, &cxldev->device), which just does:
> >=20
> >   dev_set_msi_domain(dev, pci_msi_get_msix_subdevice_parent(pdev));
> >=20
> > That allows the CXL devices to create their own per device MSI
> > domain via a new function pci_msi_create_subdevice_irq_domain().
> >=20
> > That function can just use a variant of pci_create_device_domain() with
> > a different domain template and a different irqchip, where the irqchip
> > just redirects to the underlying parent domain chip, aka PCI-MSI-X.
> >=20
> > I don't think the CXL device will require a special chip as all they
> > should need to know is the linux interrupt number. If there are special
> > requirements then we can bring the IMS code back or do something similar
> > to the platform MSI code.=20
> >=20
> > Then you need pci_subdev_msix_alloc_at() and pci_subdev_msix_free()
> > which are the only two functions which the CXL (or similar) need.
> >=20
> > The existing pci_msi*() API function might need a safety check so they
> > can't be abused by subdevices, but that's a problem for a final
> > solution.
> >=20
> > That's pretty much all what it takes. Hope that helps. =20
>=20
> Absolutely!  Thanks for providing the detailed suggestion
> this definitely smells a lot less nasty than previous approach.
>=20
> I have things sort of working now but it's ugly code with a few
> cross layer hacks that need tidying up (around programming the
> msi registers from wrong 'device'), so may be a little
> while before I get it in a state to post.

Hi Thomas,

My first solution had some callbacks where we created a local
descriptor so that I could swap in the pci_dev->dev and
just use the various standard pci/msi/irqdomain.c functions.

The 'minimal' solution seems to be a bit ugly.
`
There are quite a few places that make the assumption that the
preirq_data->parent->chip is the right chip to for example call
irq_set_affinity on.

So the simple way to make it all work is to just have
a msi_domain_template->msi_domain_ops->prepare_desc
that sets the desc->dev =3D to the parent device (here the
pci_dev->dev)

At that point everything more or less just works and all the
rest of the callbacks can use generic forms.

Alternative might be to make calls like the one in
arch/x86/kernel/apic/msi.c msi_set_affinity search
for the first ancestor device that has an irq_set_affinity().
That unfortunately may affect quite a few places.

Anyhow, I'll probably send out the prepare_desc hack set with
driver usage etc after I've written up a proper description of problems enc=
ountered
etc so you can see what it all looks like and will be more palatable in
general but in the  meantime this is the guts of it of the variant where the
subdev related desc has the dev set to the parent device.

Note for the avoidance of doubt, I don't much like this
solution but maybe it will grow on me ;)

Jonathan



=46rom eb5761b1cb7b6278c86c836ae552982621c3504e Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 10 Sep 2024 17:10:09 +0100
Subject: [PATCH 1/1] pci: msi: Add subdevice irq domains for dynamic MSI-X

PoC code only. All sorts of missing checks etc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/kernel/apic/msi.c  |  3 ++
 drivers/pci/msi/api.c       | 14 ++++++
 drivers/pci/msi/irqdomain.c | 87 +++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  5 +++
 include/linux/pci.h         |  3 ++
 kernel/irq/msi.c            |  5 +++
 6 files changed, 117 insertions(+)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 340769242dea..8ab4391d4559 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -218,6 +218,9 @@ static bool x86_init_dev_msi_info(struct device *dev, s=
truct irq_domain *domain,
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
 		break;
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/* Currently needed just for the PCI MSI-X subdevice handling */
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..2b4c15102671 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -179,6 +179,20 @@ void pci_msix_free_irq(struct pci_dev *dev, struct msi=
_map map)
 }
 EXPORT_SYMBOL_GPL(pci_msix_free_irq);
=20
+struct msi_map pci_subdev_msix_alloc_irq_at(struct device *dev, unsigned i=
nt index,
+					const struct irq_affinity_desc *affdesc)
+{
+	//missing sanity checks
+	return msi_domain_alloc_irq_at(dev, MSI_DEFAULT_DOMAIN, index, affdesc, N=
ULL);
+}
+EXPORT_SYMBOL_GPL(pci_subdev_msix_alloc_irq_at);
+
+void pci_subdev_msix_free_irq(struct device *dev, struct msi_map map)
+{
+	msi_domain_free_irqs_range(dev, MSI_DEFAULT_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_subdev_msix_free_irq);
+
 /**
  * pci_disable_msix() - Disable MSI-X interrupt mode on device
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 569125726b3e..48357a8054ff 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -444,3 +444,90 @@ struct irq_domain *pci_msi_get_device_domain(struct pc=
i_dev *pdev)
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
+
+static const struct msi_parent_ops pci_msix_parent_ops =3D {
+	.supported_flags =3D MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN,
+	.prefix =3D "PCI-MSIX-PROXY-",
+	.init_dev_msi_info =3D msi_parent_init_dev_msi_info,
+};
+
+int pci_msi_enable_parent_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *msix_dom;
+	/* TGLX: Validate has v2 parent domain */
+	/* TGLX: validate msix enabled */
+	/* TGLX: Validate msix domain supports dynamics msi-x */
+
+	/* Enable PCI device parent domain */
+	msix_dom =3D dev_msi_get_msix_device_domain(&pdev->dev);
+	msix_dom->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	msix_dom->msi_parent_ops =3D &pci_msix_parent_ops;
+	return 0;
+}
+
+void pci_msi_init_subdevice(struct pci_dev *pdev, struct device *dev)
+{
+	dev_set_msi_domain(dev, dev_msi_get_msix_device_domain(&pdev->dev));
+}
+
+static bool pci_subdev_create_device_domain(struct device *dev, const stru=
ct msi_domain_template *tmpl,
+				     unsigned int hwsize)
+{
+	struct irq_domain *domain =3D dev_get_msi_domain(dev);
+
+	if (!domain || !irq_domain_is_msi_parent(domain))
+		return true;
+
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+					    hwsize, NULL, NULL);
+}
+
+static void pci_subdev_msix_prepare_desc(struct irq_domain *domain, msi_al=
loc_info_t *arg,
+					struct msi_desc *desc)
+{
+	struct device *parent =3D desc->dev->parent;
+
+	if (!desc->pci.mask_base) {
+		/* Not elegant - but needed for irq affinity to work? */
+		desc->dev =3D parent;
+		msix_prepare_msi_desc(to_pci_dev(parent), desc);
+	}
+}
+
+static const struct msi_domain_template subdev_template =3D {
+	.chip =3D {
+		.name =3D "SUBDEV",
+		.irq_mask =3D irq_chip_unmask_parent,
+		.irq_unmask =3D irq_chip_unmask_parent,
+		.irq_write_msi_msg =3D pci_msi_domain_write_msg,
+		.irq_set_affinity =3D irq_chip_set_affinity_parent,
+		.flags =3D IRQCHIP_ONESHOT_SAFE,
+	},
+	.ops =3D {
+		/*
+		 * RFC: Sets the desc->dev to the parent PCI device
+		 *       Needed for
+		 *       irq_setup_affinity() ->
+		 *          msi_set_affinity() ->
+		 *             parent =3D irq_d->parent_data;
+		 *             parent->chip->irq_set_affinity() to work.
+		 *      That could be made more flexible perhaps as
+		 *      currently it makes assumption that parent of
+		 *      the MSI device is the one to set the affinity on.
+		 */
+		.prepare_desc =3D pci_subdev_msix_prepare_desc,
+		/* Works because the desc->dev is the parent PCI device */
+		.set_desc =3D pci_msi_domain_set_desc,
+	},
+	.info =3D {
+		.flags =3D MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN |
+		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_USE_DEF_DOM_OPS,
+		.bus_token =3D DOMAIN_BUS_PCI_DEVICE_MSIX,
+	},
+};
+
+bool pci_subdev_setup_device_domain(struct device *dev, unsigned int hwsiz=
e)
+{
+	return pci_subdev_create_device_domain(dev, &subdev_template, hwsize);
+}
+EXPORT_SYMBOL_GPL(pci_subdev_setup_device_domain);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 944979763825..ff81b4dcc1d9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -656,8 +656,13 @@ void pci_msi_unmask_irq(struct irq_data *data);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
+int pci_msi_enable_parent_domain(struct pci_dev *pdev);
+struct irq_domain *pci_msi_get_msix_device_domain(struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *=
pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+struct irq_domain *dev_msi_get_msix_device_domain(struct device *dev);
+void pci_msi_init_subdevice(struct pci_dev *pdev, struct device *dev);
+bool pci_subdev_setup_device_domain(struct device *dev, unsigned int hwsiz=
e);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev =
*pdev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 225de9be3006..460551f1bd6e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1679,6 +1679,9 @@ struct msi_map pci_msix_alloc_irq_at(struct pci_dev *=
dev, unsigned int index,
 				     const struct irq_affinity_desc *affdesc);
 void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
=20
+struct msi_map pci_subdev_msix_alloc_irq_at(struct device *dev, unsigned i=
nt index,
+					const struct irq_affinity_desc *affdesc);
+void pci_subdev_msix_free_irq(struct device *dev, struct msi_map map);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5fa0547ece0c..d55a91c7a496 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1720,3 +1720,8 @@ bool msi_device_has_isolated_msi(struct device *dev)
 	return arch_is_isolated_msi();
 }
 EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
+struct irq_domain *dev_msi_get_msix_device_domain(struct device *dev)
+{
+	return dev->msi.data->__domains[0].domain;
+}
+
--=20
2.43.0



