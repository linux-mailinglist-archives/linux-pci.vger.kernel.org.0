Return-Path: <linux-pci+bounces-33891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1FFB23C29
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D5E6E47C9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC02E401;
	Tue, 12 Aug 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKEkzqTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CF208CA;
	Tue, 12 Aug 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039674; cv=none; b=qXUFTZnUzEQ9K1JYcNKMVLOcZ5c/WBmz7hk+1rMY+uqFIdRZdJ/2n+KJHTfxUAICchddILye69CFHI4oHWUNPiz+eoJO6X+v0Why/4L2ecXeQKG8hjEd/Cq5ustNMfzMGHyGIp0sS/Gftbykys+nRcwhIneQIGCPbbF9DELSKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039674; c=relaxed/simple;
	bh=fyIoJvtI8A7FcfvrBxgqARccMQCph7ooMA2iQKEgbwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SOvzkNVSWPJ/HwUdz8jZ5666y9oNKtc1USKKMMTGTjYCnvbVSdSU85tJNQiwyv6oW6U7bDmGJc9Zn1t+CFWByPM0boVAWA0ovn/F9+2ZlzarXZhrbFt7m4Bjvt5jDX2lwlVEy6rG6QpQKpRX4n1iAHubboMGDeuvpMAaE2VuuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKEkzqTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19EC4CEF1;
	Tue, 12 Aug 2025 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755039673;
	bh=fyIoJvtI8A7FcfvrBxgqARccMQCph7ooMA2iQKEgbwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jKEkzqTSnP5vQnMh2MQGsDWEx3tTFsnl7CsLNWphQ/6MduONMP3yWiFFAM6C+KEmR
	 ENucYmDo4CUmDedYcx/vgExl7tIScNBK2ON80Hq7lKsWQnyzYHO9GsFVLKKpBchA8c
	 DtiNctisHlc8evUEBAUQpHYQX8ULMTUdk+tJOKCloaREhU8MaNPNyMjP5QcgfZIA6B
	 gRI6bmyqGOrbQGTOlXT/idFfIaIfBg1PA3GwBrrM3y8TYEe3S1nAQEBlkAHLaMYt55
	 UNNI0R403Rf1qEkjq7UAPsgZO/JJxlAo9ACTD8fiPNwdAmdCdrSMWtD1ddTui05gAn
	 NhXeWVsMtfKNQ==
Date: Tue, 12 Aug 2025 18:01:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250812230112.GA202387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812194113.GA199940@bhelgaas>

On Tue, Aug 12, 2025 at 02:41:15PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 07, 2025 at 01:10:19PM +0530, Sai Krishna Musham wrote:
> > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > reset GPIO. If the bridge node is not found, fall back to acquiring it
> > from the PCIe host bridge node.
> > 
> > As part of this, update the interrupt controller node parsing to use
> > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > host bridge node now has multiple children. This ensures the correct
> > node is selected during initialization.
> ...

> >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> >   * @intx_domain: INTx IRQ domain pointer
> >   * @mdb_domain: MDB IRQ domain pointer
> > + * @perst_gpio: GPIO descriptor for PERST# signal handling
> >   * @intx_irq: INTx IRQ interrupt number
> >   */
> >  struct amd_mdb_pcie {
> > @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
> >  	void __iomem			*slcr;
> >  	struct irq_domain		*intx_domain;
> >  	struct irq_domain		*mdb_domain;
> > +	struct gpio_desc		*perst_gpio;
> >  	int				intx_irq;
> >  };
> >  
> > @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
> >  	struct device_node *pcie_intc_node;
> >  	int err;
> >  
> > -	pcie_intc_node = of_get_next_child(node, NULL);
> > +	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
> >  	if (!pcie_intc_node) {
> >  		dev_err(dev, "No PCIe Intc node found\n");
> >  		return -ENODEV;
> > @@ -402,6 +405,28 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> >  	return 0;
> >  }
> >  
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +	struct device *dev = pcie->pci.dev;
> > +	struct device_node *pcie_port_node __maybe_unused;
> > +
> > +	/*
> > +	 * This platform currently supports only one Root Port, so the loop
> > +	 * will execute only once.
> > +	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
> > +	 */
> > +	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie") {
> 
> This is only the second user of for_each_child_of_node_with_prefix()
> in the whole tree.  Also the only use of "__maybe_unused" in
> drivers/pci/controller/.
> 
> Most of the PCI controller drivers use
> for_each_available_child_of_node_scoped(); can we do the same here?

I suppose you used for_each_child_of_node_with_prefix() because, as
you mentioned in the commit log, there may be multiple children
(interrupt controller and Root Port(s))?

I think of_irq_parse_and_map_pci() takes care of much of the INTx
setup based on interrupt-map, so many drivers don't contain any
explicit INTx stuff.  But amd-mdb must be an exception for some
reason.

Most bindings don't include an interrupt-controller child in the pcie@
stanza.  I don't know enough about device tree to understand why
amd-mdb needs it.

Bjorn

