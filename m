Return-Path: <linux-pci+bounces-15967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893389BB7D2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355651F23937
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4DA1AE850;
	Mon,  4 Nov 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DmpTyiC4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0742AE93;
	Mon,  4 Nov 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730630; cv=none; b=M2OQ8eCH8nhvg1agveSfQmsagRHBw29Ewtqrcpu4RmgNltUS3dV14X0U66iAqwLt8Ru9IhQ7gfGuSvH9AYbgUO80izn/RROCCKQxsGEiE7mQc823EaLIW6ygau/Xs7NnpugGma4SnRAy9DJJIHshpVuh5cJFXyVn8kLv6FqZtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730630; c=relaxed/simple;
	bh=ob7Ymv2VtFIWc3A9FGPeqHYSg5qYODu1P4mcfNOJwDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5HIJ/eWF2KzNzdtIulR0wjynA3luHpuCkGlT0MOmixUNGMrjg1QnTnp0mXGFZvPiYbF78sH9uv372jnJsqMaLeRO3SDJD43acOsHxX0xouv0HKSRYnTLxLgj4onBZWlCbgj+pVlwM6AOmUYp8YwlXn7NKD7FBAaKLUpmkY9fcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DmpTyiC4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CC5040E0220;
	Mon,  4 Nov 2024 14:30:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B6WcrwVm8o4Z; Mon,  4 Nov 2024 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730730620; bh=r7TPsYnu7shSZRrjt86Hei071WcOU4iKf7oZwIKF00U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmpTyiC4e4k/hOuVIVm0mbOFwL6hhkpI5na2QLF9fNHDEYsXj4a9vv6VYK5aJI3v7
	 AkVD7FpZ30Hob/88JRMpEqKvQzDdABvfqtPO9p3IwAb4CyTkbilOYDw/ifR2cQtSH7
	 mBwurJ/nKdCa8FeSF65VXAQ0T8NFLLpSRWSue3Jn+/GW9P2LDH48tYrmYWdKc1A/2/
	 kmQuJZ2Cy7zENnQI0pjzw4ctK5scJiw3WkwYZiUcrOAQpGxmuobm9VYQw0/30JI55F
	 sY7ATdCvTeTWdTyhhjfdDCEQbMkpnyHKezJgdIJMSRGuRdlF9mmqR/Xoebynj3D+uY
	 Xaj9Q8CNLW6w0QQzK4lSKqAmRC/drKtp6FW23XAdIxm+LECZpIexndeGeUzWAFJk0u
	 XdAJN5gl3/iCHMWQgaLrYwLECzWJQI4mRVJS0FV5p+RMFfyn9SNa5Qr0kjHZ4a7yZ1
	 7fST4PZaRhws4Z0+Fh45vUEYeU2/8H1PyO2uXxh+dTk7QgfifP3gj1lKUIHaXi8fhc
	 Mn6uNwQf+TJfIz9epVy+duT8irWjPDtrI+EhdZ6r1GqZYr+dNSy6j3+cBXGAaQSP4H
	 dM8zIx2G9TALYkH7BClAJdyMTnD3gwwWsAFFNKJXtFH257VC9Wkb6cBe7KChon1P4P
	 rGjZq34yuH0lcLvS4SWQskWo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37F8D40E0261;
	Mon,  4 Nov 2024 14:29:59 +0000 (UTC)
Date: Mon, 4 Nov 2024 15:29:58 +0100
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
Subject: Re: [PATCH 10/16] x86/amd_nb: Move SMN access code to a new amd_smn
 driver
Message-ID: <20241104142958.GVZyjaZtONnLIJAUo7@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-11-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-11-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:44PM +0000, Yazen Ghannam wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba5252d8e21c..a03ffa5b6bb1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -3128,6 +3128,9 @@ config AMD_NODE
>  	def_bool y
>  	depends on CPU_SUP_AMD && PCI
>  
> +config AMD_SMN
> +	def_bool y
> +	depends on AMD_NODE

Why is this a separate compilation unit and not part of amd_node.c? Especially
if it depends on it.

I don't see the real need for having smaller compilation units. Both the node
and the smn stuff will end up being built-in in 99% of the configs. So why are
we making separate Kconfig items and yadda yadda?

Just do a single amd_node and that's it. We can always split later, if really
needed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

