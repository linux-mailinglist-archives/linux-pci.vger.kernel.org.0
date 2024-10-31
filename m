Return-Path: <linux-pci+bounces-15699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ABD9B78C3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F13E1C21E25
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26B19923D;
	Thu, 31 Oct 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jGyx9i3X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDA198E83;
	Thu, 31 Oct 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371034; cv=none; b=eqETrnEb/kc9uR2y+50iLgbOYSAaiRLdjAfLz/IX2H+AhfM1i5J2N+zH1w6G1vgo1M0poaUkfoTNCH3Alxq3NZ+RtR9DNSKTEkJJKmB3boBfX21MfLCVViCUCeOac2cDQasP+ijlpz3GGoF4WCbCVf0JUV1t4RsujfFk47GTjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371034; c=relaxed/simple;
	bh=W62nW6o6roRgMZ6ptHYz8UTa1gqyavSGW73urSteeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTSDnTNt6XSl7XSave/He3OgJFUsPaorbfXIJYaWoqQkYv8EQpfsh+YL9+EN6muGkTKOiEZXvSKc+ys31sJDNQm5D0r6N7UUlpsHTzIhhCS+uaXf9jiRrwhhONts8eRFZafkTGXQISEa1byvv1F8vTiwaHkgX76JZsV2Iga+8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jGyx9i3X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA6C940E015F;
	Thu, 31 Oct 2024 10:37:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m9VOAnQDlvFp; Thu, 31 Oct 2024 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730371026; bh=Zoic+05z1WWqcWTpj/byU2dnEVpHhQVwPQpp8yGsvFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGyx9i3XA2zDPhvjxO8Pbo8QDnQo4jKeeV35GnVMO1YQFXHF2R1NhW9SD5QGNX9jA
	 b0ISQVdT2RbepTV/FBA2HmhiTutn8ivVBMePT0pCy9TbIMcq80iqP6sWRNFjLiiLO8
	 i9S32o8IFOsYzEilbQoTppu3G7pTPwTysIpz3V0MRCXClOFbkY99TAuHIuPrNbVxXi
	 hytf7Gw6Cb6YDouFXPnVp6j44ifzJ+s7Ihytu7HjoCesvLy2jxFJXX+HiGAvoJAWrn
	 V9hKCjYK8ZWaDEwLpXQLu/lulEXVMGgDAOsdtnbBNqiAaNGWx5ti0+rVu1IAui9Mn8
	 xKuEvij5Ig0Gr/U3G69wrAIwRE+iau68JrW1GPO5LrFzkxFbhPGN0VKTD5B1/jMr/d
	 9F/9dywo4Ljij1FqpAOBfHfbPw37OWueSaGv3SlN/pE0ldWABD9Yy7rrYmbBlntnys
	 FQolom8Wzqxrlr0tY3IS1HppV699YWFV8eGPiDTS5TE3VW2FywfijGVQAyjJKbHJAJ
	 vYSYs29Mo/IOBZiP586sL22mEwnsMubEEc/eGlA+hHysDZirYst50a+02ElHc01BPY
	 EslxuwMrfaaUkGdUNCr7Fqnxuo5u3G9IFFs3XEFzfA8zDfiJKwZBON6y93xhJ5eYJs
	 V/AwSV+dPWWLU/9VKtbX3d4A=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDDBA40E019C;
	Thu, 31 Oct 2024 10:36:43 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:36:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
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
Subject: Re: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based
 systems
Message-ID: <20241031103642.GCZyNdumQSdi76CA3w@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-3-yazen.ghannam@amd.com>
 <CY8PR11MB71340D079448528FD548F73289552@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71340D079448528FD548F73289552@CY8PR11MB7134.namprd11.prod.outlook.com>

On Thu, Oct 31, 2024 at 08:09:14AM +0000, Zhuo, Qiuxu wrote:
> This function could fail and return an error.
> Is an early return with an error code needed if this function fails?

No, grep for amd_northbridges.num checks in the code.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

