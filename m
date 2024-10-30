Return-Path: <linux-pci+bounces-15599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E909B63EC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 14:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357711C20E24
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DF56B81;
	Wed, 30 Oct 2024 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDQrniUO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514117579;
	Wed, 30 Oct 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294340; cv=none; b=mmkB6FLqVR4vMGaY/ypsW7Pq8fIBgsmtCwPc+mtl6uKjwLS6fEuTCflR7UeyfKSverrfRVQydo/nndPhZnlyWMAPkvWGQNHfV6Tusu3RRHbvfFBlYWgA0GTXMVIgIAN5k6AutdSUfNhOAHhwRPk+dkQAzGGbiT5ijbxExiMdelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294340; c=relaxed/simple;
	bh=SGyl53QrSXt0NK+s0TZTOWpg5y0Q+SHCYZKlj5mUth0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzKqStdT6uBNu1vvDwPrh45cE8dLbsvhiz1c3D0PTSwXxarEUt9hgsEygmSHNOvtiUcdT2lO+FvMrLNXVZ0ECQlW0jVxBz8JzNQ4HZohMBJM14GS8FzL8ly0/ZGLMwhK/UZZpzpaqx0oa4Yp/ly+rI39jwzH8pzzt67ka81vlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDQrniUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F4C4AF0D;
	Wed, 30 Oct 2024 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730294338;
	bh=SGyl53QrSXt0NK+s0TZTOWpg5y0Q+SHCYZKlj5mUth0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oDQrniUOEt7Nu28y198TARsKSRQWEdfQNjz1UvtRgj3V6Fjm2/R7sWOw9T+C6ThXx
	 BZEDiiv8ygh26EMMY+Nsdx2qC0EIteHw3YbA7NjnVXaSgb4G5biqH5WACjYkYwKte0
	 jzYcq76H8gAcf/eXJ/bxSkJwFSZFoo1ZGXAbvSzzCvOkS8tvsku06NpP2f6pDKmAK8
	 ZaXBpd8DI0HhQ9vdurQzxnGa4hSmnomsT3Ome8uIZGQw+LtbtHDEzWs5eozLjpJaHz
	 a8s/TlgOCJtfB1Jd/XJqzgc595L3LEhp1YzlEql3c9AnaSXNQu8d6dCpR7QmtXtuVO
	 wIwxB80AejVQQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e13375d3so7481341e87.3;
        Wed, 30 Oct 2024 06:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSOVLPK90vfmuX7CbMxGhyD50JjXb+9cQYFI3l35w5nuK4tSQR1pTPNrzIzoXPeW0amRzdexJ6MBRc@vger.kernel.org, AJvYcCVFyfGcq5NrBZVWlUeTRSj6l1TMLpNseJjXtUIyfdSGzCHJODvfxBh6hxt++JCeIt2iQSW+jcwX6I8f9s5z@vger.kernel.org, AJvYcCW/Am8t33Z+zUNuefygExMMzYCNH2lHfg9Wif7nXoTvMH8D0CTbYveoCyK1JGX689C1fA8Rn3V5kVA5sRfD73w=@vger.kernel.org, AJvYcCWFkoCnnT+3/EU4hcprgMmTMu9720lscy/Saf4VBVR8yNlE9i1BuububNVGVxi+ZimED0aoDfdRPrQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyT46pjCZb+M9Rtmbhp6QCUUirrmZDTmLbI9yXAVizjZxMCrvbx
	hjB26OWO9T6Yrn7ddDtGcFBZHVZ/+LlpyjSnx21SB1zjiFr2g1CqFDgbCQPGkRT/HlyFZH7uUv6
	rR+frKO70QvU44aGkOtd4DnkSvg==
X-Google-Smtp-Source: AGHT+IEVKvqZU3lwKIBTDRwXuRwrMn8l0pyFDoASwjFpuJlO7j5nl3i6/F0Uq11GWp7kjD53mP60fhBKM1x1llFdaqA=
X-Received: by 2002:a05:6512:3ba7:b0:539:530e:9de5 with SMTP id
 2adb3069b0e04-53b34b3bc7amr7674957e87.56.1730294336832; Wed, 30 Oct 2024
 06:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com> <Zx9lFG1XKnC_WaG0@pollux>
 <fd9f5a0e-b2d4-4b72-9f34-9d8fcc74c00c@de.bosch.com> <ZyCh4_hcr6qJJ8jw@pollux> <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>
In-Reply-To: <8d72e37e-9e27-4857-b0eb-0b1e98cc5610@de.bosch.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Oct 2024 08:18:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL674Mf5_QcWxEn-oStMx45_VsaQfbN-Qzh3jEtXdsyYA@mail.gmail.com>
Message-ID: <CAL_JsqL674Mf5_QcWxEn-oStMx45_VsaQfbN-Qzh3jEtXdsyYA@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:19=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> On 29.10.2024 09:50, Danilo Krummrich wrote:
> > On Tue, Oct 29, 2024 at 08:20:55AM +0100, Dirk Behme wrote:
> >> On 28.10.2024 11:19, Danilo Krummrich wrote:
> >>> On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
> >>>>> +/// IdTable type for platform drivers.
> >>>>> +pub type IdTable<T> =3D &'static dyn kernel::device_id::IdTable<of=
::DeviceId, T>;
> >>>>> +
> >>>>> +/// The platform driver trait.
> >>>>> +///
> >>>>> +/// # Example
> >>>>> +///
> >>>>> +///```
> >>>>> +/// # use kernel::{bindings, c_str, of, platform};
> >>>>> +///
> >>>>> +/// struct MyDriver;
> >>>>> +///
> >>>>> +/// kernel::of_device_table!(
> >>>>> +///     OF_TABLE,
> >>>>> +///     MODULE_OF_TABLE,
> >>>>
> >>>> It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic n=
ames
> >>>> used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_=
MYDRIVER
> >>>> and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
> >>>> examples/samples in this patch series. Found that while using the *s=
ame*
> >>>> somewhere else ;)
> >>>
> >>> I think the names by themselves are fine. They're local to the module=
. However,
> >>> we stringify `OF_TABLE` in `module_device_table` to build the export =
name, i.e.
> >>> "__mod_of__OF_TABLE_device_table". Hence the potential duplicate symb=
ols.
> >>>
> >>> I think we somehow need to build the module name into the symbol name=
 as well.
> >>
> >> Something like this?
> >
> > No, I think we should just encode the Rust module name / path, which sh=
ould make
> > this a unique symbol name.
> >
> > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > index 5b1329fba528..63e81ec2d6fd 100644
> > --- a/rust/kernel/device_id.rs
> > +++ b/rust/kernel/device_id.rs
> > @@ -154,7 +154,7 @@ macro_rules! module_device_table {
> >       ($table_type: literal, $module_table_name:ident, $table_name:iden=
t) =3D> {
> >           #[rustfmt::skip]
> >           #[export_name =3D
> > -            concat!("__mod_", $table_type, "__", stringify!($table_nam=
e), "_device_table")
> > +            concat!("__mod_", $table_type, "__", module_path!(), "_", =
stringify!($table_name), "_device_table")
> >           ]
> >           static $module_table_name: [core::mem::MaybeUninit<u8>; $tabl=
e_name.raw_ids().size()] =3D
> >               unsafe { core::mem::transmute_copy($table_name.raw_ids())=
 };
> >
> > For the doctests for instance this
> >
> >    "__mod_of__OF_TABLE_device_table"
> >
> > becomes
> >
> >    "__mod_of__doctests_kernel_generated_OF_TABLE_device_table".
>
>
> What implies *one* OF/PCI_TABLE per path (file)?

It's generally one per module, but it's one per type because it is one
type per driver. So platform (and most other) drivers can have $bus,
DT, and ACPI tables.

While you could have 1 module with N drivers, I don't think I've ever
seen that case and certainly not something we'd encourage. Perhaps it
is just not possible to disallow in C, but we can in rust? That may be
a benefit, not a limitation.

Rob

