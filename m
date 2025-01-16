Return-Path: <linux-pci+bounces-20024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD22A1464C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 00:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2A3A730C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E7252CBF;
	Thu, 16 Jan 2025 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp95TFTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685E252CA6;
	Thu, 16 Jan 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070158; cv=none; b=pjRLqZeKtZpq4toSxZxslcbafIq3zs/Y8NCXSqV18suClP16qvRmeMK5qGcszGzWMUOPWW1K1bZJ4KLyDTtJfU9VGr/IYYlfqZaOk07TN8FhuCT6iEAzCs+U0v/AbzPOBKAkmxm6xNxvG3KtvYXFPnig2C25eUhAt7qIZbGky3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070158; c=relaxed/simple;
	bh=dMwwqya1n7mouM0thH4tLEBVCAjWJzbR4JIYV6x+c8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M7XGuc0I2z+f2JAEO6NM6UYQbA9vhqVFwZ+SALf+JTLUgOb1Bok2VPmJQAR3/EgMGtMYp105Rj51Krytj1LRLUDJIrEuF0QdRVK6cOg65K1jC7eSkE5lxOJZq1vZ/aAdekBliR6Gv+Im+BeiHPfqMP7eNAYRF22Y6Xda8vPA5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp95TFTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D40C4CED6;
	Thu, 16 Jan 2025 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737070157;
	bh=dMwwqya1n7mouM0thH4tLEBVCAjWJzbR4JIYV6x+c8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cp95TFTojT43ishZ8WQ4Mwsx3PoDWTZzdjzqZ2MTjofA4fLE8O8H2NZi0DrJToqfR
	 EN9p7UiHkjHhzTnEX/Nnfw+Cdxgdj/equtDNoIPcUVHou6MH8M6OCgjFKCjv+HGZwp
	 IC37Tez0mu7Tp2y+CJAlmCj4QkXPrCmdP4CEtIKKc0En35zUsz+1iuISun5r2YKuNS
	 xmEpPjEcmg9u+Y25j6aMDWqbPqIC5nVLoe7a2/zMsu6AmzR2eZeTWLJ18iDQAeUt8s
	 Qop6AaZZcCjRAJADxFbga5cNKEgIFrVBd0C5IEt1BxzWQFNGeeW+QfYjM6iTVNvmM0
	 QoTEoKHRcE27A==
Date: Thu, 16 Jan 2025 17:29:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250116232916.GA617353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116231358.GA616783@bhelgaas>

On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > parent_bus_addr in struct of_range can indicate address information just
> > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > map. See below diagram:
> > 
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> > 
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > 
> > 	pcie@5f010000 {
> > 		compatible = "fsl,imx8q-pcie";
> > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > 		reg-names = "dbi", "config";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 		device_type = "pci";
> > 		bus-range = <0x00 0xff>;
> > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> > 
> > Term internal address (IA) here means the address just before PCIe
> > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > be removed.
> 
> > @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  
> >  		atu.index = i;
> >  		atu.type = PCIE_ATU_TYPE_MEM;
> > -		atu.cpu_addr = entry->res->start;
> > +		parent_bus_addr = entry->res->start;
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >  
> > +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> > +		if (ret)
> > +			return ret;
> > +
> > +		atu.cpu_addr = parent_bus_addr;
> 
> Here you set atu.cpu_addr to the intermediate bus address instead
> of the CPU physical address before calling
> dw_pcie_prog_outbound_atu().
> 
> But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
> all of them need to use the intermediate bus address?

Somehow I expected the patch to skip calling ->cpu_addr_fixup() if the
driver had set 'use_parent_dt_ranges'.  In fact, I think that's a
requirement.

Since dw_pcie_prog_outbound_atu() is the only dwc caller, maybe the
parent_bus_addr change should go *there* instead of in the callers?

Bjorn

