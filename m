Return-Path: <linux-pci+bounces-15988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FF9BBC1E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3107A1C20BED
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DF1C3027;
	Mon,  4 Nov 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikj/qr/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53433FE;
	Mon,  4 Nov 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741780; cv=none; b=uH14Td2/4uDsyCU3ufcot47WpmbyljMfpA7USvzfxT7K1S8WvOYaNJ/I0p6fIIi+Ul+TfK+1BUx4tI9wkKruJAYp/EKw4icMZx0iqOlUyFc7nDT8Fa+twScMy5ne5ipskckrwn4foByAt3ij+smAjGJUMwAM9wDdoRIUhrd4q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741780; c=relaxed/simple;
	bh=14Y2C3CtK6n0zKXAiwUiWs4AmbFkmgaPQlfz0wwA+rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgQMMkXXNc4Cdt7b9vISuwVIPZa4iWVKR+GupkvTl4p1gYkUIttZPJRoOG91UpbSMGvJwxJxXfyKnyZbsjPIOvmGJWMlbzoG7TMPfW+K8rekfeTSlOMLywxoAe8SfHg1ZF69WpG7GFWprGRy6AdVp957J9CF7MLZEtcGcjDieEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikj/qr/S; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so415194a91.1;
        Mon, 04 Nov 2024 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730741778; x=1731346578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Y2C3CtK6n0zKXAiwUiWs4AmbFkmgaPQlfz0wwA+rY=;
        b=ikj/qr/SvHqevBrclbV99++lcRbn7OG1R0kjisqEszgBIeBaOe47rkrMH6N7oGuC2Z
         //eSyCye0y0sErok0X8G/tg/90lAwenpEcFMcVellNf8hlhoC2+POmQDNM2NvWsKDP6q
         CmChLxqcQeqSYDy+m4MoR2D5Af36X6DgMtryDa5Lx3m3R9/MaEhFLWhUsve0OnMqJLYh
         RmOK5cH9MsfEMZ1EivaOp8XA9dWWFLMS5UR8XFXOQdcO8xnamaGFqXBzlsA6qtwePy0B
         +wEzKJjpNoV56I8zQOg+JdDpQqUnAYw/lKi5rTrWV3TA4Pf1XfrM5jIH4FqVDwrOKcPj
         M09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741778; x=1731346578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Y2C3CtK6n0zKXAiwUiWs4AmbFkmgaPQlfz0wwA+rY=;
        b=PtqJE20NLggcxRPdtX/U7UEdau6YLnxAkvlKp1L/lw1o0sPfQCMMw73AyFENPJFB/4
         sz80wsbG1VKw6KR8fBfGnxF5w43UxdWBDHFzNMgP+rZh1JM8QvaQUlS84apKZzIwZ3dc
         h8ggtrQ4m6G2i1dq6qz/FcQYSmdAp4dpjmcTg6Xd5MEBqhzAbQAq2rtDJvTxnqcVyNIH
         y2R18q38HGUMmCWQhy+oR3UL5lm7SBWSRMcMMryMY8RM8MJODf/7ntUmWCP67VGgsWxy
         8/QqNp+tK4bWmJAoHXJxJQV0vzlU3GQKEGR0M6d+mx6cl5ZNt5RCnQROSMIFa4Bxi1ri
         lQnA==
X-Forwarded-Encrypted: i=1; AJvYcCUMI+gkRliGOc4a+8jpwVv1UqQWWxqmHyzpGafblN9ZFT62LgvuHz17EHEzx1bq2vgTu4S2XTb15EVz@vger.kernel.org, AJvYcCV4boliGxRO0V5rPH8eJCpW/bgYBP0R1gssx9YWO/EutCTFpbZsayeOJb/rZfIYXChC+PstuY6i4AC6R6/+zOg=@vger.kernel.org, AJvYcCVl+TPfGxnAnEbjFuCx4afwXvAvTiv7y5SstJxCOyDBak2W5cDH719wl5sYa7b47WieA+stSiK2OS0W@vger.kernel.org, AJvYcCXbn7pJcVDlPNqndCfU+S5j/e6mv+YatC0sMD4MGJARY4HBUBNdhUMQ6Xt4eiCcpCNg339gyccsbwEh64o4@vger.kernel.org
X-Gm-Message-State: AOJu0YycIlEjjvuNqYr5VFBGA872qHt0tfVAMxKtc8WKICo2ZJLIRch3
	cTsMjcWLzlrmJ5bYc0ixdOjCRbaIBbeNN/AwjZlSX9j2HkmdqQy0v/nqlaQUulvaXvUip9dKy1S
	hUq1MbkEekX2Es3KuaiJdSrpWGm0=
X-Google-Smtp-Source: AGHT+IFYUp8Z31hGCqN7mtBnIVFG458aQgB2jJN9y0AHvYhO6ezYNnK1zqkRnPaCXsvZOB/Saq/9VW1K8wEZC65yQms=
X-Received: by 2002:a17:90a:780b:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e8f1068be8mr16152054a91.3.1730741778234; Mon, 04 Nov 2024
 09:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-3-dakr@kernel.org>
 <CAH5fLghQ3Rdgk+xzz9RzNzTs4vYLMO0q-SkDOrnb1u4TkPQVUA@mail.gmail.com> <2024110425-overfill-follicle-c963@gregkh>
In-Reply-To: <2024110425-overfill-follicle-c963@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 4 Nov 2024 18:36:05 +0100
Message-ID: <CANiq72nh5KMDHhnD_06CqVDNU4SvRaghpfY4_K1U8GxYjDky5g@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] rust: introduce `InPlaceModule`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, 
	rafael@kernel.org, bhelgaas@google.com, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:48=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> If no one objects, I'll just add this to the char/misc tree that already
> has the other misc device rust code in it.

Sounds good, thanks! I gave it a quick spin (on top of `rust-next`)
just in case it triggered lints etc.:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

