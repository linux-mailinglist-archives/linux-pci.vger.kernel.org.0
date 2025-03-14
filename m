Return-Path: <linux-pci+bounces-23785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927EA61FF4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C4C1896AE2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C01A317D;
	Fri, 14 Mar 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RigElek/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BF262BE;
	Fri, 14 Mar 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990262; cv=none; b=Z+TsoJ4vsRjBN/NWQ+713AyxBxlChs9x6NKOcoO3GIBjRom1fSiDZstyo0Hyi3IK4wwOpM7ePI6P8UR+Cf47WP8+O0W6zHv5WjDe3ndledei9ESLSfvsm8L+m1Tzr1iGnc74SWL01LOeg+FK7wTSZBJHXEDrTiRJa9ZGyDVlF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990262; c=relaxed/simple;
	bh=Xh+a/XWN8QqEqM2NFk/G96MrvApikJtNFQXq2WvNhb8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cLo1cNrRXYtBRLEu35rsBdUJAg5DbendZNBzaUXjJj7zw4zsH2uLQk1XmxriKOpEA2dWg+C9LOa3aeVCaMPimCn5fN5vfHkawyJs0m+spbCeKYxlgJJ5k+uX8lXtRAGrHYWn+6qZdAesOKo0NTvdtfJX0ZU04gXpbZmXk7qFyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RigElek/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C284C4CEE3;
	Fri, 14 Mar 2025 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741990261;
	bh=Xh+a/XWN8QqEqM2NFk/G96MrvApikJtNFQXq2WvNhb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RigElek/U3wRrB77G3Pwmz/aC+2T3zPaqblr1Wdc0E+Mqfh7tLm5lWd7p4TJBrmky
	 6SEIBUxpkUx4lhrMLJF9TI+A7hw2HTpoY9X2V2Hh1L9Dd2dxey7hB8zvbUC5uVfzfi
	 T+1uHluADbGjDq/lZ4oqp88t3lhGah/errOo/VqSl8R1t6VUFy7cMM4CZ3mMqKkDlk
	 qeR88q1vl2L1gUuEvnbuzv3DWo4BUx7g0vahg9CMg4Xkged4jxUJLOu5Tg/uUAM89n
	 Fup2of443Y97ocD/AuSp4QcJ8wLYgiDRZHaUYS26c8HnJyGXwgPbwovYSCI3uED1i7
	 TMQcQFEY6CrmQ==
Date: Fri, 14 Mar 2025 17:10:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <20250314221059.GA806127@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9RJbyoFdkiYHXu9@lizhi-Precision-Tower-5810>

On Fri, Mar 14, 2025 at 11:21:19AM -0400, Frank Li wrote:
> On Thu, Mar 13, 2025 at 06:56:17PM -0400, Frank Li wrote:
> > On Thu, Mar 13, 2025 at 05:04:50PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Mar 13, 2025 at 11:38:42AM -0400, Frank Li wrote:
> > > > The 'ranges' property at PCI controller parent bus can indicate address
> > > > translation information. Most system's bus fabric use 1:1 map between input
> > > > and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.
> > >
> > > I think you've used reg["addr_space"] to get the offset for Endpoints
> > > forever.
> >
> > Yes, it still need ranges informaiton at parent bus.
> >
> > 	bus@000
> > 	{
> > 		ranges = <...>; [1] /* still need this */
> > 		pcie {
> > 			ranges = <...>;[2]
> > 		};
> > 		pcie-ep {};
> > 	}

Yes, of course. I'm just making the point that the subject/commit log
says this patch uses 'ranges' but in fact it uses 'reg'.

> > > I just noticed that through v9, you used 'ranges' to get the offset
> > > for the Root Complex (with "Add parent_bus_offset to resource_entry"),
> > > and I think v10 switched to use reg["config"] instead.
> > >
> > > I think I originally proposed the idea of "Add parent_bus_offset to
> > > resource_entry" patch, but I think it turned out to be kind of an ugly
> > > approach.
> > >
> > > Anyway, IIUC this v11 patch actually uses reg["config"] to compute the
> > > offset, not 'ranges', so we should probably update the subject and
> > > commit log to reflect that, and maybe remove the now-unused bits of
> > > the devicetree example.
> >
> > We use reg["config"] to detect offset, but still need parent dts's ranges.
> > There are two ranges, one is at parent pci bus [1], the other is under
> > 'pci bus' [2].
> 
> Beside, luckly dwc use reg["config"] to indicate config space. but dt also
> define ranges [2] under pcie node, which can also include 'config's space.
> 
> cadence also use reg["cfg"] to do that.
> res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> 
> I am not sure why both choose use reg[] instead of [2]ranges under
> pcie node. But the result make our situation simpler.
> 
> > Although use reg["config"], but still need ranges [1]. And information at
> > ranges [2] also need be correct.
> >
> > The whole devicetree example also validate to help write address translate
> > informaiton.
> >
> > > I do worry a little bit about the assumption that the offset of
> > > reg["config"] is the same as the offset of the other pieces.  The main
> > > place we use the offset on RCs is for the ATU, and isn't the ATU in
> > > the MemSpace area at 0x8000_0000 below?
> >
> > No, "Bus fabric" only decode input address from "0x7000_0000..UPLIMIT".
> > Then output address to 0x8000_0000..UPLIMIT. So below 0x8000_0000 never
> > happen.

Minor miscommunication, I think.   I didn't mean there were addresses
smaller than 0x8000_0000; I meant that in the picture, MemSpace at
0x8000_0000 is below CfgSpace at 0x8ff0_0000.  The important point is
that CfgSpace is a separate region from MemSpace, and we're applying
the CfgSpace offset to the ATU in MemSpace.

I think it's OK to assume that for now.  AFAICS there is nothing in
devicetree that explicitly mentions the ATU input address space; it's
just implicitly part of the intermediate address space described by
the bus@5f000000 'ranges'.

> > > It's great that in this case the 0x7ff0_0000 to 0x8ff0_0000 "config"
> > > offset is the same as the 0x7000_0000 to 0x8000_0000 MemSpace offset,
> > > but I don't know that this is guaranteed for all designs.
> >
> > So far, it is the same for use dwc chips. If we meet difference, we can
> > add later.
> >
> > reg["config"] only simplied our implement base on the offset is the same.
> > But whole concept is unchanged.

> > > > See below diagram:
> > > >
> > > >             ┌─────────┐                    ┌────────────┐
> > > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > > >             │      │  │             │   │  │            │   PCI Addr
> > > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > > >             │         │             │      │            │    0
> > > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > > >              BUS Fabric         │          │            │    0
> > > >                                 │          │            │
> > > >                                 └──────────► MemSpace  ─┼────────────►
> > > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > > >                                            └────────────┘
> > > >
> > > > bus@5f000000 {
> > > > 	compatible = "simple-bus";
> > > > 	#address-cells = <1>;
> > > > 	#size-cells = <1>;
> > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > >
> > > > 	pcie@5f010000 {
> > > > 		compatible = "fsl,imx8q-pcie";
> > > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > > 		reg-names = "dbi", "config";

> > > > 		#address-cells = <3>;
> > > > 		#size-cells = <2>;
> > > > 		device_type = "pci";
> > > > 		bus-range = <0x00 0xff>;
> > > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;

Of course we need this 'ranges' to describe the translation between
intermediate addresses and PCI bus addresses.  My point is that this
is not relevant to the parent bus offset we're computing in this
patch.

So I think for purposes of this patch, we can omit pcie@5f010000
#address-cells and everything after it.

Bjorn

