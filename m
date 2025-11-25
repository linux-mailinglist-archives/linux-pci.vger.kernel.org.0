Return-Path: <linux-pci+bounces-42047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7EC85657
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B50D74E9008
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6932549A;
	Tue, 25 Nov 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzDulWQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57431C57B
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080575; cv=none; b=m/e3FIhBNwVQIyj50B/YUNXVjPAZ9bxFdU1Uk9Hkf45qBZCv+8oylITQtOwCp29OJCt7vP7AyjzoVynyyfT+LkspeaO1oiwb+M4Lns/PTS3WGxl1W8tBt+9ueItAQN68lLqS8uQ52Gi+BLf9I9SMgyd99dAmmjajjuRl8acOh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080575; c=relaxed/simple;
	bh=SRKoFuOUD1fJozvJfcfLCTLodVX08ExcSJJP8gTJJ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrfiqisxLjSWgmdQdruSK2sY40+FvdukzvXqcfBjm/HTRgWSQRnIAiULvYOgtoGVbKTYvpZJ3umjLRcJWxn7TcKrFBUE16UhYa+JTkSRh6q6y2rkqnMKnItRGM8t4K6+wpj0cigLLIGlrY9GkHwE/w//bvrC7b94cZaU0Uqcxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzDulWQU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so3680776f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764080572; x=1764685372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYT1VtoVlzvOZrdkNdZF/nKv9vz8mfrTW6PpEO5ou4E=;
        b=uzDulWQUPB+mcW9QhemP5iU4/sdww10YbFrg0ysNetRDGMiBakrXkDJY2Hkk2h4Kwn
         l5t/7ddwgpOkX4OPOyXnhQtNx5lg0VSWoHgBB3CUnnotCaWMx2BeDa5XXFN9HNSCC0nG
         skUnxMECSgzNyzXgpv1cjNQzoH8J/V5EJ3gcjTQjGCNiGhHAbof40MyTfyilU/T6c3r9
         VGSiFI3cnOa0zpJn0xPn9mTIRtSDXGTG1gZkEnfXjO+ZI1tWLrFfgbUS45q+9cAmWuz1
         XAG0+4KniVrpQIIpcodPTwP0ycafpI8lIBaVg9r3OO5Ejkh9jR8cXUhSFELU8RYAA3wn
         KYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080572; x=1764685372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYT1VtoVlzvOZrdkNdZF/nKv9vz8mfrTW6PpEO5ou4E=;
        b=jDi+LcBFKR7r9RkuF2m14YKybloWdPCRB/uNT2FS+51OeYplM8JcIWULemi9YtF5Yw
         clRM+7RyiV39muPjzSFbswvpfbDbQnyUCv+gTVoaM6WLEybJ49H393vt0PbcsEWl7z/p
         vNUOjumanRobfpBA/mmLvVqn0huMfBSxowefGrbLZCGGgpHofN2Bptuz0NcetHDjFALs
         3pmIwaUEVliRbxQHcZkq5riXIUCfLCIdrDWNk1BL74yoTXsaMdGa6pMmPEBip1rQcSSW
         XE8AR1uvFZCthh7m6iqFGB0yU2T/OqGyBD/pYQuEnuS5WZYlRqcKRL75t0chhl9MMVD1
         egIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmYygcHS0CO+6Hf6oIjBHXWKMTPDeVyPAn2SN1A6ot4XpaXMbUBkP7fyRtHziIfVYwUWcVoE4Mh9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/BERrTrDLgFNXykzsXTEcdGYkOo8As4XyHw02OJcqMMZ42WA
	tX6Dtml8Wzi0Rzg/YC8AQ7v8Bfaw/TKkFdkZ239pwiKJ9DgUO8akT2h41bldMWCAzNrcOog9Pxv
	EfjCX46AH/yyXbi65jW+7FTjS1vaiUXWbj3IqqRFG
X-Gm-Gg: ASbGnct0eeJHvchMrwLYRGgoNPR5egQZky8kXtD/P5JYWTC7+hYKhsuW3Rsms7roYHo
	7Bx4KZyXNLUGuCZJl4SaookGnNU4sn+UZtwzRLc/aCx+wD0l0jMN3245pjo0GRxJybWafndRhV4
	QqxcDyrUqyqBT1vMg9o7yIBfkSsueGyFVi7OE4Sz25qYdAweRYh+nyoyk//iG3OL9MZtJyMCUnZ
	RKl0yUru7Aeaolo06gouPJVkOUVpw1bWJG3Au0U6R/ad7MlKFKSlNiebWlySXtJET/FyNP/NRLK
	wDBMEp/s5rc=
X-Google-Smtp-Source: AGHT+IH2MYO2xalTpJnW5pkTtgy3I5HydZt5liuweeYqfukYO9an6xcfvAyiUF1iJKqDv9hzAKbiFMbEsz451F/xstY=
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id
 ffacd0b85a97d-42cc1cbd06dmr17365312f8f.13.1764080571675; Tue, 25 Nov 2025
 06:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
 <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com> <DEHU7A4DWOSX.PZ4CCKLAH9QV@nvidia.com>
In-Reply-To: <DEHU7A4DWOSX.PZ4CCKLAH9QV@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Nov 2025 15:22:39 +0100
X-Gm-Features: AWmQ_bnmcUvz0D0w8i5WIfKnJ-siR4BLsptNpV2Tb4YAf1c-9xeQGVhAxsn-1ec
Message-ID: <CAH5fLgiCgMse0-L9Fb_r=3umucTqNosfO4R+1YVzOqavo07zMg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dakr@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, joelagnelf@nvidia.com, 
	jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:15=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Tue Nov 25, 2025 at 11:09 PM JST, Alexandre Courbot wrote:
> > On Wed Nov 19, 2025 at 8:21 PM JST, Zhi Wang wrote:
> > <snip>
> >> -impl<const SIZE: usize> Io<SIZE> {
> >> -    /// Converts an `IoRaw` into an `Io` instance, providing the acce=
ssors to the MMIO mapping.
> >> -    ///
> >> -    /// # Safety
> >> -    ///
> >> -    /// Callers must ensure that `addr` is the start of a valid I/O m=
apped memory region of size
> >> -    /// `maxsize`.
> >> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> >> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> >> -        unsafe { &*core::ptr::from_ref(raw).cast() }
> >> +/// Checks whether an access of type `U` at the given `offset`
> >> +/// is valid within this region.
> >> +#[inline]
> >> +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> >> +    let type_size =3D core::mem::size_of::<U>();
> >> +    if let Some(end) =3D offset.checked_add(type_size) {
> >> +        end <=3D size && offset % type_size =3D=3D 0
> >> +    } else {
> >> +        false
> >>      }
> >> +}
> >> +
> >> +/// Represents a region of I/O space of a fixed size.
> >> +///
> >> +/// Provides common helpers for offset validation and address
> >> +/// calculation on top of a base address and maximum size.
> >> +///
> >> +pub trait Io {
> >> +    /// Minimum usable size of this region.
> >> +    const MIN_SIZE: usize;
> >
> > This associated constant should probably be part of `IoInfallible` -
> > otherwise what value should it take if some type only implement
> > `IoFallible`?
> >
> >>
> >>      /// Returns the base address of this mapping.
> >> -    #[inline]
> >> -    pub fn addr(&self) -> usize {
> >> -        self.0.addr()
> >> -    }
> >> +    fn addr(&self) -> usize;
> >>
> >>      /// Returns the maximum size of this mapping.
> >> -    #[inline]
> >> -    pub fn maxsize(&self) -> usize {
> >> -        self.0.maxsize()
> >> -    }
> >> -
> >> -    #[inline]
> >> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> >> -        let type_size =3D core::mem::size_of::<U>();
> >> -        if let Some(end) =3D offset.checked_add(type_size) {
> >> -            end <=3D size && offset % type_size =3D=3D 0
> >> -        } else {
> >> -            false
> >> -        }
> >> -    }
> >> +    fn maxsize(&self) -> usize;
> >>
> >> +    /// Returns the absolute I/O address for a given `offset`,
> >> +    /// performing runtime bound checks.
> >>      #[inline]
> >>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> >> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> >> +        if !offset_valid::<U>(offset, self.maxsize()) {
> >>              return Err(EINVAL);
> >>          }
> >
> > Similarly I cannot find any context where `maxsize` and `io_addr` are
> > used outside of `IoFallible`, hinting that these should be part of this
> > trait.
> >
> >>
> >> @@ -239,50 +240,190 @@ fn io_addr<U>(&self, offset: usize) -> Result<u=
size> {
> >>          self.addr().checked_add(offset).ok_or(EINVAL)
> >>      }
> >>
> >> +    /// Returns the absolute I/O address for a given `offset`,
> >> +    /// performing compile-time bound checks.
> >>      #[inline]
> >>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> >> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> >> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> >>
> >>          self.addr() + offset
> >>      }
> >
> > ... and `io_addr_assert` is only used from `IoFallible`.
> >
> > So if my gut feeling is correct, we can disband `Io` entirely and only
>
> ... except that we can't due to `addr`, unless we find a better way to
> provide this base. But even if we need to keep `Io`, the compile-time
> and runtime members should be moved to their respective traits.

If you have IoInfallible depend on IoFallible, then you can place
`addr` on IoFallible.

(And I still think you should rename IoFallible to Io and IoInfallible
to IoKnownSize.)

Alice

