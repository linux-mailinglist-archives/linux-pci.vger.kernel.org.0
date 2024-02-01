Return-Path: <linux-pci+bounces-2951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD6845F10
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16357291CB4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695984FAB;
	Thu,  1 Feb 2024 18:01:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410784FA4;
	Thu,  1 Feb 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810465; cv=none; b=rV4R+dkMxEKdD71kFuXUZEJjmrLm2vjmqklkqfDv6vh8HmpwiTjg+xFELAsGNJeQ7ygprVIgkMTPndea4C6GXDdWrtwLhWN15hwnqfCsDtEnMvC8d+vlWHZ38bI8xSFPfJ+GIsTXiyMgqKrEfmW+5CiwIPFYnFnW0/J8VwIvqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810465; c=relaxed/simple;
	bh=EpJiLhFS+151+GyOf+8iaj+gSxq90dRPc5y/xhTFA9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze9uoKvYmRV7JQYWLOeyRZ4xSOzp0oZPQIbikVn8xHzEm6s7/IORXEngWJMyL7jwo+ILChxXXYnVEG6izYdHxnSG3CJ4gqg5GKE9F7F/gTI53/OHMOXHvTwS2qnFykKSViXeBWije/Y9oSK0buMd2AhCfrb/6VzdP1pqicNJcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59584f41f1eso347627eaf.1;
        Thu, 01 Feb 2024 10:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810462; x=1707415262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+5pS4TaGyELI1G1YPB5J1wpziVptg2Mkm99YXYdlhw=;
        b=AbZl5sOqJZpHNVusAMCLhi8kvWcSmCULkgqa7WOL/7EmF84U1T9L3Nl3z6PUWs3x6t
         4Du+ML1Ufc6/A8qayQu+N5cw9KHUmBcbjEbRrGcfpaM3CtpjoYhkuN0V2SyRGQ6cddVh
         IduNAtPPWeJr4UY0PzxZhNYjz5AbbPWWSkc5gL/FG19twdWnRT7QymA3eEfUTw3OkTYc
         nkFI9oFP/0CISNOuWjG95wkiY1d2uduL9MpB+rmshPzhrxRV0NfnlsoxWcS7HXduqnNw
         3UemtQn84misPTUb17NO+3HTcK0OW5wFyBN5alFGCPrukDtrk7deWELdGDTC4BaKoS8v
         Em3w==
X-Forwarded-Encrypted: i=0; AJvYcCXuYSJVWXdmMrM4m3NG5IrL6Htjb4R5NfmF/4cX3rLz7p1OA0bbGrV7GtD7J3N96FT/LA7LN9R08rUnTnuO5Phw+kS5h2XSTz2lKGSGHhlBApDXibMtQmB2nd+NLOztOQUErzuZga0vj/NabcU0w3+C5XiLw+GicpcaZOWFkvnxuPVroD7dSGV7m7hAQE5Ge6NahZBfpKuJFELh8qb8mKTKMA==
X-Gm-Message-State: AOJu0Yz3D0ttjET0CN5PXBs5GzY6HZ1RQC/Up74wwoViyq0zbbf3boj/
	Xj5IyXF4da/Pd4GGcYyyxNNaCsn7FIve/km3OTDyWnuO8IhImZZRxuRL3BHUiN+435ZsC7dHXC/
	r0SZ529tYzk2DBPX0PzyhLkbYSBA=
X-Google-Smtp-Source: AGHT+IFiN/evHJKKXCQlo4OwGibcFnmCUxqxoDhfEwf75cnMo0APq25APzPgqNRHLAa8lK0nOq0aeEdwkZhWN6YDwSI=
X-Received: by 2002:a05:6820:1c96:b0:59a:bf5:a0da with SMTP id
 ct22-20020a0568201c9600b0059a0bf5a0damr3994479oob.0.1706810462504; Thu, 01
 Feb 2024 10:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202344.581132-1-sunilvl@ventanamicro.com> <20231025202344.581132-6-sunilvl@ventanamicro.com>
In-Reply-To: <20231025202344.581132-6-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 19:00:51 +0100
Message-ID: <CAJZ5v0hHYa4c2U-tegdBtoTak=MirXwyBXbN9yrWPx_x-+yMzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/21] pnp.h: Return -EPROBE_DEFER for disabled IRQ
 resource in pnp_irq()
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:24=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> To support deferred PNP driver probe, pnp_irq() must return -EPROBE_DEFER
> so that the device driver can do deferred probe if the interrupt controll=
er
> is not probed early.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  include/linux/pnp.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index c2a7cfbca713..21cf833789fb 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -147,12 +147,18 @@ static inline resource_size_t pnp_mem_len(struct pn=
p_dev *dev,
>  }
>
>
> -static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int =
bar)
> +static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
>  {
>         struct resource *res =3D pnp_get_resource(dev, IORESOURCE_IRQ, ba=
r);
>
> -       if (pnp_resource_valid(res))
> +       if (pnp_resource_valid(res)) {
> +#if IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI)
> +               if (!pnp_resource_enabled(res))
> +                       return -EPROBE_DEFER;
> +#endif

What would be wrong with

if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI) && !pnp_resource_enabled(res)=
)
        return -EPROBE_DEFER;

?

> +
>                 return res->start;
> +       }
>         return -1;
>  }
>
> --
> 2.39.2
>

