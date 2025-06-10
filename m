Return-Path: <linux-pci+bounces-29283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF7AD2F95
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D044316EE3E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9928003E;
	Tue, 10 Jun 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r6M4FAOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255022DFBB
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543116; cv=none; b=r2PNhWXvMiOpZzq3vlTESii94v/kjq7FrJJrUzuogMV6aPE/H1zT5za66lhYIp6NYBlQW0D/jM1g8xLLlc9mEVD4QC4yBOjoCo4GT6eyauAyPXfVRqNfDmCUcWanBgIwETiPi8hwvVCMvQEiThZpMRFcqbKCAT8OEv8ExHtqQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543116; c=relaxed/simple;
	bh=UTQFUFyTCloQz9r22/rAhw6t2ufs+YkZOF9i5ZRNggw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSI7BHvhGAlzDbRLgYQeHRs0AlrjPGcfeJaPpCFtFuT+ycrQeu1W/PnVlv4kPt4mxzk7jyqt9eZegnSY+RLkTKbAQ/EGxCkVqdyNiyBZomLcnDdXC8vgNnarj6CWiU2UC/Xdp/S2tqq2coUkC/7Grs1mOCoRqx3I7t0vPSgomFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r6M4FAOy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-551fc6d4a76so5508584e87.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749543113; x=1750147913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJtbghu5MjLd9wlOORYf6KoYba3Vp+Epa5mRcL/Qk+k=;
        b=r6M4FAOy0jzOe8cidAbMdDFcFmucAZwkAGH/4lDjf+0ySc8ZSMtYRYQIWk2FE85+Jx
         Xr6WRdCOA5EBtRkri7GB69srh8/V1bWnGGwgttbaMEZfBO9aMtOujYOMsittBUNYZsTh
         VB6rDIdKpJ/X5UMdpoQLdTHYktmcuYaKS21FZBv5dujozpeoAb0Bt82uUaMp+JkVpPIy
         HFcxCgt82Q5Ss89sHLPUSFdzKRzZooyjMUHGx1mXYn4XbG0mOaajHXonNpMBOManWW89
         4SFrlAF87wKY04Z01Lc9d6aDrjpPF80YVxReT4WCQOQyaUmEE46G8VHaOA6UwVIJtDDq
         jnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749543113; x=1750147913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJtbghu5MjLd9wlOORYf6KoYba3Vp+Epa5mRcL/Qk+k=;
        b=AdH0xax4aW6GhvPcO9nQpnfmQJoXm3F7KKbtryZ05uohiZduRC6F7fOFfShWyvmK0f
         Z4sc1qB6HXM9K1FyjJkrdJgB+azs+riCvNY6j+LuqNAHWyO8kxy9WcP2lzvkW+ucicr2
         bUs6lkNq+U9ZhZDpIJyU3SzrDKPyMgLYrjdGdbgWjUkhdYLU4dxC2ErRB06RJZbmtzNp
         TiUH3mv1ltEwjbJZH2KgDgiuqzj4/27ZtXKkuK+sDFhw32rEbLWUpZtTCLOYWBGbEpe0
         eZbwDPL21/xYwcVpRBD8SbET+6eO3PzXWPuy8Rfr95s/u30L77m6zo2Na/u/1BslJxBe
         41mA==
X-Forwarded-Encrypted: i=1; AJvYcCVL7I6VvAJINmUgfpj23ypSlGfmOp25AxlrxRpIvsJOG5z7d8uQAP/Xmd28yhK4VRIGhwknsBOC5a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R2qkx11PR0iVDJpDz1ziRJFqjyTjDS64fmnuN4MiKZYDnyoG
	fR09aaBLRCUUvzXWXh1kYebc131PPd1fnafpD3yi+eEfCIjhQzSnCv3stVTc0KL1ZTGgYIfT12H
	jDghhxBJHo7NnTDjVbdmNWN51hgzpJ6IyIz0ueXz2ag==
X-Gm-Gg: ASbGncuvxNLLZjr3/apvsfGJwAW/5PeAkwcSDK6CLL0J0eQFZ2JUwc/PNlad4/wwKpD
	8bopfDBtAUuRh7fFJ21aesyOp89CmvoW3WdKASaYLGdbo7JVwEhg28Lg6lT2myfHmyx4k23Ymwa
	4oVhO0uOCaYJeVTRsgmkKt6tiyC3CO2co78tXpP6cO7FOPGqKvdrzFsmJICga466o+LbWSQOmV
X-Google-Smtp-Source: AGHT+IEdcUwTs67oKYNKfNvvDZgkO7SOMiRX1WybDEE10tjxivAeZ04qb8n5eXb9Kvqxo7q26bda9/VNxF/tQA2U5XE=
X-Received: by 2002:a05:6512:689:b0:553:33d5:8463 with SMTP id
 2adb3069b0e04-55366beeac8mr3710105e87.24.1749543113066; Tue, 10 Jun 2025
 01:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
In-Reply-To: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 10:11:42 +0200
X-Gm-Features: AX0GCFv3_axzdZrKIaygxDW6_olXhlmKsx4lOsipYwivzmRNW4tQb2DarqWo3sk
Message-ID: <CAMRc=MdbA9i=SRyPV8jtHqoxgPobdsKCCWgyhMH34=Y4eHrkaA@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset()
 failure
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:38=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> When devm_add_action_or_reset() fails, it calls the passed cleanup
> function.  Hence the caller must not repeat that cleanup.
>
> Replace the "goto err_regulator_free" by the actual freeing, as there
> will never be a need again for a second user of this label.
>
> Fixes: 75996c92f4de309f ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

