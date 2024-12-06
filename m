Return-Path: <linux-pci+bounces-17845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171449E73E9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC469284F0F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4EE207670;
	Fri,  6 Dec 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+Hd4VsO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A39149C51
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498743; cv=none; b=RpAuKoYzgrwB5hF7OD8x3vcbnkfRA+S/VrWm9IlETSv8v2PUi76R2abGePylwCpEktCXC3lwZlqPvzh2TSf7vz7V79mGCEsLN4tBflKgoiwGhEhj9wH8UoaJsRL408v4kDfEx0wgXjfBJJf1Cpoi7+vYtUWABwEmpjQGI3pyGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498743; c=relaxed/simple;
	bh=YtRCwn0L0reKz/PCsHk5nYbtcK1nUJk/nFphVP0N18Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0Aj6b4rVNb9ZOgtG330i7/mA2vdNyO1yRJZlIz7hSYjvjUoPRTs5WMxswbaVMRBFAqnCWiJ72cLtdLyM38RCbgsTH/Cr8SaymN1hQG09CqrY8IZoFCDBrkYOeIwDzEbdVtczf+zG8T+WLStlPaisjW5C01vbuRdZhXSW647jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+Hd4VsO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e35912f1so1635843f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2024 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498740; x=1734103540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUl66/2q9Es7IH83i2VHQcZCXL2FkKLSft77+kwSp+4=;
        b=W+Hd4VsO8QYMsHWI6lgX0bOf9MvToZO1wmKypyeyzqNlGIU5wPpkE6/mRL3zhqJrEX
         vq1OPjZvD59KBakJvYfEGD0S82DHYSA3L9qblK3VYtrxnkYNkY5bXWudEYxgnDIzKTj7
         y4OwiHR3NL8r8zfFDlZY1WzKXOKjBtSkfcsQ/dlWdjGXghZSJqG4RRkOk+aps7rk18pH
         g0RRAvENYeaMxTsWMTYb4lI5R5oobOaXND/GT4lWv66K/Df3FuAggmcPb5d2V7HcILEQ
         AdbFFPX0y7B0DrF3bCfNQ0T7swqEQrSprGgV2noVfFfXOXnCq+5QIRMOgvbeeymwfqJ9
         iG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498740; x=1734103540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUl66/2q9Es7IH83i2VHQcZCXL2FkKLSft77+kwSp+4=;
        b=Zes5zUABq80nYJWfJg7QcJpwQxJhUgiWSAS+jkKsbCwljISdXHT3zd/T08jme9CnAL
         pxL3uLXd7KmEXnNvWgCPaF3sdKMW9SY4A1IEWVkdiHpnwP/DwVOvnNpIT4KWoBgPybQb
         QCp2lwYq+E+hvgo8fCACfyq6EJskrsegCwDhZo+VY+WUsMV9l/Na3ya+HT8DwsuJ1wwQ
         hXm5f8GwzcPuOE4f8cAfEmaW/6283A36Oprm0v2dHs/2k9+dmMEwmxKBdHcCTJl4UQFN
         nbA0OVt/7iRI7/pAE/ibV1N6/K1AVEC4W39FKyLHhWQd0B6G9LK4VgQvvQaAj8ZiEprl
         o48g==
X-Forwarded-Encrypted: i=1; AJvYcCUOZzisKw6XtOduKiFD6dbQ0GCQgJ2jY2d2k/Xkw/3LfiGtKC0d2AMvH1OAaYMUD4OhKlxb63tXSsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJrZztBqX8N63Ew25pfLkTtDd74av3mlhA8OwdbjtjJcgo2Ia
	jEO4B3mfYykzLEZ8sT4rj9iSoD/5iQxTcuvGjkV8pMiA+RWkScxyilfgstX6F3vWiARNEJeerQg
	V3CUfrfYViNPN2XtXQLxASfQMet68StqAKABB
X-Gm-Gg: ASbGncsscrEpG6SA8iLl4NITJ3GznfjM7xg8osj6lGTaSR9C1t3dCLc+ZA49J2Q8ZW3
	LvqCzoe9wdLRWehSvWwktbDBdCwdeHUpq
X-Google-Smtp-Source: AGHT+IFYizkoJZbVBGz6vm2wzIGh1sKlEnG59vyrJhpEUKD4My3ZUK6cpeBmwJvlu/MBEgYOtQCHyJ9kZroLKgAnFK0=
X-Received: by 2002:a05:6000:1886:b0:386:3327:9d07 with SMTP id
 ffacd0b85a97d-38633279daemr57136f8f.54.1733498740410; Fri, 06 Dec 2024
 07:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-9-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-9-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 16:25:28 +0100
Message-ID: <CAH5fLggWOkut0O+28NVYBSF2CTpHXe9Thb3rhXoRZo5e9zFjzw@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement the basic PCI abstractions required to write a basic PCI
> driver. This includes the following data structures:
>
> The `pci::Driver` trait represents the interface to the driver and
> provides `pci::Driver::probe` for the driver to implement.
>
> The `pci::Device` abstraction represents a `struct pci_dev` and provides
> abstractions for common functions, such as `pci::Device::set_master`.
>
> In order to provide the PCI specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is implemented
> by `pci::Adapter`.
>
> `pci::DeviceId` implements PCI device IDs based on the generic
> `device_id::RawDevceId` abstraction.
>
> Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> +impl<T: Driver + 'static> Adapter<T> {
> +    extern "C" fn probe_callback(
> +        pdev: *mut bindings::pci_dev,
> +        id: *const bindings::pci_device_id,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: The PCI bus only ever calls the probe callback with a=
 valid pointer to a
> +        // `struct pci_dev`.
> +        let dev =3D unsafe { device::Device::get_device(&mut (*pdev).dev=
) };

It shouldn't be necessary to increment the refcount here.

Also, the mutable reference is illegal because it references a C type
without a Opaque wrapper. Please use the addr_of_mut! macro instead of
a mutable reference.

Alice

