Return-Path: <linux-pci+bounces-35735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2EB4A4D7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE5A5416B5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD82472BA;
	Tue,  9 Sep 2025 08:15:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD42459DC
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405701; cv=none; b=YjApSUJSlRMIbsw8FdNDrsa7t5+VMIjBvwXy29jUP3kDIlx2MPnv47On91YVRkzxOov11MkP0IsEXiT7564qqVVnFZIrc1Uf4xNnHMuLNGKsJdzmadq22K0hyPdK+kf6NA4GfEWG6g5lBK2Uou4q78P1IxpK+wTF+rTmB/gk9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405701; c=relaxed/simple;
	bh=mUpojkUNgwVP2t3wHzIErAx6gB5xojU+UmuhrBljuHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh+UD/DDZJw4VtcrtdMnz4+mUZtxj7rZ5C1kjWkMO9thbqqSyAqblpSe8NvoTvOFkJgNFuAznNm/Rov5Z+GSL+EoetaMpIGQf51yyg2jIyXLzboCyPSwFa6I2nFdkg8KI6DYV0K6e75Dx0ZF4dtUaokw9++Kwdr7osexxpHj9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5898EmlE076748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 16:14:48 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Sep 2025 16:14:48 +0800
Date: Tue, 9 Sep 2025 16:14:48 +0800
From: Randolph Lin <randolph@andestech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <ben717@andestech.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 5/6] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <aL_h-HnA8Dtb0G15@swlinux02>
References: <aLF0-0u38hKC7JcP@atctrx.andestech.com>
 <20250908220737.GA1467566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908220737.GA1467566@bhelgaas>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5898EmlE076748

Hi Bjorn and Frank,

On Mon, Sep 08, 2025 at 05:07:37PM -0500, Bjorn Helgaas wrote:
> [EXTERNAL MAIL]
> 
> [+cc Frank, who can probably answer faster than I can]
> 
> On Fri, Aug 29, 2025 at 05:41:17PM +0800, Randolph Lin wrote:
> > Rn Wed, Aug 20, 2025 at 10:54:44AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 20, 2025 at 07:18:42PM +0800, Randolph Lin wrote:
> > > > Add driver support for DesignWare based PCIe controller in Andes
> > > > QiLai SoC. The driver only supports the Root Complex mode.
> 
> > > > +#define PCIE_LOGIC_COHERENCY_CONTROL3                0x8e8
> > > > +/* Write-Back, Read and Write Allocate */
> > > > +#define IOCP_ARCACHE                         0xf
> > > > +/* Write-Back, Read and Write Allocate */
> > > > +#define IOCP_AWCACHE                         0xf
> > >
> > > Are IOCP_ARCACHE and IOCP_AWCACHE supposed to be identical values with
> > > identical comments?
> 
> Just pointing this out since you didn't respond to it.
> 

Sorry, I originally intended to add a comment in the V2 patch.

The following shows the modified version:
/*
 * Refer to Table A4-5 (Memory type encoding) in the
 * AMBA AXI and ACE Protocol Specification.
 * The selected value corresponds to the Memory type field:
 * "Write-back, Read and Write-allocate".
 */
#define IOCP_ARCACHE				0b1111
#define IOCP_AWCACHE				0b1111


Refer to the AMBA AXI and ACE Protocol Specification.
The last three rows in the table A4-5:
ARCACHE         AWCACHE         Memory type
1111 (0111)     0111            Write-back Read-allocate
1011            1111 (1011)     Write-back Write-allocate
1111            1111            Write-back Read and Write-allocate

I know that the following are meaningless.
1. Read-allocate in AWCACHE 
2. Write-allocate in ARCACHE
However, I want to set it up as "Write-back, Read and Write-allocate";
therefore, it seems they have the same comment.

> > > > +static u64 qilai_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > > > +{
> > > > +     struct dw_pcie_rp *pp = &pci->pp;
> > > > +
> > > > +     return cpu_addr - pp->cfg0_base;
> > >
> > > Sorry, we can't do this.  We're removing .cpu_addr_fixup() because
> > > it's a workaround for defects in the DT description.  See these
> > > commits, for example:
> > >
> > >     befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
> > >     b9812179f601 ("PCI: imx6: Remove imx_pcie_cpu_addr_fixup()")
> > >     07ae413e169d ("PCI: intel-gw: Remove intel_pcie_cpu_addr()")
> >
> > I’m a bit confused about the following question:
> > After removing cpu_addr_fixup, should we use pci->parent_bus_offset
> > to store the offset value, or should pci->parent_bus_offset remain
> > 0?
> 
> If you needed qilai_pcie_cpu_addr_fixup(), I would expect your
> dw_pcie.parent_bus_offset to be non-zero because parent_bus_offset is
> used instead of ->cpu_addr_fixup().
> 

In this SoC, the dw_pcie.parent_bus_offset should be set to the value of the
config register base address. Setting the dw_pcie.parent_bus_offset to a
non-zero value seems to occur only in the path that uses ->cpu_addr_fixup().

The parent_bus_offset is generally used instead of ->cpu_addr_fixup() throughout
most of the code, but its assignment still seems to rely on ->cpu_addr_fixup()
when it needs to be set to a non-zero value.
If no other method exists to set up dw_pcie.parent_bus_offset, can we keep using
->cpu_addr_fixup() for the assignment?

> > In the commit message:
> > befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
> >     We know the parent_bus_offset, either computed from a DT reg
> >     property (the offset is the CPU physical addr - the
> >     'config'/'addr_space' address on the parent bus) or from a
> >     .cpu_addr_fixup() (which may have used a host bridge window
> >     offset).
> >
> > We know that "the offset is the CPU physical addr - the
> > 'config'/'addr_space' address on the parent bus".
> >
> > However, in dw_pcie_host_get_resources(), it passes pp->cfg0_base,
> > which is parsed from the device tree using "config", as the
> > cpu_phys_addr parameter to dw_pcie_parent_bus_offset(). It also
> > passes "config" as the 2nd parameter to dw_pcie_parent_bus_offset().
> >
> > In dw_pcie_parent_bus_offset(), the 2nd parameter is used to get the
> > index from the devicetree "reg-names" field, and the result is used
> > as the 'config'/'addr_space' address.
> >
> > It seems that the same value is being obtained through a different
> > method, and the return value appears to be 0.  Could I be
> > misunderstanding something?
> 

Sincerely,
Randolph

