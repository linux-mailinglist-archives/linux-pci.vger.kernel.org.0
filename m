Return-Path: <linux-pci+bounces-29769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783C5AD9584
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA823BC74A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDC225761;
	Fri, 13 Jun 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVdoPBim"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901622E11BB;
	Fri, 13 Jun 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842831; cv=none; b=ajlHG1z4jMTOYVHdy/vQfmcHsbheV/0yJg6sXWMNOzaFFnEuxmuveyd4siw5M26u8cp29wzIkexym2Ii+4D/d9PcHRY7josHlCS3vosrHEsTBkHGGdQNKVI+Vl+ECBodUQ7o3Sn2GB+w9PFJvLXfQeLBrpL02qv88rQn6t0p8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842831; c=relaxed/simple;
	bh=faZgBj3OG+5oZst8i9znuKpqc5DmC3rZiACY89LYJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kSyYqAOLGD4AaEs1nDUw2dRUYPWLpHUJa5vJrz+lLXWDnMvdErMkhvLCHj+JTV4x40YnLayn/cznzIGiwwKUC6lmIlzagi/HLYd+Sr0fqS8Hg7FuPiMQkHZMW2gALLk9gSM/ExebrZR1bhzZAO657WvHiNUqE31V03hOB+YZgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVdoPBim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE9C4CEEB;
	Fri, 13 Jun 2025 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749842831;
	bh=faZgBj3OG+5oZst8i9znuKpqc5DmC3rZiACY89LYJLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dVdoPBimaPmBN7fPWzA1H4jOeua65sr0vDUrPdccine238XmGkJ/8+QdGLXmurI3C
	 9rt9uXVJOkqUXxPqCzyhYlgwyWdSg+xRbb+lqqea1pcj9nY3xr7XdLOKcEQbt3Uak4
	 SHB81Ael271D/Sg1mSILLRi8iHUs6aW90z5nT4Uz1s7unPxYb1AO92jYR7r/CGZ3YX
	 w9SjcashO3k3vOxfS0LbZznc7m9IaPY3lfH68a3/p60le0ApU0fKAFT6I8wNfHOq1l
	 WyyEC86QBm76McGng58ESdAEx2iesj+YAOux2LLLfJv3bbNVO9BNj2/FPuotRQ6xAL
	 YqkYTEI6w5Lcw==
Date: Fri, 13 Jun 2025 14:27:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <20250613192709.GA971579@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610163045.GI543171@nvidia.com>

On Tue, Jun 10, 2025 at 01:30:45PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> > On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > > Hi all,
> > > 
> > > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > > before initiating a Function Level Reset, and then ensure no invalidation
> > > requests being issued to a device when its ATS capability is disabled.
> > 
> > Not really - what it says is that software should not expect to receive
> > invalidate completions from a function which is in the process of being
> > reset or powered off, and if software doesn't want to be confused by that
> > then it should take care to wait for completion or timeout of all
> > outstanding requests, and avoid issuing new requests, before initiating such
> > a reset or power transition.
> 
> The commit message can be more precise, but I agree with the
> conclusion that the right direction for Linux is to disable and block
> ATS, instead of trying to ignore completion time out events, or trying
> to block page table mutations. Ie do what the implementation note
> says..
> 
> Maybe:
> 
> PCIe permits a device to ignore ATS invalidation TLPs while it is
> processing FLR. This creates a problem visible to the OS where ATS
> invalidation commands will time out. For instance a SVA domain will
> have no coordination with a FLR event and can racily issue ATC
> invalidations into a resetting device.

The sec 10.3.1 implementation note mentions FLR specifically, but it
seems like *any* kind of reset would be vulnerable, e.g., SBR,
external PERST# assert, etc?

