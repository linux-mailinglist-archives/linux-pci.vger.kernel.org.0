Return-Path: <linux-pci+bounces-26402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B7A96E00
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AFF3B29F4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D952284B5C;
	Tue, 22 Apr 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2c84qCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696B284B43
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330980; cv=none; b=FIZ1Jg9REz+GKLxGOci5rA2xbCYTi4LJ524GkhlHuJXNe2NjfYn8XpqW2RqlOWmnM2UdHdPKwOCjSIUrah0fEWB3TKP6xhne/lrrGExq833UkHCY6D/S5A6rA356oRRYHL5Q8fbHTnNp8+Gp/C/dOAr+uckr5btUyN2ZvV1n+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330980; c=relaxed/simple;
	bh=nUBIy+i51QSYL7IJsatUnmyU8m9DmJceXIUnZpp25mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWjBkkpF6BjtkLeNGT4jNvoqG1IriTttDDnmSqsh5Tz4atqRXqg/Wq83qtJlXXFFh+axPoOQA6Fil4ynLKv3o/fp2Id3IiVyh12Vy4uVJyKo4omLxcaTLU9o9Nx21OxJ1kfkZTKaykI1eVgKgEinWCYYwsmuHfGObP4b7FBNxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2c84qCa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a064a3e143so368297f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745330976; x=1745935776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUBIy+i51QSYL7IJsatUnmyU8m9DmJceXIUnZpp25mE=;
        b=u2c84qCaEaDJi6zertXrh2sVzOPGL7TKc99nPyBGQjR/qhSkM3TAFXb/Tbzmm/2HDh
         gvuZgTIJsdoz1A4ABegvd/D51FhyS5NYyVQYxVBpbO50FsiomVNsRcyxe34FOseBsFoa
         6d8yHPzld7eZ+c05QBtM7RF0K+Qil6G3WagoSBwyO3+9860QPmkFxEfv64f/WBpv0O5S
         qO4TOiMoUuHTMW6hqvlTGoPWXi4RYhY4YQ60I3kCEQW9LOWRRNWwdpOGxsJ/X6TTj44D
         0cR6dFl7fVVkaoQZ3ku2ml9g52viMV75VSgu8gxSZmLEVs7UrtgS2dMrtBadHXlHKHC6
         /mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330976; x=1745935776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUBIy+i51QSYL7IJsatUnmyU8m9DmJceXIUnZpp25mE=;
        b=SQF38q6PGXI19FVClmfPq6ViLt0AsDlU6DLSsAQ6+Wr8PcT2XDGYZ1k2Wy5ShWjpNY
         /FAwoNRFYpgD1evPtZm2L6bFvxoYfO2E8kcf77Rj181EnuDpweyKhHaisJ+2JJfdwlpK
         iSpiyIMJs9jlYVGopHpaGFx5l+x8v8O8V47OhfMo2m0MoYwjrJJO95mZlfspVhb2gktO
         Cp8vv/oYXFhhA9qCF2fk17ShkOhtB/6BzVbQNcQuAx3peE8QO/tChVLpu1CZmbOLmIIz
         862MCJrmtqxzuK0vOxJC3ZglMQE13OySj3d6etnPb3ZfLbGr13bYoycZHmFMtoC8Ks7M
         UrLw==
X-Forwarded-Encrypted: i=1; AJvYcCXFq++66UiPeRzEBPSuvqdX57eZFINynHVrV4oKierpwOJ0NMLMmsuZQo2tX7gv1JJ/WljRLwLmUtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRQi4d6d3c+uaGQC9wDTeuIeD3jERXzBqdTloSFiBaqZS79ok
	PiBHCMLXQbONzhPHDEYfwMoVZBMgb9IcoPdb/0r8ko6S28iV7jmtuXnXqoMgXF9WZ+OXw4LXmP0
	7TZOgckg27PXBt+PWvpDQ1uzDEGsb0tz0VEC7
X-Gm-Gg: ASbGncvxpRjiOH24HRlvLOzVwB1wSAK7tCEjSg/RXDMInB76UAWQFaaFUJpTvLmDNm7
	p/gVBRcBqgA41BfUfDdAn7hxAxJuhulNMl6MhtKmQsCodxLe5oeuTUCsxY7/yXCk9U7DIyuur4i
	UvHGIo0Zke1U+oALi23QQvuAoEvGL+2JISfTMXb0/Q2G2MOfQtzJfIk0dhLI53pcY=
X-Google-Smtp-Source: AGHT+IGwScacxzzijOMYqxF2+IsuIQ4NgmXseaPx5XZpHVl/ayR+TnwBKHbV/nBatZSqoI4Mv/F9u+SkhmnIKJyE7K0=
X-Received: by 2002:a05:6000:c08:b0:3a0:65bc:3543 with SMTP id
 ffacd0b85a97d-3a065bc358amr191420f8f.35.1745330975703; Tue, 22 Apr 2025
 07:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-5-afd2b7fc442a@gmail.com> <aAeiv_mfAT_6DwCt@google.com>
In-Reply-To: <aAeiv_mfAT_6DwCt@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Apr 2025 16:09:22 +0200
X-Gm-Features: ATxdqUFTO7mUJE5Nhep9GfGkL2sugL58qUOhU5o43dLkiY9ui4CHl0bP1YBoKaY
Message-ID: <CAH5fLgiQJi8UhPcydPrkbjWO_--m=z8K=A9xnn33jDRYwT0+eQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: list: remove OFFSET constants
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>

Sorry this reply is to v1 by accident, but I did run the test using v2.

Alice

