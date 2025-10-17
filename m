Return-Path: <linux-pci+bounces-38432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD9BE7322
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F926278DB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D526F2B2;
	Fri, 17 Oct 2025 08:32:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291E29A31D;
	Fri, 17 Oct 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689940; cv=none; b=XM321112OHnG9MJ8nvhQUnSb3zLB4jYmlXejRkn9OKkrzke79jvQLqk84qPRGnvjupGhfe1XQIROrauqIg9w5AJ94AY1zotnneTHeiSFYQVvmDU6y2S8msdpEYgrOK4ijfqej0VU35snOC5db80nBrXbTc6sOafFLAYBWRuJr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689940; c=relaxed/simple;
	bh=lKOf9JuIDX4uy3fcGx8kK8IIwOIACYdHYSQFsVoys3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr7KoVzA9sfK0zNhS/VQmTGxvmwu0fSzzPPujIDHxA3PbTLvdkNqt9kbSFAILNTidnhvB3h4o5LCQP2dYR6xo/mBfXxJb3TqMaBWzCyuQncX7+yJvyrxXf/d1hwxQTho5HCDhWyFgnVHS4H+zsgiPaHnji83FhmLdWz+SEDqCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AE0C42C051C7;
	Fri, 17 Oct 2025 10:32:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8541A4A12; Fri, 17 Oct 2025 10:32:07 +0200 (CEST)
Date: Fri, 17 Oct 2025 10:32:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPH_B7SiJ8KnIAwJ@wunner.de>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>

[cc += Ilpo]

On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> PCI devices are created via pci_scan_slot() and similar, and are
> promptly configured for runtime PM (pci_pm_init()). They are initially
> prevented from suspending by way of pm_runtime_forbid(); however, it's
> expected that user space may override this via sysfs [1].
> 
> Now, sometime after initial scan, a PCI device receives its BAR
> configuration (pci_assign_unassigned_bus_resources(), etc.).
> 
> If a PCI device is allowed to suspend between pci_scan_slot() and
> pci_assign_unassigned_bus_resources(), then pci-driver.c will
> save/restore incorrect BAR configuration for the device, and the device
> may cease to function.
> 
> This behavior races with user space, since user space may enable runtime
> PM [1] as soon as it sees the device, which may be before BAR
> configuration.
> 
> Prevent suspending in this intermediate state by holding a runtime PM
> reference until the device is fully initialized and ready for probe().

Not sure if that is comprehensible by everybody.  The point is that
unbound devices are left in D0 but are nevertheless allowed to
(logically) runtime suspend.  And pci_pm_runtime_suspend() may call
pci_save_state() while config space isn't fully initialized yet,
or pci_pm_runtime_resume() may call pci_restore_state() (via
pci_pm_default_resume_early()) and overwrite initialized config space
with uninitialized data.

Have you actually seen this happen in practice?  Normally enumeration
happens during subsys_initcall time, when user space isn't running yet.
Hotplug may be an exception though.

Patch LGTM in principle, but adding Ilpo to cc who is refactoring PCI
resource allocation and may judge whether this can actually happen.

I think the code comments you're adding are a little verbose and a simple
/* acquired in pci_pm_init() */ in pci_bus_add_device() may be sufficient.

Also, I think it is neither necessary nor useful to actually cc the e-mail
to stable@vger.kernel.org if you include a stable designation in the
patch.  I believe stable maintainers only pick up backports from that list,
not patches intended for upstream.

Thanks,

Lukas

