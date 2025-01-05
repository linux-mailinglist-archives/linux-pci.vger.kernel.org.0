Return-Path: <linux-pci+bounces-19315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665EA01B2E
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 18:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C954E3A35ED
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C371A8F61;
	Sun,  5 Jan 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV1RrQyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E11474A7;
	Sun,  5 Jan 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099186; cv=none; b=Y57iiwVzG2P5PTXI7XZnOA7xRXsF6T8QUXkCcK52/I8v/KA6V74ORW3gHQj26lT+QLAPGPcOHrbhE3WZSzpKRCSIdbrnYcYD0PA/tQfD2g1iCxrONfgotK7wvDdhTY4ejB9yuCaZnBX0iy/GappT7Cb/xcQsK7yE80R3FXMkCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099186; c=relaxed/simple;
	bh=16dja6sPjpAJw0P4STGKxY/COGb3YcH6ePLNGKK2vJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozt0QIp1wvcXD83qr+X4E5LUXbpWeAEOJFXpduS4pEYochCofBQGWULkeztqYZ92qYagwIvqzqsPuRzxZAw4y1aPIwKZ18HERDKi6e2vSzvSVPgm+Gk6PnIbQz8s2L8qaM29ufzytRvvx0/IIOkHTEVfiuCifg64K8zhLqd6B3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dV1RrQyl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so23930959a12.2;
        Sun, 05 Jan 2025 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099183; x=1736703983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIykvlmhFYKrh2hGvG0EqISiN/aGTtZGMfzgjXPy2TQ=;
        b=dV1RrQyllyds65bTxCMVdoDrilmUXtZcpa/YNG4GHq2j/xA++r56+310Wt+L3XT0qe
         oXccdrxmAYCVwpVZjqQOHkG6MFs0n0Cb8GdO73j0RPWxohwYXRFFUGg3QYOpRa04Q+9E
         ND+J0cmuzFWMBk2rZfhbShBEzGqSL+RZ3Q1DlVsBqdeVwY7CUCYSrHwua/c79rWwnkpi
         lyBTCieObgfTHpbkK0M5pRxX1fWbmbBOjkuvRlESYcn1i4lTJP+10FPpXxr4jCX+DwEI
         P9lddp+MuJZW14U7c1Cyi1AVOVcPaKM7y6876/kSv66bfRytEPNtgBFDNJeLyHkQZl7s
         jDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099183; x=1736703983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIykvlmhFYKrh2hGvG0EqISiN/aGTtZGMfzgjXPy2TQ=;
        b=v3MHJ4WtU4CnesZSSkdA1VoauiuQKdXdm9I1YDGoOsMZgjJaYfgYayU5DM49T44nO2
         FCeqeRVFjAW6RaI5Xl7LOKdpXbDp8lJoC2ipEZZePdKObUzbuYzVhthvGuQhYArJNOiE
         QOuEYx6t99TlHQEmJTKmhLM0V+BXeUoybdzCYBDvgJsH2wuiksFzNAfw8LEP2TWRGHT0
         TRy8nklNtzrkZFFSjRU+Y58HU040FV/AgafXzjulKjzQGLYoooTmoljJtqSc3fXwvRGt
         AZOSieBs5fklWBsAO01CeXgnNERuCVfBK0dh+XVEUKXII0JM5w0ci0ih7cmSxlC1rmwl
         XijQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPtMFE3BBqi3fNyEVVNxwHdkw0YFtWP4fPtn5/9jw8+l75m2KcT6P7eaYbyQPMLucwwq7tW5ZA8dgHwqg=@vger.kernel.org, AJvYcCW0T5mNKlpSOA8otA8WZGJ3BOIUaoL1LBCwvRsLoHZsTiiBhqJX0BqwTD+9G541E5VVDMLk+vPNLS7w@vger.kernel.org
X-Gm-Message-State: AOJu0YweXz5MK8fr3UVcWG4x3QnC5XBkXNWWS7C7RKZdwPBsLj2GHl4w
	T4AHZ5DxQP9HC7dbofZJXe+m4bPvFM/oCcH46NgCR49wqSWTCWIZZtCCPyxlpbCUuyErOdSKsrg
	6vv8pprbEvSxViWWAR+Yp09/G1bU=
X-Gm-Gg: ASbGnctY2F6gUDrkAnZhMH1/vfC3QXjCzTv3jVeGRyTZmsb460ukAmTBqtbLuC5ovvW
	DQHgYep2Nnuc/ccs8fwt3PHnacV7Z35WMoVJ5iw==
X-Google-Smtp-Source: AGHT+IHKoLQ3bbk5sX9596VJfsx7MTb1NN/9SirZSGNKB5kB6RJj6mYW7ASrHVq7n/gBHPzbAHYnTQkgOBJmhlHwrKc=
X-Received: by 2002:a05:6402:230e:b0:5d9:a55:8104 with SMTP id
 4fb4d7f45d1cf-5d90a55812fmr8206307a12.21.1736099182361; Sun, 05 Jan 2025
 09:46:22 -0800 (PST)
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
Date: Sun, 5 Jan 2025 23:16:05 +0530
Message-ID: <CANAwSgS3iXUOH2_4CYK0W+A09xitDdXhQFns=E7XjwqOTUXMRg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

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
I am unable to reproduce this issue on my end. Could you share your
config file with me?
Additionally, if we build most of the ROCKCHIP components as modules..."

You will see this warning, which is the main reason for this patch

[   34.642365] platform fc400000.usb: deferred probe pending: dwc3:
failed to initialize core
[   34.642529] platform a41000000.pcie: deferred probe pending:
rockchip-dw-pcie: missing PHY
[   34.642604] platform a40800000.pcie: deferred probe pending:
rockchip-dw-pcie: missing PHY
[   34.642674] platform fcd00000.usb: deferred probe pending: dwc3:
failed to initialize core

> >
> > To my surprise, we have not enabled mdio on Rock-5B boards.
> > can you check if these changes work on your end?
>
> I think these changes are wrong, at least for rock5b.
>
> On rock5b the RTL8125 NIC is connected via PCI, and PCI devices should not
> be specified in device tree, as PCI is a bus that can be enumerated.
>

According to RK3588 (TRM) documentation specifies the requirement for
a dedicated GMAC controller
to effectively manage certain critical network features. In the
absence of this specialized controller,
the network interface card (NIC) may operate solely as a standard PCIe
NIC, potentially leading to
suboptimal performance and a lack of robust flow control mechanisms.

Log analysis indicates that Ethernet probing occurs before the
initialization of the PCIe PHY and PCIe hosts.
To investigate this issue, please test with the following configuration changes:

1 Set CONFIG_DWMAC_ROCKCHIP=m.
2 Enable the probe mode PROBE_PREFER_ASYNCHRONOUS for the DWMAC_ROCKCHIP driver.

Thanks
-Anand
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

