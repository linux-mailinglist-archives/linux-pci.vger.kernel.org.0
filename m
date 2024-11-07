Return-Path: <linux-pci+bounces-16202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10A9BFFE1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639911F22E30
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5E1D79BB;
	Thu,  7 Nov 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNYIz/hX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41241D54C5;
	Thu,  7 Nov 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967812; cv=none; b=VcsR2OjlG3ZtAo+xsmSDvrDdILwj1+2zKm+YohWJwUqHlQK9M0vx7RMosbR0dQG+PZ0RH5s7btIKDGDUV3waTbFYmWHL/HKS0W7YCMlrR4GkhxIQZFrfM+wli+1xcuH8Get+cQFWMCxgQ64qQA3NTaP95EqzrGNeIGuSn8kX92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967812; c=relaxed/simple;
	bh=Jbge6csLBNINYCXV95rg8/Nd3s0MiFub4Pcr7+ZJbGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+UM+S17rxexX1Ikk5T/UrynA5IcZIJxVmj1DT8JqHyQASgWxds6wGPWOCA/Bc/1tuieiYkOUPGHF/UDzkIPrtMRA+JwxOhSNgS3MpdSzybHMjET4/UBngkURkPgHHk1WBPj5cnOA+3YIyKFKLC/m3Qd+ZLU4uS+0VVFt6Npxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNYIz/hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C65C4CECC;
	Thu,  7 Nov 2024 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730967811;
	bh=Jbge6csLBNINYCXV95rg8/Nd3s0MiFub4Pcr7+ZJbGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNYIz/hXsVN4JPR71e8KybkNE5EmOacdX6hsKefcdPD8zebVEv549cZXEDemLFV+G
	 IdVj9iLlPa3+LsbQKetSkti8VpRkDFBxrByZ787p6MmLMPDOXd760ugIqFOVVM0ZHE
	 e6fwG+epmtbdae8AHOV1K3DuyhFpMicylMfuukRAPCq3kAa4k1zEzAII7H7b2IOh4Y
	 wvmhIQR+egU+5GacIGE4O4sNeHo36O1xF48yypbI3x5k8aIBUgq5tK0o9w/7j7yK9u
	 SIvz91ooHyqy+Tu2Vm2hCmUjq1W6zbha9lGq62QLT9dAlL/Ws3cIijs2mPDZAK+qKG
	 lsJ3xijuWWLPg==
Date: Thu, 7 Nov 2024 10:23:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107082327.GI5006@unreal>
References: <20241106122251.GC5006@unreal>
 <20241106171257.GA1529850@bhelgaas>
 <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
 <20241106160958.6d287fd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106160958.6d287fd8@kernel.org>

On Wed, Nov 06, 2024 at 04:09:58PM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 18:36:16 +0100 Andrew Lunn wrote:
> > > How would this be done in the PCI core?  As far as I can tell, all
> > > these registers are device-specific and live in some device BAR.  
> > 
> > Is this a licences PCIe core?
> > 
> > Could the same statistics appear in other devices which licence the
> > same core? Maybe this needs pulling out into a helper?
> 
> The core is licensed but I believe the _USER in the defines names means
> the stats sit in the integration logic not the licensed IP. I could be
> wrong.
> 
> > If this is true, other uses of this core might not be networking
> > hardware, so ethtool -S would not be the best interfaces. Then they
> > should appear in debugfs?
> 
> I tried to push back on adding PCIe config to network tooling,
> and nobody listened. Look at all the PCI stuff in devlink params.
> Some vendors dump PCIe signal integrity into ethtool -S

Can you please give an example? I grepped various keywords and didn't
find anything suspicious.

Thanks

