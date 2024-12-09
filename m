Return-Path: <linux-pci+bounces-17917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC69E90C6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71180281D4B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628A217707;
	Mon,  9 Dec 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR8zGabs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216261DA23;
	Mon,  9 Dec 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741149; cv=none; b=NfNUqxqRb60iZ6bSsQr/QDrRwgwYPPnG3QAJNcooMt44nm3TMAjvMrBZ/QCSyYjmrOqF/UYbiQ8HO1Oi0wabe6BrN+SHfKOd/iqmR/+S/nOmauRQyjHbuwTlGt7wdffO+EDi22ZAABA/XRhuTbO1mnA6o0s7923DigVAJx7yWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741149; c=relaxed/simple;
	bh=KqxofnkRfuHYODB9+MVSOswW7N8mb6NXv1+2dwKMJww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBMV2jm8RXCyDioPHWiIcihal3AaOyf9ykQNZYGZ/75aBOMOcDLo3shwrJs9vV/7CMkTw+KmFPyBbZEWdUev33uPFweGgOTdfSNM7Py8P1EG9IfcaeqEHv8eH0aANSUcniCmJML6gB+EzC7oYtkW3xpLTLRhdz8Ex+VGWws/PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR8zGabs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF585C4CED1;
	Mon,  9 Dec 2024 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733741148;
	bh=KqxofnkRfuHYODB9+MVSOswW7N8mb6NXv1+2dwKMJww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tR8zGabsV1VttmSo/SHMJJxse3+stSwzmjaVdQodytl2L9wp1IvCnKlNLoqOUznQd
	 LKa2/fWvAkiZi/2MN56Q2q22mvhgQn3fgZ/dbYpn9cDOkrQXCE7RYic0Ffyo+BtrLa
	 O1H93RzC58UT1ka9rSZ3+A7GkY8cAku+9qas7lE/6vZMvtdPOGS65dKrHTWritPIZy
	 XK6dr7YrwJjgYm2pNuyh9oMSyBSp2nng4/eh7EBFmq0VYkj2m3M073uHNSbsjpd3Ii
	 sLM0J7hhmilIt4XSyALlXjgcZiX3rX4MWyGnlrWIrv7rxSGXtx5X4aKEyhEda7d+yB
	 FKoCht94jyKJA==
Date: Mon, 9 Dec 2024 11:45:39 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Fabien Parent <fabien.parent@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, chrisi.schrefl@gmail.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v4 03/13] rust: implement `IdArray`, `IdTable` and
 `RawDeviceId`
Message-ID: <Z1bKU2vNp19Yx8bO@pollux.localdomain>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-4-dakr@kernel.org>
 <CAPFo5VJ9=VAghiUGbzPjDDdG8tg6xNQaRtBduHk8R70jktPQNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFo5VJ9=VAghiUGbzPjDDdG8tg6xNQaRtBduHk8R70jktPQNg@mail.gmail.com>

On Fri, Dec 06, 2024 at 05:14:00PM -0800, Fabien Parent wrote:
> Hi Danilo,
> 
> > +/// Create device table alias for modpost.
> > +#[macro_export]
> > +macro_rules! module_device_table {
> > +    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> > +        #[rustfmt::skip]
> > +        #[export_name =
> > +            concat!("__mod_", $table_type,
> > +                    "__", module_path!(),
> > +                    "_", line!(),
> > +                    "_", stringify!($table_name),
> > +                    "_device_table")
> 
> This doesn't work on top of v6.13-rc1. The alias symbol name has been
> renamed by commit 054a9cd395a7 (modpost: rename alias
> symbol for MODULE_DEVICE_TABLE())
> 
> I applied the following change to make it work again:
> -            concat!("__mod_", $table_type,
> +            concat!("__mod_device_table__", $table_type,
>                      "__", module_path!(),
>                      "_", line!(),
> -                    "_", stringify!($table_name),
> -                    "_device_table")
> +                    "_", stringify!($table_name))

Good catch, thanks!

> 
> 
> > +        ]
> > +        static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> > +            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> > +    };
> > +}

