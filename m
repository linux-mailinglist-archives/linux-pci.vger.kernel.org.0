Return-Path: <linux-pci+bounces-13762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D798EC18
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E41F21D37
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C07142E7C;
	Thu,  3 Oct 2024 09:13:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A713DBB1;
	Thu,  3 Oct 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946814; cv=none; b=BR6J/9kH94aSeYSE6cIezzbQLCmY6dFV76DvA2BR9U4DW1z39IzBs55K4l4TV8FoG+4Pxv/Q8pV2vLkEUISQzIuAvgkjQqG0MTnmP6M9BnwqCkySEH8rUwgmvrqZ3jBa2s9ExlZ06+1rPomXqVjfwNWoex/z7WebNmS3oS42TYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946814; c=relaxed/simple;
	bh=NXCM33NdXsSEuRRLpBcQcMOtIahHrw3gOJde07MAaq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkB1E9vW86R49GTCmyKlPTHMF2XIlgXrgaLcEcBObgPcRDn9qk2dqNV+IozbUygCXxmfYb9uNoY0dMQ/HDynyirC8cUXceNMkXPaW0u3DOF4DbtOfN96yZBoW5iOiMjXc6iE1MySTZNmU6juRJTIcLjQTrKxhdt80vYqheNbzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ddfdeed0c9so5664027b3.2;
        Thu, 03 Oct 2024 02:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946811; x=1728551611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7WgvebXXsaRMnWziPr4x8Pj8uGoCS6EaJvHvtQmBuY=;
        b=skiEfA82QesGYJog62JU63cMx1yyt7EdfbhvJIsRGZXuzYzhyOJGY9KS+tgsmNkJlE
         rKVN0/KoKIqFlWIqBsOTsXDCI+YwGOKKKScOQKnZhre2l/P8ML447jnzPLHs7NOl4aZm
         5RYuQe8EgMJnp5S9d/z71owjSb2FCYdi90833HGsbz2mp++AxHyAh9bPE9NP/4BBmwM+
         me4Lsc0gX4Yh5X/8TntH5RVuhIBhlEzGoTTPnpOJl5GLiywVEoWreTb5E/oaj6oO9HRx
         rOgs+q8256or7lEpLATxZrbCe8Xxm0x/ugF4LTsD64HT7j0VdrxxS/P7lJ5nKPDtHOUP
         19YA==
X-Forwarded-Encrypted: i=1; AJvYcCUGur2MGfdOCjMsx/AkG1Wmxjbod5bU1S4XQWSSg/ZwQ4HSLlFPGT7xTZuL3T2wDXy0N2ifB944I8ftf6y0@vger.kernel.org, AJvYcCWWzVWB8phuSQkvgVdortL4/uSL8tVcelnb1jwOnf+6z78s719jQInlEN0I/NUp/Xk08YVWQFb3@vger.kernel.org, AJvYcCXRqWRrbB2mkLYysLuNkpzKgQiClx8IvTE33MIAyeAXV7uCMgHl/inQj0HRjMixDq/S6RmjH+sb0yrv@vger.kernel.org, AJvYcCXqLmCLpWR9LYYSGDj/X2bRzdzBlSZ3/RIPhCYveyhPdXbOgF8bc5bgzYdI4Ubd8SGt/3Oex0gmxQe4@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtPd0ImKYp2kLFnwENb0bhkkdFahehXcFj8MZMeONufcmqnwe
	0TsxQHYjZrLTF4gf0AO/SsyhfNZ2e2Y3ut7yOT2gW89aaewWbci8hORumuniAYU=
X-Google-Smtp-Source: AGHT+IGn18KDopn5fANqBk5+McBjmh6uePf8h4ryC2QhJR0RNJaG/0M5ek3KbypWMR3DGEBkmK/ztA==
X-Received: by 2002:a05:690c:b13:b0:6e2:83d:dfd9 with SMTP id 00721157ae682-6e2a309f315mr62025137b3.44.1727946811113;
        Thu, 03 Oct 2024 02:13:31 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bc2d1de6sm1334357b3.68.2024.10.03.02.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:13:29 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e232e260c2so6053897b3.0;
        Thu, 03 Oct 2024 02:13:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+vvUfrvAOYPhCbgy1OcVfwxSR64yz1OIrTbiz7/Ikj4LpElzYKdcB8cC4idfggou8Ki0FVxXSA6iQt3tz@vger.kernel.org, AJvYcCV0jO9Sst1ZcZ4T+SIY2g6UwAtW76oIWHxtA2A/HoGac7fbTGxye45m/YO+/rMKDrXlh5GO16IcJ8C3@vger.kernel.org, AJvYcCWJhotmCwgW8t6hvs1hfVawmel2bVrXfAuHhjfnFWxLwqh4UaWeXQYXemwuJ8wHCOh94lFfXIg3@vger.kernel.org, AJvYcCXF4Ag7lK4fYaqH2jmWHYct9Sfb4wXkrox76ebUdhuYocx7KzgM/+6Jfnwf7UeXOhRIYRlijganGRzo@vger.kernel.org
X-Received: by 2002:a05:690c:660e:b0:6e2:636:d9ed with SMTP id
 00721157ae682-6e2a2b72c98mr51489427b3.3.1727946809298; Thu, 03 Oct 2024
 02:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003081647.642468-1-herve.codina@bootlin.com> <20241003081647.642468-2-herve.codina@bootlin.com>
In-Reply-To: <20241003081647.642468-2-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Oct 2024 11:13:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=Huug5Hip+CCma8pzo=AHAeWtzPES8Zu-qCBAJ0Ng2w@mail.gmail.com>
Message-ID: <CAMuHMdU=Huug5Hip+CCma8pzo=AHAeWtzPES8Zu-qCBAJ0Ng2w@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] misc: Add support for LAN966x PCI device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, 
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, Oct 3, 2024 at 10:17=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
>
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
>
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/misc/lan966x_pci.dtso
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Microchip UNG
> + */
> +
> +#include <dt-bindings/clock/microchip,lan966x.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/phy/phy-lan966x-serdes.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +       fragment@0 {
> +               target-path=3D"";

Nit: missing spaces around "=3D".

> +               __overlay__ {

Unfortunately we cannot use sugar syntax, as sugar syntax does not
support empty target paths yet.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

