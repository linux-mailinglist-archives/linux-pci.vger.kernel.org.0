Return-Path: <linux-pci+bounces-15335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDDF9B0902
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB16B21E48
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B915D5A1;
	Fri, 25 Oct 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TopFVnXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D521A4AA;
	Fri, 25 Oct 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871947; cv=none; b=tmrguTD6StEAXgoFhZD/+amaBvROJz5sD/rq5IqPoTkxuUOzZtxRgE0nlLIPfIMVEeLtdJuPOUmhboTE1LJNB58NyoxtxIVBWydJRhxfYiqnRokEEywVYXFzAJhUJQyjUKFmUtrytOpeDsPC/dO9cb2AFyCW41LkNdnD55ZQj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871947; c=relaxed/simple;
	bh=AvkYH+hW9tresKrMteUdveA2LbEIBtWYSDRUa1vdvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUp9AKK90QzCZ6aIrEIHFWlZnuMJCqjOaKhExlzg54sCryqF1hMKbUCV+QOCIcBkrI7EZmEfWr0hFKKgkWRodumshOUN2WdXRW6+ZWQtqcKNK1LCmOuTRMes62g6HzsusMiBYMKwu41aEU+qTCQ3R/n71RonZ0TyH6xH6PdWGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TopFVnXw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A60BE40E0191;
	Fri, 25 Oct 2024 15:59:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x1RYJmiQrgXh; Fri, 25 Oct 2024 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729871937; bh=KgwsroPMB6szToFuiVCMidfCzRwZJN3VNHPp6aYpWP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TopFVnXwRxunlnliPoYE9HEgcpvkZc+rGjOSm7SOSR9LswhO0BBck/2cvg7BiPmfL
	 /TotwacduBzJRd7JCfhdSOwMcm+4oKCujmCtXJP37rmEWwsD9CS/ZZgBkvW6v67Ke0
	 rKtl4UMDRimvcmFt6QffhwnvZ58f0zItGJXkSwGf6gfc694o+pedOqVtu+Bk7lrJuK
	 5W9tNkb2KojGEBQ4/McRpI1o7VhfliGNR8Rvx7IQXaGReSrBCN8G5E+hriYjOFx1+7
	 dBnSjb9nK2r6okA5M6mgWPAoG1ns8b6PlxDwqDG700jMT+IkvcTxDXiryzmDzAnII/
	 jUvzhE9UdWCUpIQYpdbZJ4tNrtbkHE+3kFK5YP5WtCsnRSmA9+QrILhN+NoWwd3FJ0
	 hMfic90UaUCtvFsXzGP6q1Sdjlv48gNNwTdyUqCyYSGS571EGFF85Te1vmz1fG7Xrg
	 IOqoejar9Qi2ySf4GhqTqRf4KK23fMu0q9wQSfJQMiNZiDw4ClwdVHwTVNvWGxVsVp
	 OpAAHvyycRqElJFVZHkqXh01FcjT4SjGrgreSTX4ATtKokEhrGUrBkkve70ryzOZ+P
	 ygt01gNwhZzpR6AHospmDcTrog9UkrfBDldCRe6BcWsmVHRZOng1wKtabbyUGNAvFS
	 C2W/gZt3nv+BDtsv7aKxEU2k=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E24A640E0284;
	Fri, 25 Oct 2024 15:58:35 +0000 (UTC)
Date: Fri, 25 Oct 2024 17:58:30 +0200
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
Subject: Re: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Message-ID: <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-4-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:37PM +0000, Yazen Ghannam wrote:
> @@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>  		return false;
>  
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> -		misc_ids = hygon_nb_misc_ids;
> +	if (boot_cpu_has(X86_FEATURE_ZEN))

check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_nb.c:395: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

