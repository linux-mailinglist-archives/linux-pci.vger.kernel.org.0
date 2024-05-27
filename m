Return-Path: <linux-pci+bounces-7849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E298D0032
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4AC1C20A7E
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9915DBCA;
	Mon, 27 May 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="AKVO1+Vf"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4238FA6
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813562; cv=none; b=OxACitrANb0HXnNUHD2OS41HsIyOMOsKdcc/n3/wLkwXMJC5TLoROl2ostCJ13lUfU9a8F3nRJSN7dhWy2XDl1qP6cnfCVP7YLHRLXU+2jbflHKJKFHKjcBb/8dtB4UnTE7LtzVb3zOzivdLvPPv8dta5ZBOJ5W7FRmcxOVHlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813562; c=relaxed/simple;
	bh=v7mvAlhYXED1ImjYm7zlQlkEILTFhBeYmUkVHpqOTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1fVH8bJbRqa2M2TcxRLBtFYgXhBQkIGBWmGnxUnL2qF8PZO1MRJt2LtogPmEGrhvoIFiv5N8WZKwMcSXT3VdydcNH431tmQGqcO1GZIPb8ey+N+GbOtXrF4i9VoCdJRoFE1cIrKB7OBV5OGm6kEsb02XHxZ1Uz5EM2a6ZohIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=AKVO1+Vf; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 1627028739F; Mon, 27 May 2024 14:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1716813183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSWyPLZW1mVJWsSNUuKur5RRWHACmQXlDA1Y4AcN0d4=;
	b=AKVO1+VfE5RZ1T8kLZK+7LDGj30aAAPtwcirfWxs+1Vn6F32CKgpaGG+HtlnqiJj0irXGl
	9R2MceDYlH6/LF2bE1YUAJfEw3ZAKvnEpUWolHBqGcGX+mbNiAS/q4ihZw+9FB82oFNZGC
	iY0AANw20w1rVVEb5BkqbciRNfVhM6c=
Date: Mon, 27 May 2024 14:33:03 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Jules Maselbas <jmaselbas@zdiv.net>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH] libpci: sysfs: Fix segmentation fault by
 including libgen.h
Message-ID: <mj+md-20240527.123235.12093.nikam@ucw.cz>
References: <20240521080519.7833-1-jmaselbas@zdiv.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521080519.7833-1-jmaselbas@zdiv.net>

Hello!

> On a musl-based system (Alpine-linux) the basename(3) function is not defined
> by including string.h with _GNU_SOURCE defined. However basename(3) could be
> defined by including libgen.h.
> 
> On musl this is a problem than can lead to a segmentation fault, as I have
> experienced. This issue is caused by basename(3) function being implicitly
> declared and thus having, implicitly, a return type of int. Which in my case
> caused an erroneous sign extension of a pointer leading to a segmentation
> fault.
> 
> Adding an include for libgen.h sound to me like a proper solution.
> Also by doing so the `_GNU_SOURCE` defined is no longer needed.

It should be fixed by commit 89cb2ae87236604b0e8ededd0fd7d9425c2d8cb6.

Could you please check if it works for you?

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Sic transit gloria Monday!

