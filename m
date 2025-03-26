Return-Path: <linux-pci+bounces-24757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3DA71595
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D583A7780
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348714B965;
	Wed, 26 Mar 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aG/ouA9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782DEEC3;
	Wed, 26 Mar 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988131; cv=none; b=FTj/5+zc14yt8J9XTYokhy0S98EW/Wp5D/l+mtu/VcesAmrJlbvdZi9UB8zqsocRSfE/mdoJJjrvAFaUVpE9ckKIejJjuCkd6ugXuYXn9rg/e03SRWhy0Vvhs1kXIIkv0gGBthjL9VBuM/KqFbDZ68CmtdEVTQII5hwXbLje5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988131; c=relaxed/simple;
	bh=DDYSSoeVhtr1bSG7emTvEf7aXB/ybdiJGg8e+EDIylA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoZ/onsH3lXipukHKBttXsikin0tIHfNBXHMO6YKmDWHgfldGFmdJOAYdY/GhEnqGQcfNdRB3Z59AAsvV+2JfY3kjVpgSEGu/GpXLOhjz/V5re44F+ahJ8hivKsX4eBCS3NTTyMFznjvRHzZGHu/6g8dKPjQLPrBRvQt64pEN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aG/ouA9V reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C77140E01FF;
	Wed, 26 Mar 2025 11:22:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2BBJubJfUa6X; Wed, 26 Mar 2025 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742988121; bh=HHmqfeWTgw3N+abSgf1eEvtMfI5HsocYTyjY2Y/8nZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG/ouA9ViexZdNByT93a5dwhb+1CXWJcAuelsphHkx8e93/dO0BW1QldVxlT9POsa
	 uGIHfghooDUE8UFtzBQJShNq9eWsTf1h5D2SFODw1iTLNZFWC2zgi2DX27SnIVUhc+
	 D71sAU2AQuc45meB6zxxyyBSlsj7SMExaWoCarLZh7jsG8rNUYXnJzkst+yDYhF5Mx
	 xI2NSoRS1NRZvOo9YV9SR1ATS5WIVilgPupFFyojgZo9lFV/itBpeg4rmr/NJMjmLf
	 SeqYr0XOCnP83ZiQkXleMWhrli3lID3a+wyNLM80+hqdEFWJ2LWv2hdKPKnfXekRM/
	 bhWIxM9kqiMA503IXOgaNLy1KhusZXcIrXuIrY0s+rMhcr4tZQBys6CkihfLea7MBg
	 3Lvkwe/cVm509IBItBSAPMDAl6T+NF6A3fZtTohN/kGmiH3QnGJF0hcknp5/XE9sDM
	 IOjD6SpFKC9GrW5Sz53udRR9m1aiyWrrBgtFpFqNLsuesT7wnDpKoPAOnqg5MQjWHG
	 x2hwZR2a9dcwAaXe1i9FrnWiFcGrc1czzhIRIgjs4XeMfn06CC/bS/4LRbMP8b54jz
	 trB3+9FUr29rdPAhSMmtdM8HkhvqB76OvR1ND63Ax06DLZrRWbCf4qMOl72ZZKcfBn
	 Fffh7UZj/O7uuDigVra8WASU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C404F40E0213;
	Wed, 26 Mar 2025 11:21:48 +0000 (UTC)
Date: Wed, 26 Mar 2025 12:21:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <20250326112143.GAZ-PjR5xrN1GyzXzE@fat_crate.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <20250219092059.90850-4-roger.pau@citrix.com>
 <20250326110455.GAZ-PfV3kOiQw97fDj@fat_crate.local>
 <Z-PhgWQMHjxbac3b@macbook.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-PhgWQMHjxbac3b@macbook.local>
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 12:14:09PM +0100, Roger Pau Monn=C3=A9 wrote:
> Sorry, not on KVM, I've tested on Xen and native.  It also seems to be
> somewhat tied to the Kconfig, as I couldn't reproduce it with my
> Kconfig, maybe didn't have the required VirtIO options enabled.

Right.

> It's fixed by:
>=20
> https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/
>=20
> Waiting for Thomas to formally sent that.

Yap, he just pointed me to that one.

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

