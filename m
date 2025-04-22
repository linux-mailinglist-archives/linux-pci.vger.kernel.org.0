Return-Path: <linux-pci+bounces-26404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755FA96E45
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7783B36BB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB2284B42;
	Tue, 22 Apr 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAKjzfDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B64281517;
	Tue, 22 Apr 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331810; cv=none; b=M8L9EavAO2uG+33y2G7pgeQiNfguPyzYfxteRWSmQkLolMtRIBaLZSYVJCX1zbgYeXjYe6FO9cU9jzTOf1lwZ/SRhWDYi1YSVOdaJru6R14ZTbRaS1AMPTAPzB3xtveWllh0Gh8nXVc82Uf2lOiMUdfsf4Olk4v3UTIvkPxiH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331810; c=relaxed/simple;
	bh=2+irYqNqFtPSbvXEoNWRSPMp4kiaSzXHKbIMOd/mHaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bILi0+xbjgYMSIytHjckp9L7m763oVGpCzP7IJYleFBVwWWTsF3FrA8pHtjTTQCHa8yjOHmcCXgX+3TsiqPDPG/ejHCNU7Lsl8B5/od4TJVsln+ZqpxuJ+lOjXxHkcCcAnRtfr6zEWXIHQ09BdOqC620qdr9Sf35WH1euqXHK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAKjzfDG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403c99457so8555795ad.3;
        Tue, 22 Apr 2025 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745331808; x=1745936608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhgxihL4Wib3NE2BGbErbJZ7/JG0NsxC0J0y3dShv7g=;
        b=hAKjzfDGE35oVVzFlWH3B723Q8Er1nvOByCL52MIb23ImZgafIzfLFko1Wc7Uk4SbF
         UC34vlPrjBt3dLcjkP9OdmbHO5Imc6UDx0weMkHR3rBkv35ujZt9DF3KTriEjal5Q3Ut
         sKRdCkzXFNws6fMjZYxdSGiVmqZIlbQuWZs9HW/alImfuS7Wo+HKzch2UGSdJOmf8Bd2
         7F9O2eTkmBLSDigAvE5ig6vtRM8SwitGde2sQXOU8JtW8m2hjpvlLNytV6mjqgYGfcfD
         olqes424KmO3E3O/rGDWEREXwL3EVob/FzHNI0S+VpgrU9JFiRZCYkqgsapceposRJ56
         9UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331808; x=1745936608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhgxihL4Wib3NE2BGbErbJZ7/JG0NsxC0J0y3dShv7g=;
        b=Lq6auxaUg0gHcTBW06n/7nGmr0Wa0F3ZQaw2C+PL4OtEtV+1J1zM5WVT+sqK7uaXg6
         teScfsuj4P6b65VQiK4ASx8x6orTMemsKFa0ADileIW87BVphKRGnh3uPn5ZBL/ukVIK
         rZigRJXPgXWtjf7d6w821EsyWzz15BdqvHTqmzqO3pF1iHW14PWty7sVUI4GYbDOjZdP
         YzL0x5FIZd95fM6qfUC4saLpIxY2BRkVvFTLXV4ONLB5ZYx78ZtKXPKMI6MjTvB9wqdP
         a5Il9QIPcWex/HXum2QMKbTpzsKB739aWw2v5AFm310WLAJ3VY06mx+IgsAWPeVjMdwy
         KoBw==
X-Forwarded-Encrypted: i=1; AJvYcCU8C5OtNaekGqaV+qDYyXaWG7SxFoBNmQ/J4HH+b1gqz2BszSbn/UacTWLb+hGdCDNx5LbmvehKoQRjKhx4m00=@vger.kernel.org, AJvYcCV6e5/YZX6QeQGaO0CCW/Hbw0V5tbwTaTqZxL9TvfjDSdgY/BodB0O/EhPU8HkaR5TE8v8upQ1IK9Jx@vger.kernel.org, AJvYcCVA7D0dMD1Kdxel+07DtCuYD9ECrjTrWcPZh4E69FK1cS/+mz+98EE9eK6PhHufWP0jPg0kJAAJthJKSKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL874h0H7QLGHdesqT1wX9gXdbF3lTJ1Z1HQf9CfgJq/BhFg3D
	9dJDTDTd/vhmKyniXmJ+1rW30xRC+/hVd2pXryV65l/4OUfTnEeY54aN05AQdyAZWXLpOeJb0sU
	YJyN7N5d7G+TC8zl6j+SUS164esY=
X-Gm-Gg: ASbGncszxxSF1K7jNUQZdWXX3vI8YDH/jYP4xm9Kwpt9PzWBUnSSrQKr9cP9hTr9UZO
	bA6O8u/8/ysHi6bZJn+ENXL3+yzdNscj++vnwxKMhpwKORiOY1C/bJa9Upa7CnNLk/quGyoB9AE
	G7B11ZVUGmLkI1wuGG9VomOg==
X-Google-Smtp-Source: AGHT+IHxirjvMU1TYZxcmHGblsxt1IPtANgT3JFCJeU00c0KjBh9bGSsGqXSUY61Z0zbHKWPIr/Oet/I9La4hLsWddU=
X-Received: by 2002:a17:902:c405:b0:223:5525:622f with SMTP id
 d9443c01a7336-22c53472977mr79904275ad.1.1745331808145; Tue, 22 Apr 2025
 07:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com> <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
In-Reply-To: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Apr 2025 16:23:15 +0200
X-Gm-Features: ATxdqUHiTDekx23W0XaXQBL6uKW239ZNoGTSz_vkHVe_W_-qxe72aUF4qvNLNU0
Message-ID: <CANiq72=1YtvFDEMJw_=SWWC8E5vUwK7XSt23kzrKvxYMjkbXug@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust/revocable: add try_access_with() convenience method
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 2:09=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible, or the

[`None`]

> +    /// result of the closure wrapped in `Some`. If the closure returns =
a [`Result`] then the

[`Some`]

> +    /// define their own macro that turns the `Option` into a proper err=
or code and flattens the

[`Option`]

(Assuming each one works)

Cheers,
Miguel

