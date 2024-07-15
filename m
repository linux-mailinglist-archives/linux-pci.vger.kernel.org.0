Return-Path: <linux-pci+bounces-10273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AB93192C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591A01F21E4C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0EF446D1;
	Mon, 15 Jul 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYJdY5gh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0734AED7;
	Mon, 15 Jul 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064235; cv=none; b=DuruGw+tbtuIdzm+vVQX5YSTq35448hLzG1hj2Hr/0Mo2Lgz0+/KADx/jwFTw2vi5Cm7C1qppzvTWC1RXnLCkcnhG9Y05SOPiMU2Huz1XoUJZOk71mKBbf6/ZEUme4uerJR2xCo6PsUkdWnJsmaHTAWLsAKMD+JEduYVJbv/aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064235; c=relaxed/simple;
	bh=3QmAXx2e4bOyJ2G+afG35LYnFILceBE5kmjrVO7hR/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q2ArImwWREpotHJcvbJ31ICq0DBNyLh8UsOTwrRQSJbJDsG1b3SWmnQWKeRtm3aP4x5APwb2pgRqjWCT2mnKIxAL6hUeBk+RgmxFqBIlPq8r6lgTyCGXi/m0XtS9mIHySKajiMU/pg6rm/Fz1q6wIMhCrJdnXCUVIIIJjgD51AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYJdY5gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C64C32782;
	Mon, 15 Jul 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064234;
	bh=3QmAXx2e4bOyJ2G+afG35LYnFILceBE5kmjrVO7hR/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fYJdY5ghdBmaAAkOm81y+sfsv41P/MaKQHgT2a0SUz5Ca+YWAzQigODFx5ClmGLQv
	 dwOa+n7hFy9PIeK6Qp509UzbIQ6FWBgo//G0Bmo2Hf2hEVMNOKseGW7ASgFbVpZ+tf
	 N8BhK4Ne9A6EMjEcQhcisIgCZz9nrAIMpgSErKoW+nJRspWHYdcdajERu9YI3aQqee
	 I/bXZuRrJPPdEwnb3CbZidTLde4fL2D7TTynn7gXG+Kms8VwxHTwo8ZtEiM80WyUU7
	 uvhfLT6Zq0goxcM+DVRd1k8OyKS34S3KOg9nvHmyS67fbyYmqPV/jftRJAfs1jVM9w
	 PH9NLTSovHVGA==
Date: Mon, 15 Jul 2024 12:23:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <20240715172351.GA434759@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d645e3-69ac-170d-bdc2-26bc3c03b890@amd.com>

On Mon, Jul 15, 2024 at 09:20:01AM -0700, Lizhi Hou wrote:
> On 7/15/24 01:07, Amit Machhiwal wrote:
> > With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> > of a PCI device attached to a PCI-bridge causes following kernel Oops on
> > a pseries KVM guest:
> > 
> >   RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
> >   Kernel attempted to read user page (10ec00000048) - exploit attempt? (uid: 0)
> >   BUG: Unable to handle kernel data access on read at 0x10ec00000048
> >   Faulting instruction address: 0xc0000000012d8728
> >   Oops: Kernel access of bad area, sig: 11 [#1]
> >   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> > <snip>
> >   NIP [c0000000012d8728] __of_changeset_entry_invert+0x10/0x1ac
> >   LR [c0000000012da7f0] __of_changeset_revert_entries+0x98/0x180
> >   Call Trace:
> >   [c00000000bcc3970] [c0000000012daa60] of_changeset_revert+0x58/0xd8
> >   [c00000000bcc39c0] [c000000000d0ed78] of_pci_remove_node+0x74/0xb0
> >   [c00000000bcc39f0] [c000000000cdcfe0] pci_stop_bus_device+0xf4/0x138
> >   [c00000000bcc3a30] [c000000000cdd140] pci_stop_and_remove_bus_device_locked+0x34/0x64
> >   [c00000000bcc3a60] [c000000000cf3780] remove_store+0xf0/0x108
> >   [c00000000bcc3ab0] [c000000000e89e04] dev_attr_store+0x34/0x78
> >   [c00000000bcc3ad0] [c0000000007f8dd4] sysfs_kf_write+0x70/0xa4
> >   [c00000000bcc3af0] [c0000000007f7248] kernfs_fop_write_iter+0x1d0/0x2e0
> >   [c00000000bcc3b40] [c0000000006c9b08] vfs_write+0x27c/0x558
> >   [c00000000bcc3bf0] [c0000000006ca168] ksys_write+0x90/0x170
> >   [c00000000bcc3c40] [c000000000033248] system_call_exception+0xf8/0x290
> >   [c00000000bcc3e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > <snip>
> > 
> > A git bisect pointed this regression to be introduced via [1] that added
> > a mechanism to create device tree nodes for parent PCI bridges when a
> > PCI device is hot-plugged.
> > 
> > The Oops is caused when `pci_stop_dev()` tries to remove a non-existing
> > device-tree node associated with the pci_dev that was earlier
> > hot-plugged and was attached under a pci-bridge. The PCI dev header
> > `dev->hdr_type` being 0, results a conditional check done with
> > `pci_is_bridge()` into false. Consequently, a call to
> > `of_pci_make_dev_node()` to create a device node is never made. When at
> > a later point in time, in the device node removal path, a memcpy is
> > attempted in `__of_changeset_entry_invert()`; since the device node was
> > never created, results in an Oops due to kernel read access to a bad
> > address.
> > 
> > To fix this issue, the patch updates `of_changeset_create_node()` to
> > allocate a new node only when the device node doesn't exist and init it
> > in case it does already. Also, introduce `of_pci_free_node()` to be
> > called to only revert and destroy the changeset device node that was
> > created via a call to `of_changeset_create_node()`.
> > 
> > [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Changes since v1:
> >      * Included Lizhi's suggested changes on V1
> >      * Fixed below two warnings from Lizhi's changes and rearranged the cleanup
> >        part a bit in `of_pci_make_dev_node`
> > 	drivers/pci/of.c:611:6: warning: no previous prototype for ‘of_pci_free_node’ [-Wmissing-prototypes]
> > 	  611 | void of_pci_free_node(struct device_node *np)
> > 	      |      ^~~~~~~~~~~~~~~~
> > 	drivers/pci/of.c: In function ‘of_pci_make_dev_node’:
> > 	drivers/pci/of.c:696:1: warning: label ‘out_destroy_cset’ defined but not used [-Wunused-label]
> > 	  696 | out_destroy_cset:
> > 	      | ^~~~~~~~~~~~~~~~
> >      * V1: https://lore.kernel.org/all/20240703141634.2974589-1-amachhiw@linux.ibm.com/
> > 
> >   drivers/of/dynamic.c  | 16 ++++++++++++----
> >   drivers/of/unittest.c |  2 +-
> >   drivers/pci/bus.c     |  3 +--
> >   drivers/pci/of.c      | 39 ++++++++++++++++++++++++++-------------
> >   drivers/pci/pci.h     |  2 ++
> >   include/linux/of.h    |  1 +
> >   6 files changed, 43 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index dda6092e6d3a..9bba5e82a384 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -492,21 +492,29 @@ struct device_node *__of_node_dup(const struct device_node *np,
> >    * a given changeset.
> >    *
> >    * @ocs: Pointer to changeset
> > + * @np: Pointer to device node. If null, allocate a new node. If not, init an
> > + *	existing one.
> >    * @parent: Pointer to parent device node
> >    * @full_name: Node full name
> >    *
> >    * Return: Pointer to the created device node or NULL in case of an error.
> >    */
> >   struct device_node *of_changeset_create_node(struct of_changeset *ocs,
> > +					     struct device_node *np,
> >   					     struct device_node *parent,
> >   					     const char *full_name)
> >   {
> > -	struct device_node *np;
> >   	int ret;
> > -	np = __of_node_dup(NULL, full_name);
> > -	if (!np)
> > -		return NULL;
> > +	if (!np) {
> > +		np = __of_node_dup(NULL, full_name);
> > +		if (!np)
> > +			return NULL;
> > +	} else {
> > +		of_node_set_flag(np, OF_DYNAMIC);
> > +		of_node_set_flag(np, OF_DETACHED);
> > +	}
> > +
> >   	np->parent = parent;
> >   	ret = of_changeset_attach_node(ocs, np);
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 445ad13dab98..b1bcc9ed40a6 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -871,7 +871,7 @@ static void __init of_unittest_changeset(void)
> >   	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop prop-add\n");
> >   	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
> >   	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
> > -	n22 = of_changeset_create_node(&chgset, n2, "n22");
> > +	n22 = of_changeset_create_node(&chgset, NULL,  n2, "n22");
> >   	unittest(n22, "fail create n22\n");
> >   	unittest(!of_changeset_add_prop_string(&chgset, n22, "prop-str", "abcd"),
> >   		 "fail add prop prop-str");
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 826b5016a101..d7ca20cb146a 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -342,8 +342,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >   	 */
> >   	pcibios_bus_add_device(dev);
> >   	pci_fixup_device(pci_fixup_final, dev);
> > -	if (pci_is_bridge(dev))
> > -		of_pci_make_dev_node(dev);
> > +	of_pci_make_dev_node(dev);
> 
> Please undo this change. It should only create the device node for bridges
> and the pci endpoints listed in quirks for now.

IIUC, you want Amit to post a v3 of this patch that omits this
specific pci_bus_add_device() change?

> >   	pci_create_sysfs_dev_files(dev);
> >   	pci_proc_attach_device(dev);
> >   	pci_bridge_d3_update(dev);
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 51e3dd0ea5ab..883bf15211a5 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -608,18 +608,28 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >   #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> > +void of_pci_free_node(struct device_node *np)
> > +{
> > +	struct of_changeset *cset;
> > +
> > +	cset = (struct of_changeset *)(np + 1);
> > +
> > +	np->data = NULL;
> > +	of_changeset_revert(cset);
> > +	of_changeset_destroy(cset);
> > +	of_node_put(np);
> > +}
> > +
> >   void of_pci_remove_node(struct pci_dev *pdev)
> >   {
> >   	struct device_node *np;
> >   	np = pci_device_to_OF_node(pdev);
> > -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +	if (!np || np->data != of_pci_free_node)
> >   		return;
> >   	pdev->dev.of_node = NULL;
> > -	of_changeset_revert(np->data);
> > -	of_changeset_destroy(np->data);
> > -	of_node_put(np);
> > +	of_pci_free_node(np);
> >   }
> >   void of_pci_make_dev_node(struct pci_dev *pdev)
> > @@ -655,14 +665,18 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >   	if (!name)
> >   		return;
> > -	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
> > -	if (!cset)
> > +	np = kzalloc(sizeof(*np) + sizeof(*cset), GFP_KERNEL);
> > +	if (!np)
> >   		goto out_free_name;
> > +	np->full_name = name;
> > +	of_node_init(np);
> > +
> > +	cset = (struct of_changeset *)(np + 1);
> >   	of_changeset_init(cset);
> > -	np = of_changeset_create_node(cset, ppnode, name);
> > +	np = of_changeset_create_node(cset, np, ppnode, NULL);
> >   	if (!np)
> > -		goto out_destroy_cset;
> > +		goto out_free_node;
> >   	ret = of_pci_add_properties(pdev, cset, np);
> >   	if (ret)
> > @@ -670,19 +684,18 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >   	ret = of_changeset_apply(cset);
> >   	if (ret)
> > -		goto out_free_node;
> > +		goto out_destroy_cset;
> > -	np->data = cset;
> > +	np->data = of_pci_free_node;
> >   	pdev->dev.of_node = np;
> > -	kfree(name);
> >   	return;
> > -out_free_node:
> > -	of_node_put(np);
> >   out_destroy_cset:
> >   	of_changeset_destroy(cset);
> >   	kfree(cset);
> > +out_free_node:
> > +	of_node_put(np);
> >   out_free_name:
> >   	kfree(name);
> >   }
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index fd44565c4756..7b1a455306b8 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -702,11 +702,13 @@ struct of_changeset;
> >   #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
> >   void of_pci_make_dev_node(struct pci_dev *pdev);
> > +void of_pci_free_node(struct device_node *np);
> >   void of_pci_remove_node(struct pci_dev *pdev);
> >   int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
> >   			  struct device_node *np);
> >   #else
> >   static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
> > +static inline void of_pci_free_node(struct device_node *np) { }
> >   static inline void of_pci_remove_node(struct pci_dev *pdev) { }
> >   #endif
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index a0bedd038a05..f774459d0d84 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -1631,6 +1631,7 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
> >   }
> >   struct device_node *of_changeset_create_node(struct of_changeset *ocs,
> > +					     struct device_node *np,
> >   					     struct device_node *parent,
> >   					     const char *full_name);
> >   int of_changeset_add_prop_string(struct of_changeset *ocs,
> > 
> > base-commit: 43db1e03c086ed20cc75808d3f45e780ec4ca26e

