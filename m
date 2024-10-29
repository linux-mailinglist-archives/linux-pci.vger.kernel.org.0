Return-Path: <linux-pci+bounces-15522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD6D9B4A4F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C5D1F23F8A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90401621;
	Tue, 29 Oct 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liL4lnLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7020606C
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206541; cv=none; b=ux/+APZA09+iHjE/oh/0gbqA9zaL/7tHHDm2v7Hgv+WbsJ9zolNknYoC8q7UV5OS9rF5mkr7drrOVMxri/p0LR9+QlS/7+b11Ddu6LX1u6DHrVYG8n1y0rCmRFEHt/WTvdnyfnuJkOyjymKhMt9iWQzE8hUdBoaFSHRVDC9Nuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206541; c=relaxed/simple;
	bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG+/R7OCTqTf+nKVaUYHVz2aesfYLcWOxxOQxnDVl5QrnLxtT946apfR/UEHXFaBy/jgyyXqEG3+F6BiXS7eYxO+IgYDU6Vpg8uWCroHUdk/ZH2oHO5TiJ80QrBkrXQPlixMPpyvPZ+67IYKDF5imROcxhEXnOR4I55UJ8rP8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liL4lnLl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3623736f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730206538; x=1730811338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
        b=liL4lnLlX9DxaHaOdkOXmubQk0roBoobR0dl3s5ESM3KJPlEOx/ifqlO2X7OfrQJU8
         eiRSzCIy+epyt7LECq9Ze/hM1lC+5CQf2TwdbJg502ZGiF7YlZ7N5zijJLeqbNVOrHL5
         4m4ahiFR71RchLT0gU01T9YhMeuCNv3fk/Asoei2oOtq66nxpUQ2zVZHaLbrGCZzKoqB
         pPgS1DSs0lPPzFgZG1y/5tDOgmHS+JFDTeaHIAX1imRtansy6XqtdhDVMWN/XCrxuyVg
         zcUMciUnKSiUVY2Atg+4+FLMCXgNiIeIWAHU/TiFJI7Gs1YqQw+FJSF0rJ/guC9rdJL1
         BmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206538; x=1730811338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
        b=S6xKHjOdonTwnTeEn8w/iVUcDdSKZ1GSgyxF4sAxYB1T5R6BkKQ4yUjFoFQ0xOD6U4
         k/t2ZfVS50UEqA2Nc/QKe5cp5CVFL0homAOYMS6HCS9E2+YLvzZji11D24rTps4JfIxU
         7pIRotMmM41IM1N3j4+4QmH66Auo4MOs8PcxaEw0EMmBGLpo6+pxtwudU3DYI0bzLc6h
         f9S5brR5UrOe9z3Np1KSxo4mW0gp2ucg5sF8OnZuG0xuFqXLC3HVbxLkIVabNDCSsofx
         oRoPDLOEv/GQIa01rZ7gvctJaLBOyEpgUw890nIN9IaEchLiMtljIi0/LRT3XtTdKzTm
         i1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yXjrq63M4M+KDevsCLyiNeNRW3olJ7t4yxSvrV7FhZeBO1aUCuaJsYrOsZlmhNQ8mn2cAxgudR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoeRZBn8CniGWvFzwzgS6iLYh9oBAN735A8jmdsZDGJ0RalbZ
	EDBkputsFNjlnYXqX+75Hpb1oUEGX5aAB6JMLzKNOkGTYTtC5zhPN1DvIgZ714YZ3ICuR/Etyyh
	Lql9mtPphT6dzucNm0DBRp3aaph9PilCkDwFu
X-Google-Smtp-Source: AGHT+IETmQQTDrL4vzmRoJuOfPmcPv8jJvaCBtX/7GajtM20569P5Q3g1pr1IEWMYE0imQiiY7vndpIG9NNADzh62fw=
X-Received: by 2002:adf:cd83:0:b0:37e:d715:3f39 with SMTP id
 ffacd0b85a97d-380610f7bcemr8407978f8f.10.1730206537735; Tue, 29 Oct 2024
 05:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-4-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-4-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 13:55:25 +0100
Message-ID: <CAH5fLggCouwZa7894SAdkVtCHVO-y7iV2G0-b0pjec9gbt6V6g@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] rust: pass module name to `Module::init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> In a subsequent patch we introduce the `Registration` abstraction used
> to register driver structures. Some subsystems require the module name on
> driver registration (e.g. PCI in __pci_register_driver()), hence pass
> the module name to `Module::init`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The C-side just uses KBUILD_MODNAME for this. Could we do something similar=
?

Alice

