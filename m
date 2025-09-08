Return-Path: <linux-pci+bounces-35706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B7B49CB7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 00:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3824E430C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6E2E8B85;
	Mon,  8 Sep 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGz0Dg9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B42E2DD4
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369259; cv=none; b=LGUn+H39PtcuderZQBtTugFC1G/DFCWNCp3nmqsXv8JMOB1bSjwr1tFJ2PO5o+EIR6G4I0yioGG/jbiN+wP0hNu61I2H81USr5WYENm7wgcZlFBX4FkQSGCb/umoOhfFrMEL2dWalQbu90lXgIdqht4GTUHrj82+R+5wwHHUCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369259; c=relaxed/simple;
	bh=7bvSe7ulLAuGZevWaXonyuZcvvFtIJwxZvZvkEJcefE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bX2zGXGPJYnd34u3HfwvZSvMlm+KDHRASKJvO07n9A2CpVqXNJ4QFS0FZQZRY/uhoDnChuYoRP6WpQOru+rsjQAucI03bqXuY3A/6Gw+VjWm8/f7+PJYk2h9MN7auBzYo0OIbFegH1M5HEC/FjL93qobaRqQlMaUZvVlXeO8JeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGz0Dg9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C4DC4CEF1;
	Mon,  8 Sep 2025 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757369258;
	bh=7bvSe7ulLAuGZevWaXonyuZcvvFtIJwxZvZvkEJcefE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MGz0Dg9n+tla1tpADin4+OfT/J4BKEAFXFjJWevNq24Qor06HXP+lnZDvgnL4V47k
	 UK1eok5i8tssLT5Hp16uoDfomxYjLoIOlsVpGAVUwNRn+of9Zaw1q+oeTM/HvVk7SU
	 n4UV1pkmx3cW7ct7n81F+kvPU6mx2YYcttyLHw8mhTVmZkVsJNxTKZQ17t80obR1UZ
	 2kDKAo/3s157SlEB/C70CnvNkSWkUuMi9ognGRvggHHWM3kPXv+yjJ/DiTQK/7HwfF
	 ugEOYqJ8D/wBKG4x8lJwPhJcvpGuvUtOlo63DmKfkILljev8cgZIQjTurF/nm0L2Sd
	 1N/j9Dc+0cidA==
Date: Mon, 8 Sep 2025 17:07:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-pci@vger.kernel.org, ben717@andestech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	randolph.sklin@gmail.com, tim609@andestech.com,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 5/6] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <20250908220737.GA1467566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLF0-0u38hKC7JcP@atctrx.andestech.com>

[+cc Frank, who can probably answer faster than I can]

On Fri, Aug 29, 2025 at 05:41:17PM +0800, Randolph Lin wrote:
> Rn Wed, Aug 20, 2025 at 10:54:44AM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 20, 2025 at 07:18:42PM +0800, Randolph Lin wrote:
> > > Add driver support for DesignWare based PCIe controller in Andes
> > > QiLai SoC. The driver only supports the Root Complex mode.

> > > +#define PCIE_LOGIC_COHERENCY_CONTROL3                0x8e8
> > > +/* Write-Back, Read and Write Allocate */
> > > +#define IOCP_ARCACHE                         0xf
> > > +/* Write-Back, Read and Write Allocate */
> > > +#define IOCP_AWCACHE                         0xf
> > 
> > Are IOCP_ARCACHE and IOCP_AWCACHE supposed to be identical values with
> > identical comments?

Just pointing this out since you didn't respond to it.

> > > +static u64 qilai_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > > +{
> > > +     struct dw_pcie_rp *pp = &pci->pp;
> > > +
> > > +     return cpu_addr - pp->cfg0_base;
> > 
> > Sorry, we can't do this.  We're removing .cpu_addr_fixup() because
> > it's a workaround for defects in the DT description.  See these
> > commits, for example:
> > 
> >     befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
> >     b9812179f601 ("PCI: imx6: Remove imx_pcie_cpu_addr_fixup()")
> >     07ae413e169d ("PCI: intel-gw: Remove intel_pcie_cpu_addr()")
> 
> I’m a bit confused about the following question:
> After removing cpu_addr_fixup, should we use pci->parent_bus_offset
> to store the offset value, or should pci->parent_bus_offset remain
> 0?

If you needed qilai_pcie_cpu_addr_fixup(), I would expect your
dw_pcie.parent_bus_offset to be non-zero because parent_bus_offset is
used instead of ->cpu_addr_fixup().

> In the commit message:
> befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
>     We know the parent_bus_offset, either computed from a DT reg
>     property (the offset is the CPU physical addr - the
>     'config'/'addr_space' address on the parent bus) or from a
>     .cpu_addr_fixup() (which may have used a host bridge window
>     offset).
> 
> We know that "the offset is the CPU physical addr - the
> 'config'/'addr_space' address on the parent bus".
> 
> However, in dw_pcie_host_get_resources(), it passes pp->cfg0_base,
> which is parsed from the device tree using "config", as the
> cpu_phys_addr parameter to dw_pcie_parent_bus_offset(). It also
> passes "config" as the 2nd parameter to dw_pcie_parent_bus_offset().
> 
> In dw_pcie_parent_bus_offset(), the 2nd parameter is used to get the
> index from the devicetree "reg-names" field, and the result is used
> as the 'config'/'addr_space' address. 
> 
> It seems that the same value is being obtained through a different
> method, and the return value appears to be 0.  Could I be
> misunderstanding something?


