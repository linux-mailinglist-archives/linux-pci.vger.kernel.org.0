Return-Path: <linux-pci+bounces-33263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93036B178D6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 00:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D231655B4
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADCF264608;
	Thu, 31 Jul 2025 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC9pmL4F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06DA921;
	Thu, 31 Jul 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999332; cv=none; b=aDZIK60A42X9tgHU1TAIWdvtJbniJUX6L+tAAaLODm4hJAde/MljV7smoKTxHKilFC5ATyCNIUcccIsV+MKGzIPftS3S9HsfDFg6nH8maomQFXxGCNIIOqMOZtcDyzGAuslvAM3FUKnhrY0hnvOi8FIu1NqsethAtbY/eL1HHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999332; c=relaxed/simple;
	bh=Aeb7LXryARwLKBWxkPeja6oA6N2LlRfpr0knT9VALgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyqTogL0f5oeoOYEqMDrgKy6qQcqyN4+yehDSeqILJ4h4lBN8ptU4/NviQ7gYR2ipIcWj8riD9+i3Jzk/D+V70StyT7a1t1dHbUwg5Eo7foPB091g2xtyGA3TIklQoVq1D3yM8eQP7J578a6D+jluWW63nc/sXrUEY2q+VRBfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC9pmL4F; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b7e35a452so1589904e87.2;
        Thu, 31 Jul 2025 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999327; x=1754604127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwQMVaWAcAPT6hTn2TLzQM81uMg7jcDm6ApBxWtipBU=;
        b=RC9pmL4FuNomzqqMkMO1hf3QJim+zSqksk37UpNUCKbcwyJ0lrN4i2BNTTjaThARGK
         jYNNvsGARe5V1t1qPl9tW2uWbEtXlydsCtI7QQVu0Iowr5AOdhuehIeFJejUV1QOcUG+
         a2LGkTOcvLQXxQFGpwcmN9rz3o1RAAup7vEssgVd8vpr8fK4YsLznZ7/Ple5NRFdobLX
         sVYlxF+3PLdjuVsKZ052MEz3hy/G2b51dZ6AMTrI66UezD9yeobtcZZkNFFv9mYk83Jt
         HG7S1d1RV3s9PjoTmm8tCpBHFHhGMikMr/PcQz6pHg+SGj3xHkA57WQer7ghUznOydnL
         9A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999327; x=1754604127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwQMVaWAcAPT6hTn2TLzQM81uMg7jcDm6ApBxWtipBU=;
        b=WN8STDpRFaVZtVCqonGmDg584XoxOrP0hMWMhddKySkomWE5GDlxg5O+/4OZLrzrRv
         ol0cd4esqiW4oGWp29YsRMW4VI1sms3dKtsws+qf7FhKCgU6IyqCck8Y+ddtABVwaDp9
         jUi0g97c8lfK+ZcUrvBVyig0g9wBGx70fxNHYd/cvnHWjMzmfPmPaHBDVmLAEAbwU8MH
         hcyYBH2/deSELCtI7QYpoGscR/98zp7XAgsNKUlGIddgqJa3OYEXKbwcl7t3byfeRO2t
         5hnZhb2o13rz+i0kVJXtBPBYZKxpnqeNHO4TCUQv2bHGAXSKb6GwzWi15heYAk08mNAX
         bZew==
X-Forwarded-Encrypted: i=1; AJvYcCUScpnLk9y0Y5UCoIZyPv4yWn7YNr6drIzWLW98Q9mb734XqS0scFdf9305COBlRl9y6Stwybir0a/P@vger.kernel.org, AJvYcCW2xCMma0DKTyI48N3c6JZNtMggEkaDStD4R+e2rxoKbcU25m7RLvVM/7JwEdcaHtKkjcYHWw3MLm4=@vger.kernel.org, AJvYcCWLSarbAOqmtC7wENZY3Osrs70bvzbfycAp6nYnfQbBaxTZ5MSGCAaw108tms1rmQ/7uTUoOesTlZ2pnt4=@vger.kernel.org, AJvYcCXCv3bSMdq/6SZpSpkLdOkzU3J4p6ra3RCNCzXRnDPQvC+BqGy80OtIL0dAyDE+fBtnv+3f6jVYqm4VaCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H/JBmB23jvRCsn7zYiaV7V6XszDJ3vZmHzpZyP+PcBu73nmV
	BBrrJ1yvOSa718nIJQcLJxWI5k7kg7uKDHw/dacO3IieMp/yeypdoJ8ecM8jQc9CGn+jlxZ7+ox
	wnvGJ8vz+X4DzRb/y0qx30XUX/KrN9N8=
X-Gm-Gg: ASbGncvknEHuOM5RiOvyWWoLoJWS8aslyxCITbjoYKGX6GdXgQW+rEBaUqjOZCTVXM2
	ZIVcYQ3eR1yVWPBm8tQBZYMbw5/iK/bJ3Ph+WhvxJhRHGOBKXV1Y8G8yXtJxoD60cc9DSwYO5d8
	6BtWmq9nfhJSmDCoC1AvvgH2P5lPj0Exc5nX94TBZNunsMBzxYLgJHKigFFtHBUCOO2mjirOCcW
	bX73+0=
X-Google-Smtp-Source: AGHT+IHrhGtVXBMcgioEqs0gfuEwzuQX+rLjTgYNOrBMMYzGNs77k0w/wsXdSir30vhkHoLper+s/O2Yz39317GxU/8=
X-Received: by 2002:a05:6512:ac9:b0:55b:89e4:fdfd with SMTP id
 2adb3069b0e04-55b89e5009bmr1055393e87.14.1753999327262; Thu, 31 Jul 2025
 15:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
In-Reply-To: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 31 Jul 2025 17:01:55 -0500
X-Gm-Features: Ac12FXxwmer-1j1MzGtCRUP_-g_XXn7WqjPJTHdQH3fvsju2YDlG6pfVQj72Lm0
Message-ID: <CALHNRZ9tOJccZ5sQjvkoPe4-+VUtWRxAzAOUainGUCs4+_RBCw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: tegra: Allow building as a module
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 4:59=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v7:
> - Rebased on 6.16
> - Updated mailing address list
> - Link to v6: https://lore.kernel.org/r/20250507-pci-tegra-module-v6-0-5f=
e363eaa302@gmail.com
>
> Changes in v6:
> - Remove unused debugfs cleanup function, as caught by kernel ci
> - Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-0-82=
7aaac998ba@gmail.com
>
> Changes in v5:
> - Copy commit message exactly word for word on patch 1, as required by re=
viewer
> - Delete remove callback in patch 3, per request
> - Don't clean up debugfs, per request, which drops patch 4 entirely
> - Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-0-08=
8b552c4b1a@gmail.com
>
> Changes in v4:
> - Updated commit messages for patches 1 and 2, per review
> - Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-0-55=
6a49732d70@gmail.com
>
> Changes in v3:
> - Add patch to drop remove callback, per request
> - Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-0-c1=
1a4b912446@gmail.com
>
> Changes in v2:
> - Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
>   building pci-tegra as a module for arm
> - Drop module exit to prevent module unloading, as requested
> - Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-0-c0=
a1f831354a@gmail.com
>
> ---
> Aaron Kling (3):
>       irqdomain: Export irq_domain_free_irqs
>       cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
>       PCI: tegra: Allow building as a module
>
>  drivers/cpuidle/cpuidle-tegra.c    |  1 +
>  drivers/pci/controller/Kconfig     |  2 +-
>  drivers/pci/controller/pci-tegra.c | 35 ++++----------------------------=
---
>  kernel/irq/irqdomain.c             |  1 +
>  4 files changed, 7 insertions(+), 32 deletions(-)
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250313-pci-tegra-module-7cbd1c5e70af
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>

Continuing the conversation from the last revision [0]. Is there any
path forward for this series?

Aaron

[0] https://lore.kernel.org/all/CALHNRZ84Xj=3D_HqrFWnYHdV-A9YM4yu2FhfYgHy4-=
sR65tsYbUA@mail.gmail.com/

