Return-Path: <linux-pci+bounces-11505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4609194C391
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB70B2110E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B2190489;
	Thu,  8 Aug 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA0ofsIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8D189B8D;
	Thu,  8 Aug 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137745; cv=none; b=ELiawt2/qm1ZgZ/CTpSWNaOcpd6G9wzCrimnK8Yg/Q9CCIzvd476MwG9sRe27NxcGIcLMZnV/f3vr3dy2VdrZSxCLa5pGR3A4B8QuAzNU0ZiHDpMEyJXFoJuAxlVbYUiSEImfxELGOE2kndIW2leMHXN2fiZmr5NTKcpYdgBaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137745; c=relaxed/simple;
	bh=fXY+RFRHP4l2g4HjvBhxw/ZWCqTkjJ4XWkFm7ZS+A3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sx/T9VkX2cWTBs1tswMwTVsSc/QP7lacr4B/rDFApxp+6xlikfGh8K4dif6Xn1lQ1GOjIAB1vAl59AalzuZNgqGcDVF/LIQZdke66ionvOanwbF12H4e/dNKk7qFiKChwGFNg0U3gy3K8LR1018wpOyMjY8Y8RzJkdA304WOqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA0ofsIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF3C32782;
	Thu,  8 Aug 2024 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723137743;
	bh=fXY+RFRHP4l2g4HjvBhxw/ZWCqTkjJ4XWkFm7ZS+A3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oA0ofsIXPQA+yC7ILi51xddRAt5i9Wz41DU2ItkxcJ+G+F/qNKgB0x3Vnd7S5gv2Z
	 dJnOGsdN6Ai20ET0tQHN/HcsH3O2bWj0GYqdol8Qu8xdiaC4RMzBs/9mwh9scYhqXt
	 uwPcPXrb70DRK66g9vvqoOWjyl8/VK+qpsmfVQHdGQEypIdmiDmvZCixJQ3fUqKrDP
	 tRhNK2/LO00ObwxEPXA3Qv4+tcw0138++F9Arwe6pPfz6kEO4o0WQNnVn+Zif0Vf8N
	 Qz8kHehrhpiYjfhEcPNUokc4q2gBHZFjvbWatq0CvxnEuUmySrurCSSRPPIKiH+tTL
	 0eW3td9N1BHtg==
Date: Thu, 8 Aug 2024 12:22:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: 412574090@163.com
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xiongxin@kylinos.cn
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
Message-ID: <20240808172221.GA150885@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808023217.25673-1-412574090@163.com>

On Thu, Aug 08, 2024 at 10:32:17AM +0800, 412574090@163.com wrote:

You inadvertently trimmed out Ilpo's attribution.  Some hints at
https://subspace.kernel.org/etiquette.html

There should be a line like this:

  > On Tue, Aug 06, 2024 at 05:38:41PM +0300, Ilpo Järvinen wrote:
  ...
  > > These should be in numerical order.

so it's clear who wrote what.

> > On Tue, 6 Aug 2024, 412574090@163.com wrote:
> >
> > > From: weiyufeng <weiyufeng@kylinos.cn>
> > 
> > > PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capability
> > > ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will want
> > > this whilst doing Gen6 accesses.
> > > 
> > > Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index 94c00996e633..cc875534dae1 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -741,6 +741,7 @@
> > >  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> > >  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> > >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> > > +#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s */
> > >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> 
> > These should be in numerical order.
> In PCIe r6.0, PCI_EXT_CAP_ID_PL_64GT value is 0x31.

Right.  The #defines just need to be sorted in numerical order
(PCI_EXT_CAP_ID_PL_64GT would be last, after PCI_EXT_CAP_ID_DOE)
because PCI_EXT_CAP_ID_MAX is defined to be the one with the highest
numerical value, and it's hard to find that when they're not sorted.

> > >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> 
> > This was not adapted??
> PCIe r6.0, sec 7.7.7.1 have this definition。

I think Ilpo meant that if we add "#define PCI_EXT_CAP_ID_PL_64GT 0x31",
PCI_EXT_CAP_ID_MAX needs to be updated from PCI_EXT_CAP_ID_DOE to
PCI_EXT_CAP_ID_PL_64GT.

Bjorn

