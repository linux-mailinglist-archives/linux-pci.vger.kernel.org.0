Return-Path: <linux-pci+bounces-19229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CBA00AB7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D967A05FB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95541D61AC;
	Fri,  3 Jan 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpNerby8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CAA47;
	Fri,  3 Jan 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915238; cv=none; b=eISGg0/deeHVVgWTGrsckK8Lj3QW6lIyDX39/a6zM9/ry0pnJ6EUlMvNHVMwJVEQURUCFaVMBUTjr6NaBPKTif3nmEoCBq5S/IKnM1qpgLqf4WotB9TX7d31WCAZAaNrzR0vTA5AeyKgkPNKXSq4lyQxwCqXI3/QGmJJB8XMO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915238; c=relaxed/simple;
	bh=L7+0flr4g7k9Ep6XGvlhH+YnhAGEce6SmWWz7/rr/Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRQfKUG0SifEbjGz6J5zMo5SHuksUmn7f1yO4pppCvsDBcjB2iEH3F8auisuacaxAN5gKLF1hvtpcmXkgt8qfbmtgFxDE5NXdiKFe3GYSQjbb1xBP/8cRPIdGeyM+o2I8kht9MHrURK1KbXvES6I7z03erX5jLSH7WcTbUVczAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpNerby8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so16523250a12.1;
        Fri, 03 Jan 2025 06:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735915235; x=1736520035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYtF9idV5u7+bQH/eQgXZrY6v9oUYy083r4PjjJyJkY=;
        b=JpNerby8/ON3GUi/NU6aM/BKjDquLcYLlQ9uAmfnSedM5MWJjPJd5IzwIZq8Xuk/VC
         anqMll9LCSHMqxAkmTg0S9r2dfEFx+Rjfd0F5yBXP3VZeJoLYrdbSuuX/Tgfw78R+wzD
         TGv1iIS2eYUx4NwEClL+co3ESDgLm5c1K649W3qTDiMAa0CM3Ejeo7+OqujXoMJ+WTvv
         x9FZIPxOrEons8HY/1SMa34z6oKbuGtkIWN/F6DLHnaxqUr3MYjb7TBtlNpR5IvJilhe
         mJjgZsoQO2ZUxta5wYbnxmUan4mxKnNSqYGd+7uGuB2fu8VZbcXCU6E6dd5xPZNRDiJt
         DuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735915235; x=1736520035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYtF9idV5u7+bQH/eQgXZrY6v9oUYy083r4PjjJyJkY=;
        b=AH++y3HQwqXkxe1a7phtkSqY9Or4nKHCg7K2ZVG73iUIeSR0YxafO448ssS64z+qCn
         F95FN6oWCruDLYZxbjyZ00Txk4qS+vSOvic7+ZwEf4i95zfUh+j4j2qjQuHe9rt7nNsH
         Zgqn1vV6C2ED9y4IhDXuQhUDBPst5hif183aJT7bXraAo1p0c0ZXTe6qfSlKR41b9WVq
         FSYz+266erpvbdMDv6tUP3Na7xNa9jJmfNt04x3nhlusjexfPoYH4J60r78EBaRG2rrM
         Rc+GDJv6DyRAViU87JyyAD/DRJV9smYLWBLkNxHKf2tmW2raKXIAVmE2UJrHCWGK/Amj
         p9fg==
X-Forwarded-Encrypted: i=1; AJvYcCX+EMmD478L+S+z4LbFxr8ErZ6IEeW1YbId28mLYdrKA6EhZBbMpr2NSPQ3/AluCLImYDNJrBCCSV1DmmA=@vger.kernel.org, AJvYcCXfq92aP+KqU2Uau1OGBEQDrzgaX3JCG+p6EhYVyy//xtbTKTJd2xbCPFPXrAFa43Ithnl8/1A0h9B3@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKLpac8MtuX+ViMP9mvutAXm1ZelFoVYkDFDp6N08Kyvrw4cx
	e0kcEkG4ixC+0CLpQKM15TrfVJflE7ARKSG6jejz8c62SAM9QGQsQV2+8lXwQFJguDgjVR176tD
	tHZ6RPw0tioVmJNyrFDaAO6gLjac=
X-Gm-Gg: ASbGncvTFDRwQJ+oI7QsgjtsxVr8K0TmpyldJ/2zSv2/b4RdARUbhZks4pSlfertCzu
	UyM96MAbPwV2axQYmpXnf5LW5hl0VCvouMDb0LQ==
X-Google-Smtp-Source: AGHT+IEjqk3b0N0ssUpO0OZqcvf6plJRVZVjRmT4cXVVUQfx76Im4Dz0WkqoOF7bZ30b2au7OXaKBtS7jM85GootQ1Q=
X-Received: by 2002:a05:6402:1e8e:b0:5d0:bcdd:ffa7 with SMTP id
 4fb4d7f45d1cf-5d81dd64027mr41529657a12.3.1735915234754; Fri, 03 Jan 2025
 06:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com> <Z3fzad51PIxccDGX@ryzen>
In-Reply-To: <Z3fzad51PIxccDGX@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 3 Jan 2025 20:10:17 +0530
Message-ID: <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas

On Fri, 3 Jan 2025 at 19:55, Niklas Cassel <cassel@kernel.org> wrote:
>
> Hello Anand,
>
> On Fri, Jan 03, 2025 at 07:24:07PM +0530, Anand Moon wrote:
> >
> > Thanks for testing this patch.
> >
> > This patch should have been tested on hardware that includes all the
> > relevant controllers,
> > such as PCI 2.0, PCI 3.0, and the SATA controller.
> > I will test this patch again on all the Radxa devices I have.
> >
> > This patch's dependency lies in deferring the probe until the PHY
> > controller initializes.
> >
> > CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
>
>
> Note that the splat, as reported in this thread, and in:
> https://lore.kernel.org/netdev/20250101235122.704012-1-francesco@valla.it/T/
>
> is related to the network PHY (CONFIG_REALTEK_PHY) on the RTL8125 NIC,
> which is connected to one of the PCIe Gen2 controllers, not the PCIe PHY
> on the PCIe controller (CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY) itself.
>
> For the record, I run with all the relevant drivers as built-in:
> CONFIG_PCIE_ROCKCHIP_DW_HOST=y
> CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y (for the PCIe Gen2 controllers)
> CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y (for the PCIe Gen3 controllers)
> CONFIG_R8169=y
> CONFIG_REALTEK_PHY=y
>
>
> >
> > To my surprise, we have not enabled mdio on Rock-5B boards.
> > can you check if these changes work on your end?
>
> I think these changes are wrong, at least for rock5b.

We need to enable the GMAC PHY and reset it using the proper GPIO pin
(PCIE_PERST_L).
Please refer to the schematic for more details.

These changes also apply to other device tree nodes for different boards.

Thanks
-Anand
>
> On rock5b the RTL8125 NIC is connected via PCI, and PCI devices should not
> be specified in device tree, as PCI is a bus that can be enumerated.
>
>
> >
> > -----8<----------8<----------8<----------8<----------8<----------8<-----
> > alarm@rock-5b:/media/nvme0/mainline/linux-rockchip-6.y-devel$ git diff
> >    arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index c44d001da169..5008a05efd2a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -155,6 +155,19 @@ vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> >         };
> >  };
> >
> > +&mdio1 {
> > +       rgmii_phy1: ethernet-phy@1 {
> > +               /* RTL8211F */
> > +               compatible = "ethernet-phy-id001c.c916";
> > +               reg = <0x1>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&rtl8211f_rst>;
> > +               reset-assert-us = <20000>;
> > +               reset-deassert-us = <100000>;
> > +               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> > +       };
> > +};
> > +
> >  &combphy0_ps {
> >         status = "okay";
> >  };
> > @@ -224,6 +237,21 @@ &hdptxphy_hdmi0 {
> >         status = "okay";
> >  };
> >
> > +&gmac1 {
> > +       clock_in_out = "output";
> > +       phy-handle = <&rgmii_phy1>;
> > +       phy-mode = "rgmii";
> > +       pinctrl-0 = <&gmac1_miim
> > +                    &gmac1_tx_bus2
> > +                    &gmac1_rx_bus2
> > +                    &gmac1_rgmii_clk
> > +                    &gmac1_rgmii_bus>;
> > +       pinctrl-names = "default";
> > +       tx_delay = <0x3a>;
> > +       rx_delay = <0x3e>;
> > +       status = "okay";
> > +};
> > +
> >  &i2c0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&i2c0m2_xfer>;
> > @@ -419,6 +447,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                 };
> >         };
> >
> > +       rtl8211f {
> > +               rtl8211f_rst: rtl8211f-rst {
> > +                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> >         usb {
> >                 vcc5v0_host_en: vcc5v0-host-en {
> >                         rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> > >
> > > Kind regards,
> > > Niklas
> >
> > Can you check this on your end
> >
> > alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred
> > [sudo] password for alarm:
> > fc400000.usb    dwc3: failed to initialize core
> > alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred
>
> Sure:
> # cat /sys/kernel/debug/devices_deferred
> fc400000.usb    dwc3: failed to initialize core
>
>
> Kind regards,
> Niklas

