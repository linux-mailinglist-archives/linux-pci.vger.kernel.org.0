Return-Path: <linux-pci+bounces-27109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBEBAA7ADB
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307CF9E0A92
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB21F9F7C;
	Fri,  2 May 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkX8ctaY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04C1F8AD3
	for <linux-pci@vger.kernel.org>; Fri,  2 May 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217778; cv=none; b=uYxNf8ScO0ycelAMmw3XUjrXG0ZkXQEprCzm4PNZzSzKQ7FR8F5kR6WcDgfvkCQ/nE0JMjRxvJDT+6Uw4jDnn8yhTtEuDig4s9tBHLauk7+8zZpKKKQGTaj6IiDwA9x+cyL1hd/PRfLeMnRv08fPagtlm7HudAlShKqa83hsFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217778; c=relaxed/simple;
	bh=Dyc4VucIA18bMQ/LaDxwZ0u3No29RUGoJCBcBQD1gr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guqrEOK7hu2zYd6bEx8Mlk4VfdQhkGKwXQU5CrESeenLSNlNwIXkFRdKpz3dvzcx6tp11pTii0CGibsT3NtqwkRyQw6XbURNmGKT7rPjMw0lT2CTUk40VFe2GxXe9fh0/aRUFxOg3PEOJA3rasCi0rltdX/V3S6yXDklLnjW/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkX8ctaY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so19027471fa.1
        for <linux-pci@vger.kernel.org>; Fri, 02 May 2025 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746217774; x=1746822574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyc4VucIA18bMQ/LaDxwZ0u3No29RUGoJCBcBQD1gr4=;
        b=gkX8ctaYC44kdZJvcD/i6x2qKypvYMoxuk8qxyQpVeA+/OfvmnsuR4sWf3fCaUprXZ
         oDGuKJrpVrP+IoSwksFkWX8EgGMdfzq2lzcnKfR2B4WvehRCOJoSFtwNFeNbGgoihTBH
         b5N2d6B4qIkSvIMwz0OaHkfrF77FIN7uYMN0bRRu1kBU6RCpNriRJPIFhnxBtLkrWqKY
         /6xci12lIsj59h875vqMaqhiAdclf7Ayi7Me+XJotC3Dct4CYtkJ828+35h7UrwHhC8R
         XMpJpvoKV0QZ5taC1zg0IooAzqCvc1F30QsoopYMHfPiWYa36ZceFCXa3lSvMAj+4M6D
         mm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746217774; x=1746822574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dyc4VucIA18bMQ/LaDxwZ0u3No29RUGoJCBcBQD1gr4=;
        b=KJ3fPGLYT1j28Rde6RVlgJ8YuAXWBBN4EpMrc65M9DbaBrpBAixj7MpuGbuwyfsUGF
         jm0yGTQDqVa+Qe7EvaDYpgNouiIt7fwvsHTI8qsZ87R038DZOPHQOhrsjAI3Zev/gN5S
         GrB+BobLmrcnJeBhIc35AZGbjExcMjIIP6iv2P84DKmQ9kNvfG62jYSohorYd906ZKKt
         /tIis160qsWroqTIpeZfL/ssluOlsSenfdTi0xt3dbyXVD4ZQEWAITEbWBiz8lyBuC2t
         8fAv7AGFuLrjB7ButA3zzBnGY68mBrJcHMAq5Hhd0rSGhdWEpUwgEskDoS1CJvfnq1Qo
         T8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7rWvoRbqxnxt+YinEkFRYmi9WcKrTaTWSLU3KD3hVMMr+JXp8iuD2UEqrW4HCQcEEL1jrqnIpB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yXTkfMiXlHvBllKYoOXDHdhNe03f+ownQETWeXMoRRhSVwjx
	s33NqctpNKrmsynkxBpKFJZZ8CXOJA9ITcXKHJpiyI5hq8f0RtRs1UTx6AzVJx6s3yOmsMQzQ6W
	RmY0khHHkzxeuMHoT/Dcrk+2qvmPrzoZki/VTKQ==
X-Gm-Gg: ASbGncsgW8LfAVrG7Sbkw2xHG94SNQB4FDAcl4saAQvku4XDCO7PMkdqagQa++yLWK8
	y8zvjzwVs7RDKlCQQZPq7a2kCvrGsFh3Kry6hN8cEizOfwjQ7kkOyij6kHtqCzS6OwwUXJ4bjlu
	8mVZ2tyU5/I4vVJqojHDZIpQ==
X-Google-Smtp-Source: AGHT+IE6YTt/niqKQC/QybVWYRM9e6shd/VbSY8KRysq6VEEG74icJfMuCm0qJps54EJDOCFiUhMQ2MFyXvrkj5LwG8=
X-Received: by 2002:a05:651c:24b:b0:30b:fdc0:5e5d with SMTP id
 38308e7fff4ca-320c3b0277fmr12099371fa.4.1746217774478; Fri, 02 May 2025
 13:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502013447.3416581-1-robh@kernel.org>
In-Reply-To: <20250502013447.3416581-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 May 2025 22:29:23 +0200
X-Gm-Features: ATxdqUHkisrPrxN0V8LxOcj69_oQIgjXM5hj0MkSydduFZ6VmGupMstVtA3t7To
Message-ID: <CACRpkdZ6ZsSTXGDFCLe_bFanKLeEm8+vY4_SvKrF5BrH068UCQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 3:35=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Convert the v3,v360epc-pci binding to DT schema format.
>
> Add "clocks" which was not documented and is required. Drop "syscon"
> which was documented, but is not used.
>
> Drop the "v3,v360epc-pci" compatible by itself as this device is only
> used on the Arm Integrator/AP and not likely going to be used anywhere
> else at this point.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob, I see the robot is complaining about a oneliner to
MAINTAINERS but I'm confident you will fix that.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

