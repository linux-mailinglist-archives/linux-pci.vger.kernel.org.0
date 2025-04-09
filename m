Return-Path: <linux-pci+bounces-25581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04624A82966
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F861BC8373
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35A267712;
	Wed,  9 Apr 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljlxjZh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B6266584;
	Wed,  9 Apr 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210433; cv=none; b=oRd3o/oP4Jpa3rUaR5r7+4QSAufbQeRd0B9Ig7ZecnPUGDgCUspQBwIEphvd57QlVyQvUnac0mvZXKNogvEEJKZF1OzKSzV1khhyQDp/5UDCTss6XFVozRHNUx3npdcOtu2SV+xn32hcojjhJ6X7f5NkouF0SnsECTiBcNREFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210433; c=relaxed/simple;
	bh=53KKzPlpzb7gC5zuaIMx4InWNHXbNxAOj4jyTJyQImU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWAk+HpMVQALllgjNLjiUTFdKWNRYdi3g85bMUO7eXr+s+09VwlaYjiT2Kb3teaPLy5Y1Kmdl3wB5LTAZZBzW+MU8wAyxHARYbOZHoM7uOWrKIMBxe1DUilbMK75y4ab6vXqf/vG1mueFCaokhrXLwzam1L6clgyhFLIsjhUvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljlxjZh4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db3f3c907so62216871fa.1;
        Wed, 09 Apr 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210430; x=1744815230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53KKzPlpzb7gC5zuaIMx4InWNHXbNxAOj4jyTJyQImU=;
        b=ljlxjZh4BlXICbjnLYsSMsNgDj9NWnSPFLw6EZKIksL8OT3qIU25TzRSIgZPYEhO8a
         wHrmFw95kcLxgVbDkPbxeEwtRuXBg71oIamUYqvWjLhZpbVX5mukushDn/gryLRq7Zoj
         vitCLd2RZahmqpflBYGzkOvPYg2nUp+wTdOv1Lzcc6K5oAnI3Dxi68ZzZzdM5AbcnCbE
         pE1nm6bMEfdYQB7dyGwnmG98xU4L78ZbAaFGyuq97TMORz4zkOozKCsYCLKsGn1LOOir
         hdGdWyW8FrMBH2irJX4SSvduDVcTDgpo9ESBoodU6Sf0d3sjB62dI4ATRDccvTbzLPFP
         oqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210430; x=1744815230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53KKzPlpzb7gC5zuaIMx4InWNHXbNxAOj4jyTJyQImU=;
        b=AVtAVg6O50hphoeDVtfoLFPLITZFug0HsSLmkPtX69BqTnCv48jvD9sokUKIRnHvDS
         xQe4N/2e3uDCYTcxRpGaQoLgk6fPHZWflMN6GqHoIWs3rHaIkswFjWzh9T8W7kvHm7lo
         rKdXpInDvjoSnPt9jD82cM8tJjkEi+PEgfNQdm0qlYHiwxR3RMjZghil4XiNx5HOjdJX
         9nLRwH/9dnxd5di9UfAUVw5UEByXbHdqyXYP8Y336MayqJq9noD1qnU5eLgghYxOoHhL
         rNB/0Wx556zlCforLu5s5jGSZy4bV3b4toW4XSuWaLPg15lB9MFUXrZM3GHZk8hPDs3O
         9EmA==
X-Forwarded-Encrypted: i=1; AJvYcCUOl2PQUeEQ/7y5aFi0f4eOthUx/rAfjgIXuLIEwRKY5mzRcR49ix3f10BE+cx1sumlJvvpypikjccDKpM=@vger.kernel.org, AJvYcCXUma35bRgHV+fW0lhoQOkYi8IYB7dx99OSCIs82UazDvn1sObqcFEW6GUSAI17byy64E+7c0/pPj7n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2CT2GGH2HnDt/rzFlGA3KLPjBUYHO4haNL+VCdjxiyvZd/5K
	3VZamja8V/d+rDDYR0quhR35C/1Yc0Hs+3KFCGOZ1dMn0DrLacpNGP60D3iJZ2gsUk1Ppn59ZT6
	gvs+0J9AnmHKVWWvise5+HPgUvRg=
X-Gm-Gg: ASbGnctd3GYfWSDNiwbO4mW9NHZypHBW03Pa+j1Z+As/hoT2FcTy6XNJByk2NFG8c6R
	xzXBMoetu/g2QBskH3ROp1rsWFXzgzAQUqLNDkgcbSsX8Rm+IHmG3hHW7W+ul6FXju8Z+n7RjmA
	NnhtxrUGEJ3rDMggAtShi1KnKIOmLl6Wi0HNV21Q==
X-Google-Smtp-Source: AGHT+IEcxnsTdNCxfxlMDyIf/Jd27gS1PZesPEHPpGoGie1uudNn7s3K8FevLTW7IvL5YZmZm/yzSbKB37B+Rat5/XI=
X-Received: by 2002:a05:651c:3126:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-30f4506ca0amr10183131fa.37.1744210429655; Wed, 09 Apr 2025
 07:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Apr 2025 10:53:13 -0400
X-Gm-Features: ATxdqUFq-wev47-jDnEKm--z-nhtBup98s8fXg6ahqd7cw11Pc7kdV6lrJxkfhc
Message-ID: <CAJ-ks9=Q_s_XnyeZSUC+yABP+BrH+7LnJkg1mHDuH7k18vLR2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rust: list: remove HasListLinks::OFFSET
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:51=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The bulk of this change occurs in the last commit, please its commit
> messages for details. The first commit exists in 2 other series but was
> picked into this series to allow using `container_of!` without the need
> to cast from `*const Self` to `*mut Self`.

That first commit is now in the prerequisite patch, not here.

