Return-Path: <linux-pci+bounces-18528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E299F368B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EF016B965
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A06206F0A;
	Mon, 16 Dec 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJQp7TAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB693205510;
	Mon, 16 Dec 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367425; cv=none; b=Ua75lw2o6M8LYP8oymGksGn5R63gWh0XeJqH4cvCRosai0+bAMr9tMcoREuDk0w99rmHiynNwIynhAwlyb5Q/l/uoyf6AQjk59N4papiHNhmgYD7OtSVUDLRmrPLzZW9xqBpSVUeYGec2SqPtZFwdvYlXgdFcQUKfmaSm0z+85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367425; c=relaxed/simple;
	bh=04uq97evC0SsjGrcIpfj85T+QYon9j42SA1xzgoB2h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5q2jGPOfe6nN7hsRFNkA/HDpRy04eXtEBvmtXXTczaGGlQmct0RknF8DubaHLBLxsyb7fgPZn9+yeEIWQrY/gbkjbZeeRMnQE15yMlxtwj1VEoQvR8ajipYFVQ93AMlcnnUmDSbDefF9db6KFMkkDKkiGVhJm8HrDm+rtkMYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJQp7TAD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so658327a91.0;
        Mon, 16 Dec 2024 08:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367423; x=1734972223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04uq97evC0SsjGrcIpfj85T+QYon9j42SA1xzgoB2h8=;
        b=KJQp7TADjBHf+JciSDM2ecOyo8hT5A4HZfpEFrMb/2b8HV6/QryvTK0XRhOon0jWS5
         2r5qW/VA8K7ag4Pm5Lx/Fh5Y+ufdAEyebv66WvLXyNqDGBWqq4MYfK3WCEU+w2FgDp63
         3D6rfbiU/hbTeec7y5HCuf8tSgr83kJRJQf5T3GLkwyHPlCDcdKmDOUgBqY3tFTQx3NZ
         HNchx2cyvRqVlICmxRpp17vRiBlpuj/0cI4nNpKOO49dsW54d/S56YaMJTW4q5rJEbSC
         xxYs8/xg/df62WwDWLMVgJTWvxGcX1gGknLu/GjUn2eXXTPqz5hFUCPS4EwBQ2W1hLR4
         0nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367423; x=1734972223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04uq97evC0SsjGrcIpfj85T+QYon9j42SA1xzgoB2h8=;
        b=kkd0arzGb8GtcKjca+mnmKrdoQrd6Ms4/9i8quS2nmlHD6ze+fb5TVIEWjRto1h6JG
         /qzWyJxQqXfCqz6HAXPNYN6laWWjWj50ffT841Slc9Cz1Sn2wb6ngbQQ1NC1vWEh5ON+
         Ku1t/4/JCneo0d7KHQptnKwtrYX2mTqaEWqufa3NZooabfS0MlQHzG26clmNeo6AbpEt
         zGk/ZkDuhJBlfogwEbm95H38m+XvpRlHNPQFfPkdtXvfbyiV2AREK6+4Mxv0zC3hHZQn
         1KiXB/Pjx8lCzZ0f/dUiMK9Q3DO6TdYEcMBA9OIfewckAmBmv6AgJzibH2P+dgsnUsm8
         ylqw==
X-Forwarded-Encrypted: i=1; AJvYcCUIh1yga0UXP9PYOa5mfcewZSeAfAtp/7kvd6D1fKNkDlUYAfYMjp+zmOqGYYN9SMjaYTKiBVPUbdre@vger.kernel.org, AJvYcCUdDznQvOOp+TqzUCUzNptbf9j7Stj4oAQWJavjnB441KMQ6dlitSqjwiiDeL64/oXcxqXg@vger.kernel.org, AJvYcCWkoKZJXWAPPfAKKdb4LFRLFAFMqpBFKoGQXhLOMB3+j5rnCgSLXYkC1408kCRrJ4u2q2dB3B7sFgTQ9umc3/w=@vger.kernel.org, AJvYcCXQLaL+dlq2RYw0hoFwZNQRzcd9KfGkQjYIIfGzDBRNRGupAeg6Sw2hmGVo4tygY2XkTy6RoF8rY4L9@vger.kernel.org, AJvYcCXoUarC7aDQkJm5VrN5zBA9kXihMkiaRN/Zh74+yV2HnHjmaFobdm4IvduVWyrSN5rwxsfsfAft/w04bSRJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+o8QXN0pcBsi69ncpd6xqL+Eaoqdlo4qNryIymJeaeia9VdiS
	nmHSHjQmtnIFH2HMpnNNS5thPnUh8Abdl+mdToCJdP+vVTrlwTrNpzdJ90nXuhGZ51UH5xP39Su
	gQqnmztfv6qGyGeYQyBgUg+eG//k=
X-Gm-Gg: ASbGncseY2KX1N2LipHCg3sPKyHeoM2E+qHvFxRo9Ihtl8W/AfxYPfeCdELgDmRz0cs
	df+w9jFAMXROoS77bExSoybGg1eyNSJrtIralyw==
X-Google-Smtp-Source: AGHT+IFKc7fJkdNBzcdwh9kY45ShdWwWMEp2syQkysrKW6iv3Fq+LMpjh+KUuaXeGBaITab5cB8AhTBOz/VBn8AK0aM=
X-Received: by 2002:a17:90b:4d06:b0:2ee:b665:12b3 with SMTP id
 98e67ed59e1d1-2f2900aa595mr7449238a91.5.1734367423043; Mon, 16 Dec 2024
 08:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212163357.35934-1-dakr@kernel.org> <20241212163357.35934-16-dakr@kernel.org>
 <2024121550-palpitate-exhume-348c@gregkh> <Z2BV72LDOFvS2p8h@pollux.localdomain>
In-Reply-To: <Z2BV72LDOFvS2p8h@pollux.localdomain>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Dec 2024 17:43:31 +0100
Message-ID: <CANiq72=cOgKRbA9_G7XSTNkNx0JxEa8Qqwe+VNCw8t7y1w7n3Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/16] samples: rust: add Rust platform sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	paulmck@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:31=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Thanks! If nothing else comes up, I'll send you a v7 end of this week add=
ressing
> the two minor things I just replied to (remove wrong return statement in
> iounmap() helper, `pci::DeviceId` naming and `Deref` impl).

If you are going to send v7, then could you please take the chance to
update `core::ffi::c_*` to `kernel::ffi::c_*`? (since we are migrating
to our custom mapping -- `rust-next` completes the migration and
enables the new mapping)

I think you have only 3 cases here, and the change should not break
anything in your case, i.e. it is just a replacement.

Thanks!

Cheers,
Miguel

