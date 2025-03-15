Return-Path: <linux-pci+bounces-23845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283BA6305F
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083601892891
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B885202F64;
	Sat, 15 Mar 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS70T1Fp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEC13AD22;
	Sat, 15 Mar 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742057969; cv=none; b=EzJ2it3gtrLZCC4rnFP44NVFCtAy0E1UuAYF8BILIT5F9ffEgy9ekZCQ5ye6MvjjuK3wE9W6XHgVgxqkBoxqrIGA2zvYJu7gKzIGp299Ydsc8NsR6Wx2WfQLeQS800MJRa7WKZNCleyhN2NUrVmRZQxnnRVyCEvH46a5fVkhlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742057969; c=relaxed/simple;
	bh=AvP8HBp5JgocLhOoMHSLf4D6s2CBJQEzj9+bAMqWXzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZa9QBtFUUlo7Kvj8JA9odoYp6596p63f+UxhFc6SZdZh922rey2rFFwu52SR4Dj2gJfFKAT9p6hpqEvie3q8muwgMfgmJux1BMcDoqN6jUURDulkmy72inaqiz+FQcw2aU+Jc4C04QIPZ2yAKytOEtm3mxgnYA4Av5IwSSvU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS70T1Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506D6C4CEE5;
	Sat, 15 Mar 2025 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742057968;
	bh=AvP8HBp5JgocLhOoMHSLf4D6s2CBJQEzj9+bAMqWXzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dS70T1FpoFr3Jew8AOyyMO6/BikWm0dQRyUKaPq3I9sLADIwXs3U4sXTyQU+1eWQh
	 30DUcdSjzo1PgL/vH/ZEIGLAOGjHJAHY00hvS3KCx7I8N9DFlbuszpZDzZyxJd+pHy
	 Mu3+FIVVA9ZRfIeZna90hQ9AvGMH33Ir81DfHtVBsFzyFX7/PeNsl9naRBMoCT0nND
	 awFapLBjdVCbUvJ9WnL6AevLfgSy+4SoWveBFdwgfENxVpSD16uJ2C7xjeDweUxUMM
	 bMg1i6ADTw0TU9T46zLZsufktTM6MJGZZZSWqf0bcUayxEiQ5/PpzQRs1T5urwPX2o
	 djzsl5aNpiFtg==
Date: Sat, 15 Mar 2025 17:59:19 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 03/16] rust: implement `IdArray`, `IdTable` and
 `RawDeviceId`
Message-ID: <Z9Wx53fSQw39nHpx@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-4-dakr@kernel.org>
 <CAJ-ks9nnQU4ryR1mbaWqNqcH+b=-s8Y0xKxTF-TQvfNGsWO7+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nnQU4ryR1mbaWqNqcH+b=-s8Y0xKxTF-TQvfNGsWO7+w@mail.gmail.com>

On Sat, Mar 15, 2025 at 12:52:27PM -0400, Tamir Duberstein wrote:
> On Thu, Dec 19, 2024 at 12:08 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > +/// Marker trait to indicate a Rust device ID type represents a corresponding C device ID type.
> > +///
> > +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> > +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that:
> > +///   - `Self` is layout-compatible with [`RawDeviceId::RawType`]; i.e. it's safe to transmute to
> > +///     `RawDeviceId`.
> > +///
> > +///     This requirement is needed so `IdArray::new` can convert `Self` to `RawType` when building
> > +///     the ID table.
> > +///
> > +///     Ideally, this should be achieved using a const function that does conversion instead of
> > +///     transmute; however, const trait functions relies on `const_trait_impl` unstable feature,
> > +///     which is broken/gone in Rust 1.73.
> > +///
> > +///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of the device ID (usually named
> > +///     `driver_data`) of the device ID, the field is suitable sized to write a `usize` value.
> > +///
> > +///     Similar to the previous requirement, the data should ideally be added during `Self` to
> > +///     `RawType` conversion, but there's currently no way to do it when using traits in const.
> > +pub unsafe trait RawDeviceId {
> > +    /// The raw type that holds the device id.
> > +    ///
> > +    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
> > +    type RawType: Copy;
> > +
> > +    /// The offset to the context/data field.
> > +    const DRIVER_DATA_OFFSET: usize;
> > +
> > +    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of the [`RawDeviceId`] trait.
> > +    fn index(&self) -> usize;
> > +}
> 
> Very late to the game here, but have a question about the use of
> OFFSET here. Why is this preferred to a method that returns a pointer
> to the field?

We need it from const context, trait methods can't be const (yet).

