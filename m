Return-Path: <linux-pci+bounces-6626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1A8B09D1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2981F25666
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492633989;
	Wed, 24 Apr 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZKosjc/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7656219EA
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962268; cv=none; b=FdPcXdTMivmaKRjCd7mY3f9x0XQTafz7DN4Ct+Llb7u2kL5LLgghDpOSS+JF8tqEVOHqyFuifzwteEl7GWpdZYhPLS4wedCWQKWKEMxpyvyZoDec7YHw1pC+pwO6PCK8Zj8fbHMNcU6XvTaJ4aFyNTgIfpEI6VPkiqecWbt2qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962268; c=relaxed/simple;
	bh=wd4veTdLpoEtjArjvTVZaErpq4Brh+HhcvjqxPMOy50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gygAXh8rCyPxLlO8kDEkD1pV48Vk47gNU/LLlZlmKtkXof00w+TYnGNtNPaUzV3FU7fgyY5p5buSZeX2mj20JKZLG1lMXCY7lkLGG3eK54L/rGx5/UrfNcfx4vMyNFbd/Y5jW+W2LmYzZpLoaeJeqd160GpDhKNADbyqQsGcj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZKosjc/A; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 2FCF2286B01; Wed, 24 Apr 2024 14:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1713961943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKg+n8l4yLlSXI5sdMj2S8L++IfRqJSYpd46cLDsdOw=;
	b=ZKosjc/A6maDW+heshK89NgpXaus9MNjIRvl+FNqh8G5B3A9JRbTuWTppePUvMdbkSh+68
	tWcwl0HLZQV67+Zpj08T26whiFunrRCMKfcGe9IbJ018qf8X3tJby03E7al0Vc+1slVhMz
	p4sxT8MgZnhN9rvk0XilAQlmSSEdtCA=
Date: Wed, 24 Apr 2024 14:32:23 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils v3] ls-ecaps: Correct the link state reporting
Message-ID: <mj+md-20240424.123213.99334.nikam@ucw.cz>
References: <20240424102011.1706839-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424102011.1706839-1-aik@amd.com>

Hi!

> PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
> the link state as:
> 
> 0000b Insecure
> 0010b Secure
> 
> The same definition applies to selective streams as well.
> The existing code wrongly assumes "secure" is 0001b, fix that for both
> link and selective streams.
> 
> While at this, add missing "Selective IDE for Configuration Requests Enable".
> Also fix the base and limit parsing for the memory and RID ranges.
> 
> Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Thanks, applied.

				Martin

