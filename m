Return-Path: <linux-pci+bounces-32101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710BB04C5E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 01:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E226F1AA12E2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3B279DA6;
	Mon, 14 Jul 2025 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly1LiJT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC622236E3;
	Mon, 14 Jul 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535938; cv=none; b=Jk1gzqkDWB+1j7A108FtywUbOAc6cq7EiTyuhw7GwHyINCHFgHI8XoHe9SmfTf3DOnjpX5A49wjTUCrcEU1cki1HzX+c0QBp8+NFJAs5PwAE1GEhtsJUlMMOAW5pXBN2NfpdwMZDIKrt0bNP7U0L+D5YKSiefgA/aSG6aI82cNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535938; c=relaxed/simple;
	bh=2/oNFlKo4K04BpxOEswcCzhS0He/I+9ZW2Mu8DkmHAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBnkvn0k/t2DRhHb7jOmRvZEzdAvuZ12s9oPRHODvpk34PDf5iyfm7VAbEeGuUNrePX4QtCaJ+YKdDZ8cAVSht6tMD87M/ihbJBDAkgfErzSL7zloRPjnMSI+SkTL/J9GCUev5+OOJJUc+/8pRGXTc6lj1Su8eXXeHPDZDQ+e50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly1LiJT3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso875905a91.0;
        Mon, 14 Jul 2025 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752535937; x=1753140737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9huWMMuSwFCG5+4z1117BYAaGoD+b+TOTuhM4RJFTjw=;
        b=ly1LiJT3P9dkB9QTGxjOq2N8tdSJkEzhKC+6lQmUnqAVlLu72lTx4s6tIPfcDh8iWa
         OCgCJpyRkKhTr2+UiXDje222U1Jzy0oVmp/b9Nx5lhqXdoeB4CzsxxE5CYLDPWCbrPvf
         B/01cexgpEmuIqpA2Oakx6fsKWsQrmBaCFT72Fviyaps4SYl1KN/mH25b65MXu6IuOIf
         Pyp+H9eLrbW+7oMcHmZTDO5Le1YhG+v24pDPQiTR8bTSAcmbYaMHOTc4OhmEodopFtwL
         pl5Vtu0dgqPkuuDssh8/f8tBnhsusabNfP5U/cy6jm23OmrYPhkZcnnupkjaXy/i61RB
         5SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535937; x=1753140737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9huWMMuSwFCG5+4z1117BYAaGoD+b+TOTuhM4RJFTjw=;
        b=sl2rzd9iMe9EgcVDigWQT1OrOk9Xc12UQKlMuLwXRk5OeAWdAwsXozvbso5dCcwgE5
         UdSPnQOxL+evkXENmgpl2lF5/hTztCNRYLt0sWmpqNhI1+gnW+lPvsoTW5CHkLu92O2Q
         Ld+X3UqZaGySOEHEOh7IUcVE7RaIS+/seaQuSnuV1hoYWxsoI7gJl4waK6YGLL+CgHZj
         UjtA5LUaK/lNa1FoyejjNvzjZZyIRQPvTrnvsIQWxZST1tL+FJdV/C/OKmomr4BsP6VI
         icvv4RTp7/gsoMN4xCd3V77gRACWGtCq93Kplp1/YcrEhZDa4//qU+oOo70JKn22xe2m
         ez/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIEy4tWb0pxPbVSA7mxBmQNNkOIcDvMOEvfFcRLyylkXQxbHm7VAX1ga70OAXu1b+OMOW0VokO06LK@vger.kernel.org, AJvYcCWYi7lEFNA7xdXzic7gMr9saOgbJCUusN+45szGkCkqnsYoGMg7/j2Oo+l8L9EJ2qoqzkZYHeElhRiS3R0=@vger.kernel.org, AJvYcCXjnjnXVGTzeKeyD3h8Am5/5AidKaI2rlTEBaBgVBgatuRRBU+gvcaS7SPqM0ONcRaZcegWwpZW7KScf39Za/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyr11uU50sOliuvCU8iXeJOLuRXOUlBZJk5QEOm48LSG/Wq6L9
	+deN7TJQZIYxj9PnaT/yGsbUFGYJlezaSfse4oxqOzDaiIZKCFzpF9pPM5uI2pZc/7O7c6wzm3V
	66Je8VYGafUJyWkiv2woqGk6qLq/F9T4=
X-Gm-Gg: ASbGncsbVzb2ob3vfnokwaEpojMTr24uyBwI/dhSJAZiHx5Z/CaMS1v+xz5NwpbFDBN
	OJbPMNAuVty7LOyZt6g/LVEdx22yvjzXuWZfgJI8NCPhcPmIQ8LCLq/GwHu5FDL5vPPXhq4Vhn4
	iV2FN++XK1kIP0KbPQgHk37FKmkY0SnoBp5mZ9RY2CieQozcELZm5O6EOM/UNb9Kue9bJ34W9z1
	S84q2cu
X-Google-Smtp-Source: AGHT+IHUy0Ua1v25mTwgpPWWm4Ri227bQJO0AgCRs1B0MBYEz4SMJojVAJXI6xkVLaJXbNN4w7vG5Yna3v+jPIMffj4=
X-Received: by 2002:a17:90b:180e:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-31c4cd5dbd7mr8270342a91.8.1752535936646; Mon, 14 Jul 2025
 16:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
In-Reply-To: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Jul 2025 01:32:04 +0200
X-Gm-Features: Ac12FXyVGYAXXFEuBdmbjs9srXtOE3USrnSlAZ8_k2h0Q5DrPvEr3zbj7eQY7i8
Message-ID: <CANiq72nXzAOTYEZU6iu+1Qpux-ukN6ktp2xp40g4jBApQMq=5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: improve `ForeignOwnable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:11=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> This series improves `ForeignOwnable` by:
>
>  - changing the way we assert pointer allignment,
>  - improving the safety requirements of the trait.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

