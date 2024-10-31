Return-Path: <linux-pci+bounces-15697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79649B7897
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DFA282BC3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05BC1991CB;
	Thu, 31 Oct 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I8ynmJwP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2421990BD;
	Thu, 31 Oct 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370290; cv=none; b=a6PMp6EpBgbC23P3amjDsRKlTJqiJvxkuAhUmJBGAciDMp91ic6jn2L/qof5yVJ98n8DMcYG2Gvl002r3Jmmc1PdrH98AjZ+tg/ZfuJZM4gn+BTITj9vN3MjBvNjGBzR/P2/BbrAF1YubHsph6qO0waFoiAFgfWnQb6kE3smRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370290; c=relaxed/simple;
	bh=Dcs8uezQDu8TIPzq+x7EHDomq/ErpK9DELbZnXFkW00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESz2j+7Ga/f36A3w71gSeEXMfu6+/zpiElgkw3qUW7Ve0vPt+gp3rqHTu3QEquevkh8olSxwQ2Thelxua1iKM5tgJkH4hWcfDqXVCNEy7JrTs7scOZ2EtDdQzBDiaaakgwogNr8biQtNM0DxhXch9KGIEK2LHe/EyvMGPSQAiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I8ynmJwP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5883D40E0219;
	Thu, 31 Oct 2024 10:24:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rYHAt8XQxasY; Thu, 31 Oct 2024 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730370281; bh=rkquCrs7fPqx+/X745GkwcUDl28gCwCs1bKo0rGbyUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8ynmJwPYjyktq43Ws7uS5sT4KiRaxNWcvK5R3XyhO7iRaUPJ7Qnnspot0tsbi7ql
	 YZx+MW5tybq5kVpCsYAaL+cewgEj1jwrBfb9zPCVcID4FWGlfwTciqxSgGbmrSBz0C
	 wWQD+MUQpLh0Hs5MI3vxFO7kQGmqQrzH59jHgQDeGo31PlPQ+yh0FzW7Ma7hKaSTWl
	 tdKBFZrmLN/a56OA+8dfy/5jg2e0OBmiNhyl9gvdt6/zSc0rPERH9CAnMwrZdU0dhy
	 hMsak4p2oYBY8abg9keeFSy2imVqbKkQxGdMqLeseD9dlxoZdQvAD92tZffq0Kdshc
	 vii78EOylmd/j8t+CigEJOpTwjwvbeCcVtGHoI7GR3uedud/4cgexg5ElrRE8lX/5O
	 F+svAjGCsP22PsjZY/cvssoqCBaqTmROeQn5jYDOTcUYaGlTxYQP3zFPlDlQx1QSiz
	 YIJzOzZlvUN/l42lR5l3uj8pn9srOfT9eb6kLGb6GX79YRC2AWbuFmme5Rkz1yN7ZB
	 dnNsWEopbEjLjMgKp1MV5SBQgYzqlmL+QjMMMxQJk5qHeqUxd8egjiWe6SsfcYhwnM
	 e031nWp5uI8+2/w5HwYokuCtMfzSOEBEzolmhslpFaP7+OCj+pDdeaij7m/pk9jDES
	 jxcthzi/MMg1wO5fNPtJ1p4I=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB30940E0028;
	Thu, 31 Oct 2024 10:24:17 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:24:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
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
Subject: Re: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Message-ID: <20241031102417.GAZyNa0fyqCSG5txaz@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
 <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241030142138.GA1304646@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030142138.GA1304646@yaz-khff2.amd.com>

On Wed, Oct 30, 2024 at 10:21:38AM -0400, Yazen Ghannam wrote:
> And if not to checkpatch, then maybe it can be included in the TIP
> maintainers' handbook? That is, if others are using it or something
> similar.

Nah, this needs to be a normal janitor task. tglx is working on it. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

