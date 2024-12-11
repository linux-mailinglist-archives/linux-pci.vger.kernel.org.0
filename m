Return-Path: <linux-pci+bounces-18119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522239ECB77
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20188165BDA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5E211296;
	Wed, 11 Dec 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWj+zK/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E4238E27;
	Wed, 11 Dec 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917301; cv=none; b=iiY0sC1cgRoXf+Y1eVClBafnDod3WdkGkBbiglOvtnhx2Y5DnpnOmFB1K7wjfcoCCH5DmpZOl6q9oJslrOwLquOzuH0ULAxtULv6KjDcbvDIy66BrXmbbnueFu2IBN0ziGFqM6MviR7dWkPeH1jXMyO1Tz172IrKgzeKctYrkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917301; c=relaxed/simple;
	bh=1mhHRf1Ma1uEypkWhhQBKWHLQA7xnihYcYLQFZydAQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAkC2Z52Ym8XQuvo9YHo6n6f8Y+AiZ+1ocB8C9Hr20qTCAjwLmBlWrGZjRgd6gYzChZiUr3eMlsYJC+YCPnTrcoZIx9F7Z5EuTg4shwDP3y51j9PVQN1/MulSqC1KnlUp0ZekOSzndrqY5JbkgahEniLJOGzqjvY/HWEEKO2EU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWj+zK/a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso1140609a91.3;
        Wed, 11 Dec 2024 03:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733917299; x=1734522099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/+snhFpulgjg/b9milrZ1XE3OxDySVi/UqtwUb6x78=;
        b=iWj+zK/axtl3hChs+3pl73aN08aM+BmeMawWCKn5AZWLJPzkbFMy3v1EBL5ZA6EZN1
         aiOuoCuTOPDtnhNYmfOMYO0h2d+1sIQe+qs6gnkHMkElTknR8iSeAJroVXQlqtLU9YTP
         UL//dPtXF0/tiRM6217biYnRE2Y6iR395puHi+zEJxBFopziWnFAqmQPTL5n6FydImIH
         oD84+6LdJRo5E5NxK+Ys7coU8xVi5Y+CvZvaHfKTje08nbPtoMaa5Rdx40ngdgJ2OKgO
         CJQUs43UVseJcNMqvncnTwe+8a3/ytDsSb8TOc8InWJbT3H6RB1c2Iun39/EfaUvyb/z
         pg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733917299; x=1734522099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/+snhFpulgjg/b9milrZ1XE3OxDySVi/UqtwUb6x78=;
        b=JOX1lAnz16gAJRHnZInOjXdkDnZA+WNtY/4IW6EY1eXwkMJwu0dhZbPtG8MyRBNLiP
         M6rGlpKzkmI8pkOzwQ2iO7o/eWX0co4XDeGG8faJtQpokJKeoeR3kKGzPfkoMpYqnSOS
         KzTNTKwN4/yD3xnYOz/gyif5VGycCFxuDXETWmLgFBi+DLpN0oGB0HiOWdt+rwohinmS
         lXrNFXFR5peh1SMEXYV1Do47VYZpZKw7rDIjU6Zq/IlwWVEdDqJu6XBlHrE9BE3FKf/m
         yMowzhJYVSDm5FhbD7I58IjSCpLaWd/+4qfOiJb1qD5FoTIV1Cc9PMoHisOwOfnI1sHY
         ECNA==
X-Forwarded-Encrypted: i=1; AJvYcCUxOFz5NdvogZSJ5Ln9E4TdRgaBDYEOAwYtoxvWUWYyVSNh4ha+7+wZL2SVHtzgpiOllKeaQjUIj3xb8L6H81o=@vger.kernel.org, AJvYcCWgw7KpWqirLVOAq0kHLauji86C3p2JHnfdeLCSzWS3UkOoGBJtPA28OVo3vVnvomAcBugkvo7pscrM6JWu@vger.kernel.org, AJvYcCWyxiu8vZqMPh4tc4meZN7qBfsJtlHB1u2oKHbhiPQxMrTn/ORvcLLab5uSNhaRm3kVzr2lDNzffaIT@vger.kernel.org, AJvYcCXfLMkUidy12xM6utmiA3TnJNxZy4oz7ouxqNLY+RBRcJIhOBhvo3kxAkZYEdJc1SlBg46I0grRljco@vger.kernel.org
X-Gm-Message-State: AOJu0YziuVeC0YU3C/NDqw3DQNbck7h3IdYs2jHaUSgzvjkWpsxNqjXD
	qMGnfPmkbq2rIUHCHtZ+YFr9f36/exlbsewVQVYwbLhX1BlBQaK/qds8PffKA0CDe22cdIGPB/3
	hgNfRPapoJBC44ij/KoEW97MfALw=
X-Gm-Gg: ASbGncs8ZvST444CMCkWcaym6k4O+2fo+t5kbg3+BNwg4D9WrB9uGupFqHJWSlwf+3B
	ZHr+A2ySD3/RON54rXZ22Vf4zlxY75NpDnYc=
X-Google-Smtp-Source: AGHT+IHaaP1PLWt8qXFf6NILDDcKKeQTWVOrXdIHgPTZI1P4nTIGd0AzO5ffZ4lvYAVw4J6pFlGFuJKgHZ4K79IvwiQ=
X-Received: by 2002:a17:90b:1a92:b0:2ee:35a1:c291 with SMTP id
 98e67ed59e1d1-2f127fbeba0mr1510079a91.3.1733917299136; Wed, 11 Dec 2024
 03:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210224947.23804-1-dakr@kernel.org> <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh> <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh> <2024121131-carnival-cash-8c5f@gregkh>
In-Reply-To: <2024121131-carnival-cash-8c5f@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Dec 2024 12:41:26 +0100
Message-ID: <CANiq72nMkzHLb9gi_i6RbQYkzP-1W5QbtGVx+z1f8nfp3y_CwQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> Or does the Rust side not have KBUILD_MODNAME?

We can definitely give access to it at compile-time with e.g. `env!`:

    pr_info!("{}\n", env!("KBUILD_MODNAME"));

Cheers,
Miguel

