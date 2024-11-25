Return-Path: <linux-pci+bounces-17279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2399D86B3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 14:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF4164F82
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B51AB52F;
	Mon, 25 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noW6Bvmd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743D18872F;
	Mon, 25 Nov 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542184; cv=none; b=ZTKwPWDoY7mP+j7olY4Qg+aU45KVIcOPdr7O/8xaN3AkvmuInvziP3g5/jeyPvFwQVolgGYQON7ZP0FTKM6V5LAHQRHr3jmrBzA0vOhQ1yrm6Vhr/XWIVbmhzdDosEhQGm93V6K1C3i4fyKpgPa2tO0p1VlsO+RnnsvLAjk76rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542184; c=relaxed/simple;
	bh=Vh96bJoOwrNFyO6Sp6Hhb3hniflnbzfSe79opOPAAMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgLtNDQtl9eG+j25bmu4QfMBjsUwB1KlGPFDECFuqGKNLMBQibX0x11PPlb5iNMij+kKghmzwtcM2TzCSBHDEB5ACM4ECPbvCtfaYDsX6Y3PEsGwnXf+EvcoKzIRhSIPj2RFjsCxnJB2tH6GAr7hMDC6WU1SyL+4NIHca8jeHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noW6Bvmd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea33a70fdfso745121a91.2;
        Mon, 25 Nov 2024 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732542182; x=1733146982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh96bJoOwrNFyO6Sp6Hhb3hniflnbzfSe79opOPAAMU=;
        b=noW6Bvmdaa106xjizH8vxD6ha0cJauBwo+L+7I4cPb8XcFdE5CD9jg1rnSkO7PBC6g
         FVLw5TQh53aC8Gd8lGI5sEGrbkoFc1DheD80KQAA9iBAGRA8K0is/AtjQHjGz7Y9Hw2h
         k/nd8eT70bcVLFA9Fk16eJ9mzW6KdpsbvDBWW9ufMTehLbiF8PC9XULzhd1m3QtjamH1
         L8wAq5gFmCPmXUYd7xQpnnz+CRunuzASD54dRGLe3M+TF5VYFtYO0I7pRGCRmaNd6kWW
         9IsiGU2CcrDv7pQVXFRJhT3LrPB4wgoRsQr8a48Aqeifwds5W4eZCPHUJobxoZ1Gycx1
         IIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542182; x=1733146982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh96bJoOwrNFyO6Sp6Hhb3hniflnbzfSe79opOPAAMU=;
        b=NKA9tz7ByTXcekBGab1dWYOfwc5yhiVB/5Bobe5Pp/xVmyfZ53Nx9XX8i9YiQa7K67
         VH2QkDwUG7k7I3i1sxqaYliysQW6wDjn8mGr9WRhY5M/DoL8ia5yvJPV3Ip8lR/6mjpF
         zAbnRt5Hj/kn1B3kbZjQs/Yt+3mBIhPgd5TTtsRDwFLEd9E4z9Z2A8ApnwHZhuQySMGI
         qAhiwaAJBqkmE2OavapcEQbmYlG/qCQ8dM/ZxEeJzLHNqjkHWdF1SbXi2/Zd7/xZtVkb
         gpnbyNIqLaLlx/H1OshAfw70oaBy8R8VsFSBeW9PDLMmZKoELmvu+zepfAMvcZTSemnA
         UTmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoKxkJVNr7juowc0bIt3lbygMfM54GOuNRF7Q8WTioR6tZyDBJyzYw5QnQCe5+oynuYGyO5X3k8Bw4@vger.kernel.org, AJvYcCW6InM7epr34y62uqmjodh4KMMDQH5XQ9Z5PPRNuu6Hb6uyGvIeg0Op8gEvFQigKScRNVyX4TywurWhOH/i@vger.kernel.org, AJvYcCWA/mmnEIOLDDqpe0Ru5I4wsTbnND41y9ax716GFwFN4n92/YIqaHEI1mOmtd4CtJEthfP2t+j0DwVqeQTEHlM=@vger.kernel.org, AJvYcCWLGwMN4ENLamSDGYlTlEwpjUwq/9v8KqvG2Fdyj36DqiQOTG6lCFUV4XRTLn0P2hYkdkhqWF4IbR+h@vger.kernel.org
X-Gm-Message-State: AOJu0YzNa4P5OpnhgNYwPo/x9HsKUClueQMTBknHpnIdnYn6DzmExeb2
	8UWF30AZa656b3FuUx/AGkIzGmUaROtumuRDTt1+Vh5lOLs26gRikyw/09rUZZ2FU8Bw+EjlUe+
	8tY2bWeOC204IJHQeZTYIAQQcb7o=
X-Gm-Gg: ASbGncsWp2ogAmuC3RJ3rGxVfk7GTuCFqMTCcLmBNksFdsX5C2oRkZvh1BvIL9BXJTv
	sSpkkHQhvYZIEKzr9AJT6tH30Vm9zLGw=
X-Google-Smtp-Source: AGHT+IGY3uQ6gtttopQGEvmtnMN78gZwZv98uC/pEs79Qk0Z00BiITe4CR6H5hcbiNZimM0EEV3FxfcxB0atDxrBtDA=
X-Received: by 2002:a17:90b:4d11:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2ede7daaf62mr58486a91.3.1732542182583; Mon, 25 Nov 2024
 05:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-6-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-6-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 14:42:50 +0100
Message-ID: <CANiq72moksyUHEYDXu3G_=FaLdXpNJrrihnw5QFhWaRZbdeT3A@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Fabien Parent <fabien.parent@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> +#![allow(stable_features)]

This should be possible to remove (starting with v6.11 we do this in
the command line).

> +// Stable in Rust 1.83
> +#![feature(const_mut_refs)]
> +#![feature(const_ptr_write)]
> +#![feature(const_maybe_uninit_as_mut_ptr)]

`const_refs_to_cell` is also stable in 1.83, so you could move it also here=
.

Having said that, to be consistent, I would just put them above sorted
with the rest -- the compiler can tell us and we track this elsewhere
(just added the last two here to our issue #2 list). Either way, it is
not a big deal, this list will be going away soon and we can
celebrate! :)

Thanks!

Cheers,
Miguel

