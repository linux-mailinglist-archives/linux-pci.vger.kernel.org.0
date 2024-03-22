Return-Path: <linux-pci+bounces-5023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF0887484
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FCE2837CF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E380059;
	Fri, 22 Mar 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYyEAOKH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0F7FBD9;
	Fri, 22 Mar 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143774; cv=none; b=MYJDP+Tsgjn8zIz9U3IrjZVl5pgMTJATWlpWvPXlHylXspFPf5MCr3yFiQLxO1FYxNES+VWwwhJB5o4h92R3mR7WGqo2zGy/BacNnsY1LU6FsYErg0d85avaKo+o6DI2ihWYgZ8mUlP6NUfOzu7uxfkOCUUD4pIZXRn/mHU2GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143774; c=relaxed/simple;
	bh=JycC0gs4OGC9gkoJ1HmCcBKIzE6fAhJJwAeFrFmRK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ixgLRaCDo93RnzBwrFm3I9W5a6ASQOBfZSPyOFohSWkWwUc86N13zrmrhGriuZE6Xo91nQldTjP1ZMoLmNw2CI3WklwJpj7Ac5/G+KvTU5cpT+HRtydsefAMRnn8RQTnbKazZqCQpNzsSenjPaSPRN73sb6yHWgn0ntrImWhFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYyEAOKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD7C433F1;
	Fri, 22 Mar 2024 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711143773;
	bh=JycC0gs4OGC9gkoJ1HmCcBKIzE6fAhJJwAeFrFmRK+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DYyEAOKHC9c23CVPAnPGivg22IKn7Nu3jt3K/MNHK4IBKrdvoWIv3Q/TLwxadyyOn
	 FbqyuLxEWmvTLox3RBtAmR721lUi8TizSOlmPI6xwhtE75WFgUxgUxPen5KkLcuiVh
	 qbGi8R1W47DUF3lOw14GBGQ/Q/bNhYT2eMUt7a7AbVFt0N/NmKsqlCsRUzt/AafJl8
	 yZ/EszELi2tI/TV8vM6aXQYpeEbpbQbof19IsukG+ZXhORb4DxeGwY+E9DI45rhfoX
	 Aa4ldEEOtKOEd4okWG3e8rzGm0OFcE6Dl/o5dFUl2UM04Cp35AdEZdV3m2tRgT2CpF
	 nHa9GXut4j91w==
Date: Fri, 22 Mar 2024 16:42:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240322214251.GA1377469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fdf85bba0e0_4a98a294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Mar 22, 2024 at 02:30:03PM -0700, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Tue, Mar 12, 2024 at 10:08:16AM +0100, Mariusz Tkaczyk wrote:
> > > On Mon, 11 Mar 2024 17:30:06 -0500
> > > Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> > > 
> > > > > > No, Linux doesn't support _DSM. It was proposed in previous
> > > > > > iterations by Stuart but I dropped it. We decided that it need to be
> > > > > > strongly rebuild because "pci/pcie" is not right place for ACPI code
> > > > > > so we cannot register _DSM driver instead of NPEM as it was proposed
> > > > > > and I don't have _DSM capable hardware to test it.  
> > > > 
> > > > I'm not sure I understand why pci/pcie isn't the right place for ACPI code--
> > > > there are other _DSMs used in PCI code already, and this _DSM is defined
> > > > in a PCI ECN.
> > > 
> > > I looked into internal review history and I found out that I dropped it after
> > > discussion with Dan Williams:
> > > 
> > > > After review and discussion with Dan _DSM extension is dropped.
> > > 
> > > Unfortunately, I don't remember what exactly he suggested, I just remembered
> > > conclusion that it needs to be reworked and I decided to drop it.
> > > Maybe, I didn't understand him correctly.
> > > 
> > > Dan, could you take a look? Do you remember something?
> > 
> > Straw man proposal:
> > 
> >   - Update this patch so we use NPEM if the device advertises it.
> > 
> >   - If/when Linux support for the _DSM is added, we use the _DSM when
> >     present.  If a device advertises NPEM but no _DSM applies to it,
> >     we use native NPEM for it.
> 
> The current patch matches my last recollection of the discussion, at a
> minimum do not use the NPEM interface when the _DSM is present. That was
> the compromise to meet the spirit of the _DSM definition and leave it to
> folks that care about the _DSM and have hardware to implement and test
> that support.

In the case of an OS that supports native NPEM but not _DSM, I think
it would be unreasonable for NPEM to stop working just because a new
firmware release added the _DSM.

> However, I think the strawman is workable if only because base NPEM
> already has a problem of ambiguity of which NPEM instance in a topology
> should be used.
> 
> For example an NVME or CXL endpoint could have an NPEM implementation
> that is superseded by an NPEM instance in its parent downstream port, or
> another ancestor downstream port / root port.
> 
> The fact that the native NPEM may not be the right interface to use in
> the presence of the _DSM has no specified way to resolve conflicts is at
> least matched by downstream-port vs endpoint conflict resolution not
> being specified.
> 
> So the spec left a bit of a mess and it is reasonable for Linux to say
> "just turn on all the NPEMs and hope that userspace knows what it is
> supposed to do".

If a device and its parent both advertise NPEM, I dunno how to figure
out which to use.  Maybe that's a benefit that could come with the
_DSM.

Bjorn

