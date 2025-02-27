Return-Path: <linux-pci+bounces-22582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157EA485BE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C0188580E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07561B4F15;
	Thu, 27 Feb 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZg//mZS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC514EC5B;
	Thu, 27 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674810; cv=none; b=VYPmMpAUTNUnmzUConlnYKgKMJiC34X9TEX6Slo51U1BmvoUnP+3gQvnulNsGnh+CAIHF7ZVqB+YiPCGKwVO8fDBqHhtvH5SdX93K/ltNRGjhElbtHzIOFpXU4iGtneqhhPMXn87eYnjZkJBruIqLyYjcS3tMhg2IqV9k6zli/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674810; c=relaxed/simple;
	bh=fX3ywRsIqVxpoFZkdvVQUrL8YQh6bSzc2jVbJ48aZSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gm4Hdx1VtJ+WfF3gx2vxV7hXg3aapuYgPFebXrMvpx1lmNmtUSRCy9fgCL1hfN+gvpYkC5InbF4Ks84PTDtOJovoxKwdESGirFgyrjZhCViL5T7ht1MzLJyxjk1fWIMGEUxYAElDxu6NemdX96E3QD3zBrM+qOhH7wWnsWjcQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZg//mZS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234a03cfa4so2500815ad.0;
        Thu, 27 Feb 2025 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674808; x=1741279608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ple9oZGdoMGXLg03C31vuZCEU1fuqGM+vXv7chZBAvw=;
        b=TZg//mZS1eErL6It17tsbjNOvdReaHYHwt+I6yS5esBQCWvNZ9a/6DlAIbVv/sO9OZ
         Phg9yUfQsGGQXpBWTk1itJRfmU92wdo4rWVJDH5vLOwQlVugG9lcoISO3fcjuwRwNR9S
         ndT5vezhk8QIeOpwYgRbGuVcJ8fc7SX76Lb0hWFePbWVBfBanEOQxdw1YKmmGbmMKXBe
         FWjK+cUQeBLpU129caIfdREc6tUGv75+eFYNJ6eEL5SpbloHw7MtmNAZQVV0rR5iT36u
         2mzmIaIIa1Hm/IT3Y98b00roSDiz+aunNk247IfbqGXQjRc9ShKEi8tzD35Ox7Z1V1oo
         qUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674808; x=1741279608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ple9oZGdoMGXLg03C31vuZCEU1fuqGM+vXv7chZBAvw=;
        b=GJk47OigGTnFusNCJukQulh9LZuZJSPEvJVoef5leOugUoM/QVrm63fTDinx/O8HyM
         tJ7tjXZ60DCgdw7JZnNLIBfXWkRqwXjGk0gSTdZuNS8DsLHH1mdPCs2GzL6Y/unPBDS7
         3mxRqwmgPyuHhuSOewbJUmUST+N/JipsXki8CEBB9wQWhGY1H2LpBRIvSWabWGpq/ha1
         +OqytcO9f6V9eMxqtBniKxJgSIvp5JSzcJCsntzmcs7x/HNXVTzavicQmzCyqd/qe93Y
         F/PTMb/0w+ZQ/AO6C2VTQFIf2E2BeLxwsPIOBwI2cgSWe/bP32TykugFFLIo20F2VKrR
         6yKw==
X-Forwarded-Encrypted: i=1; AJvYcCVREFMh1nuB5rd0aEdVtaNG1Y9CYjM1YuxPJ/o1IJDDR1QCnbIiZRpT0K9K6l+BemkLmruYYBqVgNKRfPBeuUU=@vger.kernel.org, AJvYcCWZMIatTlEPxuseUjDOeLxmFtTTA6RPLml/OoNBnsVAepf47AtDqUl5+VhEcoPVd77jv1sg7LQfaFw=@vger.kernel.org, AJvYcCX/h5RkL3HKdStFtSMdwixcfWiTnfbwxwEFoqErzLwYSii/F7qgvcXKePIEs89+T6KJqZKKGWW14CP4Lw2J@vger.kernel.org, AJvYcCXvEGlN4JK58efJ9C60zso0X55HcQVZ0T1enid4r4zubKVfYO8D7v5wVC6z3ehawzzXwp/xeUengHcu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzigv/2b9xjE6ixmGIhpQ9+Q3oqZ7MaPh4eFLXFATbUC1EJQ0rD
	BiE+OJeREYa6sZhSfEoLhj1WUQEaif4fxkA67ToWomoJMh6MeT7bT/cJUIYqV37Zyui4oXy1CGU
	viDy/upljoSOFkFwmOwzf4ezimxM=
X-Gm-Gg: ASbGnctrecAm2yFqrjwFN0aTMOm35o85H8HeRXdeTldwhDfIomOYOqc7BIGUljIGs7I
	IU9z77Rq938N/gG92ifTM3QjwT/7115auKPzIA6NUlp0PNYC/LElq6NL1gdI9EmkfPYXH8/qoXN
	O12XCNquM=
X-Google-Smtp-Source: AGHT+IGlQG/yKIie1e8xLCISJTHqKYSYyYkcckdnwfvRvkNTj3VfIDmMNMNqLPGi+gwJnBn/M+vxiBtIzuTX/OfcKOk=
X-Received: by 2002:a17:903:198e:b0:223:5525:622f with SMTP id
 d9443c01a7336-223552569bdmr14666395ad.1.1740674808381; Thu, 27 Feb 2025
 08:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh> <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>
In-Reply-To: <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 17:46:35 +0100
X-Gm-Features: AQ5f1Jrb54hpcI-WZSIX5cFh6LZtzJTx_jHD1IT6o1zi2EDpWunP6lD36EKxw88
Message-ID: <CANiq72mHVbnmA_G1Fx3rz06RXA+=K5ERoWKjH-UDJ9cKxvKQ1g@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alistair Francis <alistair@alistair23.me>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:11=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I don't think there is tooling for it today. We need the opposite of
> bindgen, which does exist in a tool called cbindgen. Unfortunately,
> cbindgen is written to only work in cargo-based build systems, so we
> cannot use it.

It doesn't require Cargo, e.g. see my reply to Daniel:

    https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/What.20is.20the.20status.20on.20C.20APIs.20for.20Rust.20kernel.20code.3F=
/near/420712657

Even if it did require something extra for complex usage or similar,
we could ask the maintainers or I could perhaps come up with something
to generate whatever inputs they need.

Cheers,
Miguel

