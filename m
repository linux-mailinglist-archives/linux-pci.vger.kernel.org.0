Return-Path: <linux-pci+bounces-27915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9CABAE23
	for <lists+linux-pci@lfdr.de>; Sun, 18 May 2025 08:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FC7AA4AC
	for <lists+linux-pci@lfdr.de>; Sun, 18 May 2025 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75638188006;
	Sun, 18 May 2025 06:20:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB30101E6;
	Sun, 18 May 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747549220; cv=none; b=QcWvlC/Is2O40bCTzzq32XIxuPQ9o4fnxPEGbUou8ZQnRUoRWZceqLd8/N7xRkHyVfiLaLn/hjyxHqOhtSH9zMpRW4Pkm15SMVfmL2UNgKMUKoN4CjzEG2eEsTgKf8POsGxPl2TNYhSYSngZ12HEzwmmRQjg3K/nFP+/JzyrGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747549220; c=relaxed/simple;
	bh=Kskr26+O1GJF48m1UGwNu0yKtkNkdLTgSMgXji7JoN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjtjvabwfuK5Ya700gTnb+HSru5Ls5KPKUPFAAFuH29Gzg7AEx94OBoZC/sPGGR899sR4XxFFlCJwk97o3GAnRVddpS1nBZ/w7WEc3Iv6hVlA3Mo2CInkYt85pWhV+AeQJcthctnifSnkL1F63h8msC8rW6CgIYqlkL9thiCr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5631F2C051F8;
	Sun, 18 May 2025 08:19:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6960054C2D; Sun, 18 May 2025 08:20:07 +0200 (CEST)
Date: Sun, 18 May 2025 08:20:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	Merthan Karaka?? <m3rthn.k@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Put PCIe ports with downstream devices into
 D3 at hibernate
Message-ID: <aCl8F0MA7JXSZYxf@wunner.de>
References: <20250514193406.3998101-1-superm1@kernel.org>
 <20250514193406.3998101-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514193406.3998101-3-superm1@kernel.org>

On Wed, May 14, 2025 at 02:34:05PM -0500, Mario Limonciello wrote:
> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
> pci_pm_suspend_noirq() in that PCIe ports that are power manageable should

Nit: s/should//

> without downstream devices in D0 should be put into their appropriate
> sleep state.

This leads to a lot of code duplication between pci_pm_suspend_noirq()
and pci_pm_poweroff_noirq().  Can the common portion of the code be moved
to a helper invoked by both functions so that it's easier to follow the
logic and understand common and differing parts of the suspend flow?

Thanks,

Lukas

