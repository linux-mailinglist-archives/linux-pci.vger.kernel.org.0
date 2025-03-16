Return-Path: <linux-pci+bounces-23896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF60A6371C
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D7D188DBFF
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE91DFF8;
	Sun, 16 Mar 2025 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiCr5ZG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18753FE4;
	Sun, 16 Mar 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151634; cv=none; b=p4qLTQeXWshcz5840FdR5BPZq5E1hsT0R2JS3c6lZD9R5oZtLKbOVoPWntckisTVz9Rx1q3lIEXeDRNdF2tvozuFzokdyE1UIgl2W0sy8q9MVy7WqIm7HtZ/TOxi03LBM+TJxNK6eeiho25wsJwB2vdKvBbnEHunieKoLL6Hshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151634; c=relaxed/simple;
	bh=naKeEvdk9+ozk7UuJjUlPj5liiJuaKNdEXADETTXuZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5glDrNqP9ligojemUXC0QAI7HQKh30K1vc63n4qGPoGjHU0On5qzKQkHEkOn1LH/V65WI12Lx47JL3b1N42LjWrgBDeLEiYeEwWB7gNUnhRPEzZHlsDa3OuZBzTfWyW2wcEhk/vpsMcFfemkpulWXjMV/rPg9NIIGj6PKLOIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiCr5ZG5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso37868521fa.1;
        Sun, 16 Mar 2025 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151631; x=1742756431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naKeEvdk9+ozk7UuJjUlPj5liiJuaKNdEXADETTXuZE=;
        b=QiCr5ZG5IzMGN+zibYo8QOVxceeeoL/6NPigP+Wgr8Hnf6akaitYodetOQ9AsAK0Ig
         8BkjAVmE0ih7EO3Nx2RklpOHYC8OTxb4IGhfgAAf0K/Nuko3VQWvPk6e4elu0zWv/4u8
         816wQZidJkLpgbejNFqIzrM6w4TydYVkqKUFCB3ZZgxCJw+U532FJgRPLjDEmOunzGTE
         WkOJ3OQdsX7MyHAy4TXBvSiV0QpBehCOuKi8MxL41JqQeyGkKu1GL5865pP6XlJxRPK6
         VJDycmcIeb3vkjQUHmOS4TzFglb0THdAT2qMCx6U+80Cnmqu/H14sHvSWVchnBJh6Xz3
         kKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151631; x=1742756431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naKeEvdk9+ozk7UuJjUlPj5liiJuaKNdEXADETTXuZE=;
        b=ODM9wr+w4chrio4xWdz+AEHNOB84u7wdMfshXz2ZqkNaJwdGVKLWb7aVOBP91MK1kw
         wd3LYum4cHvotVpbHHcQatVnG/Lo8S8VtizNboElyuMjWwIA5psDdOZYdTYZKqigJ7Ct
         VSGPFAddFv4fDifXo6HxF0Zk7K/IEp7vOZkO6YIBrmbgrrd+vS2PzjsYoDrGaDswaB0t
         MJRGuFK0nFnNm8yPdKUkx1vuk7qQNRMwJ8WwASOHAoOY9W9grIvjKByjr6HbaSiS8hDi
         iAHDNUhifEOrUXbh+z/Lh8UgF28EfqDr9lLznmn04bedOfN4I0jUv1JO+/dX3R9AnHc7
         hhIA==
X-Forwarded-Encrypted: i=1; AJvYcCUGulvToY4rhSEB91rRY544evoVQoKN7FqgHzzm6IsOVgpXb7rkA/K3MWDuXxYEj63Fw5l0DF3mPygeyNA=@vger.kernel.org, AJvYcCV8bB6JLp/7hI7NTmkoY33DX1zB5RMJIqW3avgGGBDzktEG4yCT7p/o4dq19Klij0gvrwMd7CBETE+Oomuf6S0=@vger.kernel.org, AJvYcCXb/sHQnO0Y3YRijXNgjFMcBkYbAyUI+J7E41KKQY4rezczvW53u48qTebkGD3GeeYXTMpP6QU4E8Um@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNjKC08Rtc+TgUROm/raj9WMMeiyzT9x2SgUHvAD0K+ZrDEWo
	NkJbA+68C3QygKWptIwV0OhLmISjiPc4wATZioUeVCFxs4BVWcMMg54KUXR9IgwlTUORld64xwH
	5mG1yvzYDD6Re5dBYtXTckmWyWIY=
X-Gm-Gg: ASbGncvEN+iBwCOyHeDcMFqjNVONztE6sQqwAF67BmqZzGPbvpQIsMwW7Nb533fuJl4
	5/A59zmHyhz2KQzinFBZe2ySkPjR0W2pRSkdmcltIT2psXGS5DezBtIbv68ui7Z/GFCFiZQWpUy
	HMBsFbxq/b0UwX+d50nzNJSNjvw/iFNprhdNIwt5wRZWaDWbxb5f3umOPkbWOf
X-Google-Smtp-Source: AGHT+IGTwU9YeVzBXKqgu0s9gGBozC+T1Jtztz6LIcVHnk/qa4lKpaynB7mmrDnm+HOk/QPhsi0bd9yvRAEOCYporI4=
X-Received: by 2002:a2e:918c:0:b0:308:ee65:7f44 with SMTP id
 38308e7fff4ca-30c4aaa2af3mr33621581fa.8.1742151630571; Sun, 16 Mar 2025
 12:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
 <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
 <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
 <D8H1FFDMNLR3.STRVYQI7J496@proton.me> <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com>
 <CAJ-ks9=AKR+LUMBjLNrC9NZst9+18Q3HTrWn4q+baz87BbG6Rw@mail.gmail.com> <D8HVKRW45ESG.3NP8BPWF76RYT@proton.me>
In-Reply-To: <D8HVKRW45ESG.3NP8BPWF76RYT@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 14:59:54 -0400
X-Gm-Features: AQ5f1JrC_o7dZ4bxDZdzSgTtiII538sFdEPTVEXJYP8AoweSkwo8OIDOPkOagoI
Message-ID: <CAJ-ks9nsEMALOFbQEjj69=griW=x_h_irDg4mHdo+hG+ZbGN5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 1:43=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> No change required, with my reply above I intended to take my
> complaint away :)

Cool :) is there something else to be done to earn your RB, or do you
mean to defer to Alice?

