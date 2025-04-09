Return-Path: <linux-pci+bounces-25582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D41A8294A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BDF7B64B3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A315262801;
	Wed,  9 Apr 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwrBfAdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B23267383;
	Wed,  9 Apr 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210546; cv=none; b=Gwccq+2BkEQGrvsgb0nI8P9wUSv7jIe4IYp/QLNEYQDqVfxzNfJzER7vLVHsuYEoRy4FKX5+Pwwa1Uw2Vo7mipxacVAsWrvaFozY8BcKN0wXPCip+xHPMTIY5qffcu3wHo94aAziYP4KHD9xPlAJu18QgTiizeK1NGwFEhxYzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210546; c=relaxed/simple;
	bh=62bqKvwVWb2RbbvEZTZQ7pce7YUNhLlASdgo1XeKzms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4eSzVYDZa19YK+SDDj5/vP+T4uW0hAUG0iltVRPgH9SKKfIu8zvQbqRcVmC022ifMfMsRqjUSlSoH9c4YVZAafGZXIci7WCUZeG7TPO7h+/mLFELazlcTvgrVR4mPiufbByzAq0/rFwzb8y0YddmTIahlN8w+pRdlJVzPJcas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwrBfAdz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30de488cf81so71098241fa.1;
        Wed, 09 Apr 2025 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210542; x=1744815342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62bqKvwVWb2RbbvEZTZQ7pce7YUNhLlASdgo1XeKzms=;
        b=SwrBfAdzwiVlAvOzRTfh3jDgybEO3ZtmfQ3ADeWyOiMaBLmpzR3vplOjph/JTXv+mH
         Rs0Z5cAzzGyQeINxyWXFwC5h88c5CAJPJhgjnmdWq7KcQ+GvvnndDGs48FXy9Zxa/0vp
         /bpUOBGRqYkwB7CQq8KlO9D0wZyqbZZY1pIk15xELKPCnxN894jjG2EFCueguOsPe5XO
         aFcBDhiKxw6Hv2Cn2WlPXVbFTbzd/+7YP7mNmntRr18HD9UC0eUAIIAWgkR7eXxvXuvb
         p/4Eio29A3wearOdW7lVvHC2F9JFdA6HmtimptvZX+Rz3q9ciScw2mRokbwJdlWYj3Gg
         PUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210542; x=1744815342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62bqKvwVWb2RbbvEZTZQ7pce7YUNhLlASdgo1XeKzms=;
        b=PXuKyT9aB16b/+tCE7wqIm0euqb1TBV47CsgsN5oKrNJPcIpKeoob6UfxEVHihVs3u
         QK4GdEowxn9RLgSN1yghHW2rELmPg4deTAa1AHeo2KhR/9d2teSPmPq8RbaL37gTiC7r
         U1aDonTZuGQPeqSlSY404B6yW/o6jnJJv3npceRYb8tilcy3cH2m+l2KF9Ku/m0rtQtv
         2cqLFVV5j/MNdJ9v/j6SvJOCVHNHOTzTqgPjctKn1Youl3D3CcyNLWiTM8CCDlcNIfse
         VeaP2KRAC9DyRHtK/ZivFj6c34m5NL7XYJoUHgIRt1z/xPogHONCjy29I70hL8ZhtkT6
         GQiw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZPB5sIrKBWiyImCWvV63s3pYnoutKNHPFB2LXSkn9cLFq+x2PXZ/lfh+teFQEp77qoD2uh3PkY/GN1Uxp0o=@vger.kernel.org, AJvYcCUxO92jEcqAa/W/E7zifNUXYZHv8XmIf7VRcxcnDtElfOhnEf7L5w+PW4DiVGP5RBDuKjWT1sAxmXwm@vger.kernel.org, AJvYcCXGY9FjvPTGi6Iazpi9r1x03WnGn3l09vwfKmX2+YMrU87OmkiqxmV69igGZ4C/vGkW/eFhKp8HsM1UokI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/Ded4pjAiJjS87RLGQVtOaPnDesREkT1KhHpeBeOgqUVpzUQ
	T2rhyJlkHq19MclKkz1vJEGlc9bWD9mu71si5ytsXt4dacFSjTfDKtT7HxUvFfb1HSmqGGpvZJx
	0pATZU4fxJWzASg2YFAB+m/Hh+MA=
X-Gm-Gg: ASbGnctrHjhx1RCY3pzxsE0zwyVHioJ2NJm+xf6W9t1LwQQ20yc42+LbKR/qjcFoScu
	bsNo1G5Bn8h5vcNmR6mSoL00X539nroMM16aVpOwFA6kKUMwLawQNmAxDteHkwxJPiT9jusTipH
	TSMETyOgnQSKF9+4FJ8L/pK1Q206QZuvvMX621Yw==
X-Google-Smtp-Source: AGHT+IHU/AoP7PryV9Y9U941zDt6V/1WgWnOS28Omvx3meSa+N4WA2w6askTABheugnhgL+yBekqBm0YaUl/UwmUotw=
X-Received: by 2002:a05:651c:144a:b0:30b:c5e7:6e61 with SMTP id
 38308e7fff4ca-30f43800087mr12747631fa.20.1744210542384; Wed, 09 Apr 2025
 07:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
In-Reply-To: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Apr 2025 10:55:05 -0400
X-Gm-Features: ATxdqUFwh6PVplCrJgmh1yKW9Ryeq0LHG84erG1yevB-cYQLVWpCzPYRzwfthIU
Message-ID: <CAJ-ks9kiqAfBc6tWbzzS=3GchBXEUg-yyJE4iGU0zgywp4PZEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: workqueue: remove HasWork::OFFSET
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 6:03=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> The bulk of this change occurs in the later commits, please see their
> messages for details. The first commit was developed in another series
> not yet shared with the list but was picked into this series to allow
> `HasWork::work_container_of` to return `container_of!` without the need
> to cast from `*const Self` to `*mut Self`.

That first commit has been extracted into its own series:
https://lore.kernel.org/all/20250409-container-of-mutness-v1-1-64f472b94534=
@gmail.com/.

