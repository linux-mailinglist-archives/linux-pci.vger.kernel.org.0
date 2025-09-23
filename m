Return-Path: <linux-pci+bounces-36797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE2B97231
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF7C2A07F1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C87286D4D;
	Tue, 23 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/KHlXO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F842DF12A
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650199; cv=none; b=lhS0vl0IOSrF5AumqcftOPL0qJKGtUOzp7TQzGNq6MqzkDxJfQwco//Y7iVPp9ZxDkcuWrc7gaaTytzcpERxt1pC0x3mu+CQp4nBaZJISdN7f/N+Q/qTIqpRDVxWnSzJgMaXXx0CqQgR/92bf43C/bc8GGsXSU8SrVQhvPan/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650199; c=relaxed/simple;
	bh=+2VyYQWo3bsBibTZIVLx3nWadN0J/BZKQdGjMX/uX1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFAW5YfsT47YSXgQoajvDwn4etSjzWr6JO53qCfYM7y3Dm2INdBZ8ZiF7pZfPcfHbsGRbAHOq6VC93Iq7ucAxxvCdQd7rntyPUMIifhRNBBOBfhg2kH/W0+LN4ULBYX0SpxtjYF0LmTL567CIOOljPILaOjsitYyI2k7wwYtQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/KHlXO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72eb001d0dfso3769577b3.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650197; x=1759254997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=Bf/KHlXOgjHZvLypdVJ6KMhZjIsdWPT1SZTuztKu1b9MKovaRA45FM+cE+YgKik3dW
         pGv3jcxcdsP+BTxn2pdGcCJAkAF7kP94iBGwtO5DVjpdoskAM4XXZyfhR6u3mFHESvet
         KmcgP70wG9G5atqoxuTdzqaFO4GGtzMQlR2r2idBRDpP5q1V0k8fjrDPTOlrclbTAm3g
         REjrHMurtmFUh83Vq+namEtqwudN/wBipDBNc1+clSSwqMnXDKpSI8YKkU2UqlDaLO5t
         /NIEGbVzlFmEXHvLlNi4pHP/mHspqS9tMR10pP+H/I1lXgfwyDjhcwG1PEZmGGzJ9yh4
         sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650197; x=1759254997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=FkF/VEbAhlBwPObXX0h8wKA/CSfix4v0NBHLbBebN+u5sD6yaK9zGxAibiAwhkeVJa
         aJEZfOBpr/Ffv39Fnm2r4dTMAbGlGs655rnYYtvCfIVVTaxYm0lt544VJ412qJULIgl/
         oa19VtoMpIyIySp4ZhRcA42tPSjw8mStR8jzOeHOZiOouwxot2yrlq1+VIdZUPrylbfQ
         qC1Tk+vFxMDDHA+2nbnSvCUkcHdckvLRNGQzx7kUvQQFbsiEdCwmute5hDwbRKdXOxSv
         i02LTCKl9qUzUjFR2u0gGyQ8p4X9s0mudOB5uzVuw4Qzo+EVfEtj8usDwMD3mhUUO8nP
         37tw==
X-Forwarded-Encrypted: i=1; AJvYcCUSY6INYE1MKbGpRWRPQ3q3Y2XpUu/Jsi7WR5ikxssEtusOuCU6US/C0g45jkT5oI37Crs1c7U+Qs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE4Z6RJiGWJ4NLlc2bBSbgyNgD5lqWYCjAYUM4dmYUii6kesT
	vbyBmGYLHzeujK3wxr7pkmv7qQ6QMFmAYt9eIiT+5sTEekKXVC+H4dVPjev7ylWD+vmEmi4w2KR
	JR0kJzoMyZrjcJC96p0mqa5X5Zpmo3h2KmQYA6PM=
X-Gm-Gg: ASbGncu5zoZQLAI2zeWKK2IwUPDOV1vgw1q95NrE0ZVkP97XpNS/ljaGgH160zED5Hc
	9yRXLOcYjhjWDUTTGLSbCqg1JGGT1vBOgfCeFhgSK/znnIxFvlTU16cY99yXscu5MLQYNJ2+37j
	syPVRUqC6gfTRo7hfcPWCRNszwERqniMvSq3WVuWo4BkNWo8g29KvEHnXmo2y0YgtGwkdtplcM+
	nPn+cHz/aE0oPzvFhS+A7MZxkkQCjggCyLDlKL0L51XcG6+BPI=
X-Google-Smtp-Source: AGHT+IHFYFnbDFoI8nXPm/DbKE6WwSpo1v/Alo1pPkP09kUWL9d8Oowjt7g3OspcbiGB8leMO3y3rMrtwX3aXsOxGiM=
X-Received: by 2002:a53:e035:0:b0:628:3892:b666 with SMTP id
 956f58d0204a3-636047726bbmr1466398d50.5.1758650196488; Tue, 23 Sep 2025
 10:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
In-Reply-To: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 23 Sep 2025 19:56:12 +0200
X-Gm-Features: AS18NWARQQsHpK2MdVqC8zgUyvOCYrPAmI9se1FvWZJ1HDiZT1pR2BaT5dqzbC8
Message-ID: <CAPAsAGx6C4PdODuTVxc2un=wpDC1azcO5GUa5cH7KwC=bHF-7w@mail.gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:10=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> From: Brian Norris <briannorris@google.com>
>
> max_link_speed, max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold, we may see -EINVAL or even bogus values.

I've hit this bug as well, except in my case the device was behind a
suspended PCI
bridge, which seems to block config space accesses.

>
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
                       accesses

> rest of the similar sysfs attributes.
>
> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_s=
peed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..160df897dc5e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *de=
v,
>                                    struct device_attribute *attr, char *b=
uf)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
> +       ssize_t ret;
> +
> +       pci_config_pm_runtime_get(pdev);
>
> -       return sysfs_emit(buf, "%s\n",
> -                         pci_speed_string(pcie_get_speed_cap(pdev)));
> +       ret =3D sysfs_emit(buf, "%s\n",
> +                        pci_speed_string(pcie_get_speed_cap(pdev)));

pci_speed_string() & pcie_get_speed_cap() don't access config space,
so no need to change this one.

> +
> +       pci_config_pm_runtime_put(pdev);
> +
> +       return ret;

