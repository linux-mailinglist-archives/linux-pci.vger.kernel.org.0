Return-Path: <linux-pci+bounces-31409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49CDAF7912
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E58D1887025
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9452F0044;
	Thu,  3 Jul 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1w5cXib"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF312F0034;
	Thu,  3 Jul 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554393; cv=none; b=FbraUHKhtScz5AYiyaIHzBdzkfRTF+VBCjSebZ2CAOaKHVuuFtiurL1K/B4vEFKDRZ77jN7XYfs4ERwBcyX//u5A3u5L4FbLl/6CsgE/3MbZLpi0W/jOiBH0m7eg/0QhgpXLZK0wwqmUVMxq1GWzOcePwPEVp+51MCnT1LKXvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554393; c=relaxed/simple;
	bh=DYtPFjKsBRMKz/l5D/t4ZCOdW4ZlU0pbxZxDlephea8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R86Ib6jacqHGZXRRvjM91OqEm8MjbYa69BPC+dPHhnyQLCQIG/IbNF8y6ACWkoKUxKZoOfaot0vF9QzwhqmDCaZeDbTMmjfm4pDqCCspro24kSI0ihNJ5ldzuKlmH7m+YKkxhOYSuDfv1LdFrBeKnt19uBLdIadDi5XN3KqoiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1w5cXib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547FFC4CEF6;
	Thu,  3 Jul 2025 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554393;
	bh=DYtPFjKsBRMKz/l5D/t4ZCOdW4ZlU0pbxZxDlephea8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p1w5cXibIDAhNVjtLQmdEwa2Ytv9ciyjyG1naJxm3QJ9haNeaXPF7TgVrOk9MK8PZ
	 q8NABLCgkGxo/K+NlGfxmpv+PAF8mh6VlgHOSY6brq4yfZieF3zhxW6GTZY0nKboHq
	 3Z9CBTYcStEFUTnvgyOEBxfisunhbBwfqSYo5golA9ibkFTyyd5K4ka0kgK9AeN73J
	 eb4TRQ+dyo57/jRPhs9GTDJucL67RmINNHy3O+xptglXyNF7JGHkOFX+t5rxidYFCh
	 kgAz3h7AjtPqsriWHCsFnFdnOE7X5i7NvuYnxupi701uvWOeYgmLhuNCJaSmxW5vPC
	 edAgFNQhHGBnA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso9747175a12.0;
        Thu, 03 Jul 2025 07:53:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/FQVEYwM9J7RfS3PoPeD7k0dyjqhwWI+P5DVEM30cV4Xc4aFmqnLWsz1GreDzWJRtqIQ4pyVnBt76@vger.kernel.org, AJvYcCW0sTV2I63IO8SVWox0VV8nX3eUJ5cIcs3kTLLJ3IobUj5U6U+sBBTo/pLN0Oe5jGDoZ40f2gus/U+Z@vger.kernel.org, AJvYcCWUb7SomjKhWVAh7UjlaeZ9Z4/sF5n+sRKXtBJD1kx2G+QBDAW/mkz44TRz+oWT6ogE/HHUICyRJ7Uskd60@vger.kernel.org
X-Gm-Message-State: AOJu0YzBm+C/VdExb1eQaT6SVHJCkt2IYsRX56J6/OMHtWtAeyHVWrmm
	G4oudOrkS7DRhgawryL09c1XxYG66uVScfOMiQUOUQkJuBMhNjEI9sgD6IS2Ma8cyxk5keJl/Gr
	i78g8gyqstumKgfdhckv2M8IrRutEow==
X-Google-Smtp-Source: AGHT+IF6/W7R/MdVdKSm57lSvwfhmuwesnrXaz+1Ouf3Kgia+HRQDsPWXxDpsPtXTQ0Z1Gxc9bSEIcQnIrE3MFEps0E=
X-Received: by 2002:a17:907:3e24:b0:ae3:aa8c:e8f with SMTP id
 a640c23a62f3a-ae3d8337789mr318025466b.2.1751554391802; Thu, 03 Jul 2025
 07:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org> <20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Jul 2025 09:52:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKejEoHhFNfybJVpimXwCGyc4_hqM4w8F54fFnEdMFb0Q@mail.gmail.com>
X-Gm-Features: Ac12FXxFUu74snwLufqalaVhV3WIbBJAXXqbS-UUZMip9gA7bEBFm5gd5gAC7P8
Message-ID: <CAL_JsqKejEoHhFNfybJVpimXwCGyc4_hqM4w8F54fFnEdMFb0Q@mail.gmail.com>
Subject: Re: [PATCH v7 24/31] of/irq: Add of_msi_xlate() helper function
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:27=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> Add an of_msi_xlate() helper that maps a device ID and returns
> the device node of the MSI controller the device ID is mapped to.
>
> Required by core functions that need an MSI controller device node
> pointer at the same time as a mapped device ID, of_msi_map_id() is not
> sufficient for that purpose.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 22 +++++++++++++++++-----
>  include/linux/of_irq.h |  5 +++++
>  2 files changed, 22 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

