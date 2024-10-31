Return-Path: <linux-pci+bounces-15704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF859B7992
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F21C2113A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89119ABAB;
	Thu, 31 Oct 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N6yNuIJy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB1175BF;
	Thu, 31 Oct 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373658; cv=none; b=pf95BxZYdOHjn3xG5PCShsSw8AIaYAQn6Kv64XdeQP8R4w1C5ipVdAt4+kLeVfhQ9WPrcHNlMXFZzkE98SZkKrEibeEc4J/i+IbneNCY1bdJG5Gb+H19YPYTvcQbLlkG8QgSNAlBC/ziGOtJJHOSByAtgD+UlsnXo4hNPV6xuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373658; c=relaxed/simple;
	bh=upHPwx55hxxZ+6K0pfkfoQMLECjDZs0A7t7naqRPHvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9qs+oY16Z+G1+3susBSIuI+kzBWvtD7DmmJBKsxjy/JYzAvzLcwdOg9/Px7sNdseU4L5dbL4DKLwc7DVfSqvv5omAg3/htieFAWuNmBNo9KBYL6kIVipVaS3zaFM4aINyKeHTz/SpkA2mz4Id9E4MB8y4lE/oWLxi3WYydYaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N6yNuIJy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9093340E015F;
	Thu, 31 Oct 2024 11:20:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nxVPQm6v3gQU; Thu, 31 Oct 2024 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730373649; bh=4kgxj+Oy+aos2Q4VuRMB7uY4sjDqeuK8/GP9QzylIOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6yNuIJyRW9ePKvpyv3Z9ShFCuOfo5KYH5g/0PVXJBZOYNwECXjty8dAkfmSP+E0E
	 GJa02a/OuBOsDQLmP56rtp9pkEt+TSLapaGIz/8jwwDy2/ENCVo+wYmHmai18YZRtN
	 TSIxbECsFVNpKqdquj086NZaCDkZL3E0w0etmSAFJsV+qWYi8Y4rdL5YLVdU54tRGr
	 0ZMMblwbw4R0SYNuF3nRltNV9KNRH4QEeJa4NFVGmdZVsN/KV9uTlEOsVJ554PtZpf
	 MX08LucSwAMCRWtWl8fmBvUB9EZU4IF7eFLAvUDhLJNjS4ttgy0H1GMtvtbQ/9++Qw
	 i9GnKs4z86mZnB6+Cu94ZcPrS9HpQ98su9Az3bC8Jbah2upcYPvQB5MrG6L6s2Eh/q
	 e1yfC1EiBxn6xVJ8fi5MghK3SxcDuWFqsAeNnOjeuq0P1yYwgGA757jwwSa9mgW5Rq
	 gw1BNaGR25CDI381pYM8sPBdtgrds4+hr0awuzsoidTl07FKrMidgMYpMPOo6slR7n
	 3SyZoPeE0LMs6S5pi3ZVdhG/Rxb7+sVtx9hIN77D4GBY753bQ91TDWmW/hJ4X3saSZ
	 cmpmJYEBQbOzbwv2zSskPOdrXKvnfSf/suvcB6vr5Pvx4nFvE6tIieoIFtl97hv3Kh
	 RaFpcyOX2H4dGHvr1xSpJp2g=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9791540E019C;
	Thu, 31 Oct 2024 11:20:28 +0000 (UTC)
Date: Thu, 31 Oct 2024 12:20:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 06/16] x86/amd_nb: Simplify root device search
Message-ID: <20241031112027.GIZyNn-2JkbpnNJhw1@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-7-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:40PM +0000, Yazen Ghannam wrote:
> The "root" device search was introduced to support SMN access for Zen
> systems. This device represents a PCIe root complex. It is not the
> same as the "CPU/node" devices found at slots 0x18-0x1F.
> 
> There may be multiple PCIe root complexes within an AMD node. Such is
> the case with server or HEDT systems, etc. Therefore it is not enough to

HEDT?

...

> +struct pci_dev *amd_node_get_root(u16 node)
> +{
> +	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
> +	struct pci_dev *root;
> +	u16 cntl_off;
> +	u8 bus;
> +
> +	if (!boot_cpu_has(X86_FEATURE_ZEN))

check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_node.c:67: Do not use boot_cpu_has() - use cpu_feature_enabled() instead

> +		return NULL;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

