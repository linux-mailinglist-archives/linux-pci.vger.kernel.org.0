Return-Path: <linux-pci+bounces-33937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580CB2447D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 10:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C31C7A6D74
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3C2EFD85;
	Wed, 13 Aug 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUsBu5C3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CE2EE5FE;
	Wed, 13 Aug 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074321; cv=none; b=jsawF0Ve1sXik+ILxesPxDyE+0IrrLd/2Wxo2XqUM1bay4g2HwtREJGUSiqeCBsp+ByRlkQb+p410CZLCsJZvt8u3xxatzC2s+IP9KBWWyfn3ZO/4TRorGjo3zk1shakBRzuhgdJoJ9QyTFeBhmGXXqgoXcPfJLEtosPO9Mrpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074321; c=relaxed/simple;
	bh=4WeOZe+tHXrZMy0vTgIJaEZ2Y1n1zvWM5wBmDGw54R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgDdMuOb5lI+gdzUwJXvSdebnAIdB8yu8l/JYKv6sUPUKJROujrKGfjqxtHhquXNd6ePpjuechQeWuqDE0aBfGKcNTW3/N9UJVhPOVjFRd42QHo+HreT6mAdAiZI3dYhEvYv+nKZvZldAGzu4IKpfC3BKDn/WgMWlZ4+hSnnTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUsBu5C3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58A3C4CEEB;
	Wed, 13 Aug 2025 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755074320;
	bh=4WeOZe+tHXrZMy0vTgIJaEZ2Y1n1zvWM5wBmDGw54R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUsBu5C38WwPIg4WA4oIhQREHRrReyj8jf3LQR3k4c4sqReEFPa9C13yMLqUdYlOq
	 ogsyVOrHLE3oQ9cueLxsRiTTl9itk3hAOgH/6f5D1mIeWyF340qT9zXyFZq7ImYGbZ
	 ITcK5P4Dl38M0Sh7sCRsOtP93JZVIQnfycXnilyttTmMgB6jPpmIfr8UpKlWHBRQUO
	 5AROKgybXxZSefSjLmNutHY789sj2stpMnUw9z67gunpprgciIAyUK3Wd83pr1rEQT
	 t8+TDkFGVUN3SVLiLVpnPtuahABRmbBippk1usaQfZVh1L2lXMT0yT2c2ELh0MoW8D
	 A900Oo1wYL/gQ==
Date: Wed, 13 Aug 2025 10:38:36 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, maz@kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
Message-ID: <aJxPDH6Sx0Ur01ER@lpieralisi>
References: <aJms+YT8TnpzpCY8@lpieralisi>
 <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com>
 <aJrwgKUNh68Dx1Fo@lpieralisi>
 <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
 <CAL_JsqJF6s8GsGe1w6KEkeECab956YiBSFbdbHOiiCv2+v3MAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJF6s8GsGe1w6KEkeECab956YiBSFbdbHOiiCv2+v3MAA@mail.gmail.com>

On Tue, Aug 12, 2025 at 11:59:06AM -0500, Rob Herring wrote:
> On Tue, Aug 12, 2025 at 10:53 AM Lizhi Hou <lizhi.hou@amd.com> wrote:
> >
> >
> > On 8/12/25 00:42, Lorenzo Pieralisi wrote:
> > > On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
> > >> On 8/11/25 01:42, Lorenzo Pieralisi wrote:
> > >>
> > >>> Hi Lizhi, Rob,
> > >>>
> > >>> while debugging something unrelated I noticed two issues
> > >>> (related) caused by the automatic generation of device nodes
> > >>> for PCI bridges.
> > >>>
> > >>> GICv5 interrupt controller DT top level node [1] does not have a "reg"
> > >>> property, because it represents the top level node, children (IRSes and ITSs)
> > >>> are nested.
> > >>>
> > >>> It does provide #address-cells since it has child nodes, so it has to
> > >>> have a "ranges" property as well.
> > >>>
> > >>> You have added code to automatically generate properties for PCI bridges
> > >>> and in particular this code [2] creates an interrupt-map property for
> > >>> the PCI bridges (other than the host bridge if it has got an OF node
> > >>> already).
> > >>>
> > >>> That code fails on GICv5, because the interrupt controller node does not
> > >>> have a "reg" property (and AFAIU it does not have to - as a matter of
> > >>> fact, INTx mapping works on GICv5 with the interrupt-map in the
> > >>> host bridge node containing zeros in the parent unit interrupt
> > >>> specifier #address-cells).
> > >> Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I think
> > >> of_irq_parse_raw will not check its parent in this case.
> > > But that's not the problem. GICv5 does not have an interrupt-map,
> > > the issue here is that GICv5 _is_ the parent and does not have
> > > a "reg" property. Why does the code in [2] check the reg property
> > > for the parent node while building the interrupt-map property for
> > > the PCI bridge ?
> >
> > Based on the document, if #address-cells is not zero, it needs to get
> > parent unit address. Maybe there is way to get the parent unit address
> > other than read 'reg'?  Or maybe zero should be used as parent unit
> > address if 'reg' does not exist?
> >
> > Rob, Could you give us some advise on this?
> 
> If there's no 'reg', then 'ranges' parent address can be used. If
> 'ranges' is boolean (i.e. 1:1), then shrug. Just use 0. Probably, 0
> should just always be used because I don't think it ever matters.
> 
> From my read of the kernel's interrupt parsing code, only the original
> device's node (i.e. the one with 'interrupts') address is ever used in
> the parsing and matching. So the values in the parent's address cells
> don't matter. If a subsequent 'interrupt-map' is the parent, then the
> code would compare the original address with the parent's
> interrupt-map entries (if not masked). That kind of seems wrong to me,
> but also unlikely to ever occur if it hasn't already. And that code is
> something I don't want to touch because we tend to break platforms
> when we do. The addresses are intertwined with the interrupt
> translating because interrupts used to be part of the buses (e.g ISA).
> That hasn't been the case for any h/w in the last 20 years.

If the parent address values don't matter I think we can just leave
them as zeroes and be done with it (explaining why obviously).

Something like this (with a big fat comment added summarizing this
thread):

Lizhi are you able to test it please at least to check it does not break
anything before I make it a patch for the MLs ?

Any concerns ?

-- >8 --
diff --git i/drivers/pci/of_property.c w/drivers/pci/of_property.c
index 506fcd507113..dd12691fe43c 100644
--- i/drivers/pci/of_property.c
+++ w/drivers/pci/of_property.c
@@ -279,13 +279,6 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 			mapp++;
 			*mapp = out_irq[i].np->phandle;
 			mapp++;
-			if (addr_sz[i]) {
-				ret = of_property_read_u32_array(out_irq[i].np,
-								 "reg", mapp,
-								 addr_sz[i]);
-				if (ret)
-					goto failed;
-			}
 			mapp += addr_sz[i];
 			memcpy(mapp, out_irq[i].args,
 			       out_irq[i].args_count * sizeof(u32));

