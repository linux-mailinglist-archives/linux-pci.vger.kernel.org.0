Return-Path: <linux-pci+bounces-25130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C69A78956
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF733AF56E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2504233724;
	Wed,  2 Apr 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF6tKAZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB49233720
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580711; cv=none; b=tiXoOevf0TlXCmefJun38payKslfz5xfbyiajmz+z44W9mlXkVCHzVXt4TU0eJWvM79VyVvUfwcYrAsNZuqR0ZltJLJZAajXFiaB0G+I/+CDHAOCVUjGZBP4gLwQWscv9tsyH97l5prw8o/6NLq5ghE6UwNYKhxOro7elI4i7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580711; c=relaxed/simple;
	bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNQUxGi+9UiaTAoVm4VRd/iDFVGhX9DY0p2u7ZANv3cQ4eni7tLRndV6LH4O73qwp5oUVMhAoE1B9BahgZ+uDPfHkM1nalsSP9ZIP6AftoU+Lem/QE+X1cuI5j3idiJWXtqRHya8XrX3rB8zv2Sv/Pn0tP1K/zSkajyTqpXiIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TF6tKAZg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743580709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
	b=TF6tKAZgY3OnyDfVa38C/GBuaJwBAtv8OGEu+47r0k7UsPZowXnAgG9t4Sg9wDQ8oR9nEb
	nh/MnTn1OO81qxvQXPpYhow0buDoW80VVEgtBocgT93LOj5aNbEoJPipAtmM6LBFJEOQVf
	WSL7ZJ6wcKIivb0RlVimC9kz9tMu9ag=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-44qfNNa_N8OK3hGuzxWEOw-1; Wed, 02 Apr 2025 03:58:27 -0400
X-MC-Unique: 44qfNNa_N8OK3hGuzxWEOw-1
X-Mimecast-MFC-AGG-ID: 44qfNNa_N8OK3hGuzxWEOw_1743580707
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso481230666b.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580706; x=1744185506;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNZG4kFoGbGB7pheqiYG3iEXKZBGzv6hERVCUWp27mQ=;
        b=FDbk9WUGX8nZw9KEE7wQWNU+rWv5ndWjI4gav/rP4Bf4hs7/N9xzMzLWmHMvLSFOwe
         XxBGjdp2vOsxzGg6UvKcqkvjmByLa4O+jJ5x1+WNL1llErefQMZMBUx6BsFSGthEOWMI
         JImH5nk8rNvIfyPnzV8Z+YcnM88G0hxyrisSsIUJUbc2oZtp0S/EgEiKW6B8xMW0gQDb
         oEjkWJPp+p4Sw7VCHxqGTyDa/iL1k0hkBYnrQB16svZXlRy/wacgZg54l2g3M6Cem2G1
         JUKqg8gJiZ7nM3BSJCIdyeEsBmUq4JL0jzAIzqzbT82qqlsuNpKeXG6wRgDgyuKovbCH
         4r1g==
X-Forwarded-Encrypted: i=1; AJvYcCU9y110wPPELPi3DD5T+BwSC9LeKjf8t6w7/vzrgH6u7Dw8R3gNLRvjfIVO0gTILpdvZbo9Y1xdOYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtrLHFbVea9HS54Fz/lva6xGMoWtIBdmyxUo9PH8AtJnGkZo6
	kAfoM/t1frHOEdkQKqDDsikYzxQ7Pm99FAsSY/30UVWWHOEx50geGaFjP2ndOcVWf/qSXM0hXhy
	RFukSYIJ7a0lMnY3WdwpfIxPpNJGbYPpBSN0HmwzWrns5Ws9Ow7mHvs5zsA==
X-Gm-Gg: ASbGncvvSaFLjqwxKNN3Kl/r0UwpqbiZB8/iQU4GaM1tj9YczzfWlfGDfk2eLGX5X7r
	lj72ZfCPy2WZE4ACVEgP/nmnpM8C9296oUUjuMgOugEF0sSpopPYZZPUr6JMrMLp0yZZJFwuKZw
	VL0CgINrBGYuPbK7NT69kPgig8WWk+wikYKLmwElXLdyOm+BJKRhLFAa3W8dL4J/Qw1s5USrB+n
	LQLKPPA3Voi2YF/BFvxiyucok+mf0Aea2gFNx9JNjlNMVnei3bu45xGrCvEcRgJPMa18eQOWbpm
	5Z+gboeJBn3BQe1f2yDDAfY+6MZEyrlcZ3CQ66Q9m5EEWbD2K1cPemjHFpotDXi69k/eCxyGpDa
	7m2HUJPyDtVr/jlCjNh/aJwekBsNp5E+B3VbOhQvIn/sLzCXTQso=
X-Received: by 2002:a17:907:7215:b0:ac2:c06:ad9d with SMTP id a640c23a62f3a-ac7a16c1267mr109993166b.14.1743580706554;
        Wed, 02 Apr 2025 00:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYj6cd0a2ZmOIrY2+9xoa0kFQ790CUzhth/mn7wiW3bHJ2mcwrNEVMrfPgd8xSJJfNJC6BBQ==
X-Received: by 2002:a17:907:7215:b0:ac2:c06:ad9d with SMTP id a640c23a62f3a-ac7a16c1267mr109991066b.14.1743580706042;
        Wed, 02 Apr 2025 00:58:26 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d97:6a00:6929:a9f6:5863:aac5? (200116b82d976a006929a9f65863aac5.dip.versatel-1u1.de. [2001:16b8:2d97:6a00:6929:a9f6:5863:aac5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e1esm877349966b.7.2025.04.02.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:58:25 -0700 (PDT)
Message-ID: <323da53fe2ec06c9cc5d1939a9e003c5bd2a0716.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Bjorn
 Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Damien Le Moal <dlemoal@kernel.org>, Yang
 Yingliang <yangyingliang@huawei.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, Li Zetao
 <lizetao1@huawei.com>,  Anuj Gupta <anuj20.g@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 02 Apr 2025 09:58:24 +0200
In-Reply-To: <Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
References: <20250327110707.20025-2-phasta@kernel.org>
	 <Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 13:42 +0200, Andy Shevchenko wrote:
> On Thu, Mar 27, 2025 at 12:07:06PM +0100, Philipp Stanner wrote:
> > The last remaining user of pcim_iounmap_regions() is mtip32 (in
> > Linus's
> > current master)
> >=20
> > So we could finally remove this deprecated API. I suggest that this
> > gets
> > merged through the PCI tree.
>=20
> Good god! One API less, +1 to support this move.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> > (I also suggest we watch with an eagle's
> > eyes for folks who want to re-add calls to that function before the
> > next
> > merge window opens).
>=20
> Instead of this I suggest that PCI can take this before merge window
> finishes
> and cooks the (second) PR with it. In such a case we wouldn't need to
> care,
> the developers will got broken builds.
>=20

Normally Bjorn / PCI lets changes settle on a branch for >1 week before
throwing them at mainline =E2=80=93 but if we ask him very very nicely, may=
be
he would make an exception for this special case? :)

P.


