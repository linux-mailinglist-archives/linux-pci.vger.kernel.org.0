Return-Path: <linux-pci+bounces-15651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663A9B6C4B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC681C20E65
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B21BD9F1;
	Wed, 30 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8/Ly+cO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A401BD9D1
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314003; cv=none; b=B4CPFfIxgv9aBfH5CUoEsuU0sOsfAuTJgOpsJ8JrlIxMM+bEiBjW+X8+91FD4pzXEA/3ZK90fdWkUjIhqIogcfRzEGFrG4zLJRiXZwC5tLDTnr4LEGvexRH4/5G7jrPW8lCRv51Ngt75tRkiNAYWOEJUqR0WRefL/ZUKMaRYHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314003; c=relaxed/simple;
	bh=l+ecJbm/aUQtIvrPiYspqzUjap35Pt3yFHgDQiaSyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KUVNwwGkDDTOKbS37zUvfiVELBGj4wLeh5A/SguiVxykABCSpmMrKNDdnsXrY3FWdG1Ou+qqmkQyiep7uGlPKgv+OoHAwznT5nPoOTXSO4EwXHJmBkg0MOJfwicIiSsLJs0NWCRHbXIlrNTBwJXb1u2QvCxMEuOpI9RQP2+hjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8/Ly+cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B53C4CECE;
	Wed, 30 Oct 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730314002;
	bh=l+ecJbm/aUQtIvrPiYspqzUjap35Pt3yFHgDQiaSyhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D8/Ly+cOsDXI5VCy74m3maVFa6izmnu7c0Mj6hex6T1jRykWhJk5DPwnLkDUn+FJu
	 hM5Nvn4lWhvc4g2B9FxPt5cHuIXDKMhHC8V7GXGlzQwuZsBGSSsNmryLGm9axCwLwM
	 h/RsvaBeSCDtm0icbrp7D3Akn8SscQ8vL+1Xz0qEbJ4Ay2S+DoD3vv8Ksw8FRfreT3
	 9/Q/bt5HaptPG/xmYbbMZKSdxWpt3lP1jH2jyEOAeNvYD0tBTuyzh7LdgdX08YMnUY
	 QJyaGFCOSR6xQMuDsKKuGG1PynvvHLpq9Eux1lHB6Ggl5V7nEKJTGZikOuIMfo+Ga+
	 nEO2jye0EdQBw==
Date: Wed, 30 Oct 2024 13:46:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
Message-ID: <20241030184641.GA1210322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB7185C903E9468C3221615F4FF84F2@IA0PR11MB7185.namprd11.prod.outlook.com>

On Fri, Oct 25, 2024 at 06:57:37AM +0000, Kasireddy, Vivek wrote:
> > Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for
> > functions of same device
> > 
> > On Thu, Oct 24, 2024 at 05:58:48AM +0000, Kasireddy, Vivek wrote:
> > > > Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for
> > > > functions of same device
> > > >
> > > > On Sun, Oct 20, 2024 at 10:21:29PM -0700, Vivek Kasireddy wrote:
> > > > > Functions of the same PCI device (such as a PF and a VF) share the
> > > > > same bus and have a common root port and typically, the PF provisions
> > > > > resources for the VF. Therefore, they can be considered compatible
> > > > > as far as P2P access is considered.
> > 
> > I don't understand the "therefore they can be considered compatible"
> > conclusion.  The spec quote below seems like it addresses exactly this
> > situation: it says ACS can control peer-to-peer requests between VFs.
>
> I am only referring to the specific case where the PF is trying to
> access (P2P) a VF's resource that the PF itself has provisioned.
> Shouldn't this be considered a valid access?
> 
> > > ...
> > > > I'm not sure what you refer to by "PF provisions resources for the
> > > > VF".  Isn't it *always* the case that the architected PCI
> > > > resources (BARs) are configured by the PF?  It sounds like you're
> > > > referring to something Intel GPU-specific beyond that?
> > >
> > > What I meant to say is that since PF provisions the resources for
> > > the VF in a typical scenario,
> > 
> > Are you talking about BARs?  As far as I know, the PF BAR assignments
> > always (not just in typical scenarios) determine the VF BAR
> > assignments.
>
> Right, I am indeed talking about BARs.
> 
> > Or are you referring to some other non-BAR resources?
> > 
> > > they should be automatically P2PDMA compatible particularly when the
> > > provider is the VF and PF is the client. However, since this cannot
> > > be guaranteed on all the PCI devices out there for various reasons,
> > > my objective is to start including the ones that can be tested and
> > > are known to be compatible (Intel GPUs).
> > 
> > Regardless of BAR or other VF resources, I don't think VFs are
> > automatically P2PDMA compatible.
>
> I agree that VFs in general are not automatically P2PDMA compatible
> but a PF and a VF should be considered compatible particularly when the
> provider is a VF and PF is the client.
> 
> > For example, PCIe r6.0, sec 6.12.1.2  says:
> > 
> >   For ACS requirements, single-Function devices that are SR-IOV
> >   capable must be handled as if they were Multi-Function Devices.
> > 
> >   ...
> > 
> >   - ACS P2P Request Redirect: must be implemented by Functions that
> >     support peer-to-peer traffic with other Functions. This includes
> >     SR-IOV Virtual Functions (VFs).  ACS P2P Request Redirect is
> >     subject to interaction with the ACS P2P Egress Control and ACS
> >     Direct Translated P2P mechanisms (if implemented). Refer to
> >     Section 6.12.3 for more information.  When ACS P2P Request
> >     Redirect is enabled in a Multi-Function Device that is not an
> >     RCiEP, peer-to-peer Requests (between Functions of the device)
> >     must be redirected Upstream towards the RC.
> > 
> > Or do you mean something else by "P2PDMA compatible"?
>
> I am no longer making any generic claims about devices' P2PDMA
> compatibility. Instead, as mentioned above, I am only focused on the
> interactions between a PF (client) and a VF (provider), particularly
> with Intel GPUs. 
> 
> More specifically, I am trying to address a use-case where the VF
> needs to share a buffer with the PF but is unsuccessful because
> pci_p2pdma_distance_many(provider, client, 1, true) fails (due to
> ACS redirect being set) although the buffer is located within a BAR
> resource that the PF has provisioned and has full access to it.
> Shouldn't this be allowed?

IIUC you want the PF to be able to initiate a transaction on the PCIe
link to access a VF BAR.  The address in that TLP will be inside the
VF BAR (and also inside the space defined by the VF BAR<n> and the
NumVFs value in the PF's SR-IOV Capability).

In the PCIe world, I don't think a TLP can "loop back" to another
function on the same device.  I think it has to go upstream at least
to the Port above the originating function.  The Port works like a
PCI-PCI bridge.  The TLP address will be inside a Port memory window,
so in the absence of ACS, the Port would reflect the TLP back down the
same link it came from.  I'm pretty sure an analyzer on the link would
see two distinct TLPs.

But as far as I can tell, when ACS P2P Request Redirect is enabled,
the spec requires that the Port forward the TLP upstream (regardless
of the TLP address) instead of reflecting it back to the downstream
link.

Do you read the spec differently?

Bjorn

