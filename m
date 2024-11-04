Return-Path: <linux-pci+bounces-15963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79C9BB799
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081CD1C21EC8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C2165F1A;
	Mon,  4 Nov 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BTprzF+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E122AD0C;
	Mon,  4 Nov 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730247; cv=none; b=OuVd0DF47yHbIgwzE0epvtqX4FF89LZn+iue7S4TrVKprO9BVfagZCRR3+C6qZq/GtXarx4CodXBHjd77SZDmumDMT8X1ZmFnt2VET/9yRdmngkeeSgZXrKSOWXhNQmhAUUHetJvDEkK1J/qV37aty89kEuCEM5pXu/k9kF684w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730247; c=relaxed/simple;
	bh=dFWMHWo1n5jFkTLEUAVg6+FBsVNcLtsbTmw+hxSsSmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXJsFON9L8kU7MODZmhl17W8rKTRaCZx8+2XqdQg4FkMc98IUXP53nmhJeZTWwWT4DyPCrcYKCa82J832fq2GCG4/OB8OgrJaLUS0/xM5EwuNLLCq8/qLMTGkeGnk9//Jhy0u4uFlQW5Aa9kacxXENLhBxKEGcb5awfkIdww3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BTprzF+H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BA5F40E0220;
	Mon,  4 Nov 2024 14:24:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zjlq6e9v7tSE; Mon,  4 Nov 2024 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730730238; bh=mi5Jlho0Cd1trC6Apgms9J9UjhU9YxE55TxITVhcGDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTprzF+H/KnxeUjxe1V78yt8x8Ryu4cvLGuCPnpk+JGrHPkEXSqLx6EEZF13dmWln
	 NHSkRWUtZrgtdLfDeKaQIVncgUONUMoIJw52ez6QyjCvAEYgTl54RRRr6eRRWFEosC
	 VKu6KpzpG3Gaa2m6DeL0a+M0Y1lJKDdmhdBSt5SWffUY3WoEW9nTRmOw/5iNpTtSmv
	 leAmMYbWarYLpTnHVjGrgype7jNesZMufPPEGs/f/m1mUC4upRvOeT9pRMxkHUh8l8
	 4EioiWaUPHhLZHlG3GsXPHl10CnZIPMt5VvbpLZH+Nlj/P4aihVQY1UZ8lYn5FkkvP
	 sxvNgL3WWRppFFKtmQuh+qaggjTddCs3iOYHE63n4CFwn6WPgQrirxJ6eHJFcMh3Gi
	 HOMxSAWjZUQyyDzgmJHAe9odawbSO8InmDefynhdfPjUl0CsBtb/6BJJd8QI6YNk/B
	 lIc0N6v5Ufd9Mjh4f2uxOCVLpkSG/tlGYNH5iDmfzi2EiVvgpuFcYBWiz4+jbVnEG/
	 scJwf7RvgTS9Aq9ntzLleKwQj2tb+Jth8N/2IIXZL4PnZhtryBRIFBn3i1geFe6kWj
	 kyKH4DtrwCrkyyejgU2wZD8wTfyIRwDMZ4nZjoyx0f37c3tRCLD03lwANyepVPt9JC
	 zGtah/pJ2TkxdJwUxegzuCNA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D191540E0163;
	Mon,  4 Nov 2024 14:23:36 +0000 (UTC)
Date: Mon, 4 Nov 2024 15:23:29 +0100
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
Subject: Re: [PATCH 09/16] x86/amd_nb, x86/amd_node: Simplify
 amd_pci_dev_to_node_id()
Message-ID: <20241104142329.GUZyjY4Zwb6WyB2JYv@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-10-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-10-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:43PM +0000, Yazen Ghannam wrote:
> diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
> index 419a0ad13ef2..8e473a293706 100644
> --- a/arch/x86/include/asm/amd_node.h
> +++ b/arch/x86/include/asm/amd_node.h
> @@ -30,4 +30,10 @@ static inline u16 amd_num_nodes(void)
>  	return topology_amd_nodes_per_pkg() * topology_max_packages();
>  }
>  
> +/* Caller must ensure the input is an AMD node device. */

You can ensure that yourself by checking the PCI vendor in the PCI device,
right?

IOW, pdev->vendor...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

