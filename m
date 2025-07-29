Return-Path: <linux-pci+bounces-33105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB366B14C92
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF98654699E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8EC289E06;
	Tue, 29 Jul 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH2QOCrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D5227EA8;
	Tue, 29 Jul 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786382; cv=none; b=czqUTkbq5BAMYlDOgUFRCapXulgXDvIoaXGdDfH//3puf/9kAAtkeulLWRv6rqXH9svN0ApCmVydoQ376qMrmSARmAzlkhcH4kMMEDt/XEzSSkHY5HKcyhv/hcpUe+jJmPMV31vjXH2ztOn+ESITO0XF1VyHWW0QVbUSu+IpQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786382; c=relaxed/simple;
	bh=0jwI4ByPSh17ya/A6DhJ8GdK70BSnqVwxGNcDMcnexM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfJ1xJ5Z0rEPnMYqBAjhQz0r/KSykVjRz7gD2TSpusvIgUQp7xGO4J58jhmCtVwPpmSCR3qvXIE2dYlOJvIeh1ouSqIdArlEeUb3gMYvTgjcpYRFdafRu3+nShXZ9c9YdT7uICHk70pde59r2xznQyYd/9zGEEj7lKtayRnXH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH2QOCrF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3510c22173so364048a12.0;
        Tue, 29 Jul 2025 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753786380; x=1754391180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jwI4ByPSh17ya/A6DhJ8GdK70BSnqVwxGNcDMcnexM=;
        b=CH2QOCrF5TrELMbSVza1fvRrN7CEHFd8vX/ZSpvlqS1tdWoNf1zpEsc6uJmhIwgLsP
         kpd2ksNRkYALxn8R4/1aueBg3ZuNwjEsVzCoJDX8YqOTAYhDkErI3IWhmmeBqLHtOgMi
         zeQ/mo/QWSxY3TFCEsP/dAuiNjhJoQv+1d+3IeLAAkW9xys0P1YLU9g1mA+MRimPmhEP
         KkTFgZut3oTDa51pUREUlJWRxlZFtuxJ8nX6kdWK1+vXn2SkJopOEPrtnyic8dGxvaHr
         2sdrBcwLIVhFCeB+b5CZjBH5bJmAfWA7GTt63gxaXWp9KmLXsumUDJmAsNoXuyNdv6ec
         WjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786380; x=1754391180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jwI4ByPSh17ya/A6DhJ8GdK70BSnqVwxGNcDMcnexM=;
        b=H2PJzoXMO0AnHnDQCc6fFNBvGG7XduhcEyytZPdC//GJ6Oebj3JujE91XncKb7tXNm
         5uF6gcGlJRl9IHlhvTklnVC1LFuiD0zTdJuhjINj+F0+Hy3yAxOkYbPq1Vep16/fQ9oI
         lDdLzVVNLpK38+inWcrVkj/Tr7aUGzaf8R6uVQMO/HKPydFcRdMQebeuIZRS1JOrRGV/
         XOdxoIIh0jQniUuSVMkL0YtLwnJl5zjwMjHokumRd1Rw0N8hGK8+FjZrcei5pgjPAIgM
         S7G65kS/b/GQ9OAhk9Zgp6rsC8dfpHt8X7XlR8y+T2RUAHsfxoIzzpKmcQrg1Uku3Tnd
         OY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBFha8AkwVoMAjKyluS6+RSQwtt1CHp3sGbgaPz16WBnI9Y3/+A6fS01YZXCxfT0H2u2OeftonpsYhx7Y3vZQ=@vger.kernel.org, AJvYcCVsWGhZJvPArdICrJQleXi8cZoRW/ct/E0VMFxAYW7OS6G+fyR92AVXvCxp05J1gI6oAfjzK+Qq8nYkuio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmiVcW34uFHYGSSff8EHKJiGWLcA1oNjEES9dbBfJqT4FsGlTG
	1zlmCn8suUB1c6UCHnnjaj7qSSUq+h4D+NKMc0xkLI2CrWqDnqtkgRTwTo+2loIsC18bYdXox2m
	VOkn/w6G6sVR2Ng8GgJtRF5kbV96tl1g=
X-Gm-Gg: ASbGnctQKSih6hnu2C5l7RGSubqwpeNTC4aErGe6hNP0ixnIaRMBWR2h0Z2AsSdF4F7
	poH6DrZI5zcaz3l+OckHLF+6kLAnOInYkXckOpxVBDQzYWi0NX+pLYeWYXmTKOwckoulzb7iqyg
	kJpgvH3toxFiyc+/LmsC1To0Jt/eZ/LL01AiOJ+pwE91YhtJmWqMV8v2SrllCXah5yzI9qb/czo
	clRqsMV
X-Google-Smtp-Source: AGHT+IEfjaf1m/ZMQWtF/x4P/O0T08k13vTbYIwHz0IZ4fY/ozodeLiWojLdWd4z7laSinmlyN3duBduURp/W2lne8w=
X-Received: by 2002:a17:90b:1643:b0:31e:ff94:3fae with SMTP id
 98e67ed59e1d1-31eff94428emr3596891a91.4.1753786380120; Tue, 29 Jul 2025
 03:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729102953.141412-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250729102953.141412-1-abhinav.ogl@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Jul 2025 12:52:46 +0200
X-Gm-Features: Ac12FXyLitR_GXACAyRoN1xW0OYYTZ2y3N-eS3Di47C532EEWgv7pHq2BTa1TiA
Message-ID: <CANiq72kRu5Wd-3Tk7px=2Y5kU5Tq2fQch=+f3ExYSrJa2+tSSg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: pci: Use explicit types in FFI callbacks
To: herculoxz <abhinav.ogl@gmail.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 12:30=E2=80=AFPM herculoxz <abhinav.ogl@gmail.com> =
wrote:
>
> and improves ABI
> correctness when interfacing with C code.

I think this still sounds like it is fixing an ABI issue -- I would
probably just remove that second sentence.

(But no need for a v3 -- I think it can be fixed on apply unless
Danilo wants it).

Thanks!

Cheers,
Miguel

