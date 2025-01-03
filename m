Return-Path: <linux-pci+bounces-19249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA51FA00D49
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C373A4085
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BED1FBEB7;
	Fri,  3 Jan 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBthy0t3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9E1F9ECC;
	Fri,  3 Jan 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927121; cv=none; b=nAQlpZPuD3OAAiCP1d6toSbQoUotvjiFJrE1kg1qMh56eLZZcJaDNsIO+IOGZDPWbj27RAA9z4WidQTuwpUUA+24wk2O6QB311pmLCQr1iGUj/CO/CI/nSj7laypQse6A4mGsdYbI9TJjaJhzMJTfckzidrqgknE1YahN/fJtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927121; c=relaxed/simple;
	bh=pSEECInPSyB+T38zKK/HGjM50PM5KyZbdiJ6tpQxcc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BFbGxffcF0uMy5ICE1vR7nfQ6s3VUxX7F7WGjbU7RFvbWWyrpm7uKqcUDcYRQxgSMh+BFaLwxl4h89xsBeJQudmE8xknsp8EDxzlVwZ+YtkXNUeT6CpTE7hMcnIob9kSw+wgUINQ8gpGYEgFF0ikJMj56beegelOfOy1z6t11nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBthy0t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3AFC4CECE;
	Fri,  3 Jan 2025 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735927120;
	bh=pSEECInPSyB+T38zKK/HGjM50PM5KyZbdiJ6tpQxcc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QBthy0t3HiS2hdFmEN8Evye6kRKPO/yWINQzpyiwldPXGC9l94BBO+mmsHopTJhOY
	 249FVgPbMYzR7iisgReuZRJraR+SPpFE3fb7tUlUgWC/rKb+6gqkF3dC5ntje2/ekb
	 1c+AXkZ/uYdezTSQHRx0+m8QMFq3g69q0q4hZf9Mr6RKJFV+SWjDAOAKo96jIZvQNI
	 uIMIE6g8qtNmf4EDTptolyYqkMGuOQ8bLqSktR+lXTQxrYpWYsggtw7+dDMdbEkMGp
	 4GUvwCJKR08a/JF8eUYjG3AzUx3e/mDI1WXhvoXs3He9nixMD+mQKpT6fnQciaZq1l
	 vycBsXLCjf1Rg==
Date: Fri, 3 Jan 2025 11:58:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <20250103175839.GA4182486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103174955.GA4182381@bhelgaas>

On Fri, Jan 03, 2025 at 11:49:57AM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 02, 2025 at 05:43:26PM -0800, Brian Norris wrote:
> > On Mon, Dec 30, 2024 at 10:41:45PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Oct 15, 2024 at 02:12:16PM -0700, Brian Norris wrote:
> > > > From: Brian Norris <briannorris@google.com>
> > > > 
> > > > Per Synopsis's documentation, the msi_ctrl_int signal is
> > > > level-triggered, not edge-triggered.
> > > 
> > > Could you please quote the spec reference?
> > 
> > From the reference manual for msi_ctrl_int:
> > 
> >   "Asserted when an MSI interrupt is pending. De-asserted when there is
> >   no MSI interrupt pending.
> >   ...
> >   Active State: High (level)"
> > 
> > The reference manual also points at the databook for more info. One
> > relevant excerpt from the databook:
> > 
> >   "When any status bit remains set, then msi_ctrl_int remains asserted.
> >   The interrupt status register provides a status bit for up to 32
> >   interrupt vectors per Endpoint. When the decoded interrupt vector is
> >   enabled but is masked, then the controller sets the corresponding bit
> >   in interrupt status register but the it does not assert the top-level
> >   controller output msi_ctrl_int.
> 
> "the it" might be a transcription error?
> 
> > That's essentially a prose description of level-triggering, plus
> > 32-vector multiplexing and masking.
> > 
> > Did you want a v2 with this included, or did you just want it noted
> > here?
> 
> I think a v2 with citations (spec name, revision, section number)
> would be helpful.  Including these quotes as well would be fine with
> me.

Oh, and it would be awesome if we can motivate this patch by mentioning
an actual problem it can avoid.

It sounds like there really *is* a problem at least in some
topologies, so I think we should describe that problem before
explaining why we haven't seen it yet.

> > (Side note: I think it doesn't really matter that much whether we use
> > the 'level' or 'edge' variant handlers here, at least if the parent
> > interrupt is configured correctly as level-triggered. We're not actually
> > in danger of a level-triggered interrupt flood or similar issue.)
> > 
> > Brian

