Return-Path: <linux-pci+bounces-44739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC2D1F004
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 14:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB57303DD21
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86F399A77;
	Wed, 14 Jan 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSkP++GT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/QV6as9"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07413399A59
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396226; cv=none; b=jh2rPuzNXOvAT7Br173GCYttMr62kFE9IW6G8xK3y8bWlNNGfbdmxssJUIVI2sSvtlR/1kFBYFZBvIbkbPwBFf3HtmJhc7prMAryPd5OOFEp1vj25qO6aKJQTJG34Dn7Yda+kdxHe5seKTbIApfMqOsVdhUNDgMvxF0fGKGNfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396226; c=relaxed/simple;
	bh=rvKojorBhGiq9oSSjlzSpqngsEZX6K1yHB2mMFTb3RU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryxx6v0r31B2cXJ/mb7NxBTSPmMt478fQsMgNlC3ET4TrASruJ6s4lC4pxeRW1nmkaaKKZ9hP3raabqC47ssMJXLwnUQkxE1ppNTLomj8S0+P6VKHAMHFmY2U6y4R/CDABRQglw6Jk3kM6FfNre5meRplF1vaBPouC+Y3urrKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSkP++GT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/QV6as9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768396224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGW7KNWxKx5IGz4tEhfu2+JvNbz5fYr5dGcjHlJSJFs=;
	b=QSkP++GTaRIEzbEr50HOkb5toNbk2rij0OHxZwyK8TQCIb44n7GhJ2b2tXl5TnwgaOIFvf
	FsURWHuEr4mq074isH/aRgJ8+inwEPz+Ii3u3SGT8n0gxx6dT/eMvfEnJmc5eDCTT5gN0Y
	ev6ceSfNgFY4N91hqQFc39GMhtbIYIU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-i56oyYRDMYyce36fpEf6SA-1; Wed, 14 Jan 2026 08:10:22 -0500
X-MC-Unique: i56oyYRDMYyce36fpEf6SA-1
X-Mimecast-MFC-AGG-ID: i56oyYRDMYyce36fpEf6SA_1768396222
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c52ab75d57cso3935377a12.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768396222; x=1769001022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGW7KNWxKx5IGz4tEhfu2+JvNbz5fYr5dGcjHlJSJFs=;
        b=Y/QV6as9qodYXUxAfoCahpAxAIUgck+W47qVE3JZ1lXkU8aBzxI9P/gQKcsTmRb9kx
         z9yVAkMBwjhBIyKpjNue2iEvC4t4zanNTwukjXfNcf+MBFtEn8zpHjeL4x6CXos5+Pho
         Kwz339iTAbd6ppNVVxyGK3MXdyMGLlgs7t2eOfEIQj8LQtaj1G3U50BDawrSKYNNZ01u
         ZX7kQK+pFwA8JY2hF4Syok5M725TNdZ8h8efD6CHL/aFe8EYkCH6ozjwqTOAuIJmwgYO
         Rwm/4eHQZKDQiTJfYMP59/BniiOxqmuYn8vpmKE9TPBKbNf/emL0vBs2voUy8HKIp4KJ
         WLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396222; x=1769001022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGW7KNWxKx5IGz4tEhfu2+JvNbz5fYr5dGcjHlJSJFs=;
        b=sQiM2Y3gT7PZve/rT+d9mZcygmhOVc0rCr/INZJFh9XylmW5VrFe3ZpMxs9/4XQt6V
         1Y/wo5kR7oaIAyp4UfQkXbUOK5+YYZ0BuM2Eu9sbouf+dBzx2sFJPc+UvHaEXRIVH/Jh
         a0Xy5NCb4Wf0i5sCEQaQojZz8RnRXLGFpTypOk1qZ09i2YNqhkBX+NIocIJuuBEf7Eil
         PsOcF6c/xftUBDObBExKTMeEzzxDucUG7r2OsoxV3GQHl/V/SU5CEaBgNcN2151HfQXj
         7tThgZodzLQbn1gBH4RAsFn062TQ/dnjZNDEVCOlfSAhYQ7k80ubupMsk6je6lMTpPrh
         1CyQ==
X-Gm-Message-State: AOJu0Yy3MeOU2wTGONleUUcxV1tNvvDka4ZVdvOwzRP08/nEAakdP/Yg
	Bn88Cg+ZRljH3DL72e0p2P801F8iO7dQZp8eUMqYgg1jtyv7ZF2LgJqyLBq5JIfi5cFXvPFRofv
	ZJ16TqoHOhx4T+HUUN6NPei2YJb5CCGozR9q5oAja7SFAfqkfWdiUF9lpFv6alg==
X-Gm-Gg: AY/fxX6+wkyhruzfFu1cO7iE4czpFQoZKmc6JKM+kCjNORXrLsdYU8TTnNQ5s+HjE8u
	LNxF67stwCXQbwV6BSH6ZGCI/F7JF/aFTUpgjbY7chbQQuqpq+Ed2P/HufCqAQbLnt/wbFBzjh8
	gAg6+jLgd/FgNlHNu0gMnT9smfBMieIM0ka4bcjK0wdkFQvrYVCKLKmGPvYo/nM3H1a605kDGzA
	E4Oxuol5gbsPKjVreGHbtEOnv4e4DTIKJNFejwfnCSkIWC2L7aw9wR572EXBGk8Kn2ppygBFq0Z
	gwXHo6yFHjEPf962LTDYOr8BicEuplnYOxUtMbF0VJbfSz1hmkS31qo/LkJr8UR4PuVyKWtiaD9
	f78jKSg5r2C8U/Eqt3bqopI5qoNGR2o0am5gT
X-Received: by 2002:a05:6a20:a10d:b0:342:d58b:561c with SMTP id adf61e73a8af0-38bed0d6f87mr2445884637.27.1768396221620;
        Wed, 14 Jan 2026 05:10:21 -0800 (PST)
X-Received: by 2002:a05:6a20:a10d:b0:342:d58b:561c with SMTP id adf61e73a8af0-38bed0d6f87mr2445863637.27.1768396221204;
        Wed, 14 Jan 2026 05:10:21 -0800 (PST)
Received: from [10.200.68.138] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f477sm20335a12.8.2026.01.14.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:10:20 -0800 (PST)
Message-ID: <1e57f54e6738e761ed49cfde8a7423ce141915be.camel@redhat.com>
Subject: Re: [PATCH] PCI: Remove useless WARN_ON() from devres
From: Philipp Stanner <pstanner@redhat.com>
To: Philipp Stanner <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck
	 <linux@roeck-us.net>
Date: Wed, 14 Jan 2026 14:10:10 +0100
In-Reply-To: <20251218092819.149665-2-phasta@kernel.org>
References: <20251218092819.149665-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 10:28 +0100, Philipp Stanner wrote:
> PCI's devres implementation contains a WARN_ON() which served to inform
> users relying on the legacy devres iomap table that this table does not
> support multiple mappings per BAR.
>=20
> The WARN_ON() can be regarded as useless by now, since mapping a BAR
> multiple times is legal behavior and old users of pcim_iomap_table(),
> the accessor function for that table, did not break in the past PCI
> devres cleanup. New PCI users will hopefully notice that
> pcim_iomap_table() is deprecated and are unlikely to use it for mapping
> the same BAR multiple times.
>=20
> Moreover, WARN_ON()s create noisy, difficult to read error messages
> which can be more confusing than helpful, since they don't inform the
> user about what precisely the problem is.
>=20
> Remove the WARN_ON().
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

*ping*

> ---
> =C2=A0drivers/pci/devres.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 9f4190501395..f075e7881c3a 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -469,9 +469,6 @@ static int pcim_add_mapping_to_legacy_table(struct pc=
i_dev *pdev,
> =C2=A0	if (!legacy_iomap_table)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	/* The legacy mechanism doesn't allow for duplicate mappings. */
> -	WARN_ON(legacy_iomap_table[bar]);
> -
> =C2=A0	legacy_iomap_table[bar] =3D mapping;
> =C2=A0
> =C2=A0	return 0;


