Return-Path: <linux-pci+bounces-24764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C14A716E1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 13:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC2F17090C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737D18DB03;
	Wed, 26 Mar 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+R1pFPW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuFW9Hg6"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D41433C8;
	Wed, 26 Mar 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993204; cv=none; b=usP9JsWfGyHcopRtzqCTxandor1ISLkQJZkPT6dP4MHPLjz3sAW/Bwzf1S3E8PYCAuaPYyWLLFApuGVG+gln+V9XYkQLdP0Le1Q1KCUhA+oPTeBIxD0ih7dG2jGivA3LHcvMm5v49/lBG4NH87SMb0//VQFD/GjvYzZTsWjbJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993204; c=relaxed/simple;
	bh=hpNe9bOmYhf6R3dZ28PTiRVSTJFU+MWIM2AaGCOu0EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QoUrhsDiucBK1n8S4GRWlheKwo2rjzAcNLZwl6VcJJ1X0vKE1lomIp8K+C2dvdXkrUOuDEVv+KGQFQrgRTJELSfJ8GE7aFgK43WlrterO+wg0dhoAIPbxz5vfYcAQbx+FCWLy5qD/wbxpf5KLvc0BlQczSd73kYbQfwsFPVsz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+R1pFPW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuFW9Hg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742993200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP4pKI9DdiAPAA1Qe115sjRa5UlaNblibaMOzmAshvg=;
	b=n+R1pFPWz9k5ncKoLCDhAwRkDvuwXb/Y1ffN+p/T1xWjVsJ3kdu2IjvnQnkwSqufYpg0DF
	NeBS/zI6LZx5r32u1viZHFL/riinRKvm4CuLI5Tn+9NsF+1OXn2XvpwO8QsRS/+nAMjXaJ
	RPWRI2jP2M6TBQLZ9MrJ+Yygi+e1bsZMS30R3cq0QqIDvtsXXyCwwvHn35CZiVNR+gG4JN
	AO+d19XCP2jp2LBgdalzqdu0TsxQh6Fmg3MxHwaPAqAaKZHSYKmSQbebJpVgu7duIihzKD
	bTv/iWFO8Jyd8ZmyOadTtNmlmY6N4QUCX2JwNdlfVdTaqBdn300MgDjYYim3Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742993200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP4pKI9DdiAPAA1Qe115sjRa5UlaNblibaMOzmAshvg=;
	b=uuFW9Hg6GotTKz4G4HeII+TJyL0F9a12wiePIquBqioqtwID34dHlB3/bSPBp/p8tR7HtD
	XByX1YIPFGJ3MuDQ==
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Daniel Gomez <da.gomez@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PCI/MSI: Handle the NOMASK flag correctly for all
 PCI/MSI backends
In-Reply-To: <f56cc306-3c80-45ce-9955-f7fd36defa4e@suse.com>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx> <87iknwyp2o.ffs@tglx>
 <f56cc306-3c80-45ce-9955-f7fd36defa4e@suse.com>
Date: Wed, 26 Mar 2025 13:46:40 +0100
Message-ID: <87frj0yn67.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26 2025 at 13:09, J=C3=BCrgen Gro=C3=9F wrote:
> On 26.03.25 13:05, Thomas Gleixner wrote:
>> The conversion of the XEN specific global variable pci_msi_ignore_mask t=
o a
>> MSI domain flag, missed the facts that:
>>=20
>>      1) Legacy architectures do not provide a interrupt domain
>>      2) Parent MSI domains do not necessarily have a domain info attached
>>=20=20=20=20=20
>> Both cases result in an unconditional NULL pointer dereference.
>>=20
>> Cure this by using the existing pci_msi_domain_supports() helper, which
>> handles all possible cases correctly.
>>=20
>> Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI do=
main flag")
>> Reported-by: Daniel Gomez <da.gomez@kernel.org>
>> Reported-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Borislav Petkov <bp@alien8.de>
>> Tested-by: Daniel Gomez <da.gomez@kernel.org>
>
> As the patch introducing the problem went in via the Xen tree, should
> this fix go in via the Xen tree, too?

I'll queue it up now and send Linus a pull request.

