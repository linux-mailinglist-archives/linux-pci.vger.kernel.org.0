Return-Path: <linux-pci+bounces-39456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A426C0FBE0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5881D40831B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D59296BC5;
	Mon, 27 Oct 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGJ8jYuf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C91F12F8
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587149; cv=none; b=Fxtgpqnz94EMQuvs86Azeglkximym1ncE3/ZdXvCZV3gfxmtW8o3bW2klIGFBrroLmDyqlzo9WsEfSIxoVf/xc9lP+PONfNGaV8mzryqCRJg5BwXUJJ0bxUtCDT9wdVZjU27vBsxdbm3OrJY7vJU9O5zi0878oDDLuZfdTxAiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587149; c=relaxed/simple;
	bh=o669fjd3dDVU9cn2su/jPAOMdfyTHDst9tkSlUsrzt4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia4hvhY1WGEPTXKZzcPZTAtF1yfBbrLY85NoHMVBKmWXCi+j+tvYLzAM2I3g0PlHLpA/zXXby4UATfzypOLWNcMSKtpNhc5hevzvVJqB7tYXfpCbVz+dG1+cGLQRwmg9ANoH4W5ThZ3ylt21pYPwRuiyegH9xmtxgSY7EUOQNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGJ8jYuf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso3720880f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587145; x=1762191945; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LBJAwN+hEhckPiJl2/YQkICj7IvpHc/sgZR39cQQqw=;
        b=lGJ8jYufp2kTC64Du3Oc1Puvw5a9dT5EIzAjp22a8npdcQdUldq73lb2qj06TDbpBc
         etAFZNWBgJ8DF9TS3dxHlsFz2AKhkj+4WpPYkJuYa4tib+MwRtgVkSW/i3z92qCwrIND
         0jg4GUt3rQJ4Qvd0giRxAquFaoqE5CDDf7XhsB6wruaJibVXLkMrYaknFD/p73QNeGQr
         sq1pDdEo3KvbevqqKw0J0Yr+/nc1+s+XkrOaKxccM/zIlAeJNZy3306B4O25mjmE9zVF
         xOi8Zp7GIC6wNbvLp1EzEGLHVjMa+phLR4LG9NkD67q6x9hcwj7jAvtUUOaJzdMEkORo
         rOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587145; x=1762191945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LBJAwN+hEhckPiJl2/YQkICj7IvpHc/sgZR39cQQqw=;
        b=pPgO8yh9JHJ41uyxPt6StVKpXPM8cJsi4z3PPRDNnkR1eeRIvbJwknPUX2ky3T6XOA
         KXmaLxS9692dcEp5yrxsN69XCkMmi4Xf6Fgb79RavG1ZtyspCRmalGIojTPtz8DeLjsI
         u3QgODWv1wwDixcyEynw6NWJmFhXFMat9clNk6bfs3LKwnjYnIvIkmVWIVrjC3MJ6KZS
         wWvVxi+cmIMUUukQlh9kvrlRGtVqWgJuaFVFyI2yAVuZfWd9FnL7I1BuOz+NOqaT4pg0
         ljZlsmweqdFwRPuyO44/03D9f4rj5xRAFZAJOZwDwWX6TNtXR5Q/bM3zoJqJW0X19BTP
         6YRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcTpOv5N6ERjm4y48Gh/WyJ4wcfa0q8KmGKIksLlG10AVeJOAz+70bvI5oEGOtt8lP0eEfzIPHzkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEB8gnilThlHqr4IVq0BSoFH4XO5XBLBvky2lWfmRfWVUJqUv
	lEHTPs0a3irkHHbnQU21o4HBdH2/9vLkNizS/BfP+SuVEOQItZXkOwyd
X-Gm-Gg: ASbGncvmkn59DCb6v1n2RlQ6NGg7uqqrB4xqGJMSaiXLH8ro1ZZVPF3kSl3URd9nCvj
	uFhuQkUZ9OsTHCtEaGQERl7+hm6XTJ9k57F0zEuV6Jz5zhcW1N6KQvZfBxnWuIITSvepd6mXkCw
	tqwzUWlNmr0IjgjM82RyDC/AyDBVrVOvF5klwNRWPOD1vp/Jxf+Ogh5GT0WlT+UJBx5nlJAGtyE
	FCUNCeyEImpNJ6YeblQxk7Gk9YHFlVrjCy4cRHBa16K7qw5bed3C/5RgyB0wSPNgyu/1z+DIjq/
	0j4YmQYW5aHmJNoT17bedaaYPt53Sl9fngW/Q5dxy71Xb2xGtRVzxRqbgz4wg2CbnWyjVECDKwg
	+RvOUEHT3scHYHU1/sOD61ziZ+I5PRQ50f6/6++wQvPY2zf+cgD57zvs/IqsZ306S+QbLwX00Eh
	mGQy5EEctD3JIYUcxvBaW0P7hYGS3cMXjycI0ouqXlt31bQV3FWegVD0lx6Cfir6+Y+x6P
X-Google-Smtp-Source: AGHT+IEptkSeRjmkp008huRQkOlM+f1dkThVyqxjPThNja3/evUbxE55EXn1v0MFXcbIJnFXV5SMXg==
X-Received: by 2002:a05:6000:2913:b0:427:526:1684 with SMTP id ffacd0b85a97d-429a7e52f6bmr618840f8f.25.1761587144388;
        Mon, 27 Oct 2025 10:45:44 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:7ad3:93f6:d1b5:4923? ([2a02:168:6806:0:7ad3:93f6:d1b5:4923])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7ce1sm15214644f8f.0.2025.10.27.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:45:43 -0700 (PDT)
Message-ID: <4419385c114b344ba5c1d5b0a817a322b37624cc.camel@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 18:45:43 +0100
In-Reply-To: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>
References: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 15:24 +0200, Ilpo J=C3=A4rvinen wrote:
> pbus_size_mem() should only be called for bridge windows that exist but
> __pci_bus_size_bridges() may point 'pref' to a resource that does not
> exist (has zero flags) in case of non-root buses.
>=20
> When prefetchable bridge window does not exist, the same
> non-prefetchable bridge window is sized more than once which may result
> in duplicating entries into the realloc_head list. Duplicated entries
> are shown in this log and trigger a WARN_ON() because realloc_head had
> residual entries after the resource assignment algorithm:
>=20
> pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:03.0: PCI bridge to [bus 00]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [io=C2=A0 0x0000-0x0fff]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] a=
dd_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] a=
dd_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> pci 0000:00:03.0: PCI bridge to [bus 02]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0xe0000000-0xe03fffff]
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unassig=
ned_root_bus_resources+0x1bc/0x234

With this patch on top of v6.18-rc3, the boot log looks clean again:

pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
pci 0000:00:03.0: PCI bridge to [bus 00]
pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add=
_size 200000 add_align 200000
pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
pci 0000:00:03.0: PCI bridge to [bus 02]
pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]

(and no WARNING thereafter)
Thanks a lot!

Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

