Return-Path: <linux-pci+bounces-16168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BD9BF865
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C984B2844B9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1120CCE0;
	Wed,  6 Nov 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2IEBEy0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F81D63F8;
	Wed,  6 Nov 2024 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927862; cv=none; b=HHsESl9uSCfD8+V/mtCa7PhAK59Vi0juzycV00VvAT5Q/cJXHJi1ygJ3AG1duHsORp0CdtRPaTrSq3UVL0vDuphJyF1uGph0Jsgn88XKCXxl6ev2k2YCxDf7psEoRZL1mr4oAO3zSv28YPSmRM7LCbjVkYqHvqJsgos/9Xyz3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927862; c=relaxed/simple;
	bh=30pjOrftk+x/9JwFj0XfoVd8G3rer8//+ZVC/VnGbV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C1utmz2oLjsbPUXDXMZKDncuJBj8EfT8hiHX+7EYZDDa61hHvuAq3WUryPWWm8QY8n/T6+3SQXXrGeu7KQiLDKdMNt4O/BXSQETWWJmDGZIj+w22l3subD719qSYHZl7WL8A7uwKUf6uf1yVTXNmqRrOgd4Izp9JnHhBzuzIPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2IEBEy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A0EC4CEC6;
	Wed,  6 Nov 2024 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730927860;
	bh=30pjOrftk+x/9JwFj0XfoVd8G3rer8//+ZVC/VnGbV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i2IEBEy0j5D6Hs5Uelajxim0x5TkJosdCViiVn14KMOBw8KohhHaQgG89hYZF88zK
	 aMR8vAPDhWthT1BdH1NW/FUsfEza4PvVABrzQeDnfoKiFwTKMEdywdy61ULnVBP2+8
	 zp+sWqiDVR7a0GIBS67GeWSF94r8ugyryFnBU3qvr8x+b0OyLaTQ9jzX/nygZQDi6b
	 v7f39T8ICyEkIDNzWosdvngu32r48JRKRT/NJuDDjsIcQ49X22O2iB967W8UknozZl
	 CTwUencrutetUgfz0Y0Lo4P0lDXtnflnybqcjopiqVTBhYUxPiD16hMcRmAsib+uFo
	 3es9zqoHZeraA==
Date: Wed, 6 Nov 2024 15:17:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241106211738.GA1540450@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106175054.GG5006@unreal>

On Wed, Nov 06, 2024 at 07:50:54PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 06, 2024 at 11:12:57AM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 06, 2024 at 02:22:51PM +0200, Leon Romanovsky wrote:
> > > On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > > > Add PCIe hardware statistics support to the fbnic driver. These stats
> > > > provide insight into PCIe transaction performance and error conditions,
> > > > including, read/write and completion TLP counts and DWORD counts and
> > > > debug counters for tag, completion credit and NP credit exhaustion
> > > > 
> > > > The stats are exposed via ethtool and can be used to monitor PCIe
> > > > performance and debug PCIe issues.
> > > 
> > > And how does PCIe statistics belong to ethtool?
> > > 
> > > This PCIe statistics to debug PCIe errors and arguably should be part of
> > > PCI core and not hidden in netdev tool.
> > 
> > How would this be done in the PCI core?  As far as I can tell, all
> > these registers are device-specific and live in some device BAR.
> 
> I would expect some sysfs file/directory exposed through PCI core.
> That sysfs needs to be connected to the relevant device through
> callback, like we are doing with .sriov_configure(). So every PCI
> device will be able to expose statistics without relation to netdev.
> 
> That interface should provide read access and write access with zero
> value to reset the counter/counters.

Seems plausible.  We do already have something sort of similar with
aer_stats_attrs[].  I don't think there's a way to reset them though,
and they're just all thrown in the top-level device directory, which
probably isn't scalable.

Bjorn

