Return-Path: <linux-pci+bounces-25961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD736A8A9A4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AB87A3F36
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3523371D;
	Tue, 15 Apr 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQOdDcJO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE92550A3;
	Tue, 15 Apr 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750307; cv=none; b=VcxMw8Kxd8zwbh+aDoabQnt0uem8Uzy0wTOhs1PX/qR7z+Mn7YGexrRAmigu0UkUj44JdDTwmbP4h7BHCVo/boZYWu0b2qgsIhIPNxV+OYEqkZRIbEnIdQKo22o1H6lstOitBGIkkrT1jJs8MQXRAvnW4Fz+1ykoxVU6NdDIKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750307; c=relaxed/simple;
	bh=NQ4iPhEgvX+2SenVE9kTgdSqML0X9cHumSV7NU3ONoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H20+Ekx2uV/LntJThsNsaPEaSDcKVDhzzkdO5EgSR51Zm8GvkXzj+BnwaMPbOjHcprfT59hY79ZEa+RqIpJGcz7LO5RmMvBzeM/c/MXkzr7N2GjnoAwxVC8ds6HX9bvYJjLJKL+oYm2dqljLSKYWuAe8XKwZLZsA3pgMRj195T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQOdDcJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B687C4CEE7;
	Tue, 15 Apr 2025 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744750306;
	bh=NQ4iPhEgvX+2SenVE9kTgdSqML0X9cHumSV7NU3ONoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQOdDcJOSgYHYjBw0jfVGGA5Nafn9GEipT+hpS7bMzQiKOqN3xBv9NjpCead/WJfK
	 5E6UxkEhK90vK1/NJ2Emu1xhMGDRLt52rc6nSaTyAKu53EArJm93IcRtPKxy6uppl5
	 VFxVLnrvuYJFxpVFZ4HYO3QV5ft9S+Fc8iCOBQNih9NuhJMt8vbliLJ9t7++iCgi8C
	 /t9d0dNvfP3RToP+eb8Hqd+8XNYsGtxptFFycZCcfxpANtXMAIVUNi+yxdi+/kdAXZ
	 OlCyevQS9uv5lthS0XbFcZwgw0OQSXAcBLChgv9WhTKGS60Mv269f7dmevt4ksNIhb
	 v3js0gUibDBbg==
Date: Tue, 15 Apr 2025 14:51:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] Ignore spurious PCIe hotplug events
Message-ID: <Z_7G3rq08FCFU0gy@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1744298239.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744298239.git.lukas@wunner.de>

On Thu, Apr 10, 2025 at 05:27:10PM +0200, Lukas Wunner wrote:
> Trying to kill several birds with one stone here:
> 
> First of all, PCIe hotplug is deliberately ignoring link events occurring
> as a side effect of Downstream Port Containment.  But it's not yet ignoring
> Presence Detect Changed events.  These can happen if a hotplug bridge uses
> in-band presence detect.  Reported by Keith Busch, patch [1/2] seeks to
> fix it.
> 
> Second, PCIe hotplug is deliberately ignoring link events and Presence
> Detect Changed events occurring as a side effect of a Secondary Bus Reset.
> But that's no longer working properly since the introduction of bandwidth
> control in v6.13-rc1.  Actually it never worked properly, but bandwidth
> control is now mercilessly exposing the issue.  VFIO is thus broken,
> it resets the device on passthrough.  Reported by Joel Mathew Thomas.
> 
> Third, link or presence events can not only occur as a side effect of DPC
> or SBR, but also because of suspend to D3cold, a firmware update or FPGA
> reconfiguration.  In particular, Altera engineers report that the link
> goes down as a side effect of FPGA reconfiguration and the PCIe hotplug
> driver responds by disabling slot power.  Obviously not what you'd want
> while the FPGA is being reconfigured!
> 
> This leads me to believe that we need a generic mechanism to tell hotplug
> drivers that spurious link changes are ongoing which need to be ignored.
> Patch [2/2] introduces an API for it and the first user is SBR handling
> in PCIe hotplug.  This fixes the issue exposed by bandwidth control.
> It also aligns DPC and SBR handling in the PCIe hotplug driver such that
> they use the same code path.
> 
> The API pci_hp_ignore_link_change() / pci_hp_unignore_link_change() is
> initially not exported.  It can be once the first modular user shows up.
> 
> Although these are technically fixes, they're slightly intrusive, so it
> would be good to let them simmer in linux-next for a while.  One option
> would be to apply for v6.16 and let Greg & Sasha do the backporting.
> Another would be to apply to the for-linus branch for v6.15 but wait
> maybe 4 weeks before a pull request is sent.

I'm a bit conflicted on this because it does appear to help. But it is
ignoring a PDC and there are times where it is legit telling the host
the device presence really has changed. There are switches that let you
toggle downstream connections to change what's attached and it causes a
DPC event, swapping out the downstream device at the same time. So this
change has the pci driver resume with the wrong device if you happen to
be in such a situation. I don't have such switches anymore, so I'd hate
to stand in the way over some theoretical issue when this patch helps a
more immediate one.

