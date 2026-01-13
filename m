Return-Path: <linux-pci+bounces-44583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFDD169D2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 05:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3823018F6F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12861313532;
	Tue, 13 Jan 2026 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXRa7dug"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0025BEF8
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 04:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768279614; cv=none; b=E2BXLINwD5F4NQnVD/qgUZsyZ+/PCcpnokLAb9WZgm1lXWM4+8XEKEQEmWnf1Ixax/GorsGMoBvhGEbhQIYTCWCevH4MQT9CAbXjWbdEh4swm9xhFLESGK6VdSKmWd4YMrz8HXfAvH4g0wMdh9zpwX9b6MbyXyWrZlJr+L1utNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768279614; c=relaxed/simple;
	bh=aGBQ+yN8ubeLgAJtGA586Zb3Qf9KIiiRaq0ACQmKZng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbm3OogIosadgW7mGnhDckxY9k2xGha5sQkW5y6mq6v3Ixaia56I8tNQKBGarNmmG5GGQlx1lbigmpdQmj812Fep7+TSfpgmCfZVPU6bNjFtzSmvOYdcxmOtrlRCUP4bHa4gJ4rME9RW0phtqXwuXcCb8GrJxqq0o/Hn/MOdx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXRa7dug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5985C2BCB8
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 04:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768279613;
	bh=aGBQ+yN8ubeLgAJtGA586Zb3Qf9KIiiRaq0ACQmKZng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RXRa7dugM6fdw2HEF/ybFcJPenOCEIh84sUeZTh3XmSqPxwZ/+8wWQrQ2zoW1B9UP
	 Q804xoUsXlRp0emrsMEEopiDQaKf2c3JFIrarxU1dK8q8TkTPJ97Dc6ce6P7Ms1Qhi
	 ose3G6QxaJrGUCPnOpxG5nyi1pJi9PfF95BJLQG+aTIJaa2YAPIGAWJtwa6ZwtTK1M
	 4UfNRK9KYM+S20fQL8b3RMOsFrXKk+th7tEHUejKBopjX8BFZR+71eI1sc3wx1kNYY
	 2sI/rbhxmIUuhQ1UegfCOuMzYq/o55JkwTinhSImFul7OmWsAEG/aLzMy+gR3p5Eki
	 j5uMlvfslL4cA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso14974458a12.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 20:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3TLdCSVpmx5x89nfXHHCAYgcUFCPMBv9BevAjlfBmb0ZowHjatsxVbju12exuFL07NChMgn0/Lss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4J7cNTV8r07PGBIaTROCxtdXbp0DxmGII1Vu66SzaGuAwAXg
	+WOOavV2FYyhK2xIwr3PnIrGmHQa7MW3vSKur9BEpz3kNMkwN+EOEXDDf9FZhmPYxhZMSVefrV0
	a8XLZVmP7j/CWtQGRUX4PPJX37psFAPY=
X-Google-Smtp-Source: AGHT+IHxfmFJnwol2oFof4hU9TKfRglrHo14dFqXfwgac4v0J9+cVkh7Jag2ZA+XnbdjkcnYAZrqM3frQ6/yYLWwuH8=
X-Received: by 2002:a17:907:7291:b0:b87:2f29:205f with SMTP id
 a640c23a62f3a-b872f293a6amr266193966b.0.1768279611917; Mon, 12 Jan 2026
 20:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com>
In-Reply-To: <20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 13 Jan 2026 12:46:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4o4ULmN1wc93tXfHghGUd2pJ-yK5u-P-OrZzHfbKs76A@mail.gmail.com>
X-Gm-Features: AZwV_QhazdGa9hg0s3-mOXd-XVzsCSMYGXF2I3YfQAw54s8Rsn2hAsgPrJgAwng
Message-ID: <CAAhV-H4o4ULmN1wc93tXfHghGUd2pJ-yK5u-P-OrZzHfbKs76A@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
To: liziyao@uniontech.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com, 
	Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ziyao,

On Tue, Jan 13, 2026 at 10:39=E2=80=AFAM Ziyao Li via B4 Relay
<devnull+liziyao.uniontech.com@kernel.org> wrote:
>
> From: Ziyao Li <liziyao@uniontech.com>
>
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
>
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
>
> Also, amdgpu reads the value by pcie_get_speed_cap() in amdgpu_device_
> partner_bandwidth(), for its dynamic adjustment of PCIe clocks and
> lanes in power management. We hope this can prevent similar problems
> in future driver changes (similar checks may be implemented in other
> GPU, storage controller, NIC, etc. drivers).
>
> Manually override the `supported_speeds` field for affected PCIe bridges
> with those found on the upstream bus to correctly reflect the supported
> link speeds.
>
> This patch was originally found from AOSC OS[1].
>
> Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
> Tested-by: Lain Fearyncess Yang <fsf@live.com>
> Tested-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> [Xi Ruoyao: Fix falling through logic and add kernel log output.]
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0=
433d73175a17f493454
> [Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-l=
oongson.c]
> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> ---
> Changes in v4:
> - rename subject
> - use 0x3c19/0x3c29 instead of 3c19/3c29
> - Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5=
ae3ba93@uniontech.com
>
> Changes in v3:
> - Adjust commit message
> - Make the program flow more intuitive
> - Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e=
57b6ef8@uniontech.com
>
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aab=
bd11fbd@uniontech.com
> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongs=
on.c
> - Fix falling through logic and add kernel log output by Xi Ruoyao
> ---
>  drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index bc630ab8a283..3d0873b63cd6 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -176,6 +176,44 @@ static void loongson_pci_msi_quirk(struct pci_dev *d=
ev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loo=
ngson_pci_msi_quirk);
>
> +/*
> + * Older steppings of the Loongson-3C6000 series incorrectly report the
> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
> + * from 2.5 GT/s up to 16 GT/s.
> + */
> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
> +{
> +       u8 old_supported_speeds =3D pdev->supported_speeds;
> +
> +       switch (pdev->bus->max_bus_speed) {
> +       case PCIE_SPEED_16_0GT:
> +               pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_16_0GB;
> +               fallthrough;
> +       case PCIE_SPEED_8_0GT:
> +               pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_8_0GB;
> +               fallthrough;
> +       case PCIE_SPEED_5_0GT:
> +               pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_5_0GB;
> +               fallthrough;
> +       case PCIE_SPEED_2_5GT:
> +               pdev->supported_speeds |=3D PCI_EXP_LNKCAP2_SLS_2_5GB;
> +               break;
> +       default:
> +               pci_warn(pdev, "unexpected max bus speed");
> +
> +               return;
> +       }
> +
> +       if (pdev->supported_speeds !=3D old_supported_speeds)
> +               pci_info(pdev, "fixing up supported link speeds: 0x%x =3D=
> 0x%x",
> +                        old_supported_speeds, pdev->supported_speeds);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19,
> +                        loongson_pci_bridge_speed_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29,
> +                        loongson_pci_bridge_speed_quirk);
Sorry for my ignorance in the previous version, these can be put in a
single line.

With these changes, you can add:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Huacai

> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>         struct pci_config_window *cfg;
>
> ---
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> change-id: 20250822-loongson-pci1-4ded0d78f1bb
>
> Best regards,
> --
> Ziyao Li <liziyao@uniontech.com>
>
>
>

