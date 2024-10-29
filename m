Return-Path: <linux-pci+bounces-15535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BE9B4D0E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF87B22B88
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A0192B7F;
	Tue, 29 Oct 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iPqZJMWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E211885BD;
	Tue, 29 Oct 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214559; cv=none; b=tgdeHTEV6hjKikIASlLon3/nhh4fHbh20oy7dTCGqzTV/l256J4vjbm8tW+MXMw4KMDjNiXtUl/sQRFE6Ba7vhzTFtT3pybWAzdBDEm5t8Mg8n4PRwwipOLXnigyyAsY9HBgLSLau+tIdAh9mtKbOdMfAK/9iEyj3AOTdVvojzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214559; c=relaxed/simple;
	bh=Uu7MSsIfwM/nK86sCizAjmT3qbPGspNamKH58t1cCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyqaEQRa2zlHYVj4KAm4nuL2RCQvbJxi0atzuONwIXq9HQ61JfyQ2Yz0FLeZeRB8ZybYE5v3dqjytqkbaqvFZjeGnBoqW1XKISTQ+eH3/CSACvSQuBOUJ1MbIeHhJFx8O9XJBNgUdBD+8G8v3SmPw6GcjcylhhWP5mzFhDMrVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iPqZJMWP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B99D40E0191;
	Tue, 29 Oct 2024 15:09:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UpTCgdSWcxWY; Tue, 29 Oct 2024 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730214550; bh=CGpcOAn8UHlSL3WE5rbvoEk8vV1upCzgOQR+a5Jg3zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPqZJMWP/S97Nw3qt0o9eoCnSWA0S5IDfZgXGAEtZQ7JZWnosysRxl+HGVtwoGUDq
	 +jCfzuzv6y8wrw84eZ18870uqv8Fjyxpl3DixUrwno6AP9ikM0/qQTn6R+uIN+yEve
	 aSyl5n6iZmq3s+w8MIUIDTedEpgvJeGNNpL8gxyySd0YolqY8l97DSFa3wpb7cbGBx
	 IhcwlV0Qml8Tymeq8EFT+PcsDfCG7cpM7cM0lUhyDa3u+wP5I3p+PqKdzbK0WY8CfQ
	 Ud8ZIfFZj7hILM02w8A4I9ypSPnZH8eBr0rdQeRXOw0JrZp8fwM8RPbM8w7AOe7CNr
	 TwLHRBgdKJh3p2egKaVB2EaVEjjVaB0soGOBUZVHK8wi6EDX2zyzDLVSw4pvqO3j/t
	 PmT6bBBIWguwUsk2La+8SbgbEsaMrIkwEEcxJAut/d9BSKX7rBZ5KituH3bUdBe6IH
	 AIui1ceCdOEGc8IjUzBLWtxRPZ8tdLRs3uBgN2QkauRlEfM3qkGzptraA2n3xfjgud
	 ui73I8Fi54+uW8qOnoq0hqGjMEEGZPnXixtvpktbVta1g959eDcsQOGQXwNDnYrTN6
	 96M2oubTs2pilfIE/35/3JQm6AQXZav8+IafheJvSgDsbTKbxxRuEQApGD81J55wU/
	 I0NTZEfjkQl0Ovif27+b2MRg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCA8F40E0192;
	Tue, 29 Oct 2024 15:08:48 +0000 (UTC)
Date: Tue, 29 Oct 2024 16:08:47 +0100
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
Message-ID: <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029143928.GA1011322@yaz-khff2.amd.com>

On Tue, Oct 29, 2024 at 10:39:28AM -0400, Yazen Ghannam wrote:
> How can I enable this check myself?

It is part of my silly patch checking script:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=vp

in here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/tree/.tip/bin/vp.py?h=vp

but it probably isn't ready for public consumption yet.

I probably should try to package it properly when there's time...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

