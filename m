Return-Path: <linux-pci+bounces-22538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C084DA47C99
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 12:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC1416C3D0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551BE22CBC9;
	Thu, 27 Feb 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pke+xbY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815422B5AA
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657138; cv=none; b=JKn4pFLqlkbN4ALRb38EMzumB4WUZkkLJzWOD1rz1UNmIyFXoGTDRjiwjy5UjJ+xjYwtkW59QI/mMDyblpcoBW82pudMTGXER0uEXAEQAFAhilCIbnM6xeTQ0z6AuPKlCcOSZ47aFPudm8hVuo7DU/denpNLZpg8QGJ7hI+pVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657138; c=relaxed/simple;
	bh=ZaBaHlXpgISQnJ1vf38M4JccZJO/2KtLDXTAswU9l0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrHpLIMbmixW5j+LNNS1evxeetwZ7B6MfgUB6A9eew9u4qMmw521mUhyQcac9ZJ7gLIYbS9Hwy4kvAaYMLKf4ogUAkTLIt9yTkXqX1rDamf02SkO/VuWG3M0XXJ5wjL1hIN/JS/wyqvIg9D+ZU1/GUziULJ9GP4AOYSr8hnGYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pke+xbY3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399deda38cso5709925e9.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740657134; x=1741261934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNdKucBFyLDnUpRRHMFpanrFUXUbOxjcG2NQFry4jEA=;
        b=Pke+xbY3dU3Sz7NC4QJSWHHHQj3b5pbIFPMJki/MA4nPqUHqTjrqDnKGPXdybYCqBH
         4ffqpIXT1KraM5jIs49Ij25xHYM2F+fbG4s803uzZ4UrkzZRhh8UR9Duph8Q+LTR5DY7
         noNSkU3zGyZtT2rsCXhNg23gcymhsRQTOTrgDhAegubmY6dZGJFJuzTD55567i8ayl34
         pOf/96ktJ/q9GIW1Re1aewCBusMkBcotxh89xlAei9qbuUvSkHaISquK0hu0BInSzy78
         hAXOigAoh+QpPDZ7AXb1U/Hd0AmgCGz/SLtSGH5lge7e+KN4PJycOjaCUPGNw9UQo0sb
         JKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740657134; x=1741261934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNdKucBFyLDnUpRRHMFpanrFUXUbOxjcG2NQFry4jEA=;
        b=QwHW0T+Xpopv8bAcfeG2NB0GD7Z2a11B5rtCFUtaLaogesqKhUL31U7Z5n1hopHp/a
         fN4zP2hUjfUVBS/zzA390v9VrvqnHKp2l0wZlwXGh3MjXcK1GhqiXlHrbB/Q6CBWtqHd
         ZyOEOr3BbgvlzzBjMC9nZgNzaQS1OAAM5VygjSC7yzP/ONZbjMnKSEP6pEu2J1vJ1Mpu
         K3VNKmh5EevoRRQNEqAHOKrJlBu0wlTrIu20NgqTaW6TBEW4S3gD5/Yt2VR4ADP1EBNR
         BGMxG795sM1Gqha/xyHwYR6vtwEH1YqQONnLR+q0B3akz0ZgrzKswnlDVBZe+CKyayYo
         AjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyWhUqpyV65N0NuqLvqEOA8sUl3jojRVWAwc8ZvLG4y7MV7BAWXvArDqeRj4XCCDSmIJkFiuTNM5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLZwBFhjEWwm8h5VrbJST6GCor16krzOFZNtHd13fRsZMUErh
	TMuXVesllaE7le/lLDKSVhZ2W8BK+ZwviIAzP1Vo4oPFe1ZRZ4s+Qm7ty0k1kyNASsvXK7U26wg
	gMAa/3sko6nRU+qdskGd0ULIGmGMNi8LBuux+
X-Gm-Gg: ASbGncuiTq1/leGxULBsm+0XlgpZnz+7TQD4gqdFH8QApcZfH3hyHLfmWjUJKjFGqYm
	2uW6q4AjSiLN5X0dmkVQAwz2lq5wyQBNmymrBwPG5MQ5DlJ+Br0erzkllqxt67D8iqFmfLEsKzY
	dpl0brWEpn6mOkYlheHjTk7hBM59HcgMBwJfWXCw==
X-Google-Smtp-Source: AGHT+IHFMCQU8NgWs1giXV4C3CXCYYEUJ/IZnhwhrgrkeisTz7Mc7yeRf4H7WaocW1dgWF/I8OCXnBza7JsyX98bFDQ=
X-Received: by 2002:a05:6000:1864:b0:390:d954:5e7c with SMTP id
 ffacd0b85a97d-390d9546117mr6217650f8f.38.1740657133802; Thu, 27 Feb 2025
 03:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
In-Reply-To: <2025022717-dictate-cortex-5c05@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 12:52:02 +0100
X-Gm-Features: AQ5f1JoXfYkoxQb4CZpqnD2kagTNPR0-RQG81bynqiWx3iUDZjKaVI-kJG8xNSA
Message-ID: <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > +     return rust_authenticated_show(spdm_state, buf);
>
> Here you have C code calling into Rust code.  I'm not complaining about
> it, but I think it will be the first use of this, and I didn't think
> that the rust maintainers were willing to do that just yet.
>
> Has that policy changed?
>
> The issue here is that the C signature for this is not being
> auto-generated, you have to manually keep it in sync (as you did above),
> with the Rust side.  That's not going to scale over time at all, you
> MUST have a .h file somewhere for C to know how to call into this and
> for the compiler to check that all is sane on both sides.
>
> And you are passing a random void * into the Rust side, what could go
> wrong?  I think this needs more thought as this is fragile-as-f***.

I don't think we have a policy against it? I'm pretty sure the QR code
thing does it.

Alice

