Return-Path: <linux-pci+bounces-39752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7372DC1E65B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 06:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A69834AB1A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 05:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14F30DED8;
	Thu, 30 Oct 2025 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGFn7QQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847C27E1C5
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801257; cv=none; b=ludhb4iNt3N9E3CQ+qXwoMDV9GoKn7LsWFaeGqPWxkPd3StORCOSplxwLUqLQ9euGDD5E+XGJyXrhKdKUItgMoDnobfgKiXxQenyMjigWJKmJQMAZeQQB/2Hr50nkMcDi5bgUXqw1iNcys0Hv04ZybHLuOEokGyYeTqZ3s8HjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801257; c=relaxed/simple;
	bh=T9QHSB+KZkLl9uHgRXc5ETf3HFmGTKOuyoZXK7i7tR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSonxRJy6sGRNrSoB0+42oefAvq5Q4+V+P8d7PkTcEvfc3GdZQlVX1DMwPmK5XXjkTnyyRsP48iKRKKzRGraUbgtm66prWXDQhVdPh44PSr/7F+Ck3aoalPOjQylQNPhrFUkvX9hH/vNTuwxDI+jHIlwubxjSzetKDcaMzm7Sjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGFn7QQS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6406b8e1fb8so98908a12.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761801254; x=1762406054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tq0yxGv6yRvwde5HLaH1HkY7PXCLMaOxQayqcCSGMU=;
        b=eGFn7QQSkw44XxcgW/Ly0VCFciycqennQ+atdW4fBXjZ1cZ9cdRDeY7Oz/Gn4gp8v3
         /vRAqqxqyiNmzyjDhwAkW4C92sd7ykz/+f32KhZipOM3HATm2jUIFj7ejVYnkmDvmc80
         l+A4Af+xRkIFg8nAFh46Ql1ZwWvmU++Szxnioa6fChxC5UvsonCd5+45dVuE3lwpNFFs
         goW3UrOAKf1Zrv/21FjXX4QWMuOsYe9PK1lGzb3B1NVo0yXklwkg/Q1wTHSjMEDKAUcn
         L/jqp7Gy0/aKe3GBuoTpDYPs5zOo8ZIUqOQdTXy6eXSbuA22XmgqG3Z4paE5Upg95KHT
         3x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801254; x=1762406054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tq0yxGv6yRvwde5HLaH1HkY7PXCLMaOxQayqcCSGMU=;
        b=W/2Vidwg5sz8NKUY3lHyjJs+omDkohgrwLnBd5GnE9jhzCK6SgcXt0mEGPAjBwCIag
         c9w8rHwIlaAav1e6UK0ujWk1UyNwfJUsGf1Q5VJhuv+jCG3ZTtP3mHHk4tsEDr0rodXu
         ZHEfGGcTBXMPR6LcMAdXDWPsyB4DN5S2GUg4MQNiYhfUCmLzrPOMFMA/8kslNu+Ho4jw
         dbMa2m2yXGCn2kv8Z9zNxwciIMH27eveemcRd0IT89YqMERHz2WUfd3/N+coaSrLBD5Q
         jLMt47eu5Ak1m6dVB5evfq0N36+00CH2+lUgzQk8/11/0jxIjt2jgmqG9g86PN9pFMkN
         sURA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwZAW4075Exu/Y5oPdr8y5pBOBRYWhvY15KrcRQ0oMFfzkYo8fHUbuYz0XzfHEaFtUbVQi8yS1Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MuFZ/CALzKv8rphBD7uURjRRsvEqhWlIn5P/3mloHa3xkBoY
	zNP/8YIMmXqgCaw3GKRnTQopHN3TnvVxVqpZaC8zTmIZRFKoZqs27SHDPir+SF4+qo/j93nwOQU
	ZhE0pJQuuULRTdZsEJWk9+s+TjDSWXzA=
X-Gm-Gg: ASbGncsvVTrBQvYIkTGfe82rBLkzNpxxKLUqZvFbwhfaCEh8nFWdNeIM/Xxbm1SeIB5
	+qvLsiribsyOPJVvb4UmjQ6vvDY7zdT6ALaH9nR3Jhv9uyPb1PPyHqSlA2yN3VVp4yZuL3E5OE6
	YEX1WbQV1wshywzY6/nHfLH9IAnqK4AKSXAQENVqxf3UvhZzH3Od9qjEAmiK4RhitFX+vmw57lz
	fe1uXyB611jSgl9fK7k0njMiY9V3uVXxIv4+t+HTaEkT/Tkt9FkhABGbx0=
X-Google-Smtp-Source: AGHT+IFDCMfSXrIL3bjIKZw2IhpHFG1U5RsQXDbZl1lPFfpuAvA594DxUOaln1JvXCqNQSfMK0dolS63NIEWPJif8rE=
X-Received: by 2002:a05:6402:50c8:b0:63b:f3a9:f5f1 with SMTP id
 4fb4d7f45d1cf-640441c2092mr4444447a12.14.1761801254315; Wed, 29 Oct 2025
 22:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028154229.6774-1-linux.amoon@gmail.com> <24319a9a-ccf8-48a9-8b5d-3a846976afcd@web.de>
In-Reply-To: <24319a9a-ccf8-48a9-8b5d-3a846976afcd@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:43:56 +0530
X-Gm-Features: AWmQ_bl9cBL27Bidm95xNfiwXFieCJ3byhHw0tTbL2X_4Wmj8VImOI2xhqIIeMc
Message-ID: <CANAwSgTO2s8LA=e5CVYnpJ95_DLdkiot5Zbz1hFaejV=kTK2_w@mail.gmail.com>
Subject: Re: [PATCH v? 0/2] PCI: j721e: A couple of cleanups
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,


On Wed, 29 Oct 2025 at 01:21, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6> Changes
> > v4  : Improve the commit message.
>
> Would an other version number be more appropriate for the subject prefixe=
s
> of this patch series?
>
Yes, if there are some more review comments on these patches,
Or they get lost in emails.
>
> =E2=80=A6> v1:
> =E2=80=A6>    dropped unsesary clk_disable_unprepare as its handle by
> =E2=80=A6
>
>              unnecessary?
>
> Regards,
> Markus
>
Thanks
-Anand

