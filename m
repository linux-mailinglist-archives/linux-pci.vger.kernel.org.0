Return-Path: <linux-pci+bounces-23844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA827A63052
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E63B6D20
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE36204090;
	Sat, 15 Mar 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHDMyUoH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8E13AD22;
	Sat, 15 Mar 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742057587; cv=none; b=EnRJtbCTMZCxc2ev1qJhCRZr+XMpyNs/4KCJ/0CW3iOTWTCq/DYZsjJvhrKX8YTsS7lJAw6+TeagZum5nelXa9F7mv2IDFj/j1rydVulRkajNZfWd2IxXz78GfFcICDF/5i0y4te0hLGp3u/pajwWJQZJn84ONk0dp5SbzRj8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742057587; c=relaxed/simple;
	bh=zjOSu9/dnsAEMjfIozr3ojYdoi0Fs9oyyhaZpqVgY3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUixlBQhEGl5ZhzIFHU1u9VBY1e+z3c9YMgalU0N1uoPEisPk5JAS/mFLL3Q5HuO3aTawkrAmNHdU1XkjmWTG9XC3F/4Y3lOTnesLEOfbD1UupPZJbWhfzzkEnb9dIaOKNwlZ938vT2SuslgfGf5/zbJ2cqmyGT5600G4yVMkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHDMyUoH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a59so34362771fa.0;
        Sat, 15 Mar 2025 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742057584; x=1742662384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j98XjoqRqS//TK0dhh02Y1wC/XiTzmRNvGvaHw/U+9E=;
        b=RHDMyUoHIcv7hGOpMeoqZXZlO13zNMJLPrnbDpWbSATz2od/pHEXPVoUyHK7Kuhydi
         HrC4mwB1uy/ZMBJ60JW0MxH+mghSGgatxuRfuw5tvbDcBoh8uwGipea+oqX4nkmiaAqQ
         C+z57IWzSCAxseZwVUj/WSM7h7nxaBYvO6wv7l58VXVbmCDFF4SDap4BEAA8b1GR6GaA
         2P161SljPGcjYbivGLrWmt6wxTEG5AcaqN5Zkeqmvh3oDk6Xtr5nVEPP46jjRS79sK6f
         6Z2g/dJAHiFmX004U+mORftKsKg4azIe5d05LuaYKOC7K/toaJ3kBTFSlkjtuDPtHwmf
         2hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742057584; x=1742662384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j98XjoqRqS//TK0dhh02Y1wC/XiTzmRNvGvaHw/U+9E=;
        b=ZKL6QZuBMq1Ugbp9onKdyoRUqrdpmDcgwDJej08sIp3qs1q+eo0bFlgsYBohOVOsxk
         D3KADF9H1B4k4L8rwBwUMf6UCu1dNefnZ5xWX0ARdJU7Ip1tjD+al1lrkydOgP/BKfxI
         C0uMcDKCoI6uRQXSMgFRao3168/KI9P/zR8eKQkHI5aRGSecgzsEIjTVAb6Nka0k5PrX
         iuooEXOwQiZH3qYxeHYTPNhEX7i54lluiQHrasqZgSKveEnbNBHWHAPer8guOcuFfgmb
         0PymACqGf3/2ozqDZ4n/NP2y/o5Av8vZ4rRVo3HtqxmVbJI08pCxx3ZByV8dajri0MSA
         fm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUesFFnAqMaraLRP2didkEfIqk91RVtB0COQcTYWzl5ZUwLHvltJW5G2ThNfl7/QnRTNCra@vger.kernel.org, AJvYcCV6kGgkVtLSAsJmgIMZNKCUCQjXs5febhgZXmr/c3aQarzbkjYth6bJx0rJFF+Q904TLizgcc7qnCjiXZsAatU=@vger.kernel.org, AJvYcCVUokwQoBfw+ARN9XQaBmoilgHyZ6vx9tlbUuupv1T1gl6bw2SvKFOZfGfbKtfz8x8j2gZj9X5jo8Bs@vger.kernel.org, AJvYcCWPdq8ed+bhUZhZ8eRu/i6v1wilZW0BpEwN6BF+96Otl+GrdOnRZ8vd7LDSe4txjCgx55nSiR/c4YPG@vger.kernel.org, AJvYcCXULiAbj1iTpmw0RLRIucCTrH6b+R5YTFThRVR3Kg5q7KBAIW2aCBzMxHP+IhmD88iaDNRMpKcNKWwnH6a2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sWvnRPkW5zxATc8YsrN+v7kvEsGJdCIT31YV0pTMDYRxzz21
	C9cIa0GhGitAdVmSxsP5pOQ276ti+bgCWXLA9iQenDrHVSsbgYhUpyTYiXErj+AfrCrUJnSDvER
	+3E9uXp1fjJQIB6iqVI/phVPKHpk=
X-Gm-Gg: ASbGncs7p91bJCp8HBCLysuk9u0Rm5CkSnSeV+Rjjb9S6tn9o08548PO1yU7xEr/lhl
	vObPRPO0aRwHNG5+lk2ut9hY5yJ5SdZZCsn7ZI4VMGO1R+C46+T4z7kR+UN5QPiGBgcrtFsCUK5
	UrjOoSz2p12TXfX8FpaXrWXu4XqfRZ7OJaYMhEm9QYcse6NoLrJdp1re2kMwFk
X-Google-Smtp-Source: AGHT+IE6nJLBDig190G3azOZOlfsw3kVizlD3XnA7F8SdKwqqWHAB/0dKbxRfepfM+ueRq00y/aoSc2PeAtrf/Ekzy4=
X-Received: by 2002:a2e:97d8:0:b0:30b:b852:2f85 with SMTP id
 38308e7fff4ca-30c4a85fd06mr19914131fa.13.1742057583484; Sat, 15 Mar 2025
 09:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219170425.12036-1-dakr@kernel.org> <20241219170425.12036-4-dakr@kernel.org>
In-Reply-To: <20241219170425.12036-4-dakr@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 12:52:27 -0400
X-Gm-Features: AQ5f1Jr3qW4JM43WfoNMs9V0OgzKr9fN_4HpoGcmMxFqsIJ2AosKUujuVF5CQVY
Message-ID: <CAJ-ks9nnQU4ryR1mbaWqNqcH+b=-s8Y0xKxTF-TQvfNGsWO7+w@mail.gmail.com>
Subject: Re: [PATCH v7 03/16] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	paulmck@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +/// Marker trait to indicate a Rust device ID type represents a correspo=
nding C device ID type.
> +///
> +/// This is meant to be implemented by buses/subsystems so that they can=
 use [`IdTable`] to
> +/// guarantee (at compile-time) zero-termination of device id tables pro=
vided by drivers.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///   - `Self` is layout-compatible with [`RawDeviceId::RawType`]; i.e. =
it's safe to transmute to
> +///     `RawDeviceId`.
> +///
> +///     This requirement is needed so `IdArray::new` can convert `Self` =
to `RawType` when building
> +///     the ID table.
> +///
> +///     Ideally, this should be achieved using a const function that doe=
s conversion instead of
> +///     transmute; however, const trait functions relies on `const_trait=
_impl` unstable feature,
> +///     which is broken/gone in Rust 1.73.
> +///
> +///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of the =
device ID (usually named
> +///     `driver_data`) of the device ID, the field is suitable sized to =
write a `usize` value.
> +///
> +///     Similar to the previous requirement, the data should ideally be =
added during `Self` to
> +///     `RawType` conversion, but there's currently no way to do it when=
 using traits in const.
> +pub unsafe trait RawDeviceId {
> +    /// The raw type that holds the device id.
> +    ///
> +    /// Id tables created from [`Self`] are going to hold this type in i=
ts zero-terminated array.
> +    type RawType: Copy;
> +
> +    /// The offset to the context/data field.
> +    const DRIVER_DATA_OFFSET: usize;
> +
> +    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of t=
he [`RawDeviceId`] trait.
> +    fn index(&self) -> usize;
> +}

Very late to the game here, but have a question about the use of
OFFSET here. Why is this preferred to a method that returns a pointer
to the field?

