Return-Path: <linux-pci+bounces-22581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96AA4857C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D312B3A61B2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05661B3943;
	Thu, 27 Feb 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krErGciP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD41A9B5B;
	Thu, 27 Feb 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674718; cv=none; b=Jt1X5dHDgLXR73z+QpL+8RRW33D5fA5NaLPp47z89AoMhaskdr6LYRTXExYCHpK5ZtFnbmcV/lFPOJlt9N0GYKsDulvmtqYX/QK5jXUKtTF0zszfQkXH4mPcbUI+8AsGUqOgLis26DPboDiw30MdwEeiXMRqtkSaT7smzxHzbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674718; c=relaxed/simple;
	bh=M8C2M3u5TpN9OWynuAlfv55NDdAKyqvphIMJSxWFvvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubXCsqBdvQ66ohSPaQQCWemjb914sZTZNLtrmcZtT0DIoIMLZ8qeX7Xx1mCHYALvezhkJ10zUUsjgsyHrNtsyOI2+nQXdxyYjPyrI3i62luQsP7aiBOKuKZJXQOByYRK3Zaj4K4Huxnop4skvOiVnLo0sO8CJ7Dz4mx1ipcE7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krErGciP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe9596a582so295362a91.3;
        Thu, 27 Feb 2025 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674715; x=1741279515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL8RbLthQVpACiQn3Yhjr26jWaUe8dDUSmw2OaqrSW8=;
        b=krErGciPQqL/gI9h92JxvwvI9QDa0OizhgNQCRBHIb9l7dkNKb3G3HQcQGi6AOANJu
         Fs3EdldU4mZBEddp5FEJYp+udDZL0nxrNrWyUT3WRZb6EQPcbxsaoxMZ8Fy2QE+2qP6q
         ogr2+Pv1jd+T41VbU4EzOUbC8DUTgroGQm9hK8RVQU92rCEOR2rn1U5ZxOkL7tKcIRLb
         mOnegb97xkdjM09sfwzeSesBXs3VyGS8z0D2JC80GD8LWFHGrYPvfOZFkw5VGbcDdG4T
         nUq2L3fzA1dve4rrc6kwHMupt15b/He1n4u2phul9h5z+dQSiddBFDpWXcvCA0q0fQca
         nqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674715; x=1741279515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL8RbLthQVpACiQn3Yhjr26jWaUe8dDUSmw2OaqrSW8=;
        b=e5nJJVu37td70Jgwe2DPKKAeLDa+EiRkteZxSI2p6yI2OJbl2kInD8IaN6dHpub2uU
         A2Q/jStGQnyOAjOayd1ep5BukD1FdSeXPl4ccEUlwHtToaSt+HnM4pt7clcus4v8fk4l
         /nLoV7EfE00MVglCXm6NB2A9TrT9pu/QVFFC8hoINVqm0fdkrdkBtzuaVImlw4hYLC6U
         ZPW42MrjF9V0nuZEXwXAXzMZr9mhouLbisp24JKCasPVJ4HEOQguHWR+eeV7WM6OjJin
         fAZ/4OYKQDX+m4uHXi2i7l2h6QvKOd8LhnpHxDaedL22DjY3sxML4ynYiRQjOr2AdkTZ
         odoA==
X-Forwarded-Encrypted: i=1; AJvYcCUSaD7VV1ZUtLm3Tpl3tWgeFuJuBDXE7L29H+5Hx0sRNYLsOV3UPc4gozqTX/StYTeMxwJi7LeT5pfafanVNy8=@vger.kernel.org, AJvYcCWyCV+gqxbhEXmidbOHqJhaE9+HB5QDyLbOBNqTJdSY1hshIrE2IVuXgYMm4qrl/kXanzOFcFQLf3Jk@vger.kernel.org, AJvYcCXKL7kfOqruiyYA8VWUvKyFdL8jdw39OP8IiZIvPXU8ExARhWDv/S2eKVX3JENsZNXC39FaidlQsR0=@vger.kernel.org, AJvYcCXrDPAG/lPZtg8KaHjcel+hDoZtLvBf2OSaKJU66oA2ciwBHKjv52WCwNPWk4rNp9Kl5Se0CD09wOWj6+3R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LKEwdJUMgKfGjuRvLu0lO+ckBqWHhWPV7gul7vxin/0CkoSI
	5AowVYIrGSyDASHJjISOug35M+bOOHYHWH0N055/oMJJt5yN3jCGKjsKMPqPlgwpBeWa1k18Ztf
	FHAmEHEaQ8fbb4o9uqtCAjqUYU+P1MTohoBQ=
X-Gm-Gg: ASbGncssw6u7iG5zu0i39I5EXVt1A++BrDAsx98FhcsVRNV4L6HKaUh48eGz7geY0Ve
	ddd/fb5qZMj86AuHn8Xdd9B6FLhmqzAw3AX5b1+VTh7ww3Vtv6McUTY5Vg0HQ/UoyPQHCw8wdqt
	emuU59QVo=
X-Google-Smtp-Source: AGHT+IGlS9m7htkmiS4ofu5OERP5ZjqcFVa2Gfyhnm/qwGvf7/Ub7WKRRohsNEWZXPH5rSMRgwJpZDHpgeq/nlTIpm0=
X-Received: by 2002:a17:90b:a11:b0:2fe:8e19:bcd7 with SMTP id
 98e67ed59e1d1-2fe8e19c0c0mr3595573a91.5.1740674715406; Thu, 27 Feb 2025
 08:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com> <2025022752-pureblood-renovator-84a8@gregkh>
In-Reply-To: <2025022752-pureblood-renovator-84a8@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 17:45:02 +0100
X-Gm-Features: AQ5f1JpM3A5OMa6-YEc-JtVXDMdKZH9wLjWXNO1hTS7CpAspMy6Fu_BwL4bcJa0
Message-ID: <CANiq72kS8=1R-0yoGP5wwNT2XKSwofjfvXMk2qLZkO9z_QQzXg@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alistair Francis <alistair@alistair23.me>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Sorry, you are right, it does, and of course it happens (otherwise how
> would bindings work), but for small functions like this, how is the C
> code kept in sync with the rust side?  Where is the .h file that C
> should include?

What you were probably remembering is that it still needs to be
justified, i.e. we don't want to generally/freely start replacing
"individual functions" and doing FFI both ways everywhere, i.e. the
goal is to build safe abstractions wherever possible.

Cheers,
Miguel

