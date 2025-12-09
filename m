Return-Path: <linux-pci+bounces-42803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42CCAE940
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 02:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676933046988
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC926529A;
	Tue,  9 Dec 2025 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBvifLej"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE123314B
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242594; cv=none; b=sL0leL6bsPPQErqi/VyKZEb2hIhIRzclqgr0pf/Uq/HQfBpm9gj49uf8lZzD88P+4x0QXegxU3RaUNvHjMEP5B22W+BCojI0JrKZTWHH/gHVyfiWzHnpdio+6vmt5mEcSfxV/+p/avZBVseMBYfTYfICXDlsPgfopDVS4/pyoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242594; c=relaxed/simple;
	bh=mEsBT/pLTbTyK3CEgFpn4Sf1V+J+71IdtUhL88rzZE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmyxdWXCN9soMmVFJwwob29Ucpyr/WXeEr+gbeDpDbST4tlzVUmCxtMPSgzRFz8hFHdVo/hNcDlqyFfKIipgL27gdS5Wj9isEYs7qbEoZ5/xrZAEiskILUA8XlRa6YPjiRlrAaRdKym3r4aeb6k3pFmJAzYXqutY2N3PevccLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBvifLej; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297f6ccc890so8025625ad.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 17:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765242592; x=1765847392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEsBT/pLTbTyK3CEgFpn4Sf1V+J+71IdtUhL88rzZE4=;
        b=UBvifLejNNaz0+hjEWIBt1RpfkkU+B9kkaF3mqgLHbFYIdlb++9igJuSDeCNVO7BFw
         CcikptyBHu+CdHcH4gEFuTC3d2EOFja8EjA1DR7DbbrEKLeHr1yf/hhsx3HgtyHJu91b
         O6HOuSFNzKVACPf7/tSf/4WP8HcI7MXvEB9noe7R2xgr3DwuPiY80OqWy7qYMavbBXKI
         BR/AWfR6kYwpZmOVm4Xh4BSPhHD7lRHi2XgbMb7KCSEmVY928Ui66ya80C+rGlLTTBUr
         M7U7l176fDbPQCM6vCMS7t6j/mRBivMeqAUX4qXuM1d+tZN0UoBzIF1wXauhx2ME3At2
         vHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765242592; x=1765847392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEsBT/pLTbTyK3CEgFpn4Sf1V+J+71IdtUhL88rzZE4=;
        b=R/NHjYxcolpyRh3qqaHxKZt42BvcGJiVu5FXBrUcABvRAUmmmA30X13rqIi3Cs3Poo
         9fe+iKLJfux2G8Q1nOX3IIVoR12yoP/OlQpjfSJ60s3YVQeJQigCxZFuyNGWYxGm+uNx
         pzuZiCM32XM9chge8FNZK3F0M+2K2HXS7PdFpf7pdo9AJ4ORAxUwK2M53kuH3jMmRMcl
         9eUT+Hbe8ICJDAcZamTT3x3w0SVm0c6/tRw+LHRvdSds0alzzmFZ29Qp+TIugp9KutMZ
         SsZDJA/Y0yij7QZzj9EVrWHe03RsN3rZlZT/+1t5bR7EemO8tg/gQNfGOaWwKXmRmpBz
         2HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZM6YszajCSXetGY5RZhNi0z/JB8ddXIRP5bNxZGp82FrRK/d4NfHGe+lnZIHvaz3IKg0mD0WK7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFL50wFfGI17Xp62tyng1eeqEhhSipR9JnI/CmRMPPzRL7+u5
	YlINQ1xed0p7QV6Kuxz5COQHDu4U2iOuK7RnBC3cjSW8lSZhmUi+xP37ig0sLCnvYMd3f6KmOZf
	mB6EMqfQXJFrGc7RgcYNPQFbVMiXtRZDWwQ==
X-Gm-Gg: ASbGncsHCxIEG2s4Bp0oyJvgZ5ETONNpauO9daXI1GDIsODpaGMWnD/dWwoVyBvYoiV
	aZz4aKeZjaetcmO3Jienp9tqo4iu4TCdftRKBnSvKt3voj7ME3W0MegzK2yXAMQKPbtcAEEED3E
	sDAOGwLnvbasOSD9b1XsRohFik+4KSQ+OQuR+528cvY1C8r7LArs6p0jm3YizQov9loUbuUvpBt
	GZdYsYxzYVU5JfdBw96RRi9LgvaRMCqPmIRYNfGyE3AeBnYsRpa06PXHRZMYaJFlKmQYIGz8xb3
	31IVvSXkJNBDo+71IRbdElM3CI77cgZg/Yo4trEG0X9OxYua2wsIBZzZ3ZxGzEd8BYlCWc4j9h2
	hRxVy8TpkvPUK
X-Google-Smtp-Source: AGHT+IEJL3H2CdkWL4QxEIdsfYYJgp/HlFqFDJUUsqk1LlVkWGajJj3NrPDAOyq+1dE7luFLpJ2g4+mrjjdZg1vzVG8=
X-Received: by 2002:a05:7300:bc0e:b0:2ab:ca55:b76a with SMTP id
 5a478bee46e88-2abca55b82amr3434532eec.5.1765242591987; Mon, 08 Dec 2025
 17:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251206124208.305963-1-zhiw@nvidia.com> <20251206124208.305963-2-zhiw@nvidia.com>
 <ca549425-e10b-4d54-aebe-278d90c8cb92@gmail.com>
In-Reply-To: <ca549425-e10b-4d54-aebe-278d90c8cb92@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Dec 2025 02:09:38 +0100
X-Gm-Features: AQt7F2pwYK4ZIpAGJ2cuBoFunByDKO5gKUgFer_xOdKdqv7XdaFLaTqM1T-H2w8
Message-ID: <CANiq72mkPMwb=3P_-fjObUC8NmY_6pzK5cn41RRwa2zJCazuPA@mail.gmail.com>
Subject: Re: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, airlied@gmail.com, dakr@kernel.org, 
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de, 
	helgaas@kernel.org, cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, 
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com, 
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com, 
	jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 9:52=E2=80=AFAM Dirk Behme <dirk.behme@gmail.com> wr=
ote:
>
> What's about to do something similar here (and in the 2/7 patch as well)?

In general, using early returns (especially for error and `None`
cases), i.e. keeping the happy path as the unindented/main one,
matches better the usual kernel style.

Whether that is with a simple `if` or `let ... else` etc. it depends
on the case, of course.

Cheers,
Miguel

