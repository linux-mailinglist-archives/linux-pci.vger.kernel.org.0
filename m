Return-Path: <linux-pci+bounces-34760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90228B36D64
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDB3467F76
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3324DCE5;
	Tue, 26 Aug 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="CWhIx9qI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6D23875D
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220873; cv=none; b=aH81ZOuv+aSsDg2vKX7TKFT2qe/uO0RyNErytDU0X0m7ss9WC4YFhb4f52xg5qZssaX28XXyI5JJVKc5R+esm7ByqUBnptwlvIbY1+t38Td00Ng4CZj9azYzIoljQNt9blDV0d4s0gSrnGnHeb2OtT5I2wQ/3mhmAHIxuEcZUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220873; c=relaxed/simple;
	bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfkA4xQE2u7NLajkTeaVVXq1V9OT5pK/CYISFG8oJqfenbgtD706ClZ5zGo9bZRmlF9gDy1K7szkua/tWVC76b7FoA664xxAoublboBaDJoLEyl9EyqpIWRcox+YQi97puXJyK1TAOvUFKXxETrD689LQdqIqsLQpL0FpQ2VHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=CWhIx9qI; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50f861e18cbso1958154137.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1756220870; x=1756825670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
        b=CWhIx9qImRjTmTgJcbs+9e07Xw+/tVD4fBOUzLhXKziQz7w4ibqxLa8VFSx0UgCEsO
         JwPr2KmxWz2os0RtddSDcLlvtYIsgqfxdRHFqJIl1eXMtjW536GnTFZdkqHut3NSUFmh
         PqlbF0CMKeNZgl8peINSdCmh8v3SSElqZiSYu7w5J2idmx9AIp75zcdIvWoiHmwQk6KB
         hgwRy/jaP0gq/lKEq8PxZXQStm8Xvjyb8a/DME6cqQk1ofjqQ5iy98S+h7c3Xz3c4w2U
         ZrGUYG7bykaU+cYQ6v3D3YA+60td2tPUM6kd0Rpn2syt8/GRqbpBeU6NQdkJn35ZJQUb
         cNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220870; x=1756825670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
        b=rTUaKAJMMEh1mwkDerLEdxpsNi0Nm2W869+xAim8FvSIHsDNqMj0xMuGeCFms4BoMl
         q7TTHFNrKIDrx6tBEiUVUr40u5L9WDWt60ij6NVPyCgMtu/4Jv4IqtXPHB1goA8i1R2B
         CHxlkoU4uO28HR02ZPZA+ARHXz+BmXz3sgvnZHwvoRx0BeXZvEMxPVFQc2xxRlv9jIgx
         MF5NvGzuB0j9fRbj7pDamVxrkib1Am3ED8TWUHSnFQ2RmByt7Y/HUfmkAg5SWGUJgSjf
         ZksPAqsPciSi6MLxwiEUgeIMcSgtzf4lhnE+W37uGBj/Lo3kID7ErZLOpEMidiF4pF2q
         AsVA==
X-Forwarded-Encrypted: i=1; AJvYcCVXmOCmZEcaJ6Y1LdMmjcv7mEshFQfQz6fAvWilvkOVQYb8cASAmOUt/u/b1MjpeNNTbyheIxzq7js=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgI2T5OzFy5MQW5JNV8issNge/g3p7fU+/6YyHsqjes+XmUgA
	JoodUy0HeL+hwprBsn/qs8ab/j3zd6MxjojfLc9U9xTlbaLjn32Wily53dBIZqUhSBRMTvV39k/
	LDPXqOmAZATH0R/eVYJo5BQog1vyfNstb5m2STaIaUg==
X-Gm-Gg: ASbGnctW5XK5PrYhSpTBEmcT/bc2fYB1BGxuA3cewfl5dJFjLaxqMUlNpu9P38tb10B
	oSKtIEq2rpQkcjm2kPXh7zAY+8OJK7e3KojlBufFy/+LiLBvXoHBs8X9v/DUB9ncrinvyMiHmOF
	JW8x41V1tDWUdSE+td4PGsOcXtVzpwMcW776wxBe/PlfFKGFn0tcpNUumCuGOz9aZd/SXrbbrQR
	Bns0Q==
X-Google-Smtp-Source: AGHT+IEBQktZsGOdqIzVGY7uzXewtRe6umCPAxdRB6LipaxI53/bpdLY1F6YKDz3jLZCa8rUwlmdCxJLMPZKOVfuKqg=
X-Received: by 2002:a05:6102:5106:b0:521:b534:1e39 with SMTP id
 ada2fe7eead31-521b53424a3mr2872957137.12.1756220869569; Tue, 26 Aug 2025
 08:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com> <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali> <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali> <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
 <20250716181320.rhhcdymjy26kg7rq@pali> <20250811175756.kqtbnlrmzphpj2lm@pali>
In-Reply-To: <20250811175756.kqtbnlrmzphpj2lm@pali>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Tue, 26 Aug 2025 17:07:38 +0200
X-Gm-Features: Ac12FXxpk5v1_YyA7O6ssBnTjtcz9zqW_DvjbyN70OXMFOXGEu5A5aTQ0zN3UZA
Message-ID: <CAJDH93svLMPM0O_Lq=EgfH6dxXXbnq4QkM6ye_8tyvsRYs8dug@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?B?RmlsaXAgxaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hello Rostyslav, I would like to remind the previous email.
> I still do not know which bit in D18F4x044 represents the
> EnableCF8ExtCfg config.
>

Hi Pali,

Sorry for the late reply again. So in D18F4x044:
- bit 0. EnableCf8ExtCfg. Enable PCI extended configuration register
access for CFC/CF8
accesses;
- bit 1. DisPciCfgReg. Disable CFC/CF8 Accesses to IO space. When set
to 1, CFC/CF8 accesses are treated as
PCI IO space accesses and not PCI configuration accesses.

Unfortunately, I don't know if this also applies to later families.

