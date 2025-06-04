Return-Path: <linux-pci+bounces-28956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2BEACDBDC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA753177F12
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82B239E6E;
	Wed,  4 Jun 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcSiyIO1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0EA19DF48;
	Wed,  4 Jun 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032439; cv=none; b=qxpIoAVW1tVFYrWaKmu2xllCCrWs7EyHBdZoTuGuxXkXfILQ1P4Itf4fxSIupzXBGdWtezlUcozSBIrlaEU/ik0JzNoQGU10cbeQZRVAcY2RFSya31JvEq45Z270rpon0T0lIPcNYyCZCJ65h7te5MYwnijlelF5KyIhrCUbsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032439; c=relaxed/simple;
	bh=2nP4D7Pp64PEPL5G3sjyZgtyDpXKVhkDNwiQajpcrFI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nKXo/daRLl5gI8RpJs6ysV40hQypd0nty2oucwWmOpGaskygFBuZbv/czqjCk6ipfFW2tHk+rjoPCIhtoboGL2fBiehMl+mH7+ou/vwEbJZXtkpFX3Ypf5sXwM3IhqE8q5ZqhdFkMYyK7etLlUBW32ytKgB4bYTaeSuf9CMM2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcSiyIO1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a35c894313so5925438f8f.2;
        Wed, 04 Jun 2025 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749032436; x=1749637236; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gksmbVMdlMg2K8PgWxvAtllhStxQNr+LZ8Dt0YW8uEI=;
        b=LcSiyIO1ob8nplXDpQ/nVNl/ErBAsalI9vx0jKvw+Fiy8930o1DSThxTfrwxqzbayi
         cU+sTzN73qo7zteQ2sDwRoGaBk5q9Y/esdPzvNjdvrUMuk9YCoqWQJTltjsi60BtE+4z
         fMZhm0jlr0ITL5FMfOe05DP049asiE2cWExNKCuFBtRRORAGAh7cQqLG+Bzdwu4FKfCh
         tBTQEppteTqW75PMS5R1VUXfgzbgvNFzNXNHk8YvtB5GtDytofX7qQRJIzLNmfZ9m7dq
         NNBi2Qc4jEKY0r/nTdnKmGzzlRPR5wvB4cOrY/KmkSIzLH2Pf7V9+e/YmMVk56wjlrDl
         4InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032436; x=1749637236;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gksmbVMdlMg2K8PgWxvAtllhStxQNr+LZ8Dt0YW8uEI=;
        b=dHBaENdqFvh1nZ3M7mlRzLr3c0LbaxmIjD+cPBkUwFyBVZroR5eAKSC11TWWtWShEs
         3jHiXM2+DL/MI+iwA0tQdnwYP8Gi8gPY+McD5cw1WX2yEqHtaFY71QI92aCB1uDQuaQ2
         HS/eGak3+WeAMq29Mnnk0gyb4aCCRQRUVsWYnPsmI5cE0LBnRGSDqNZA3lJvWtKz7h13
         cXwsxEnXdWkG0rmra+g78WMGO8XR4Lns18C3lp5I45gC2gXAcLzhztcnbgjQpuk+jXHb
         kCY00uHBnvRa1tnzUF4Brpeno2ygGxny2df8k6sqzspkTTcCjaytrkoiv8kE0uQOdi7j
         EFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVquZfIcwPUs3otBx0Dx6Kj+jxEcRqbEEItRBu07XYF9DBqORpJkGTh6euIear+CU/9nfVEdj+Ilm52V50=@vger.kernel.org, AJvYcCWJGio7Xb91wWf89+yqnHGXm7yEe5+nKaBOdfgXJMzWsnqmhmBzlXMvPNegREVmUnV8THFr3vWmDXre@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UcUuDX4BdxMuCOuWKPI7QpfAbEkHClTIGPhyJB/LO8ICX1O/
	w/UKbx7nsH7NOXoa7ZMkLSuzCVdYAfMJ/N+BmGI+HwTr0hd2KpmtRlKO
X-Gm-Gg: ASbGncs1sa5/Mf7gXzceFRe0GU5InM1gaEfYcR5VaVb7eJX1WykKpOnkVfrnCEOUbUy
	eNlsGVnEajNvlzRm4wY92yxdjXtYmbtwBgM2Wa+c/34tbF/0AE7/KEDMvfxPqAj74/mrfc3ZyyX
	k3ID4duuWnmoILkTXRJ/H6y15QGIofMr/lxnBzGF6uNb8OmL8RrXekZVTZDXkQof22Sgqo0kGg2
	33wJqp7W/swhBkLcK/ZcMBb8lcJ5ajpMXasYYVPRM3bpED6ggZMQo9oiytqM9NKsiNwja5kaGDx
	reG27q56tdmOa1hJr+XO1kH1JklVezv9eOk4r4Vy3Kv4fMsJdxiBIQ/uR6LtYELeZFkY5+kXjts
	F
X-Google-Smtp-Source: AGHT+IF88CeFxKvQxdvXREnSkr8GHdt7EoWxmbkqn8grATbGWlFIxrHVsbxE7StTbOeQY8wMZZYAXg==
X-Received: by 2002:a05:6000:240c:b0:3a0:b1f7:c1da with SMTP id ffacd0b85a97d-3a51d967e0emr1682017f8f.46.1749032435644;
        Wed, 04 Jun 2025 03:20:35 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a03bdsm21776589f8f.91.2025.06.04.03.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2025 03:20:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <aEAOiO_YIqWH9frQ@geday>
Date: Wed, 4 Jun 2025 14:20:20 +0400
Cc: linux-rockchip@lists.infradead.org,
 Hugh Cole-Baker <sigmaris@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <317943F7-8658-436D-9E3C-05CB6404F122@gmail.com>
References: <aEAOiO_YIqWH9frQ@geday>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

> On 4 Jun 2025, at 1:14=E2=80=AFpm, Geraldo Nascimento =
<geraldogabriel@gmail.com> wrote:
>=20
> Hi,
>=20
> After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> N10 through trial-and-error debugging, I finally got positive results
> with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> Samsung PM981a SSD.
>=20
> The NIC was connected to a M.2->PCIe x4 riser card and it would get
> stuck on Polling.Compliance, without breaking electrical idle on the
> Host RX side. The Samsung PM981a SSD is directly connected to M.2
> connector and that SSD is known to be quirky (OEM... no support)
> and non-functional on the RK3399 platform.
>=20
> The Samsung SSD was even worse than the NIC - it would get stuck on
> Detect.Active like a bricked card, even though it was fully functional
> via USB adapter.
>=20
> It seems both devices benefit from retrying Link Training if - big if
> here - PERST# is not toggled during retry. This patch does exactly =
that.
> I find the patch to be ugly as hell but it works - every time.
>=20
> I added Hugh Cole-Baker and Christian Hewitt to Cc: as both are
> experienced on RK3399 and hopefully at least one of them has faced
> the non-working SSD experience on RK3399 and will be able to test =
this.

I think you have me confused with another Christian (or auto-complete
scored a new victim). Sadly I have no clue about PCI and not a lot of
knowledge on RK3399 matters :)

CH.

> ---
> drivers/pci/controller/pcie-rockchip-host.c | 141 ++++++++++++--------
> 1 file changed, 87 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c =
b/drivers/pci/controller/pcie-rockchip-host.c
> index 6a46be17aa91..6a465f45a09c 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -284,6 +284,53 @@ static void rockchip_pcie_set_power_limit(struct =
rockchip_pcie *rockchip)
> rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> }
>=20
> +static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> +{
> + struct device *dev =3D rockchip->dev;
> + int err;
> +
> + if (!IS_ERR(rockchip->vpcie12v)) {
> + err =3D regulator_enable(rockchip->vpcie12v);
> + if (err) {
> + dev_err(dev, "fail to enable vpcie12v regulator\n");
> + goto err_out;
> + }
> + }
> +
> + if (!IS_ERR(rockchip->vpcie3v3)) {
> + err =3D regulator_enable(rockchip->vpcie3v3);
> + if (err) {
> + dev_err(dev, "fail to enable vpcie3v3 regulator\n");
> + goto err_disable_12v;
> + }
> + }
> +
> + err =3D regulator_enable(rockchip->vpcie1v8);
> + if (err) {
> + dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> + goto err_disable_3v3;
> + }
> +
> + err =3D regulator_enable(rockchip->vpcie0v9);
> + if (err) {
> + dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> + goto err_disable_1v8;
> + }
> +
> + return 0;
> +
> +err_disable_1v8:
> + regulator_disable(rockchip->vpcie1v8);
> +err_disable_3v3:
> + if (!IS_ERR(rockchip->vpcie3v3))
> + regulator_disable(rockchip->vpcie3v3);
> +err_disable_12v:
> + if (!IS_ERR(rockchip->vpcie12v))
> + regulator_disable(rockchip->vpcie12v);
> +err_out:
> + return err;
> +}
> +
> /**
>  * rockchip_pcie_host_init_port - Initialize hardware
>  * @rockchip: PCIe port information
> @@ -291,11 +338,14 @@ static void rockchip_pcie_set_power_limit(struct =
rockchip_pcie *rockchip)
> static int rockchip_pcie_host_init_port(struct rockchip_pcie =
*rockchip)
> {
> struct device *dev =3D rockchip->dev;
> - int err, i =3D MAX_LANE_NUM;
> + int err, i =3D MAX_LANE_NUM, is_reinit =3D 0;
> u32 status;
>=20
> - gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> + if (!is_reinit) {
> + gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> + }
>=20
> +reinit:
> err =3D rockchip_pcie_init_port(rockchip);
> if (err)
> return err;
> @@ -322,16 +372,46 @@ static int rockchip_pcie_host_init_port(struct =
rockchip_pcie *rockchip)
> rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>    PCIE_CLIENT_CONFIG);
>=20
> - msleep(PCIE_T_PVPERL_MS);
> - gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> -
> - msleep(PCIE_T_RRS_READY_MS);
> + if (!is_reinit) {
> + msleep(PCIE_T_PVPERL_MS);
> + gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> + msleep(PCIE_T_RRS_READY_MS);
> + }
>=20
> /* 500ms timeout value should be enough for Gen1/2 training */
> err =3D readl_poll_timeout(rockchip->apb_base + =
PCIE_CLIENT_BASIC_STATUS1,
> status, PCIE_LINK_UP(status), 20,
> 500 * USEC_PER_MSEC);
> - if (err) {
> +
> + if (err && !is_reinit) {
> + while (i--)
> + phy_power_off(rockchip->phys[i]);
> + i =3D MAX_LANE_NUM;
> + while (i--)
> + phy_exit(rockchip->phys[i]);
> + i =3D MAX_LANE_NUM;
> + is_reinit =3D 1;
> + dev_dbg(dev, "Will reinit PCIe without toggling PERST#");
> + if (!IS_ERR(rockchip->vpcie12v))
> + regulator_disable(rockchip->vpcie12v);
> + if (!IS_ERR(rockchip->vpcie3v3))
> + regulator_disable(rockchip->vpcie3v3);
> + regulator_disable(rockchip->vpcie1v8);
> + regulator_disable(rockchip->vpcie0v9);
> + rockchip_pcie_disable_clocks(rockchip);
> + err =3D rockchip_pcie_enable_clocks(rockchip);
> + if (err)
> + return err;
> + err =3D rockchip_pcie_set_vpcie(rockchip);
> + if (err) {
> + dev_err(dev, "failed to set vpcie regulator\n");
> + rockchip_pcie_disable_clocks(rockchip);
> + return err;
> + }
> + goto reinit;
> + }
> +
> + else if (err) {
> dev_err(dev, "PCIe link training gen1 timeout!\n");
> goto err_power_off_phy;
> }
> @@ -613,53 +693,6 @@ static int rockchip_pcie_parse_host_dt(struct =
rockchip_pcie *rockchip)
> return 0;
> }
>=20
> -static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> -{
> - struct device *dev =3D rockchip->dev;
> - int err;
> -
> - if (!IS_ERR(rockchip->vpcie12v)) {
> - err =3D regulator_enable(rockchip->vpcie12v);
> - if (err) {
> - dev_err(dev, "fail to enable vpcie12v regulator\n");
> - goto err_out;
> - }
> - }
> -
> - if (!IS_ERR(rockchip->vpcie3v3)) {
> - err =3D regulator_enable(rockchip->vpcie3v3);
> - if (err) {
> - dev_err(dev, "fail to enable vpcie3v3 regulator\n");
> - goto err_disable_12v;
> - }
> - }
> -
> - err =3D regulator_enable(rockchip->vpcie1v8);
> - if (err) {
> - dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> - goto err_disable_3v3;
> - }
> -
> - err =3D regulator_enable(rockchip->vpcie0v9);
> - if (err) {
> - dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> - goto err_disable_1v8;
> - }
> -
> - return 0;
> -
> -err_disable_1v8:
> - regulator_disable(rockchip->vpcie1v8);
> -err_disable_3v3:
> - if (!IS_ERR(rockchip->vpcie3v3))
> - regulator_disable(rockchip->vpcie3v3);
> -err_disable_12v:
> - if (!IS_ERR(rockchip->vpcie12v))
> - regulator_disable(rockchip->vpcie12v);
> -err_out:
> - return err;
> -}
> -
> static void rockchip_pcie_enable_interrupts(struct rockchip_pcie =
*rockchip)
> {
> rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
> --=20
> 2.49.0
>=20


