Return-Path: <linux-pci+bounces-15747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14059B832B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 20:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21042B21FDD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D3149C52;
	Thu, 31 Oct 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HAO/lXId"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791E347C7;
	Thu, 31 Oct 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402154; cv=none; b=U4CbbPH3KHqOX1f3SeutZfuTk0KfHLbyw935gJG+RADZ+MTslZmzQEXEdI3phFYEcRzFH3OpLyNGySahL5PDiO+0F5wfBlgNAEQvkPQsXwVKEbXr0ZzWaDoGMssIqfFbdJszWe9Kynx5c0H1r3yxIiq8dPeIZ7UygqLUqxdPL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402154; c=relaxed/simple;
	bh=iz/mcCGKzKAF+54183Qep4jiiK7skiftWfkF3ZQ9fck=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D+BEr9nHiDAecP0GwEd3JjuWA6q0kTApWXSMY9vngc25MwiDPfsvyM5CKcVibLp8URtchZc2G7yBjw0Bsux1HjWbrTIznmay7GL3wPyFgTRMsRLXOpeGp2TMa9Q8stkdLWzkt9K9MRpPRTGDB5wnIPAk9E+196DfDIz9NFy+Cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HAO/lXId; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E54E40E021C;
	Thu, 31 Oct 2024 19:15:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ODtb6AuBZVDC; Thu, 31 Oct 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730402142; bh=TjBac+vUXA/VaGYTwTi6FQkjFjIMoAJ+klVbchu+St0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HAO/lXIdBMw3mLgc3LD9+uFBFW9EQDK2KX2jeJPdfe92n1O18NX440RAsMqu2qUmY
	 J7DvHEU0App/3VYoCssSdJ/NrxFFZEdVW8sIhgfmoy6CwM0Iuqfj+ZCG6ivc8J72cV
	 10ihGjL/FAFv1GH2Wi5EIz5P/oBuEHPnsO358Dc3Dm6DYXy06zBqGL5VSmmDIDvYNC
	 l2GXMMAN56VMz3X/kYfU8FNLrLHKgyAkqnNJwnmztwRAlPTBNRfko79Aty0+JR9Xwt
	 YBkwfJL92K+pRbcmvP9d6INbvsUb+pUVE2+ywlrhfWYP2KYRn9zcR/1BaiLpfvWY/x
	 P0YXcmi45qC5jjwhDKvn1uzUTvUdPZfpaUhcZSu5VOtDZ6ylssbBuU1fovpvZe+x5K
	 4Bsh/fWrnItoPSymNIaTMQm0noPkM5fW78zxq71os9XkbycSh0HzVpEtnSImIjjf8S
	 /vZTn66Kzkyo04GAzIRZfiBUvWjRsDCxwKJcQKLG3gH/tX6XUL9VevKnSwrlncQMeR
	 W96nGkXqaHuxtoRisIo5EHzIOCPcNJ3T5EPsh2401NKSrsp+irERAFk1+cOhrQ8+Yt
	 9YM57SRGpAUxb6fO4wEzdgm19sVqS1uT0P2T6M0nPFrsLp1xym/Qhi5yRaI1iSwztx
	 Cu8EgO60eyhxE5dQT77PGhGs=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:209:eccc:5132:adc4:8c65:1ae1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B42940E0219;
	Thu, 31 Oct 2024 19:15:18 +0000 (UTC)
Date: Thu, 31 Oct 2024 20:15:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "Luck, Tony" <tony.luck@intel.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "avadhut.naik@amd.com" <avadhut.naik@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
 "richard.gong@amd.com" <richard.gong@amd.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "clemens@ladisch.de" <clemens@ladisch.de>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
 "carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/cpufeature=3A_Document_cpu?=
 =?US-ASCII?Q?=5Ffeature=5Fenabled=28=29_as_the_default_to_use?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f9cd603d-8a3f-43fc-a670-75b4d9a6c729@intel.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-4-yazen.ghannam@amd.com> <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local> <20241029143928.GA1011322@yaz-khff2.amd.com> <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local> <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com> <20241030142138.GA1304646@yaz-khff2.amd.com> <c2894e47-f902-4603-84e7-a9aca545b18c@intel.com> <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local> <f9cd603d-8a3f-43fc-a670-75b4d9a6c729@intel.com>
Message-ID: <74D1358D-952F-4D33-8A5A-1D6F87B49443@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 31, 2024 7:26:27 PM GMT+01:00, Sohil Mehta <sohil=2Emehta@intel=
=2Ecom> wrote:
>Does "default CPU feature testing macro" roll better than "default CPU
>features testing macro"?

Waaay too finicky to me=2E No one cares, I'd say=2E =F0=9F=A4=97=F0=9F=98=
=82

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

