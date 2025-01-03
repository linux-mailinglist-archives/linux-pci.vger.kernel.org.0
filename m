Return-Path: <linux-pci+bounces-19227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F7A00A1F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7E18847C9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F91F9437;
	Fri,  3 Jan 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh0lHNik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC650145B3F;
	Fri,  3 Jan 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912470; cv=none; b=AbtNQWEsN1fqIcK/jFHHuiaEjzByhPm4Byd/o65GO/4TfJOWMEDz2QhSFbjDU77Uj6Emljz4QzLuDAaz5udnzoSXaM59y/6NrBmgkUmZ6eUIsOiVqPGeNV0pULB9j6K9EhY/AkAWCDFS5DIDYqfg6YV+cqAg5AZuDZu1KvCN2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912470; c=relaxed/simple;
	bh=vfPBv1axVFoL0ncfAohgZOmZ28J/KtXhIPYfd7kR0eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5GVWXISFiXeJ2s8btWJ+FH1kZIaAHSaK5MSz0YzIBdWcPbU2MpUpbBPYQnYEKr8wcrblMDn8CuhZwFlTPVpag29LfxoQVM2gT9VzxtEA0RcBxweFNXZjkxUP/nuUOLfHjKj0Ou1Mr51+JYiwr4+6WZ63rU7xf6bdkAr5lAMrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh0lHNik; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so5110984a12.1;
        Fri, 03 Jan 2025 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912465; x=1736517265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVo8vbmWhwjrxttB6H2z3OXCC+woAC8CNcN2ekPRIq0=;
        b=Vh0lHNikfIMbg9XectSPztUBXVPRUpP5p7RcMHBnNRas3EapobLNdLR2Ff3BEK7okZ
         J2wG4rMvvH1mGYSldcKXcGv5doAVg9bm60LpWU+DrZKQGtlcc47fvkCAunwELZtyXdRG
         JQ/07oFClWFmBkdUKerdOKZh8W9BbO+YqbG6wI0a8hQkXs/nlfC5222M6UoYMD4OtmlM
         pjC+SXxDNeRcIlG015YVu2wRtFd+Sut+jya2iKQ8eC1IenZGqo9KENfn5Vl8bGUsj+6i
         GBAiGpTISK86ZNFMGCF8fDDbl08ISap6mB9Vj1lBdRoHyxpNPj8HV5vo9nIE+hQYxXmJ
         qODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912465; x=1736517265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVo8vbmWhwjrxttB6H2z3OXCC+woAC8CNcN2ekPRIq0=;
        b=giwv/GGRZA3q3Htmr2cLXF3+t2sm6tD96K2HW5+xl2TrAlrTYgMAMrxbev6zKOTDPl
         4raYDkJKphxpepFkjOdVm6bnQCJwE2nfXmgf9PxSimHa9m2+xsuyuX0njXO2ZEi2lXZJ
         Z44P61OoCCFXJiD5h4vy3AiugQsWBdUPgpZI7PxVYYf6Ltzg1iAfRBTfHvyeT2Z9/Mg4
         746HOJOVehkPhf2trAXHom+Tr8Xck6jABNvm1qFTTJlHWGUNs0uAekoq9rXK3wFvnJIu
         qFvBNjQ4760/GDMHQFmS71g8ojTJ5aghSNGQt1B9MmGGTrw5Iyqh2LsADJk2Kcmd3Mir
         k00Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX9SRKIV/L3zQpFl+2CGVchLXJZbcYujwI9LqToG1kqKc1fu5/pHouaLGEyo7sQGbr1oet7djbQtEE@vger.kernel.org, AJvYcCXK0JyxO63dJlEB38b6+zKGAkvlotXCU+PPih5jT9x+dnoyNkz7xECOgeO0ZFwg9VwBhY1sE09k76vrKhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywcy/fjBzysgLpnIrtXI7UgrcSmp2I6tiIXzEE5q67W9GZCbUz
	xXgHIZard3NxLCNt1sbTmMY0Z7ftx/5JwOM9BsEsOtUzHdg36obvf7J/gBTW3ba2Fkp+fWo7TAi
	3NQM+EKvmHbHksqX/juQpeQ0llUA=
X-Gm-Gg: ASbGncsCUu+tBVoAG+5GATfEYj2I7iwOu+yNng4BT09RnZPVjtCPBLB8MNR7pMf/QiR
	D5JvXnOz1nD1Vp5U5dHqqj9QQtIgAQkY8HUExYA==
X-Google-Smtp-Source: AGHT+IFCy4cX2g6FtcQK2HmkJSadw4C8OACfHYIQXMm6vHMHgImTy7arX0MLS7Gx9zqqNK5rsyL2IvomXDwFK7bxOBA=
X-Received: by 2002:a05:6402:5193:b0:5d0:b455:36ad with SMTP id
 4fb4d7f45d1cf-5d81ddf7fc1mr50522480a12.27.1735912464792; Fri, 03 Jan 2025
 05:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
In-Reply-To: <Z3fKkTSFFcU9gQLg@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 3 Jan 2025 19:24:07 +0530
Message-ID: <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

On Fri, 3 Jan 2025 at 17:01, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Fri, Aug 09, 2024 at 01:06:09PM +0530, Anand Moon wrote:
> > Rockchip DWC PCIe driver currently waits for the combo PHY link
> > (PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established link training
> > during boot, it also waits for the link to be up, which could consume
> > several milliseconds during boot.
> >
> > To optimize boot time, this commit allows asynchronous probing.
> > This change enables the PCIe link establishment to occur in the
> > background while other devices are being probed.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: update the commit message to describe the changs.
> > ---
>
> Hello Anand,
>
> I tried this patch.
>
> It gives me the following splat on rock5b (rk3588):
>
> [    1.412108] WARNING: CPU: 5 PID: 59 at kernel/module/kmod.c:143 __request_module+0x1c0/0x298
> [    1.412853] Modules linked in:
> [    1.413125] CPU: 5 UID: 0 PID: 59 Comm: kworker/u32:1 Not tainted 6.13.0-rc1+ #38
> [    1.413781] Hardware name: Radxa ROCK 5B (DT)
> [    1.414163] Workqueue: async async_run_entry_fn
> [    1.414565] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.415175] pc : __request_module+0x1c0/0x298
> [    1.415559] lr : __request_module+0x1bc/0x298
> [    1.415943] sp : ffff8000804333f0
> [    1.416234] x29: ffff800080433470 x28: ffff42bec2e40000 x27: ffff42bec2e400c8
> [    1.416860] x26: ffff42bec1739000 x25: ffffb5bec9400e18 x24: 0000000000000000
> [    1.417485] x23: ffffb5bec93e1a90 x22: 0000000000000001 x21: ffffb5bec74298f8
> [    1.418111] x20: ffff800080433620 x19: ffff800080433410 x18: 0000000000000006
> [    1.418736] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    1.419360] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000000
> [    1.419985] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb5bec750b834
> [    1.420611] x8 : ffff800080433468 x7 : 0000000000000000 x6 : 0000000000000000
> [    1.421235] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000030
> [    1.421860] x2 : 0000000000000008 x1 : ffffb5bec750b708 x0 : 0000000000000001
> [    1.422486] Call trace:
> [    1.422701]  __request_module+0x1c0/0x298 (P)
> [    1.423086]  __request_module+0x1bc/0x298 (L)
> [    1.423471]  phy_request_driver_module+0x120/0x178
> [    1.423895]  phy_device_create+0x230/0x250
> [    1.424257]  get_phy_device+0x80/0x168
> [    1.424588]  mdiobus_scan+0x20/0xa0
> [    1.424896]  __mdiobus_register+0x21c/0x460
> [    1.425265]  __devm_mdiobus_register+0x78/0xf8
> [    1.425657]  rtl_init_one+0x7c8/0x1140
> [    1.425989]  local_pci_probe+0x48/0xc0
> [    1.426323]  pci_device_probe+0xcc/0x248
> [    1.426671]  really_probe+0xc4/0x2d0
> [    1.426989]  __driver_probe_device+0x80/0x130
> [    1.427374]  driver_probe_device+0x44/0x168
> [    1.427745]  __device_attach_driver+0xc0/0x148
> [    1.428138]  bus_for_each_drv+0x90/0x100
> [    1.428486]  __device_attach+0xa8/0x1a0
> [    1.428826]  device_attach+0x1c/0x38
> [    1.429143]  pci_bus_add_device+0xb4/0x1e0
> [    1.429505]  pci_bus_add_devices+0x48/0xa0
> [    1.429867]  pci_bus_add_devices+0x74/0xa0
> [    1.430228]  pci_host_probe+0x94/0x100
> [    1.430560]  dw_pcie_host_init+0x258/0x720
> [    1.430923]  rockchip_pcie_probe+0x2ec/0x510
> [    1.431300]  platform_probe+0x70/0xe8
> [    1.431623]  really_probe+0xc4/0x2d0
> [    1.431940]  __driver_probe_device+0x80/0x130
> [    1.432326]  driver_probe_device+0x44/0x168
> [    1.432696]  __device_attach_driver+0xc0/0x148
> [    1.433089]  bus_for_each_drv+0x90/0x100
> [    1.433436]  __device_attach_async_helper+0xbc/0xe8
> [    1.433865]  async_run_entry_fn+0x3c/0xf0
> [    1.434219]  process_one_work+0x158/0x3c8
> [    1.434574]  worker_thread+0x2d4/0x3f8
> [    1.434907]  kthread+0x118/0x128
> [    1.435193]  ret_from_fork+0x10/0x20
>
>
> Perhaps we should defer this patch until phylib core has been fixed?
>
> For more info, see:
> https://lore.kernel.org/netdev/Z3fJQEVV4ACpvP3L@ryzen/T/#u
>

Thanks for testing this patch.

This patch should have been tested on hardware that includes all the
relevant controllers,
such as PCI 2.0, PCI 3.0, and the SATA controller.
I will test this patch again on all the Radxa devices I have.

This patch's dependency lies in deferring the probe until the PHY
controller initializes.

CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m

To my surprise, we have not enabled mdio on Rock-5B boards.
can you check if these changes work on your end?

-----8<----------8<----------8<----------8<----------8<----------8<-----
alarm@rock-5b:/media/nvme0/mainline/linux-rockchip-6.y-devel$ git diff
   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index c44d001da169..5008a05efd2a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -155,6 +155,19 @@ vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
        };
 };

+&mdio1 {
+       rgmii_phy1: ethernet-phy@1 {
+               /* RTL8211F */
+               compatible = "ethernet-phy-id001c.c916";
+               reg = <0x1>;
+               pinctrl-names = "default";
+               pinctrl-0 = <&rtl8211f_rst>;
+               reset-assert-us = <20000>;
+               reset-deassert-us = <100000>;
+               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+       };
+};
+
 &combphy0_ps {
        status = "okay";
 };
@@ -224,6 +237,21 @@ &hdptxphy_hdmi0 {
        status = "okay";
 };

+&gmac1 {
+       clock_in_out = "output";
+       phy-handle = <&rgmii_phy1>;
+       phy-mode = "rgmii";
+       pinctrl-0 = <&gmac1_miim
+                    &gmac1_tx_bus2
+                    &gmac1_rx_bus2
+                    &gmac1_rgmii_clk
+                    &gmac1_rgmii_bus>;
+       pinctrl-names = "default";
+       tx_delay = <0x3a>;
+       rx_delay = <0x3e>;
+       status = "okay";
+};
+
 &i2c0 {
        pinctrl-names = "default";
        pinctrl-0 = <&i2c0m2_xfer>;
@@ -419,6 +447,12 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
                };
        };

+       rtl8211f {
+               rtl8211f_rst: rtl8211f-rst {
+                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+               };
+       };
+
        usb {
                vcc5v0_host_en: vcc5v0-host-en {
                        rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>
> Kind regards,
> Niklas

Can you check this on your end

alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred
[sudo] password for alarm:
fc400000.usb    dwc3: failed to initialize core
alarm@rock-5b:~$ sudo cat /sys/kernel/debug/devices_deferred

Thanks
-Anand

