Return-Path: <linux-pci+bounces-31772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A2BAFEA5D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B16C4E3B30
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D622E041E;
	Wed,  9 Jul 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hf5W1YXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39E28F93E
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068252; cv=none; b=eGGiHFS5HOmDNBPkKyZHnzCPZNx4eJ4gxNassvGy38s6cpQoOPEpxFFV2bOwKeXIVHlaOsYpI38a8jDpln/cUTSZ/FPJpoRsXN6tUtrUbO0Yg+FEmtQjyoyJHUzFpGTwQEdGbUadacD+Tug9IpeU/IvPsftWD5t6Il0Ty6Ca154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068252; c=relaxed/simple;
	bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqnWIgeMtLIkk2krVxhreShY74XJm/5E43Q0GmgheGp05GASG8TnflQb+ASPw9c8nMXusdXs+rwNh05ib+OWeHku639Nvk9zjDwAkhLeD9NG3G7nSSqq+vZ44W95zMZ34BylXpVRSi1VcYosTC4jTL1SPkyubTLdxfckwpDxz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hf5W1YXP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3050199f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752068248; x=1752673048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
        b=hf5W1YXPtxZSSzDSdszBMY8gTXr/oFFGyWLDNSCCQ0dOvd7B+VCaY9Ql19NRv9oPUL
         A3plrVSFhLytYsY7m3teRtBFNpiU2F5vA6gy9z7ruqr9MqXv2P/7evyOR3KHNY1Q8h/d
         1mPa3JlegriI6WyRoOb9jZB9EGdFTx2s6f6Hb4r+7d3g1m6u22pWS74nG+61m45NtzT9
         rfGOe0WASEkT15p+I7xF8ORURKai/JhaIoJ9AdhWNbvIExpXS2PA+LTQWx2SDoeYBpfa
         oacEByb7Eo4Udj2Lq5gnxgq1VLWCK7YvfXs72XsDa+/htpIC481oQyLso1MZsygt6b3j
         ssOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068248; x=1752673048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
        b=aKeN8BbKKFKIlwRfXuxBii2qRFw2+GwD5OAZuWGA0raPNdKGaY/I1/git0LIEuUai1
         crpFAccAQO4o0X18cxZ7wqq2Y0bVdhJVPAjq1S2+iw5AdEfCGabSps6aqbENsh+H8MfC
         iN4pRWeYn3U9YMgV58lVxnSxUBtZz+bLctOCdlBMwNnEyKKutExxbxc0Vu0OIcc4kpiH
         h85QPDzJMgMPkWK1lC3Gy8uOzJmr1embEO3ahpV9sPKNVkaX/TGOKETR3Cb56o9Cu2JU
         eq8+KEX0g/SCoCNb5rHELAi7JiRvO8Jq6QLZrXp8deTmQXt9cn2Y7E9AXU83C/imkVUA
         sCDA==
X-Forwarded-Encrypted: i=1; AJvYcCVeBX3WFCXZ0tgCwb+zA+Ho5OuV8DkAQlGebyTuQBm0ic1o7w2GlNz34/j75JG9TK7Z1elFnAPjZQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBtWLVsyyy6EaLZw9BZhiJ7oBPE+Wq+15Rnak/4BbKjnXZdEs
	5qNBMyLdNk7StsZE/F8n4u5Dbkc/ySol9NF66EVWtYgW254N3HweC5udAVP+JXZ16EQnWpJLIpH
	rdN2ppvRlJs6QLdUygDjthDpIP0n6bqAr6aU1aKOS
X-Gm-Gg: ASbGncto8qGfSPsTqAbFgmjn2nd5jFIc0tL3r9iDZqC+kKZdLAjfet9JUu9lFJ3C/iX
	3JpkbPmUel82TOWHQ4WIqN++L60395oHxwj5IFbaKrpP1UZX2Pi+3CLe7TNPxgeoUIu+gBjLLty
	+GescOIGpWyTbH7IlnRDToMXHYruju3OmBUDbj2nTCQu2iPiA0MHht6s025yMVC9HfGPNDRlwaB
	A==
X-Google-Smtp-Source: AGHT+IEA716nulAqRa5a2S60pK57wjynJP6MZeuoqr0aItMDvDtiVKvSCOQ7tPSH50CZIlyU0jurvE61IyCCQaR9h4E=
X-Received: by 2002:a05:6000:178f:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b5e44e3f6amr2141108f8f.7.1752068248159; Wed, 09 Jul 2025
 06:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
In-Reply-To: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Jul 2025 15:37:16 +0200
X-Gm-Features: Ac12FXyCr_gESQ0NBGSVDz1Tvd9THD57xkpCcUipxVzlzPqqz_epCDTU0SghXaQ
Message-ID: <CAH5fLghgRy_B6kJ9c4HDWw-EUTcUQC6qhm81zizeRk+mZPu_0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
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

On Wed, Apr 23, 2025 at 6:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The bulk of this change occurs in the last commit, please its commit
> messages for details.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

