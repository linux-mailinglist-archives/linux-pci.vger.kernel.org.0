Return-Path: <linux-pci+bounces-7034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D278BA917
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784D11C216D8
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0D14F9FC;
	Fri,  3 May 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJiJaRvm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77114BF85
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725777; cv=none; b=qkZ2iK/SxT4vBNatwnZHFqrZJ/uw12YErLGEQEB6OVOmqndqr0hgV30WcGNFrIjBAG1X33pVhp6nbCQbPEmWflOxJPMKBR2VemI6tn0ruxP9HzpAp6uDhLWeGcU+uKC5N4Z+d5PJ4m5Y0icFsAG/gstylRvV8zg4i7kJxML+0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725777; c=relaxed/simple;
	bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVWNxiU59Vt9hpfOqo2ZM7aP7FmR4d1Hx+EkUKKG1MMU8ThSpCPxMBqgTNnOx9VdOKu1eWblpuHFSh3lA+jGy5Rdh4NFcZz6CLGhPjVfGoSsD0uEOwYWe1Q6ElHfGGbARgTAk5ET9OYhBjJ1GRYYqQRYpOPSQfSK//ypPHfyDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eJiJaRvm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed0710c74so8236562276.1
        for <linux-pci@vger.kernel.org>; Fri, 03 May 2024 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725775; x=1715330575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
        b=eJiJaRvmxNaZPX0kTSDWdnC5BQ3dnlSzDiL6AQ1yzeL+wdcotruyKYEfLY1NQKSChg
         /HZ+LzeqTvFmlOL/Bt6pgNa+19su4WAu6v/D++8BF13obL7OCdGmBbW0jW9rmBlSlkjD
         gXJSwA2jQN2bXn1cJ5PBrONjqOWhyiSfZgqD7e6pHCVd/s+Au4ZAXkzdjpms/sjDfc9Q
         qbhdNvVGNaSSLh5NSXR31vkK5+p0xUOLcbcbZ4O7xIVV7vOCsyror9im69c+UVe7gX4V
         CACc4WmRLXtJQGH+Y2lVpZ9W1yzooY2vIUvq98sAPaSjL8awAdrWqZZXgRnZh5Vygwnn
         Q1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725775; x=1715330575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
        b=fHS56vJjgx7vNiyGN3a/bHn/69QPX2kjgjYcrQXKKAzu+TjAqrMIWrJ47KfwV49e+0
         wb7uAAtDlFwrUh1ib4i/MSFzJ6Q3uLt7/wnxdZfp79Y7qVCgvhj7YoYgj4zPNPxfINyC
         8rYGD6/tgWnXUxrXiK4zABFNq1uoJtvJMMUZHB3SDBy9LwsLz/Xp/4Zt9ucwCtaWDK3z
         Ehk661568T6hV34ESdQBGOdC0nHtkdS/FtbjgrkyphdPfX9zBxVLzbUMtB+vpAs0KFah
         CY87r4dCiYFj9bwwr1pMDxtLeFW30eXd+KsOBJhbHvulzbW4uvCmUBJ68jtYvHE1bIli
         6gBA==
X-Gm-Message-State: AOJu0YzZ2nqw9S+oE7F3qQn3vAInKwua0rh3xd/2+ukwLTr/J8e/HxRm
	Y3m3yF9RBbCYRW9ru49cceusJMt24uVuQNq6eJrZQlrUaAMzKlJYM17nW7AL2WRsJ2jLOPZmkUi
	b8Bd7ncspa0BrUFybyA0RJ6nl7uzk7Ho2kxk8KydU6zJjftUr
X-Google-Smtp-Source: AGHT+IH+xM1Y3m2/Fg9Cmc37kiLV9wltbt7f2AaSfD4H+YQIRzjErYhT3Ir8KdVsSLZ1dU5gJ3R8la+SgTZXFWbPKBY=
X-Received: by 2002:a05:6902:250e:b0:de4:78d7:3ff9 with SMTP id
 dt14-20020a056902250e00b00de478d73ff9mr2676714ybb.29.1714725774825; Fri, 03
 May 2024 01:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-6-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:42:43 +0200
Message-ID: <CACRpkdaG8CYoGbEa1AG0bByd-oTWcnfKChn2F1QsdnUHLkoX+g@mail.gmail.com>
Subject: Re: [PATCH 05/10] PCI: ixp4xx: Use generic PCI Conf Type 0 helper
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Convert Type 0 address calculation to use pci_conf0_offset() instead of
> abusing PCI_CONF1_ADDRESS().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Looks better indeed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

