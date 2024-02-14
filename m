Return-Path: <linux-pci+bounces-3470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5512855578
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21DB281BA0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFA13F00D;
	Wed, 14 Feb 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgcKYgsI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52F13EFE3
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948150; cv=none; b=mew9jXAxsD+jzx3wwNJXMWX5NXyqJeKtixtvxElghR276qaFmKjN29P7McgacJC9ZHkEkObhqD9KahclpBxspXoHDx6wvLyAAtOX6zGp70fxkIaXIHEfjZbhA0KHPGwCPfksHRd2zd88cJddpnI38OuyyozKiDPP90UptthE1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948150; c=relaxed/simple;
	bh=j2ieBIrGNYUGAMyLMdXSeK+wg6d3XEQv/C1jTLZi1lw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zzvfv5UBKm0Xg4ojYaOQ+gxIW6LcGS3XGp5k+H+kz2efm5DVOoZZRfdbTfnvWq9QE6Lv0ATmiWLKaC0dIf2SPuUwh6BuFHACDaURQY0ipySCTyxjEgwJ11K3gstFCbD3OHg3r0odkGzbf8TRDR9dEuOORgK3tV7TKvZTWpLXsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgcKYgsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F850C433C7;
	Wed, 14 Feb 2024 22:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948150;
	bh=j2ieBIrGNYUGAMyLMdXSeK+wg6d3XEQv/C1jTLZi1lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DgcKYgsIb/gDx9hPMjugg7gl+zpxlPnmIJqdaNh0LJ3J7qpUrLxexhf+CpTjlZeyT
	 K0FvSteN6hOH+ONAVmakdOy3HHfJr/YAMJJb46NxPAS6PhKifjw9BCxdnzYg5Tbjq4
	 ptRDtkEvGjw7k4W7ZOjfP34nTZRH3Hcfju87LcKCAtGavX2xMBRcrnq4D928NhYlNf
	 8sb7O0lapLH2gH+5+EPZBcRbtdBrFs/PDCXYYj6IHEmh2urHDwpVAD9QqoH6wEogVP
	 FegcjDQL3/kxMpW/zl7jm5NLgONbvtHfpMyKHMZpWcyps1ee9Hl94aH8x3znFymqTj
	 LkDcyXjfaW5vQ==
Date: Wed, 14 Feb 2024 16:02:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240214220228.GA1266356@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206171043.GE8333@thinkpad>

On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> ...

> ... And for your usecase, allowing the controller driver to start
> the link post boot just because a device on your Pixel phone comes
> up later is not a good argument. You _should_not_ define the
> behavior of a controller driver based on one platform, it is really
> a bad design.

I haven't followed the entire discussion, and I don't know much about
the specifics of Ajay's situation, but from the controller driver's
point of view, shouldn't a device coming up later look like a normal
hot-add?

I think most drivers are designed with the assumption that Endpoints
are present and powered up at the time of host controller probe, which
seems a little stronger than necessary.

I think the host controller probe should initialize the Root Port such
that its LTSSM enters the Detect state, and that much should be
basically straight-line code with no waiting.  If no Endpoint is
attached, i.e., "the slot is empty", it would be nice if the probe
could then complete immediately without waiting at all.

If the link comes up later, could we handle it as a hot-add?  This
might be an actual hot-add, or it might be that an Endpoint was
present at boot but link training didn't complete until later.

I admit it doesn't look trivial to actually implement this.  We would
need to be able to detect link-up events, e.g., via hotplug or other
link management interrupts.  Lacking that hardware functionality, we
might need driver-specific code to wait for the link to come up
(possibly drivers could skip the wait if they can detect the "slot
empty" case).

Also, the hotplug functionality (pciehp or acpiphp) is currently
initialized later and there's probably a race with enabling and
detecting hot-add events in the "slot occupied" case.

Bjorn

