Return-Path: <linux-pci+bounces-34111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F37B281AC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 16:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77663A29A8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93A224244;
	Fri, 15 Aug 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxVRc+Ly"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADB1E230E;
	Fri, 15 Aug 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268028; cv=none; b=lAbNLA50pVvmndoPvJiG2RIngLA3NzQxViFVgv2oGP6W7pAE2fsbWGZoZDrJT4s4T6EVqBEDZc/npUWIHypN6EntVNNmodiVdi72YxtNugV8u68kW6WkqNNixBurFGMFY2oPu1qnvDp2MpmzyZWAn4KMxoqDeaCSiuJ/Sp+6K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268028; c=relaxed/simple;
	bh=f/FObD14MZnJGN6cgRXbXsf/Fjw092bO8WlijOgdNQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qhrpkA0DgI8A/WzYmxfMlZ90QLpWLEUAKFGmT3gXKwrQFTroaanClxAVScMyRL3M4gpur0n258HDDEJIoktyteCCoIzkRq/3HjiARN2ur/4G0QKMetcazELPtMlxB06O2svdubgopmm7vdVmiCxgZnT1QRnRhdf3s8zklbGZmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxVRc+Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9442C4CEEB;
	Fri, 15 Aug 2025 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755268028;
	bh=f/FObD14MZnJGN6cgRXbXsf/Fjw092bO8WlijOgdNQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TxVRc+Ly1mGAqKDvCpOj1Y4DFYb38GAULO4jVR95X25PQ9VTLrRYLyt1OWDI70Z0P
	 kGQizxtT+oOuzw2+gUeonREFJ4wdG/sAiJJkQbn07LIooTvCKx9uvghdP+FGihK7x9
	 0CFWNQHAJCulBU85ytmx/uri/F3XWSKfti48VdUHr98VQxYQhdcFhNRrXO5JhlahWx
	 mbuRLDVtDgiJHSB29zzAZYy++inJiZWn3MCBX5WS+iDtTIgz+1G04oDWfYGl7z2nSL
	 SWdxMPn9qYCPrc+LPPHqCQIZIiy9dI3hrDs58iQ3eg1g8HQKI9bNiBGZo9P9O1uI1b
	 K6S4N9bFFgfhw==
Date: Fri, 15 Aug 2025 09:27:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mpillai@cadence.com, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] PCI: Add Cix Technology Vendor and Device ID
Message-ID: <20250815142705.GA377241@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ6qTdA1f21SAr_l@nchen-desktop>

On Fri, Aug 15, 2025 at 11:32:29AM +0800, Peter Chen wrote:
> On 25-08-14 17:23:58, Bjorn Helgaas wrote:
> > On Wed, Aug 13, 2025 at 12:23:27PM +0800, hans.zhang@cixtech.com wrote:
> > > From: Hans Zhang <hans.zhang@cixtech.com>
> > >
> > > Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> > > devices. This ID will be used by the CIX Sky1 PCIe host controller driver.
> > >
> > > Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> > > ---
> > >  include/linux/pci_ids.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 92ffc4373f6d..24b04d085920 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -2631,6 +2631,9 @@
> > >
> > >  #define PCI_VENDOR_ID_CXL            0x1e98
> > >
> > > +#define PCI_VENDOR_ID_CIX            0x1f6c
> > > +#define PCI_DEVICE_ID_CIX_SKY1               0x0001
> > 
> > I only see these used once in this series, so they probably should be
> > defined in the file that uses them, per the comment at the top of this
> > file.
> > 
> > Also, https://pcisig.com/membership/member-companies?combine=0x1f6c
> > doesn't show 0x1f6c as assigned to CIX.  That database often seems
> > incomplete, but please double check to make sure the ID is actually
> > reserved.
> 
> Would you please check below:
> https://pcisig.com/membership/member-companies?combine=1f6c

Thanks, sorry if I've asked this before.  Searching that pcisig
database always seems a little hit and miss.

Bjorn

