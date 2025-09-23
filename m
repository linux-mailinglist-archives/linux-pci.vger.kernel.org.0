Return-Path: <linux-pci+bounces-36821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DAFB97CC4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 01:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86BD4C15CA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 23:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50E30C617;
	Tue, 23 Sep 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IleXtZkN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5E28466F;
	Tue, 23 Sep 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670034; cv=none; b=YlCmTpk1L8CeOC6yxtulfLaGllSff9H2N4QEJ4NfDE1HVQ5p7hkdC0ybpSR1vaBJDUTYTWgdN25/YZY+H2rqxabI+baA1sA/2D8Wyu90rb0fV+hvi7PS1karxHvb0n15t52dYcgdO4ZkqlbdX5vPwWGf3nIDT5L3/1xmms63g7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670034; c=relaxed/simple;
	bh=oO7CnjqU+Nx4PqWdiK10pJe8/7xLNQvRZTwRq0LL+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AHhwhIIayI/cV5cJuhub6ikSVnUetsURGvyW/ue+GSxBeNrzKw5fj2Ng+BDjHYKU6hWW7ZYTjlRL4+BVKjsZGQBULJX3fnq40RnpnnLApbkq62MNB988917y+vgshRXO0bFHjssoydmVzpWYLmLC2O0S7ORgF20ZWTtEvTrZ0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IleXtZkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7FCC4CEF5;
	Tue, 23 Sep 2025 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758670034;
	bh=oO7CnjqU+Nx4PqWdiK10pJe8/7xLNQvRZTwRq0LL+CM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IleXtZkNbWZ7zFyFJ9/X/oN5lkJonldXHhDVnLIaqqCSrkN6e2NwqB6/HKbSkpeba
	 HFGxPtUkd5iHkingsfTwDWbvhrg7tn6PsbfBLSg382o+YChZwLu7ADu4vOey9dkz6y
	 7gqoEpNB6FeIBa91tkMkhEvELDUTrNyAsjIvGjB2Ja6/4BZ5VWs3NElEbmUc2Kolot
	 pJe5+Dkg9wl2oz3socbnwFLvrIlc74QBZddMV0LQ8VtEOEYt0dbbyTXgYI5wd0FChk
	 XSJXEstsAmHQepN7XApl32z4maU/AxS6C2XRAo648GwcNm8aEYMQv3fjtIUDuGr0Ur
	 yyyFO/eDpninQ==
Date: Tue, 23 Sep 2025 18:27:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	Ethan Zhao <etzhao1900@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <20250923232712.GA2092207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNMoMY17CTR2_jQz@google.com>

On Tue, Sep 23, 2025 at 04:07:29PM -0700, Brian Norris wrote:
> On Tue, Sep 23, 2025 at 02:02:31PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 20, 2025 at 10:26:08AM -0700, Brian Norris wrote:
> > > From: Brian Norris <briannorris@google.com>
> > > 
> > > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > > secondary_bus_number, and subordinate_bus_number all access config
> > > registers, but they don't check the runtime PM state. If the device is
> > > in D3cold, we may see -EINVAL or even bogus values.
> > > 
> > > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > > rest of the similar sysfs attributes.
> > 
> > Protecting the config reads seems right to me.
> > 
> > If the device is in D3cold, a config read will result in a Completion
> > Timeout.  On most x86 platforms that's "fine" and merely results in ~0
> > data.  But that's merely convention, not a PCIe spec requirement.
> > 
> > I think it's a potential issue with PCIe controllers used on arm64 and
> > might result in an SError or synchronous abort from which we don't
> > recover well.  I'd love to hear actual experience about how reading
> > "current_link_speed" works on a device in D3cold in an arm64 system.
> 
> I'm working on a few such arm64 systems :) (pcie-qcom Chromebooks, and
> non-upstream DWC-based Pixel phones; I have a little more knowledge of
> the latter.) The answers may vary by SoC, and especially by PCIe
> implementation. ARM SoCs are notoriously ... diverse.
> 
> To my knowledge, it can be several of the above on arm64 + DWC.
> 
> * pci_generic_config_read() -> pci_ops::map_bus() may return NULL, in
>   which case we get PCIBIOS_DEVICE_NOT_FOUND / -EINVAL. And specifically
>   on arm64 with DWC PCIe, dw_pcie_other_conf_map_bus() may see the link
>   down on a suspended bridge and return NULL.
> 
> * The map_bus() check is admittedly racy, so we might still *actually*
>   hit the hardware, at which point this gets even more
>   implementation-defined:
> 
>   (a) if the PCIe HW is not powered (for example, if we put the link to
>       L3 and fully powered off the controller to save power), we might
>       not even get a completion timeout, and it depends on how the
>       SoC is wired up. But I believe this tends to be SError, and a
>       crash.
> 
>   (b) if the PCIe HW is powered but something else is down (e.g., link
>       in L2, device in D3cold, etc.), we'll get a Completion Timeout,
>       and a ~0 response. I also was under the impression a ~0 response
>       is not spec-mandated, but I believe it's noted in the Synopsys
>       documentation.

The ~0 response is not required by the PCIe spec, although there's at
least one implementation note to the effect that a Root Complex
intended for use with software that depends on ~0 data when a config
request fails with Unsupported Request must synthesize that value
(this one is from PCIe r7.0, sec 2.3.2).

> NB: I'm not sure there is really great upstream support for arm64 +
> D3cold yet. If they're not using ACPI (as few arm64 systems do), they
> probably don't have the appropriate platform_pci_* hooks to really
> manage it properly. There have been some prior attempts at adding
> non-x86/ACPI hooks for this, although for different reasons:
> 
>     https://lore.kernel.org/linux-pci/a38e76d6f3a90d7c968c32cee97604f3c41cbccf.camel@mediatek.com/
>     [PATCH] PCI:PM: Support platforms that do not implement ACPI
> 
> That submission stalled because it didn't really have the whole picture
> (in that case, the wwan/modem driver in question).
> 
> > As Ethan and Andrey pointed out, we could skip max_link_speed_show()
> > because pcie_get_speed_cap() already uses a cached value and doesn't
> > do a config access.
> 
> Ack, I'll drop that part of the change.
> 
> > max_link_width_show() is similar and also comes from PCI_EXP_LNKCAP
> > but is not currently cached, so I think we do need that one.  Worth a
> > comment to explain the non-obvious difference.
> 
> Sure, I'll add a comment for max_link_width.
> 
> > PCI_EXP_LNKCAP is ostensibly read-only and could conceivably be
> > cached, but the ASPM exit latencies can change based on the Common
> > Clock Configuration.
> 
> I'll plan not to add additional caching, unless excess wakeups becomes a
> problem.

Perfect, thanks, I'll watch for this.

Bjorn

