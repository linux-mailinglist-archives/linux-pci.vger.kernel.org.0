Return-Path: <linux-pci+bounces-23809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6AA6258A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 04:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C4C3B84E1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46136124;
	Sat, 15 Mar 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkOxLG+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE563D
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010320; cv=none; b=TU1ou5ctasMb5w4exG6EqEjir8XXi+odr0Opg9n6m2YFneA6Tcl/tFoSvEwY3gMULiwmXhLpigGNHVV6+oRpmO963q6BAvO+IxSNqPz+JXM5ZeushI0Xsn/uzbyEr63jG+BACn17NwMwy88Yed85Xu6DXx3guVqTD76FWCgO0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010320; c=relaxed/simple;
	bh=U4IbF6pxY+oCSDLe2JwLjQ1HJpSBUObvEzG8VSi0ZEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAvb+hvXQInAWc9agYhe6FqslakZzbaw8+MOg3NZeu4KxTVTvovhAzOklYi0E6gn2/Id74tXJzU3v/8giRpURqLyE0wjgjZNR49SKoI0FKzVI8CQRGmgdEA4ZiLI+GiC5YmVOv52KppdTB5m9V/aY8S0/vYebUJDwY47QYpVHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkOxLG+8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25313ea37so548096466b.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742010315; x=1742615115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4xHD85bk13rBdgxAVADV77Uq2Fwwp1qTFHU1nr78k0=;
        b=KkOxLG+894os/tFjmIc0VdL5kYKOs5tGKZTkcYu0uU4NNDWqZvn0Pt3HVgXTo+v/kv
         Tc7P9OSMwvRjIy3N+18fMK2/UEZiK8NJcEM5Bm0edjvbKlJYRLdP+rmy5DretbLIWpNO
         KX7qWnBL8dDd3x9Zcr2iDaJlS5Q3KchBR/BS6SkJnwapccWVubl0LjyCfjjP6TH1TXqy
         6xfcJmu7WTXxJxMAeIcfbwxXRq6AAiH2ldjSWZhfOlGLCaNLSsqQDm7bQK2xKZ1oceLp
         D2sD/NNWKKZEj8BRnjrFzxTDJBEQktvsJhcTTnyFwRPqEXU2203viNJiv6CGv2zqnjss
         ogbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742010315; x=1742615115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4xHD85bk13rBdgxAVADV77Uq2Fwwp1qTFHU1nr78k0=;
        b=nooizvsaiHEY/SDtTLKdq5hdujGfXtyIIg74jijXxztF5EzRjNMVVzOEeBpgwDhMvx
         yCI3shaFeeErPB1jOHcAAhzsackhind68oPjo2G3mGxmbnTypDxNkafxPIYFcQorNGKP
         RSCDQNo3e/lzBtxaTtBo2BauS/TfEfzzXEL96en6WmA0d3BY7R3m178cKgksJNsr4ZME
         YJn4/idbUkntrejaz/jRKJ53TpB23xGWkGMaYbJRSlFICm9vKtROlE1/h3/EE54aAcj9
         s1/XwjrFbFJZDYrmtJMymt5LLqZD0EktNmRjZloOR5NKUTlXciVgcez1ouV6+6JmK/CW
         RJnw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NyoInd3i61eM17us9xZa3cAnhIHFHJYbv04gGv80c3yvsj5igdnQ8KIOyt2kGNsH2SiLcW4dIHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EowCYewMokCKDrf5ct36vcw/FPlimLIh3N0EeCMzajfY9uPY
	555SWzp6atlNh1ahzgAZlLY/qgPaJf+gsvzF4IY7kCS4rNqoBI/dIfS1vTFi9FXIqF2d4hrRuKk
	Gtj5aVZLledq+Ct+1Gkc+ut99FK4=
X-Gm-Gg: ASbGnctxG7dvwNI2ItHv47lJJayic/E3K+LVAXb4XH0+q1+zrSFjyXWTo2vM1HXs8vK
	Tr7DyiJi3pX4q9RGPa2UKF48iywDaDwJsGcgaryR2eQuqTsfsOFli97ShKGW0B/yrMKPyaKlO5J
	gJkCrVZ0YGrFLyhvycS9H9z4pzYg==
X-Google-Smtp-Source: AGHT+IGra1XDxh5h5Up0e7GFY40swSizxIX0ymUzziu7LRfD5GHIjXaWW8aTawtfXJ2P1d4B80VnS34KuofpeNCCxEc=
X-Received: by 2002:a17:907:2cc5:b0:abf:6ede:dce1 with SMTP id
 a640c23a62f3a-ac3301fdf30mr518911866b.24.1742010315415; Fri, 14 Mar 2025
 20:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121114225.2727684-1-chenhuacai@loongson.cn> <20250314075328.GB234496@rocinante>
In-Reply-To: <20250314075328.GB234496@rocinante>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 15 Mar 2025 11:45:04 +0800
X-Gm-Features: AQ5f1JrWWKwjHb4Ce5K2WmEkLOb-NSx_bkI_ZCFrqwYvNrtG183P5zH1bX1BfpY
Message-ID: <CAAhV-H7AnAnmPT73wQtx2gUitrLumc3NURvBWzJYj0UkNHw=oA@mail.gmail.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Krzysztof,

On Fri, Mar 14, 2025 at 3:53=E2=80=AFPM Krzysztof Wilczy=C5=84ski <kw@linux=
.com> wrote:
>
> Hello,
>
> > The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> > MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> > keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> > only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> > is wrapped around (the second 4KB BAR space is the same as the first 4K=
B
> > internally). So we can add an 4KB offset (0x1000) to the BAR resource a=
s
> > a workaround.
>
> Applied to controller/loongson, thank you!
I'm sorry but since Bjorn has some questions, and I need some time to
investigate, please drop it at present. Thanks.

Huacai

>
>         Krzysztof

