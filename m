Return-Path: <linux-pci+bounces-811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D135480F69D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 20:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C2EB20AE3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B181E4A;
	Tue, 12 Dec 2023 19:25:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6394;
	Tue, 12 Dec 2023 11:25:28 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da06c505ccso770537a34.1;
        Tue, 12 Dec 2023 11:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409128; x=1703013928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoyxJ6X4P/iKcYssHVUQvgFoC/dIcRS9b6OahyFAXwA=;
        b=hvf7u+Lrfh7HvRPupt0uLrNXdXFHtulwV4aymEkr8/bb+EV/D/So8MtgQjc2i9qSPF
         ZZxpz7VS1kgtBO5ZHcVYUDFiTz4Uk19MSshqjkZW4Q2mXiIY7NX5CWpPbp3j5qzBgLhU
         cUiOqNHgoIcFVcUcstSqIUc3wMtUNJyl2IGctDghTQld14GX35ZKJr9tY5b6z+5vF4HV
         QTxWwoxF0N2IsGaaxFA25AF/+S1yaU2qP9UQRK7po1zjA99IJul5+tvdeesh/InRibxQ
         aKAI6UBSauR9tuI1BOY4agA/cI9tsHmDL3AvmGcQjYTjl9jtwZdv0fT4E/d9yxYPKBe0
         PVYg==
X-Gm-Message-State: AOJu0YyBrwfMU5LEYMgTGIstr+gN8ZUNsEgCpC1O+/StN1G+syAEj3tO
	7cwdLeGYy3uaRai7jdjC13T4BCXKQeOe0rCv/oc=
X-Google-Smtp-Source: AGHT+IG+R/2dDVOAo8hNe4uTtuQoUVfj41bgYhEqgafqLkVHeNbFeZgwQy5dNh9liMdoGBMx4RX7bzlFAi1Xh1e9A3Q=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr11243353ooq.1.1702409127732; Tue, 12 Dec
 2023 11:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203041046.38655-1-mario.limonciello@amd.com> <20231203041046.38655-3-mario.limonciello@amd.com>
In-Reply-To: <20231203041046.38655-3-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:25:16 +0100
Message-ID: <CAJZ5v0g_HWFnt0a5fDnb73Q14C84O+RPYVF104TDK7T_Ox3_EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	Hans de Goede <hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:07=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
> port it is ignored because there is no upstream bridge.

The kerneldoc comment of pci_bridge_d3_update() explains what that
function is for which also covers why it does not take effect when
called on root ports.

> If called on a root port, use `no_d3cold` variable to decide policy

It is unclear that this is about pci_bridge_d3_possible() which
applies to both D3hot and D3cold, not just D3cold AFAICS.  I don't
think that no_d3cold should affect the D3hot behavior.

> and also immediately refresh whether D3 is possible.

Which isn't correct AFAICS.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 72505794cc72..3d4aaecda457 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3023,6 +3023,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (pci_bridge_d3_disable)
>                         return false;
>
> +               if (bridge->no_d3cold)
> +                       return false;
> +
>                 /*
>                  * Hotplug ports handled by firmware in System Management=
 Mode
>                  * may not be put into D3 by the OS (Thunderbolt on non-M=
acs).
> @@ -3098,7 +3101,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
>         bool d3cold_ok =3D true;
>
>         bridge =3D pci_upstream_bridge(dev);
> -       if (!bridge || !pci_bridge_d3_possible(bridge))
> +       if (!bridge) {
> +               dev->bridge_d3 =3D pci_bridge_d3_possible(dev);
> +               return;
> +       }
> +       if (!pci_bridge_d3_possible(bridge))
>                 return;
>
>         /*
> --
> 2.34.1
>
>

