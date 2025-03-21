Return-Path: <linux-pci+bounces-24390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AE7A6C2E7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C96467EBA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29F22D7BA;
	Fri, 21 Mar 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVawPpmZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE41EB1A1;
	Fri, 21 Mar 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583563; cv=none; b=hHkJJLjo+FNWIqnYbRVTnyIh7IIUiNam394WubMrIBKyXnLGtYZReb17AxrQ1/4al2nj3Z4qiCbjUJWnAqBAkeCXwn7KkcN5M2a3Bx5Xy7QMO9EcGX/y0oNWlMpF0OhJI6pbft80T84+l9TsQkGZSG+yT+a8Z4sY8TNFwsZoACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583563; c=relaxed/simple;
	bh=ygPQW8tbUTmdJrqZEgpDb8uggfJx8S4P4KR69j0L3yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/38N1aWFaprsqUCliL4W6peAWHYDRwvSSacPyvE0Xw1H3GButuVo6ozVHrkucSijDe7yyPLckPW+nx+S0lq9/pY3+zrOeaQ3lJGvKDmYz3fAT1m/sRu1WdLKqnMYrnwSUCZQ8x+TSwJXjdAaxvS2tE0gJ3jWFmF2/1df0bPgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVawPpmZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403c99457so5604625ad.3;
        Fri, 21 Mar 2025 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742583561; x=1743188361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ/vT/adxKWtOd7X1FiYMTVQZCBQfkBp6IciAkLtWI0=;
        b=fVawPpmZDBaoO9OC6CMmSEVVCWo0QwIo+OWvXFc/I7iSBfmiZZGKc2JyBe/vCMz3OY
         fYhRYXOM4evs55ejBSF/a5UyH6TvLEtoBM9SOjPWeUZOCBxt4sboa6XJQvJ7k/JaaRV3
         oQL+PG4IO5xBmM+bEHW/o7/gtUwbQMGyRDDlOn7ltlqUc3nu7BxEZsHa3CecwR9irLnI
         zlmozUHVHgEnJiBrqqkufjujGLBtzvCGPmSe4IoCEmj+lVPuqztj70OZlCvJHTPytxrF
         GVkgkP8XX530qcyrluPVqVVI/Wy/+K+sSuRQ1Dpvd1149Wj2hwYBGQPHLr/P22M6bWXP
         r3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583561; x=1743188361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ/vT/adxKWtOd7X1FiYMTVQZCBQfkBp6IciAkLtWI0=;
        b=cSjDgPJQMRpu8ASyqwoE6CxBHKD6ivnFIZ6R655JYylKFXM24eqHDaC7a5RumqOI68
         9Mmi4ntUc7dYzutVYoC+OnEI+mZoHMKzm5Spzww4VPXbjpSrx5VxKvgKbcHQd2p7iEzX
         fI/jSAcz9+M6vrT1b/4ZvxFwRjUL1PCmnkIA5KuF5PtF2ezV2oC70fdVR1xXRFtc/eAm
         SjCowVL3rU5DIb5Uvt+upEskyovySArqMSJnBrT+KbQ5ksrbbP2e0FS1Qw85OM/dflBo
         7VynB6zsnf+mYUo7mzD74x1/j6PjS3MPhvm5TA9ZnzBKAy9IGjiNqlB67ZPZEtDYdHgl
         m6wA==
X-Forwarded-Encrypted: i=1; AJvYcCU0B9KDeRzYnYwlq9Wa7Nh0V0K1BGlG4vWsZyrLgouGS8H3qV4mHIF2hrhbyIzHU2nz8k38m+fwkX+4@vger.kernel.org, AJvYcCUbwrU3WyhC1Ouo9hbn/B7jkoExV8Pt5oD5yG16+3c08f7wQINeRqWdnmTjjbwLkj47Gx/IAlvL+7w19ZwTpPE=@vger.kernel.org, AJvYcCW9jxphrbHatkiXJ1jwM3+8qOkt6jHyId7C4FdPHoqD0bZ1nllPvwwywOjcjGRgKZUiqDE6AKIqnQBrjM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/MyOZsl9nBO21ZVwMLq7k1Dy74mDXrjogNEazVifpOP3QW7r
	pv0jBOGwQFpXt5zjARrO/aySjEj99SB26rCtFjl+lyFdLv0RzvVeSFq4Nz/b6BTUt7BTNnBQ0mN
	GFnN+f11aKb79NqaN1MY3NmHbPDo=
X-Gm-Gg: ASbGncuI4qcA0BNmszR7EcU4vbxBwf5ueb9JwCz8vNj60jSpgnz+MsuTKiezXiAFkxw
	tFE7BrDKbmqI4LNi9unJa+bgy6hf8Zbh7XKs/bZ7rrWDGkIRE3pest0Z/c4oqFYypWvImzfoTWR
	VYhexOaPARJzh5iis2NrccVRjtzg==
X-Google-Smtp-Source: AGHT+IGAhuxfeZ6SMRo9eoFdQod84Rl9u+2lNK2X9LUSh8QQLFr055E6+3UGZR4aL6UGNGhtlqOrJBGyvyBKGkMk4TE=
X-Received: by 2002:a17:902:d489:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22780b9c1c1mr25632305ad.0.1742583561013; Fri, 21 Mar 2025
 11:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320222823.16509-4-dakr@kernel.org> <202503220040.TDePlxma-lkp@intel.com>
 <Z92ldvI4ihlm0HJd@cassiopeiae>
In-Reply-To: <Z92ldvI4ihlm0HJd@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 19:59:08 +0100
X-Gm-Features: AQ5f1JqE3UuC3lvXEQjAanveB2Yg9Z53_egm0hdBd5uAqUk-Rr6bLA0unz11U68
Message-ID: <CANiq72=s3rQwRt-TOr0_n=EKHwJSQSGmKfu_4TtoEhSTc2Fvqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
To: Danilo Krummrich <dakr@kernel.org>
Cc: kernel test robot <lkp@intel.com>, bhelgaas@google.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:44=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> This requires an unsafe block for compilers < 1.82. For compilers >=3D 1.=
82 it
> turns into a warning *if* using an unsafe block.
>
> *Not* requiring unsafe for this seems like the correct thing -- was this =
a
> bugfix in the compiler?
>
> I guess to make it work for all compiler versions supported by the kernel=
 we
> have to use unsafe and suppress the warning?

It was a feature, but it has been fairly annoying -- it affected
several series, e.g. the latest KUnit one as well as:

    https://lore.kernel.org/rust-for-linux/CANiq72kuebpOa4aPxmTXNMA0eo-SLL+=
Ht9u1SGHymXBF5_92eA@mail.gmail.com/

Please see:

    https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressin=
g-unsafe-statics

So, yeah, we use `allow(unused_unsafe)` (no `expect`, since it depends
on the version).

I hope that helps.

Cheers,
Miguel

