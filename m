Return-Path: <linux-pci+bounces-18150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B59ECF79
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180FB1684C3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF061AA1F4;
	Wed, 11 Dec 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYy+PU/l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB982AF00
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930136; cv=none; b=kmP7qbxnT0DmvVeNrIVQyk2BUWIx2rUrcBHu79A6P+wcm4oQum+pQCQ4I9mLByl01G2a7FT+JWk6VCYdGcRDbaG2ME4Ws9J9ilie4gg/78qUDMOovxEnZlUaTytB2nk4zuM7RpnUNDz4NZu13rAKrtpIR4sKo3jI9VadkQblkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930136; c=relaxed/simple;
	bh=9orRTat1SEQAu0HoNGiC3uLccUVYpFe0MDA7PIs6g/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG7uiN+cTRSfae7yf5nrxoU65uWfnE0yMbb+t/eF5R6FVyBYUI+tkHCW5r9PatNUftNa87fF0BvvIRy/29hsfs5Y4tX36ayaqjK/P64bdbdH63mZFScd/qajAS0HYJrRdl/ixpXxlpg/uC2BEW/lTexdvKIQ+3A0s0KyEhRz2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYy+PU/l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434e3953b65so31829935e9.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733930133; x=1734534933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnbCsVpn+OoGZZ0QxuwCZBWpLN+YdBRo1+mxWwBtZ6k=;
        b=tYy+PU/lT6HHybNaAi4tKm/cQf5BE00D7B6Zzc8buaJZoolCCRksKsS1Jq+r6/Q4nu
         JAI5PJFZiYBgklmY7zT0GI7r4bIDl6snDaS0AkYPTgh8qkkOaVAzAgT6BGCmvLjADqmF
         wRqRsGH4xcATUEHAcDUOvotENspgJTrqIVE/bIBR22bhpi9sPg4emkkzzJNVt0egFJdS
         fXTYvB/2hRbvQwZJlEzZJn7AUd2ZAWgcttj/XeCtTS9kxCwNRIafBbYasLhC4p5g+hsZ
         Y2vOahrmbE0lNJ5LncOX4pT8hT82VC9bE259NOLn1rgz2JtouZVe9/qxY4HNnJWnfDkE
         XUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930133; x=1734534933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnbCsVpn+OoGZZ0QxuwCZBWpLN+YdBRo1+mxWwBtZ6k=;
        b=et+pg30wGnEgV4B0LGuZiv9G/+W6NJTWbMZ7Z5rlN6voh0bE9xcytx0yVoqdViJhCp
         aBBvZmyDbcrGGhVLOSOzD7jT0EBoLiDS1ctOVgSP9MBfoOOktcl3IOq8TNatI7lMD7q3
         FdfYWQRxDwH0u4GgEHmi4V6uHXUXa7DnHSZ0ufPM25TamZo0ncphWbA+SbmJVLjaZPey
         HXND1dbUHG4XRl7X9G4x96w469UKYFJ12tNv3ljj8zJ8DpVnkrlbO0dB3vXPCT+CH0V+
         OdC0t1VVZ2klygKbLjTSFApcZ2Kn6Fg8wl2iu2Omwmitmx68T/S0fjndI/G1tKXoJ3Ji
         7uFg==
X-Forwarded-Encrypted: i=1; AJvYcCXPc+6z6dcWC+QyvNtKH4PfI+xwknNJRXFfPyOwbchsIBrVfFmLy5kitAQpLecsvWdmbF/22Hesf/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWm4i/RolBQJn9pFUa8NrI23Zggqp9Ifho5zrdFgbpL+lCrhrv
	iX8lomxQhQr8JcNunzlL63iG9Nhp28Mpf1Z66kp/lTFngajebS5HH5kmNzVDjX0RVahLjef6iEp
	WzHiN9CoJq6P23Qn2kwizp216rY5ytncCJ8jJ
X-Gm-Gg: ASbGncvNbbmC0x3QrHyvhOHydUWcmH8L7KzY+nIeLB8RXdFCsIC8z12YHHAZ+a0JnGX
	B4HaC817hbtauHm8ftECo2MikvtFXDeaj/nuW5Ws4TpFWyulc0H7u/1/cQAP/kRNfRA==
X-Google-Smtp-Source: AGHT+IE3io4mcv+Ps4D8IY/r7fFNlWxnkhDnANz34IMDYukadmf+Dz+LVFW6xs3eTVPp5EMr8g7sbxgqXpgRGDM6f4E=
X-Received: by 2002:a05:600c:358b:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-4361c3efb43mr24566445e9.23.1733930131389; Wed, 11 Dec 2024
 07:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024121131-carnival-cash-8c5f@gregkh> <Z1mEAPlSXA9c282i@cassiopeiae>
 <Z1mG14DMoIzh6xtj@cassiopeiae> <2024121109-ample-retrain-bde0@gregkh>
 <Z1mUG8ruFkPhVZwj@cassiopeiae> <CAH5fLgh3rwS1sFmrhx3zCaSBbAJfhJTV_kbyCVX6BhvnBZ+cQA@mail.gmail.com>
 <Z1mh2rPC3ZOjg-pO@cassiopeiae> <CAH5fLgjg82x5EiWa1BTC7DpbhteBm5Or8XtpLAL0hQz+huXMCw@mail.gmail.com>
 <Z1mnFoap_AnPPNfu@cassiopeiae> <CAH5fLgiyGjhpVDNkRHtYhk7jY0oJZmPYx3TJRnBvpt1H+-6Y-g@mail.gmail.com>
 <Z1mpvRDnlZN9Mc5o@cassiopeiae>
In-Reply-To: <Z1mpvRDnlZN9Mc5o@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 16:15:19 +0100
Message-ID: <CAH5fLghuM-mNF3CvwWLAwg5F-Kyrjeu_J+zJFrZ1=yqGL85eeA@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, bhelgaas@google.com, 
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

On Wed, Dec 11, 2024 at 4:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Dec 11, 2024 at 03:55:47PM +0100, Alice Ryhl wrote:
> > On Wed, Dec 11, 2024 at 3:52=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 03:45:53PM +0100, Alice Ryhl wrote:
> > > > On Wed, Dec 11, 2024 at 3:29=E2=80=AFPM Danilo Krummrich <dakr@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, Dec 11, 2024 at 02:34:54PM +0100, Alice Ryhl wrote:
> > > > > > On Wed, Dec 11, 2024 at 2:31=E2=80=AFPM Danilo Krummrich <dakr@=
kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 11, 2024 at 02:14:37PM +0100, Greg KH wrote:
> > > > > > > > On Wed, Dec 11, 2024 at 01:34:31PM +0100, Danilo Krummrich =
wrote:
> > > > > > > > > On Wed, Dec 11, 2024 at 01:22:33PM +0100, Danilo Krummric=
h wrote:
> > > > > > > > > > On Wed, Dec 11, 2024 at 12:05:10PM +0100, Greg KH wrote=
:
> > > > > > > > > > > On Wed, Dec 11, 2024 at 11:59:54AM +0100, Greg KH wro=
te:
> > > > > > > > > > > > On Wed, Dec 11, 2024 at 11:48:23AM +0100, Greg KH w=
rote:
> > > > > > > > > > > > > On Wed, Dec 11, 2024 at 11:45:20AM +0100, Greg KH=
 wrote:
> > > > > > > > > > > > > > On Tue, Dec 10, 2024 at 11:46:28PM +0100, Danil=
o Krummrich wrote:
> > > > > > > > > > > > > > > In a subsequent patch we introduce the `Regis=
tration` abstraction used
> > > > > > > > > > > > > > > to register driver structures. Some subsystem=
s require the module name on
> > > > > > > > > > > > > > > driver registration (e.g. PCI in __pci_regist=
er_driver()), hence pass
> > > > > > > > > > > > > > > the module name to `Module::init`.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Nit, we don't need the NAME of the PCI driver (=
well, we do like it, but
> > > > > > > > > > > > > > that's not the real thing), we want the pointer=
 to the module structure
> > > > > > > > > > > > > > in the register_driver call.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Does this provide for that?  I'm thinking it do=
es, but it's not the
> > > > > > > > > > > > > > "name" that is the issue here.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Wait, no, you really do want the name, don't you.=
  You refer to
> > > > > > > > > > > > > "module.0" to get the module structure pointer (i=
f I'm reading the code
> > > > > > > > > > > > > right), but as you have that pointer already, why=
 can't you just use
> > > > > > > > > > > > > module->name there as well as you have a pointer =
to a valid module
> > > > > > > > > > > > > structure that has the name already embedded in i=
t.
> > > > > > > > > > > >
> > > > > > > > > > > > In digging further, it's used by the pci code to ca=
ll into lower layers,
> > > > > > > > > > > > but why it's using a different string other than th=
e module name string
> > > > > > > > > > > > is beyond me.  Looks like this goes way back before=
 git was around, and
> > > > > > > > > > > > odds are it's my fault for something I wrote a long=
 time ago.
> > > > > > > > > > > >
> > > > > > > > > > > > I'll see if I can just change the driver core to no=
t need a name at all,
> > > > > > > > > > > > and pull it from the module which would make all of=
 this go away in the
> > > > > > > > > > > > end.  Odds are something will break but who knows..=
.
> > > > > > > > > > >
> > > > > > > > > > > Nope, things break, the "name" is there to handle bui=
lt-in modules (as
> > > > > > > > > > > the module pointer will be NULL.)
> > > > > > > > > > >
> > > > > > > > > > > So what you really want is not the module->name (as I=
 don't think that
> > > > > > > > > > > will be set), but you want KBUILD_MODNAME which the b=
uild system sets.
> > > > > > > > > >
> > > > > > > > > > That's correct, and the reason why I pass through this =
name argument.
> > > > > > > > > >
> > > > > > > > > > Sorry I wasn't able to reply earlier to save you some t=
ime.
> > > > > > > > > >
> > > > > > > > > > > You shouldn't need to pass the name through all of th=
e subsystems here,
> > > > > > > > > > > just rely on the build system instead.
> > > > > > > > > > >
> > > > > > > > > > > Or does the Rust side not have KBUILD_MODNAME?
> > > > > > > > > >
> > > > > > > > > > AFAIK, it doesn't (or didn't have at the time I wrote t=
he patch).
> > > > > > > > > >
> > > > > > > > > > @Miguel: Can we access KBUILD_MODNAME conveniently?
> > > > > > > > >
> > > > > > > > > Actually, I now remember there was another reason why I p=
ass it through in
> > > > > > > > > `Module::init`.
> > > > > > > > >
> > > > > > > > > Even if we had env!(KBUILD_MODNAME) already, I'd want to =
use it from the bus
> > > > > > > > > abstraction code, e.g. rust/kernel/pci.rs. But since this=
 is generic code, it
> > > > > > > > > won't get the KBUILD_MODNAME from the module that is usin=
g the bus abstraction.
> > > > > > > >
> > > > > > > > Rust can't do that in a macro somehow that all pci rust dri=
vers can pull
> > > > > > > > from?
> > > > > > >
> > > > > > > The problem is that register / unregister is encapsulated wit=
hin methods of the
> > > > > > > abstraction types. So the C macro trick (while generally poss=
ible) isn't
> > > > > > > applicable.
> > > > > > >
> > > > > > > I think we could avoid having an additional `name` parameter =
in `Module::init`,
> > > > > > > but it would still need to be the driver resolving `env!(KBUI=
LD_MODNAME)`
> > > > > > > passing it into the bus abstraction.
> > > > > > >
> > > > > > > However, similar to what Alice suggested in another thread, w=
e could include
> > > > > > > this step in the `module_*_driver!` macros.
> > > > > > >
> > > > > > > Modules that don't use this convenience macro would need to d=
o it by hand
> > > > > > > though. But that's probably not that big a deal.
> > > > > >
> > > > > > I think we can do it in the core `module!` macro that everyone =
has to use.
> > > > >
> > > > > How? The `module!` macro does not know about the registration ins=
tances within
> > > > > the module structure.
> > > >
> > > > You could have the module! macro emit something along these lines:
> > > >
> > > > impl ModuleName for {type_} {
> > > >     const NAME: &'static CStr =3D c_str!(env!("KBUILD_MODNAME"));
> > > > }
> > > >
> > > > Then you can do `<Self as ModuleName>::NAME` to obtain the name els=
ewhere.
> > >
> > > Where {type_} would need to be the driver's `Driver` structure?
> > >
> > > We'd then need to define the bus adapter as:
> > >
> > > `pub struct Adapter<T: Driver + ModuleName>(T)`
> > >
> > > But the question stands I guess, how would the module macro know {typ=
e_}?
> >
> > If you look at the macro implementation in rust/macros/module.rs you
> > will find many uses of {type_} throughout the expansion. It's whatever
> > is passed to the macro using the `type:` argument.
>
> Oh, I see. So, this means that module / driver author would still need to=
 create
> the "connection" by listing the correspong driver types in the module! ma=
cro,
> right?

I'm not sure what you mean. I'm *not* suggesting any changes to the
interface of module! or module_*_driver!.

> If so, I think it'd be better to do it in the `module_*_driver!` macro an=
d let
> people implement the trait by hand for modules with multiple drivers (whi=
ch
> should be pretty rare).
>
> The reason is that I think that otherwise we're probably encoding too muc=
h
> semantics into the `module!` macro that isn't obvious and people need to
> understand.
>
> >
> >
> > Alice

