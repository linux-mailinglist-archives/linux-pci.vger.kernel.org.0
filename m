Return-Path: <linux-pci+bounces-32549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F3B0A952
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8B717A8ED
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961E1B412A;
	Fri, 18 Jul 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5+UQCY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CF4503B
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859405; cv=none; b=kWHEnrTVuM7bquiYnxl4qTFNNEFiMLBzHUgT3/B2qdWsrz+QN/wJ5vc9JuTNmAxgR7gsL3B4DBzD+jzYPB6QA3ttNh2OPoEwVQlzDoG/GkBH2ahxsHLOoNTKzIHztnLR6aNI4NNOK+lpHV3tUBtnS9Fd1hoGtEAfiTkqbGojYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859405; c=relaxed/simple;
	bh=xH07Z/BnozkYF3PxVY9/+uGbFukliBnJ7g6CNVPx+p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnMPX5vTPnNzKxUE7aSdxT86fg6BRia3Jmhaet0iGzjLETvQO6dd3mJDEoU7Ay93yffFuPpEW394QJcPwgSNcFD2mXA6RdjS5N5oroxersz1R1DCH8MVNgEJItzMbyCnuQVGPjQg5/1totIltPCA8hnwOerdhwkICmvo/Dqfbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5+UQCY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B77C4CEEB;
	Fri, 18 Jul 2025 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752859405;
	bh=xH07Z/BnozkYF3PxVY9/+uGbFukliBnJ7g6CNVPx+p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5+UQCY/6si2HGDaIgm0H4ux9kVZ1cB9yfNLE/7OnnunUJ0V8M+2cjNWEbc1G4Keu
	 aDtjRjpcXmJND9X8dyevQz4x7Lc3aQE9xPYWzHF67oT3DxZa20M2gWuWx7D427BK+d
	 6qKcSI+D0EZLzQE7B0QsCLDObfs0I5R4jxAk8ZcK8nuShPErWlaV78kQuUaX3fUZXz
	 5TwbXhsB3qWDk2EbsaTEzoCu4gWAWRQ89HPiTACUZxxEJqhzWpDorrnjsBfGXfS8rR
	 OrPjZ2FZ/1ufNtUYNe0J9ciebJRJK6KBJlU1rXepjfeE7Mc3Kf6VfI6slzps8/7ygb
	 1nqSy3PS69HeA==
Date: Fri, 18 Jul 2025 22:53:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix warning without CONFIG_VIDEO
Message-ID: <hwdswlzbejlrawrrsgdlqtmzb6437kyei4hl5uqpe24orey2qd@2u7i7dzkhfyu>
References: <20250718134134.1710578-1-superm1@kernel.org>
 <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
 <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>

On Fri, Jul 18, 2025 at 12:06:22PM GMT, Mario Limonciello wrote:
> On 7/18/2025 12:00 PM, Manivannan Sadhasivam wrote:
> > On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
> > > never create a sysfs file for boot_display. Guard the sysfs file
> > > declaration against CONFIG_VIDEO.
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/pci/pci-sysfs.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 6b1a0ae254d3a..f6540a72204d3 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
> > >   	NULL,
> > >   };
> > > +#ifdef CONFIG_VIDEO
> > >   static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
> > >   				 char *buf)
> > >   {
> > >   	return sysfs_emit(buf, "1\n");
> > >   }
> > >   static DEVICE_ATTR_RO(boot_display);
> > 
> > I failed to give my comment during the offending series itself, but it is never
> > late than never. Why are we adding non-PCI attributes under bus/pci in the first
> > place? Though the underlying device uses PCI as a transport, only the PCI bus
> > specific attrbutes should be placed under bus/pci and the driver/peripheral
> > specific attrbutes should belong to the respective bus/class/device hierarchy.
> > 
> > Now, if other peripherals (like netdev) start adding these device specific
> > attributes under bus/pci, it will turn out to be a mess.
> > 
> > - Mani
> > 
> 
> It was mostly to mirror the location of where boot_vga is, which arguably
> has the same issue you raise.
> 

Yes, I agree. But 'boot_vga' has set a bad precedence IMO.

> I would be incredibly surprised if there was a proposal to add a
> 'boot_display' attribute from netdev..

Not 'boot_display' but why not 'boot_network' or something else. I was just
merely pointing out the fact that the other subsystems can start dumping
device/usecase specific attributes under bus/pci.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

