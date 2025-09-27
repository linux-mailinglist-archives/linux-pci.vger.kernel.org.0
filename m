Return-Path: <linux-pci+bounces-37162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D672EBA6243
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B22189A544
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43922FDE8;
	Sat, 27 Sep 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="H76AWMDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3522B8C5
	for <linux-pci@vger.kernel.org>; Sat, 27 Sep 2025 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996379; cv=none; b=OKMuRyWSSu2y55N6wYI3+G/LiuE/aT+8mFZYIQFqLItQBaYaG0Nd+bDh2fEhv4diheh0kQnisvS9jf+H7zbgjL+Ve4qKLTWAqWSdABrpxawfDgLoD7BCXWhbIZ5aBJzPecEa66cgF6MJnk0+37EEZVn2vfL6Q5QI+9UJ+pZaEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996379; c=relaxed/simple;
	bh=za3zvUL8SxkFCz68xzHlumy3WxqeoawxW94jKlIhq8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwgzf7FZUgzMmvHE/YtI+98m4GSUvcHRDh0UfqNS7PM1wnOOA9AFRUbSUDdKhFrHnGduhRNuWvOg5SwirCh8Yr29rAabXgp218l52apBkb2w2lEwMGWNAvRJ8+YrPh0+hsEUPYhH0VdYdME06jJp5NKq504W7gH5XqxkYh0eHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=H76AWMDE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8593bcdd909so332006385a.3
        for <linux-pci@vger.kernel.org>; Sat, 27 Sep 2025 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758996375; x=1759601175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdVHqiyAlzw5VOmWhe8awo/oWd+izml4/2QfCryMP1E=;
        b=H76AWMDE761FpvjQ4z30QS9UdzLm4sW0sP0Toa3aYBH6bW3nGyw4523ob2ZeKAQlVm
         ltIhoZu0a3a4wj4FLyUlfferI9Eb1K8JiDJYfuYV4htHOrA0U4wzZGSrm9pnAHKQGTFy
         Z69LW9fRgppH1YFG8XU6aZNO8rqEl7fAeaFsRPUmGuJ1CriSNs7/rCyFXklywd0weAO5
         fYgre6K/jaS4A60mMxA8sRQBKAgof4gl8kTfmaT7Mn2cxNw8jHmZvgqp03WuDNoTz9gm
         Q0UkoaFe1pOrTKbCebTKv0csNgwc6eOMc3975EgnCwmbvVxs0BGF4mE+LZiBPKuk/K//
         jK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758996375; x=1759601175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdVHqiyAlzw5VOmWhe8awo/oWd+izml4/2QfCryMP1E=;
        b=lszEmhe4IaQdGrFMdNJGy8rTvS+w6iFfOwBCjBjZyuoCGWc67QOROxjCg0jMZgBQja
         v3FeY5DdbGZQ2Yx9pMnBD+mCiZZrEZXk4GiwfYxpQr5b69feKxkJgyY8NphgnKsDd5yg
         bNuhRuhcRQc17F8FmqmJEe/BOXZa2uTnSIoD9Zwr7SNdWXpnePYlIETBTLdbFCWrmNW0
         4xGEgRsN7YAYTEONQZZoWPJZJuu2jZBpBn4QO/vweCHtCEe0TwA5W9OEseUidTGvqDch
         o+nR0cCgZ46aARb5YoKG1FW3d3ep9NSxjnLIMLdVlpHvpG9ozjF4e83nbJAVkMmiPOA7
         T3gg==
X-Forwarded-Encrypted: i=1; AJvYcCWPokqnX6UjjP4UeC8Asbi19J8lXKK23rs/d5wu+xKbP0wGuxNuuQ3M3h8hKSWTd5Z8wv2dZ+28ScU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgzqRuPQkIsWSpOn+mIC4l0xA7sf2rtwqQtnKORIYD7L/XhvK
	nWWC0OiwL/WZ6frFWe5Y2hCFu3tJkK4ZgpTy3R73vqM5ujg5p5ju80RWONiL5mTbR/m2HQLNN3l
	2HjYSLST/UtHDbx/Pp0aR0HL/Z9s5ECSkWsqOJ3bTzg==
X-Gm-Gg: ASbGncu6KMW+c+mN1AmxTp+zqUfFrihcxYeYnNIFWvFGx0eRa2eKztvx45E910YmiQj
	gmR/yMZyXuJfR2t2Li+k8M4aioDjgUeAOV/gHXAaS5gYSDZwM0kYM30x4sno4oHXSWozUdRPFJX
	6ar7OcosrZOc1XawUsYJQx7/aDPO1upYnaEQLn1/AQcSUuiu0nIwa58Ewgfe9izJy/J6DpGdKzU
	0nfNK9pPkQDpvc=
X-Google-Smtp-Source: AGHT+IH0hkC5qp+kzEtV3AAYGe6it1JS4/y6NEysHV1y6zn7mbZJQ696CJMmKCXewsNF7vFFFMvp/YeeTwbqIflnmoc=
X-Received: by 2002:a05:620a:4402:b0:862:dc6c:e809 with SMTP id
 af79cd13be357-862dc8b7607mr820813685a.49.1758996375263; Sat, 27 Sep 2025
 11:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org> <20250927171356.GA20865@bhelgaas>
In-Reply-To: <20250927171356.GA20865@bhelgaas>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 27 Sep 2025 14:05:38 -0400
X-Gm-Features: AS18NWAnH9KUAM_KKB10VKxYTihmutSj1aLkSs9HLpJN6HemSHpsSyGyQVSJndM
Message-ID: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

My latest submission is the following:
https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.=
com/

And github repo is in cover letter:

https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3

It applies cleanly against the mainline without the first three
patches, as they were already merged.

Pasha

On Sat, Sep 27, 2025 at 1:13=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Sep 16, 2025 at 12:45:08AM -0700, Chris Li wrote:
> > This is phase I of the LUO PCI series. It does the minimal set of PCI
> > device liveupdate which is preserving a bus master bit in the PCI comma=
nd
> > register.
> >
> > The LUO PCI subsystem is based on the LUO V2 series.
> > https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@sol=
een.com/
>
> Pasha's email points to
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/rfc-v2,
> so I cloned https://github.com/googleprodkernel/linux-liveupdate.git
> and tried to apply this series on top of the luo/rfc-v2 branch (head
> 5c8d261fdc15 ("MAINTAINERS: add liveupdate entry")), but it doesn't
> apply cleanly.
>
> Also tried the luo/v2 branch (head 75716df00a94 ("libluo: add
> tests")), but it doesn't apply there either.
>
> Am I looking the wrong place?  Do you have a public repo with this
> series in it?
>
> Bjorn

