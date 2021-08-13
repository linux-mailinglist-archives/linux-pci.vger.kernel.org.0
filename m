Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805FA3EB633
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhHMNqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 09:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240654AbhHMNqY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 09:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4821761139;
        Fri, 13 Aug 2021 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628862357;
        bh=EeUi56ckdIOJ1FigLpBTvp288V0VDz6TPWb/K7uw19Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y77V+g/QCxA9W5CuhWYiq/iyFiDxYmMWQIhl/IrFE3E+ORsAxs/FOU4MYxXc5TpAx
         +2MFZrryhLSxP993y1eMAewgHk/7Sycyiiq7VUf8u2rRfVbiSu/Ehd8C4ZpwWW+lvG
         s3fnxEGwC1UqUK70fENXPwjAjbCi3ahnTbJNGRBQopHTW/CJXuk476mD9+LC6BHRjy
         Rq/N3zVg/tMcTJhjJpkpiENnmFTMYMhJVanh1ZPEXF/TBGfjSDwPkuK+jwUSNR8vsc
         htCi2kP8hb2+Hpt63BWA54Y5tJrix+Aqb3dUq1iqs6XVeIODEEHdETm6hYTTxO7/PJ
         Ocuz90Lnxx7dg==
Received: by mail-ej1-f52.google.com with SMTP id u3so18442164ejz.1;
        Fri, 13 Aug 2021 06:45:57 -0700 (PDT)
X-Gm-Message-State: AOAM531YIrWWGYDk6h3N8eayQvjxsQBJU+//EUZgt7ahAlgBPBIf0oyh
        Qm5zJA/DSiFNHeGCPPouJEfOqiFZNRssSRYj2g==
X-Google-Smtp-Source: ABdhPJxxWttkbdBWX8ZKSgLQqFULtwlJIpWYYEFhpKUkIwyXS4wzCmpMsQQjP1T/EycbKePdrTrQ68PmxuaJ4dAcXfQ=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr2516158eje.341.1628862355806;
 Fri, 13 Aug 2021 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <m37dgp20cr.fsf@t19.piap.pl>
In-Reply-To: <m37dgp20cr.fsf@t19.piap.pl>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Aug 2021 08:45:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1bPwbPB-3y6s0d6XoNkjrSzpbx=p7BcTq8UyTbh8pvw@mail.gmail.com>
Message-ID: <CAL_JsqL1bPwbPB-3y6s0d6XoNkjrSzpbx=p7BcTq8UyTbh8pvw@mail.gmail.com>
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 3:52 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wro=
te:
>
> DWC PCIe controller imposes limits on the Read Request Size that it can
> handle. For i.MX6 family it's fixed at 512 bytes by default.
>
> If a memory read larger than the limit is requested, the CPU responds
> with Completer Abort (CA) (on i.MX6 Unsupported Request (UR) is returned
> instead due to a design error).
>
> The i.MX6 documentation states that the limit can be changed by writing
> to the PCIE_PL_MRCCR0 register, however there is a fixed (and
> undocumented) maximum (CX_REMOTE_RD_REQ_SIZE constant). Tests indicate
> that values larger than 512 bytes don't work, though.
>
> This patch makes the RTL8111 work on i.MX6.
>
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c473d75e625..a11ec93a8cd0 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -34,6 +34,9 @@ config PCI_DOMAINS_GENERIC
>  config PCI_SYSCALL
>         bool
>
> +config NEED_PCIE_MAX_MRRS

We don't need a config option for this. It's not much code and it will
effectively always be enabled with multi-platform kernels.

Rob
