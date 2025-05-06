Return-Path: <linux-pci+bounces-27277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9338AAC2C4
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF23522684
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D3279902;
	Tue,  6 May 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bopRE1om"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDB1FCCEB
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531186; cv=none; b=H3YLtplKzKfQGhBF1G8/pwSCCuYzKcyTlyl35NDMR29AfANWfFRF6nVXjED12FPkeEmzt/N3gbrjAqSYOiBxrlFHL/hiVocQqsgPK9LJWVKEacD7ynMvog8y4qp965adx+Q7Gvh4GeNoyNm0l4rVshUx1j2+AF+5dBwB74XelFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531186; c=relaxed/simple;
	bh=x7zG6gGQLY5b1I/ipuZi6m2HxyJ1+lEEa8n8tBP6azs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq4MgQQZZnasyKXiqTcxPUyE7GaNG/XtQEoJS1y/2UVztUNmzq7YeUPnndKCWUDbigYIoe9G6MUnWK4brAJWQQtpW8mJyL4yRI5f4sVG7UALm1JKO+bHDtU/Tw5YIwaNjBWDvbA3CKQbnzg79Xyh0UC4p8+XCow1okGIuFBJbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bopRE1om; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1746531181; x=1746790381;
	bh=x7zG6gGQLY5b1I/ipuZi6m2HxyJ1+lEEa8n8tBP6azs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bopRE1omtcDaNh9yvphI/+KKkQ3NQObllNAsaGWTXZ4qr8+Emo9PXWsZKfU/zDKkr
	 phtyxeNeijrMv21RvFoPntlZqt3cMAxbopbA8UvtfpZKGjicroo8kzrXJobJAr/kOP
	 FDX6BtF+DZUsynXIhaFIE3XlQX6hQ2DUnSmqpUgCRNxbJAg1aaYYLr5ACv2jaFGZ72
	 XZSeCaiEv9lHVGVBkY1j9z54IzWjHHLPNVns5Giy4v++3bL0GA1gtuzZ1n7DpH6kYv
	 6v8hevWaqZa4Dif4P4xiPFVHMnKUo93aFMMmW3B+C9Sr1yqh0bN9Kyn8jJRikUXGOs
	 KYWyxivZdJ0uQ==
Date: Tue, 06 May 2025 11:32:57 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before endpoint devices are ready
Message-ID: <sjCYTWsKGvCGBbOkCLKDjxQci2L3hMnKoXghzK-HzwO3ZFUGpOadN_Ro4Lbnq50p8CRvbNJy_WU1vDE831mbumbWcZzB8GAYh28IVmSx-ys=@proton.me>
In-Reply-To: <20250506073934.433176-7-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org> <20250506073934.433176-7-cassel@kernel.org>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 857b95d6fa8b1fd5a4f91774bd01c8466e60661c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, May 6th, 2025 at 9:39 AM, Niklas Cassel <cassel@kernel.org> wro=
te:

> Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(=
),
> and instead enumerate the bus when receiving a Link Up IRQ.
>=20
> Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> SSD functional again.
>=20
> It seems that we are enumerating the bus before the endpoint is ready.
> Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> threaded IRQ handler makes the SSD functional once again.
>=20
> What appears to happen is that before ec9fd499b9c6, we called
> dw_pcie_wait_for_link(), and in the first iteration of the loop, the link
> will never be up (because the link was just started),
> dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
> before trying again.
>=20
> This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS=
)
> (100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
> bus would essentially be delayed by that time anyway (because of the slee=
p
> LINK_WAIT_SLEEP_MS (90 ms)).
>=20
> While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERS=
T,
> that would essentially bring back an unconditional delay during synchrono=
us
> probe (the whole reason to use a Link Up IRQ was to avoid an unconditiona=
l
> delay during probe).
>=20
> Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in t=
he
> IRQ handler. This way, we will not have an unconditional delay during boo=
t
> for unpopulated PCIe slots.
>=20
> Cc: Laszlo Fiat laszlo.fiat@proton.me
>=20
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can =
detect Link Up")
> Signed-off-by: Niklas Cassel cassel@kernel.org
>=20
> ---
> drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 3c6ab71c996e..6a7ec3545a7f 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -23,6 +23,7 @@
> #include <linux/reset.h>
>=20
>=20
> #include "pcie-designware.h"
> +#include "../../pci.h"
>=20
> /*
> * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> @@ -458,6 +459,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(in=
t irq, void arg)
> if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> if (rockchip_pcie_link_up(pci)) {
> dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> + msleep(PCIE_T_RRS_READY_MS);
> / Rescan the bus to enumerate endpoint devices */
> pci_lock_rescan_remove();
> pci_rescan_bus(pp->bridge->bus);
>=20
> --
> 2.49.0

Tested-by: Laszlo Fiat <laszlo.fiat@proton.me>

