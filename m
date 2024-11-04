Return-Path: <linux-pci+bounces-15968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC29BB7DB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12FBB24E88
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA21AA7BE;
	Mon,  4 Nov 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ESQ7yH5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E770AD2F;
	Mon,  4 Nov 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730764; cv=none; b=PVjVcgYkCigSaAtxLnBS4y8JVk2TThT5zkc3bxixglPIlXTt/iu6cNy7lQsgqF+COOPIhAcjLmmYs9riFP3mIStgnaL55nj6lkKDNp+97TCaJHycGlrg5gpT/MIq7++kjviNK7xLhY4ZfpAyobFQJAgTLCe9NIZuKhgMTsKS5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730764; c=relaxed/simple;
	bh=9ZHERCcMyEAr8lVyOyLsT04ct8VWYOe8xayzFwBESEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOaCtsDtZWO84T1BMIUWwUpbv96jOwBcJKLTGkOJrDLpo7+7avDYXNyscwq4QQ8X7Yg4ztBLiZIX4mbuUhJET5bWMHluPYKTR23UUh5mMucRAWTBRtRww9NMIGPAZfHp/JPf5u7WpY2Vy/bEZSDrQhUnBcYA9mZfO+GS+Ebdnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ESQ7yH5t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B768D40E0261;
	Mon,  4 Nov 2024 14:32:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1xSQJJ08zheI; Mon,  4 Nov 2024 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730730755; bh=ldSGd8nTlKiOrnZUeIJgYk7a6GuKkd7dHcsz/KUNfQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESQ7yH5tN25EOUrX1jN0ykMHpQCx2Ln71XJ/zss5OKm7o4M/aZUrTB6NDHbebpp/W
	 5/gwXetVaKcfB13+ilZPQXwa/eg1y7YEYjJ8VupZ7GGI6aIoyd8kLmWINqws7Tv+Yd
	 2QHSWQW92NsWlHQQq3klLL+AqRy97aXYyM4TXD0NzJk2nHXTipOXEX3K/BhwUl6HPX
	 +dHSw7SShtKiolBMVGEJzLu1ls0hD65om+pxxjbar9dPINAkEiPjgmdTFRfYvKEmNO
	 HvsBLTWWYKCrQKdmSISK6LJQlRLDB3fiP1fOdwpspg97Lm7A9g9zjSYBoZ6VMw49rk
	 ejjdecFVTfcZQcgJ/L9h5cJ1+yIgivGuWU4x9hFO/Nyrp8/oFOh+M70BWx36evNA6+
	 wmpuc67zKAIX9QiXdr6w2neXi5atEhBebnhnOZMJUw8jiUgLDbS4QU/NIS+T4/hRb4
	 B5oFPFxJwJ+Px24Yavt5wj3TBVbdyPo2p6928p6Q993xagguLtXwndHgxay+u6oAb4
	 qFx9062hopf4iQzZPAkCpwkh/lN5y7unRmAJUMLXqgHuyzBCAWv6I70BGX6znU9Ic6
	 oIsn5FSVethEmihSqimwcHoy7sdqDNCz2TocISp+ZBdvXtmLJ7UktSCLuum9pTCu/G
	 cxAoHEDOy7DdvV7mTMt7bu7U=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9683F40E0220;
	Mon,  4 Nov 2024 14:32:13 +0000 (UTC)
Date: Mon, 4 Nov 2024 15:32:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 11/16] x86/amd_smn: Fixup __amd_smn_rw()
Message-ID: <20241104143212.GWZyja7AqB07hVa__h@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-12-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-12-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:45PM +0000, Yazen Ghannam wrote:
> Subject: Re: [PATCH 11/16] x86/amd_smn: Fixup __amd_smn_rw()

Needs a more descriptive title...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

