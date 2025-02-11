Return-Path: <linux-pci+bounces-21237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE83A318F0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2413216A3BA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAC27290D;
	Tue, 11 Feb 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oZcJ7Pk+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43C272913
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313553; cv=none; b=t13r+LT1j1IzC6JeI+UgeREpLYoF9+24qr8YWKj4CA+C2q+UlfbJ8BzTzX0mPcU9V47pN7xMIILUuhV3V/FNYAemqNgENfKn+7LivH5ZBrq/Cokn+2tHRiyd371B8OG/lrgOm9p91mzENaSPzlhY8AX+cElXmhNqkcLoIwZMcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313553; c=relaxed/simple;
	bh=+rxztfAaepIvxroPWZrjETMbmBSAZmiGeMmEEmwWnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftYTTxom3PJC7jlpccTUe89Q0syJ5qyBBCrNFs06BO26xGh2b27EBJU7A8AUdbrWJxWFV/63SoCNtrq8mQP3GUKRhiaUWBAmk57/1qRFo/oNcgZ6XTfeHZPjPY8kSRVVYchI8oCXhMeosOwnF99f6/IjJiX/+I4tds6tju60Ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oZcJ7Pk+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B86B3F171
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739313547;
	bh=gkMw6duxxbJfB77Dmk59/srgHXi1HXapVPCmFg+N4GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oZcJ7Pk+ZMqegGRCPOfrL9c/VbO3dNr/A0n2rBIZUjHg0Ay7GeFpx5d6Vcst/5ikj
	 4dlLK70BayjYA7WsTmN6aJ1Tf7Z5CXqspc4QbcS4yYrvKDuLWB8CLoXZnI383QYbGM
	 pmOVg6EQW7/Qr5wStDSVAwM2gvhnd1TBid8cphlUIXqAKmp8jC/2d9wIYSsYtFC8j9
	 S/MZWZypZsSDYjkwMo5w0JQP3iL9ZmeLhWpp55ZrRVYYD6XnmBsSbn8xOH1ZqPDdjy
	 Am98zHuD/AXIv3CX7WKAB4+nB5+eKDgVw05U+949+TlnQOaKeRKDPRlHt/YSR/s0pu
	 z9dpH1c2qLtUA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5de573292e7so4257351a12.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 14:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313547; x=1739918347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkMw6duxxbJfB77Dmk59/srgHXi1HXapVPCmFg+N4GY=;
        b=IFQS0XzZQBZ8FwTnJabUTbFGlMFHmZYGM25fpInliLVD3KGq+aGSdtomH2ptEf46J9
         R+yJkqndzUK8b6pMuWp+7NBmUDhutvxaNeMBkcienL7kAvoRdwLSq9Eqb90KMeVCPRvh
         i669oF6DERhFzJ1d4qAuTwOSPktVf4Qp5vOfEn/AJ3LjtC7t2TemQaq03l5Vtv/l78qc
         3k89LPGcmHWfbujXnoLt27T6NDWNMyuX9ZPLKdYs/dmDZBejqvt1sAJoP09ormkYOh/m
         Fvux3lI44CAOTntrd8HBggLnPQu1WRW2bOX3m3GQh1+bzZtrF6C/G2kzim/L93B0iOsV
         XWGA==
X-Forwarded-Encrypted: i=1; AJvYcCX8KV5nh/tQi3J4STiVJwTLZwb4vOw7oFY+jSZnYkO0k2i2oa+Wn0PLxG3iYCXJ7DX+MquSDPMMvdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SrMyH78KKtfo/QIKvoznKSCQXRoCxBIbBfMFOuIce6zWSLva
	xQKm+8m3HR5HiZ/I/clKofkBzKeZzAX5uQWNkA2/ZFMHlZh2RZvknz63u3fnoC8roTaH481LV3Z
	zwfic1NkYMZNmGjzo5TBuvMNhuYcO+JKtEk7AT1mT+DrSNBfwEkWApjeTFSgZbUbVc//ZiBCdVY
	G0O5PTI1Wjq5K+gkEbQmea+hJIVJdwM1jluXWSoprXWv3dvUD4
X-Gm-Gg: ASbGncsZtpkvCMqx9rT0gCAqq9zplls+v5XGg35CAhx1XFPPKc5TP/3aIGURuG/Pp0+
	qqc1kVn2pyIjI5vxNgF2ZCgJjnPkRIGKugF91+pqGiqRnyWoUk4ssys3qOGmD
X-Received: by 2002:a05:6402:51d2:b0:5de:5025:2bd9 with SMTP id 4fb4d7f45d1cf-5deadd936f0mr915530a12.11.1739313547018;
        Tue, 11 Feb 2025 14:39:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeXeNOatBL8lSa8MFqwcK0SmN6a59+iekzjKdNDyEiFXRd165z7bm7gHTT7X9urmoNWySmmNrC1TNzRw3pWYM=
X-Received: by 2002:a05:6402:51d2:b0:5de:5025:2bd9 with SMTP id
 4fb4d7f45d1cf-5deadd936f0mr915515a12.11.1739313546627; Tue, 11 Feb 2025
 14:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210210109.3673582-1-alex.williamson@redhat.com>
 <20250210220010.GM32480@redhat.com> <20250211100502.GA9174@redhat.com>
In-Reply-To: <20250211100502.GA9174@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 11 Feb 2025 16:38:55 -0600
X-Gm-Features: AWEUYZlnKNzZTDbCsc8502Eq31gjprPZsr33NdR0NJiES3nE_UoqvPy1bRypWdw
Message-ID: <CAHTA-uZ5dxh81D090YFVWbeJuko-+ACPbNFVQ8_++j_8sBjaAg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix BUILD_BUG_ON usage for old gcc
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Ubuntu's (modern) GCC 13.3.0-6ubuntu2~24.04, both proposed options
also build as expected for me when howmany is set correctly, and fail
as expected when I force howmany =3D 7.

Tested-by: Mitchell Augustin <mitchell.augustin@canonical.com>

On Tue, Feb 11, 2025 at 4:05=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 02/10, Oleg Nesterov wrote:
> >
> > On 02/10, Alex Williamson wrote:
> > >
> > > @@ -345,7 +345,8 @@ static void pci_read_bases(struct pci_dev *dev, u=
nsigned int howmany, int rom)
> > >     unsigned int pos, reg;
> > >     u16 orig_cmd;
> > >
> > > -   BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> > > +   BUILD_BUG_ON(__builtin_constant_p(howmany) &&
> > > +                howmany > PCI_STD_NUM_BARS);
> >
> > Thanks!
> >
> > Tested-by: Oleg Nesterov <oleg@redhat.com>
>
> Just in case... I agree with David, statically_true() looks a bit
> better and
>
>         BUILD_BUG_ON(statically_true(howmany > PCI_STD_NUM_BARS));
>
> also works for me, so if you decide to update this patch feel free
> to keep my Tested-by.
>
> Oleg.
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

