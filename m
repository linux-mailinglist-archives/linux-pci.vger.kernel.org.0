Return-Path: <linux-pci+bounces-35455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDDB44001
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B13A04746
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B0205E25;
	Thu,  4 Sep 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt2a7Vh9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF9C8F0
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998588; cv=none; b=P5HVMJi7eLtMFo0J29vvX/Ga2QL/hmiBsxIH/UvW9nOg9P9+hj5g0UvWz+GFQk57SztDg9Rh7hhUIryL5PEesUtRhr4Mn0uCM2qXyNeHcf2oynu2fzpmNNKd+/YpUlhEn05qeC3tUczpTF/j6TQ0gjRNmlmXhC8RGtlCM1muck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998588; c=relaxed/simple;
	bh=PLDQPQbJUUggbx4A+lxi4mlI5cau9Im7SIvtDQOngi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DDSXqOYdTcAfPydP+dk2r0wZXiqMbtx6DfqBIqqV0mMIZpSRR5j0PM4mLQkXm8ip1GcgeXBfcIeHGWGGsg2i24M8OiRLxbKqhLMZx1hAfRWgXSxvKjgvde0iwcx24xZ0FeCwhrzl6LQVjRddqmGDynyCA1bToxROcEHdrA0avF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt2a7Vh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05C6C4CEF0;
	Thu,  4 Sep 2025 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998587;
	bh=PLDQPQbJUUggbx4A+lxi4mlI5cau9Im7SIvtDQOngi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yt2a7Vh9WwZr6Kk9GlSPB3iYnUjz9Z4rbp583WTcVYwWlo726mIvj42kZPVV6T83j
	 SC2DpNZfSX+WQs/U1dP6ZolD838uZPNHFMGAHG7H8QM63G08Bgjn0Jii9LWw0bGVhG
	 Mu0iskxKyg/EldYyp7cCmVYq2vsASGEDX+d+NkG+JjDaRZ3q6j0ZDTWsXOpRLmP0Ya
	 V455s0I/MJ3Lm3op+m+fFtz5nkCP/A3ZedrygQ6uw+H2Ra+qWsMNa231jQwi91JHV2
	 VwHsGVxxRQz/B5WVdjSEQLVSHrLKS//6aQewvDRbrVunGIxhXifIPmw3dnhGzKmqdC
	 I9WhLUONVtpeg==
Date: Thu, 4 Sep 2025 10:09:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>,
	Terry Bowman <terry.bowman@amd.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] PCI/AER: Print TLP Log for errors introduced since PCIe
 r1.1
Message-ID: <20250904150945.GA1262642@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLkuvb5v4LuVJuyU@wunner.de>

On Thu, Sep 04, 2025 at 08:16:29AM +0200, Lukas Wunner wrote:
> On Mon, Sep 01, 2025 at 09:44:52AM +0200, Lukas Wunner wrote:
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -776,6 +776,13 @@
> >  #define  PCI_ERR_UNC_MCBTLP	0x00800000	/* MC blocked TLP */
> >  #define  PCI_ERR_UNC_ATOMEG	0x01000000	/* Atomic egress blocked */
> >  #define  PCI_ERR_UNC_TLPPRE	0x02000000	/* TLP prefix blocked */
> > +#define  PCI_ERR_UNC_POISON_BLK	0x04000000	/* Poisoned TLP Egress Blocked */
> > +#define  PCI_ERR_UNC_DMWR_BLK	0x08000000	/* DMWr Request Egress Blocked */
> > +#define  PCI_ERR_UNC_IDE_CHECK	0x10000000	/* IDE Check Failed */
> > +#define  PCI_ERR_UNC_MISR_IDE	0x20000000	/* Misrouted IDE TLP */
> > +#define  PCI_ERR_UNC_PCRC_CHECK	0x40000000	/* PCRC Check Failed */
> > +#define  PCI_ERR_UNC_XLAT_BLK	0x80000000	/* TLP Translation Egress Blocked */
> > +
> >  #define PCI_ERR_UNCOR_MASK	0x08	/* Uncorrectable Error Mask */
> >  	/* Same bits as above */
> 
> I've realized that I inadvertently introduced a gratuitous blank line here.
> Bjorn, you may want to remove that from commit dab104c81cba on pci/aer.
> My apologies for the inconvenience!

No problem, fixed!

