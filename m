Return-Path: <linux-pci+bounces-16201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12559BFFBB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32131F2254E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF831D0DEC;
	Thu,  7 Nov 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2xwSKEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF117DE36;
	Thu,  7 Nov 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967123; cv=none; b=OUIe92BPueFCs78MwMYtwEStO9OjLeLmyC0XB7uNsGc16itALPOL1NlRv5yz3JJkplTMn3pRqkU88E9ZLsHNgxcsrVgBB20AtBbSSZQ6LOJtUCSrujZWRa2UZJQ4LcqYKMy5KJDroTpRsikxe2UYQargY6Jm+Dg8rd145Jnyli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967123; c=relaxed/simple;
	bh=fcZHc+oGpWBFtDLuLdNTCcri+jchA4JT34oxfCUpzPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOx131436W/0Z8bDl9SHKthNiJiLbN0p5SBMfICWIAcbiADfw1CYpbIVWLhwceEl1B7a9wwsJCzAqJYsWhQMUl+hYtBv4GOwTogy/+kp75iCIZEaJaA/53yQT8L+Y3IqxfsIYp2XoSJ0IH7jR96jQ1itkwmxHvPMWaMpO7WDmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2xwSKEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFED5C4CED0;
	Thu,  7 Nov 2024 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730967122;
	bh=fcZHc+oGpWBFtDLuLdNTCcri+jchA4JT34oxfCUpzPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2xwSKEZqzj0bWh/eVRCRuXXrrtbCShFnfBH7BxSJ6A9K3VurJs6nQwmvnQIr78xf
	 UcGzYwE0SbCJtBGrvrJT4X2lu3mkoDi5xjEUT8nPLw1KcCKFjC5x+eDjdFz5qrjXn8
	 XpcHt2DqRqNu5yqxiKV2n6u69YnnLFnlcDh5QdJHd0Upb0+hY9Gt0RWotqlcB2eXdD
	 OL9Kljw+uqeDogYRyY0cYg609ya2uoTNMG548seQBpB4naxujX/YFKn7uyIE24o/xx
	 Lic3ucGP8O0E7Euc3Gec9caICMnQPYCTX0x+EjEjtZtT1jE7brLxZb4A88Yy6RWB9V
	 MBaaKQnUdeoRA==
Date: Thu, 7 Nov 2024 10:11:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20241107081155.GH5006@unreal>
References: <20241106175054.GG5006@unreal>
 <20241106211738.GA1540450@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106211738.GA1540450@bhelgaas>

On Wed, Nov 06, 2024 at 03:17:38PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 07:50:54PM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 06, 2024 at 11:12:57AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Nov 06, 2024 at 02:22:51PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > > > > Add PCIe hardware statistics support to the fbnic driver. These stats
> > > > > provide insight into PCIe transaction performance and error conditions,
> > > > > including, read/write and completion TLP counts and DWORD counts and
> > > > > debug counters for tag, completion credit and NP credit exhaustion
> > > > > 
> > > > > The stats are exposed via ethtool and can be used to monitor PCIe
> > > > > performance and debug PCIe issues.
> > > > 
> > > > And how does PCIe statistics belong to ethtool?
> > > > 
> > > > This PCIe statistics to debug PCIe errors and arguably should be part of
> > > > PCI core and not hidden in netdev tool.
> > > 
> > > How would this be done in the PCI core?  As far as I can tell, all
> > > these registers are device-specific and live in some device BAR.
> > 
> > I would expect some sysfs file/directory exposed through PCI core.
> > That sysfs needs to be connected to the relevant device through
> > callback, like we are doing with .sriov_configure(). So every PCI
> > device will be able to expose statistics without relation to netdev.
> > 
> > That interface should provide read access and write access with zero
> > value to reset the counter/counters.
> 
> Seems plausible.  We do already have something sort of similar with
> aer_stats_attrs[].  I don't think there's a way to reset them though,

Our HW supports reset of PCIe counters.

> and they're just all thrown in the top-level device directory, which
> probably isn't scalable.

This is why directory is probably the best solution.

Thanks

> 
> Bjorn

