Return-Path: <linux-pci+bounces-36088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29031B562AA
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8494C189D9BC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594323957D;
	Sat, 13 Sep 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqAUa59v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCF1BC58
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790541; cv=none; b=ghndbNOTKsVlbHMxzRjsi0C8am6Yj583K08fdNmUS8/U0Jaze2pUFycAcbu0USdtAfiGo/RI5LbfyuaCQL9NQDIbjiaqArDjWzRz4/mSfxbVzeqlne7sz7s2loEw+myKrcbusCINmaNlP/ZtFrO/OnwWVTEHJ6zeadTQhIcX+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790541; c=relaxed/simple;
	bh=cL1JgpnQ2TbFdqYtI/Uy9a+kmtKzliPYgIZ8Marbq3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnsnhoAGB8+QnwIRtUAiVANc1dMv5hPGsfQiB0hqo9eJlDJXO3HkIHCJwM2OxZhpzrlPN6AGXWO4MBSFgX6vqUKps4ZtChnFTpao9I/lJUCUs88d6n9zhrJxw0J9KoT8Q4UsS7eD2/wIwgXHjWakVYGt3reRXRNLD6PKSnOhkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqAUa59v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2618a7299faso999365ad.2
        for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757790539; x=1758395339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL1JgpnQ2TbFdqYtI/Uy9a+kmtKzliPYgIZ8Marbq3Y=;
        b=cqAUa59vcn7ZaRX57PSbvw5YHR7/DQGKTrZEsm99bX2TTc36V9G6ihFf6oSbT03Q0l
         j7HEDruT53JCD0LL0Xp/LcNabhQJlVL/0FIjIsBj1UsyjGcoNwgEGvkIngXqmpJBJKuc
         VkxKbSMHrduX4GMsn8+pIeyoW5h0BD0J1su1y3E03p/P6ppATqYpVaAGBZm+Ju68qtWc
         lUMlGSSoairF32zJWBH1uyL22DeU6xEQxzTImsFuXRjB2ul+OAmEatYWTThdBF//VoO1
         NuFHuWGZ152t51UvqtjzxteZRoIE6l7q+2LkRqLv/b71TawrCov8K+afvFjZEHF8CRKM
         2h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757790539; x=1758395339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL1JgpnQ2TbFdqYtI/Uy9a+kmtKzliPYgIZ8Marbq3Y=;
        b=QT9HBjN6Q1I2waxxDgWLZ1VphGUacMK83E8dI71iuOon8NkijVseYem3uGswPiAIyD
         r3SiFbJ4Sy8wiy9GpFw4sxzvUi05VAJDlmdKPRTFSiu5G+q245lqnjc1VABpaqUp5mDr
         5cwodfjRtjD7/69bxFDU+qExFDJ8LyHo08t+CuhSb6DoPAv92NN+MFs5luGiCsZk+AWS
         FP7R/UQaoyGEqveWEdHUAfxOr05aE4K2tFDP+AM5shTINmhxmW48sQ2p9kjvb5rAMxXy
         kwabPXOuXMN6zs+6H6B9m9mhmruEkdVS8ZoLQzyhZqhLN4SPws7HUoZdP0Z7BwVJciFy
         wGVg==
X-Forwarded-Encrypted: i=1; AJvYcCWZmczeLP/ipt0CovlbItcDlMy55ogaNUOEe40Rq8WLjEbLATmHfEpLk5Bj72Mx352Vj1Bl0PsuvEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWk25p4JXXw3U5NW89uz1MU988PlO0H9wfkAuzEVenvi5xo3bW
	t7rHToZravKQh185AAniiQ5WDxA0J6ENdaZ8aw6hfWh5iFYmf6AiQzdmk0w95LRnuKllLLMa7H9
	aDJ1CThXhv4noct6rjXzmPTN0myQLz+w=
X-Gm-Gg: ASbGnctXKUym/1/l+lLLPb9atbPcF+2pbA4eYcWgy+DyGcy7HbzeBf3C6++sBspv+1Y
	PedfTf81s/sVgMog/8/A3kE+xUJJvax5qSD9w0woqtzogl5f26yuyevWZS+vOKwpKN7gMjnoImL
	WuI+2EId36ihZJgTuO4LyYgzYkhl9n866Q2Igwb32992DJI6l08N4EAf+Va804cbVOU8WNK8zx+
	E/V4/EJnGNzdlIlnZiKzizafFS+haTH+R2OuFIxYPDaR11s6nky1gdN/oWuQurLuQtG3FGI20Uf
	SqDKMgf8fosevBW5gJDdzf+8QTiiSkP+oYof
X-Google-Smtp-Source: AGHT+IGbxMdqDo+9laVibenhSquXWzw5Wmdd+X9nwkQAivhEhBlvXq6Zhy7cVyZVuC3X779qYyESCP95mzaeXYhDLVg=
X-Received: by 2002:a17:903:3406:b0:24b:677:6d4e with SMTP id
 d9443c01a7336-25d28204b25mr30920795ad.8.1757790538846; Sat, 13 Sep 2025
 12:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913172557.19074-1-sergeantsagara@protonmail.com>
In-Reply-To: <20250913172557.19074-1-sergeantsagara@protonmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Sep 2025 21:08:46 +0200
X-Gm-Features: AS18NWCYSG-Quyu9_kICkk4Cm_0p8qizjLEvqNGQ_yosM2D0Bf8tLBC_L1FwPE8
Message-ID: <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: fix incorrect platform references in doc comments
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 7:26=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractio=
ns")
> Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")

These do not point to the same set of stable releases -- one cannot be
backported to 6.16. In these cases, it is best to split the fix into
two.

And in the one that can be, you probably want to add Cc: stable so
that Greg's bot doesn't detect it :)

Thanks!

Cheers,
Miguel

