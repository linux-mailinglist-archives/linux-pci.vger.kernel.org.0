Return-Path: <linux-pci+bounces-42622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CCCA383D
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C54153033C88
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB7133CEB6;
	Thu,  4 Dec 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="eYavfJDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB42E88A7
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849604; cv=none; b=jKVibjaidMaLZzWZfKqEaeHt4wRtyNY4ksUgraYd0E83lObSA7m5sEGRmX6HRjjyz+5/r9ylhwKUdluiFwleqEZOOgkfBJRmYGgbKt1ugXfoe3ZSX+uI+EQ3a9VuxtpNq14zri1hJyi4yXJl3hhb0eECefgurUy83OUy57FAVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849604; c=relaxed/simple;
	bh=l63sOJmlqno2gkVKkjcES4TzLbvzObcpLc8Dji6OTKk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eP9TZYtM6xD2m49dI1LEfMi5+ioak0gnKAUkLEfffgxmtscldO2m03ij6ECZXMyt9yEkzubktJi8Il1979UYwz/DdCdH0RZVD8VThlOaTZ6j2FPK4fkT3dXIKJGzvaTwQQ/L75RfzqR/WT8j6ll1qU65piABgkkZILovo/Rwp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=eYavfJDn; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1764849598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSOcwY/qQ5Xjiw03oUTju/J5KsMWDXKedAXrLMaSJsg=;
	b=eYavfJDnYzbV/1+ATBULl51tKvKwmc1JT04PBgj8/NYWQ8VMKUo5i6V0sRDcWyQGZ3JpVV
	1tnGWC8BO3EX6g9wJV1TgghoVBvha/zvDCj4nJNdx57vi1M78VYS6uFjVlM9LvtgEG1J25
	Eo0EPmhMTwgRUeQ7ZiHGuprnRCEWb+haFSeFqsAq90p/QjjUxPP5ivHKeQCqRqIRfD6J2l
	aix/h65OgeaIT9YGFIRQWCzLdi1g9vXFveOtu6z1TgwJPYjX9tY0JFNeWI8iWUIne6Ik2s
	4wccxHa4Sz62XgnUROPp8BB/Omjbi+OOMCoIhgECQyKIzwMVCwaYOMfokeup8w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:59:53 +0100
Message-Id: <DEPEYUF5BRGY.UKFBWRRE8HNP@cknow-tech.com>
Cc: <linux-kernel@vger.kernel.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] regulator: fixed: fix GPIO descriptor leak on register
 failure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Haotian Zhang" <vulab@iscas.ac.cn>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>
References: <20251028172828.625-1-vulab@iscas.ac.cn>
In-Reply-To: <20251028172828.625-1-vulab@iscas.ac.cn>
X-Migadu-Flow: FLOW_OUT

On Tue Oct 28, 2025 at 6:28 PM CET, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag,
> devm_gpiod_get_optional() was replaced by manual
> GPIO management, relying on the regulator core to release the
> GPIO descriptor. However, this approach does not account for the
> error path: when regulator registration fails, the core never
> takes over the GPIO, resulting in a resource leak.
>
> Add gpiod_put() before returning on regulator registration failure.
>
> Fixes: 5e6f3ae5c13b ("regulator: fixed: Let core handle GPIO descriptor")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/regulator/fixed.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 1cb647ed70c6..a2d16e9abfb5 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -334,6 +334,7 @@ static int reg_fixed_voltage_probe(struct platform_de=
vice *pdev)
>  		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
>  				    "Failed to register regulator: %ld\n",
>  				    PTR_ERR(drvdata->dev));
> +		gpiod_put(cfg.ena_gpiod);
>  		return ret;
>  	}
> =20

I recently upgraded the kernel of my PINE64 Quartz64 - Model A (8GB) to
6.18 and saw several stack traces and the result was that it didn't see
my PCIe card which connects a USB drive to it.
Doing a ``git bisect`` led me to this commit/patch.
I'm assuming ``git bisect log`` output isn't useful.

Interestingly enough, I haven't seen it on any of my other Rockchip
based devices thus far: not on Rock 5B (rk3588) nor on NanoPi R5S
(rk3568). Both of these devices also use PCIe via a NVMe drive.

What's possibly relevant is that quite a lot of my kernel modules are
built as ``=3Dm``, which can/does affect probe order (apparently).

This is the call trace I'm seeing most often:

```
[   19.941158] Unable to handle kernel paging request at virtual address ff=
fffffffffffc78
[   19.941919] Mem abort info:
[   19.942182]   ESR =3D 0x0000000096000006
[   19.942530]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   19.943013]   SET =3D 0, FnV =3D 0
[   19.943298]   EA =3D 0, S1PTW =3D 0
[   19.943591]   FSC =3D 0x06: level 2 translation fault
[   19.944163] Data abort info:
[   19.944440]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
[   19.944938]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   19.945400]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   19.945887] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000003d460=
00
[   19.946496] [fffffffffffffc78] pgd=3D0000000000000000, p4d=3D00000000044=
77403, pud=3D0000000004478403, pmd=3D0000000000000000
[   19.947477] Internal error: Oops: 0000000096000006 [#1]  SMP
[   19.947997] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace sunr=
pc efi_pstore configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 rockchip_r=
ng xhci_plat_hcd xhci_hcd dw_hdmi_cec d
w_hdmi_i2s_audio rk808_regulator rtc_rk808 rk817_charger fan53555 rockchipd=
rm gpio_rockchip dw_hdmi_qp sdhci_of_dwcmshc dwmac_rk sdhci_pltfm dw_mipi_d=
si stmmac_platform sdhci dw_hdmi stmmac
 dw_mmc_rockchip analogix_dp fixed display_connector dw_mmc_pltfm drm_dp_au=
x_bus pcs_xpcs dwc3 phy_rockchip_inno_usb2 dw_wdt phy_rockchip_naneng_combp=
hy phylink pl330 cqhci drm_display_help
er dw_mmc cec rc_core drm_client_lib mdio_devres drm_dma_helper ehci_platfo=
rm udc_core of_mdio io_domain ehci_hcd fixed_phy drm_kms_helper ohci_platfo=
rm fwnode_mdio ohci_hcd libphy rockchip
_dfi drm usbcore i2c_rk3x ulpi mdio_bus usb_common
[   19.954611] CPU: 0 UID: 0 PID: 38 Comm: kworker/u16:3 Not tainted 6.18-r=
c6-arm64-cknow #1 PREEMPTLAZY  Debian 6.18~rc6-1
[   19.955602] Hardware name: Pine64 Quartz64 Model A (DT)
[   19.956084] Workqueue: events_unbound deferred_probe_work_func
[   19.956649] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   19.957284] pc : gpio_device_find+0x58/0x160
[   19.957692] lr : gpio_device_find+0x38/0x160
[   19.958094] sp : ffff80008024b810
[   19.958401] x29: ffff80008024b810 x28: 0000000000000001 x27: ffffde478c2=
3e248
[   19.959063] x26: 0000000000000000 x25: ffffffffffffefff x24: ffffde478b4=
8ba98
[   19.959722] x23: 0000000000000000 x22: ffff80008024b868 x21: ffffde478ce=
630a8
[   19.960380] x20: ffff0001ff04bee8 x19: fffffffffffffc40 x18: 00000000000=
0000a
[   19.961038] x17: 0000000082a13c1f x16: ffff000100356490 x15: 00000000000=
00000
[   19.961696] x14: 0000000000000000 x13: ffffde478cdd4838 x12: ffff8000810=
c0000
[   19.962353] x11: ffff8000812c0000 x10: ffff21b977a41118 x9 : ffffde478b4=
856c0
[   19.963012] x8 : 0101010101010101 x7 : 000000000000001a x6 : 00000000000=
00000
[   19.963670] x5 : ffffde478cbed940 x4 : 0000000000000001 x3 : ffff21ba6a7=
99000
[   19.964328] x2 : ffff000100935000 x1 : 0000000100000000 x0 : 00000000000=
00000
[   19.964988] Call trace:
[   19.965223]  gpio_device_find+0x58/0x160 (P)
[   19.965633]  of_get_named_gpiod_flags+0xf4/0x3a0
[   19.966070]  of_find_gpio+0x90/0x1b0
[   19.966412]  gpiod_find_by_fwnode+0x148/0x208
[   19.966822]  gpiod_find_and_request+0xa0/0x4b0
[   19.967239]  gpiod_get_index+0x60/0x90
[   19.967593]  devm_gpiod_get_index+0x28/0xa0
[   19.967985]  devm_gpiod_get_optional+0x20/0x48
[   19.968400]  rockchip_pcie_probe+0xa4/0x588
[   19.968800]  platform_probe+0x64/0xc0
[   19.969152]  really_probe+0xc8/0x3a0
[   19.969493]  __driver_probe_device+0x84/0x160
[   19.969902]  driver_probe_device+0x48/0x130
[   19.970295]  __device_attach_driver+0xc4/0x178
[   19.970714]  bus_for_each_drv+0x90/0xf8
[   19.971077]  __device_attach+0xa4/0x1c8
[   19.971440]  device_initial_probe+0x1c/0x38
[   19.971833]  bus_probe_device+0xa8/0xc0
[   19.972195]  deferred_probe_work_func+0xb8/0x120
[   19.972627]  process_one_work+0x170/0x3e0
[   19.973008]  worker_thread+0x25c/0x390
[   19.973362]  kthread+0x148/0x240
[   19.973678]  ret_from_fork+0x10/0x20
[   19.974030] Code: d10f0273 a9046bf9 92820019 d503201f (f9401e60)
[   19.974593] ---[ end trace 0000000000000000 ]---
```

it then gets followed by several other call traces, see f.e. here:
https://paste.sr.ht/~diederik/619211a270f27fca4fbf9438ac2bbfcc8401f47d

I also did a test where I removed the PCIe card from the PCIe slot (and
disabled any references to my USB drive), but still got the crash.

But booting the latest 'bisect kernel', thus based on this commit:
636f4618b1cd ("regulator: fixed: fix GPIO descriptor leak on register failu=
re")

gave a different call trace and landed me in the initramfs:

```
...
[    7.764336] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[    7.764948] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[    7.775498] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit address m=
ode.
[    7.776396] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    7.777013] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    7.777573] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 67,32 =
bit host data width,256 deep fifo
[    8.031099] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[    8.032588] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[    8.041752] rockchip-drm display-subsystem: bound fe040000.vop (ops vop2=
_component_ops [rockchipdrm])
[    8.053961] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit address m=
ode.
[    8.054694] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    8.055310] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    8.055949] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 67,32 =
bit host data width,256 deep fifo
[    8.177729] fan53555-regulator 0-001c: FAN53555 Option[12] Rev[15] Detec=
ted!
[    8.190700] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[    8.191317] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[    8.247794] rockchip-drm display-subsystem: bound fe040000.vop (ops rock=
chip_drm_fini [rockchipdrm])
[    8.307337] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit address m=
ode.
[    8.308195] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    8.308820] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    8.309384] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 67,32 =
bit host data width,256 deep fifo
[    8.513425] rk808-rtc rk808-rtc.4.auto: registered as rtc0
[    8.517302] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[    8.517922] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[    8.520914] rk808-rtc rk808-rtc.4.auto: setting system clock to 2025-12-=
04T10:30:22 UTC (1764844222)
[    8.539869] rockchip-drm display-subsystem: bound fe040000.vop (ops rock=
chip_drm_fini [rockchipdrm])
[    8.554583] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit address m=
ode.
[    8.555321] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    8.556030] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    8.556546] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[    8.556598] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 67,32 =
bit host data width,256 deep fifo
[    8.557114] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[    8.559859] rk_gmac-dwmac fe010000.ethernet: clock input or output? (inp=
ut).
[    8.560546] rk_gmac-dwmac fe010000.ethernet: TX delay(0x30).
[    8.561075] rk_gmac-dwmac fe010000.ethernet: RX delay(0x10).
[    8.561616] rk_gmac-dwmac fe010000.ethernet: integrated PHY? (no).
[    8.562256] rk_gmac-dwmac fe010000.ethernet: clock input from PHY
[    8.569953] rk_gmac-dwmac fe010000.ethernet: init for RGMII
[    8.571077] rk_gmac-dwmac fe010000.ethernet: User ID: 0x30, Synopsys ID:=
 0x51
[    8.571847] rk_gmac-dwmac fe010000.ethernet:         DWMAC4/5
[    8.572341] rk_gmac-dwmac fe010000.ethernet: DMA HW capability register =
supported
[    8.573032] rk_gmac-dwmac fe010000.ethernet: RX Checksum Offload Engine =
supported
[    8.573719] rk_gmac-dwmac fe010000.ethernet: TX Checksum insertion suppo=
rted
[    8.574362] rk_gmac-dwmac fe010000.ethernet: Wake-Up On Lan supported
[    8.575119] rk_gmac-dwmac fe010000.ethernet: TSO supported
[    8.575687] rk_gmac-dwmac fe010000.ethernet: Enable RX Mitigation via HW=
 Watchdog Timer
[    8.576429] rk_gmac-dwmac fe010000.ethernet: Enabled RFS Flow TC (entrie=
s=3D10)
[    8.577088] rk_gmac-dwmac fe010000.ethernet: TSO feature enabled
[    8.577640] rk_gmac-dwmac fe010000.ethernet: Using 32/32 bits DMA host/d=
evice width
[    8.581607] Unable to handle kernel paging request at virtual address 02=
ff342760bfa000
[    8.582364] Mem abort info:
[    8.582630]   ESR =3D 0x0000000096000004
[    8.582979]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    8.583465]   SET =3D 0, FnV =3D 0
[    8.583806]   EA =3D 0, S1PTW =3D 0
[    8.584107]   FSC =3D 0x04: level 0 translation fault
[    8.584556] Data abort info:
[    8.584825]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[    8.585326]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    8.585790]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    8.586276] [02ff342760bfa000] address between user and kernel address r=
anges
[    8.586924] Internal error: Oops: 0000000096000004 [#1]  SMP
[    8.587444] Modules linked in: rk808_regulator(+) rk817_charger rtc_rk80=
8 fan53555 rockchipdrm dw_hdmi_qp dw_mipi_dsi dw_hdmi analogix_dp drm_dp_au=
x_bus drm_display_helper dwmac_rk gpio_
rockchip stmmac_platform cec fixed display_connector stmmac rc_core drm_cli=
ent_lib pcs_xpcs sdhci_of_dwcmshc drm_dma_helper phylink sdhci_pltfm dwc3 d=
rm_kms_helper ehci_platform sdhci phy_r
ockchip_inno_usb2 mdio_devres pl330 dw_mmc_rockchip ohci_platform cqhci dw_=
wdt ehci_hcd ohci_hcd udc_core phy_rockchip_naneng_combphy dw_mmc_pltfm of_=
mdio rockchip_dfi dw_mmc fixed_phy drm
usbcore fwnode_mdio io_domain ulpi i2c_rk3x libphy usb_common mdio_bus
[    8.592659] CPU: 1 UID: 0 PID: 119 Comm: kworker/u16:4 Not tainted 6.18.=
0-rc4+ #9 PREEMPTLAZY
[    8.593452] Hardware name: Pine64 Quartz64 Model A (DT)
[    8.593935] Workqueue: events_unbound deferred_probe_work_func
[    8.594499] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    8.595139] pc : __srcu_read_lock+0x38/0x98
[    8.595539] lr : gpio_device_find+0x6c/0x160
[    8.595950] sp : ffff800080e4b5a0
[    8.596260] x29: ffff800080e4b5a0 x28: 0000000000000001 x27: ffffcbda959=
ecd50
[    8.596926] x26: 0000000000000000 x25: ffffffffffffefff x24: ffffcbdaa82=
77338
[    8.597588] x23: 0000000000000000 x22: ffff800080e4b618 x21: ffffcbdaa96=
71d28
[    8.598248] x20: ffffffffff600448 x19: ffffffffff600030 x18: 00000000000=
0000a
[    8.598908] x17: 0000000072de8d8d x16: ffffcbdaa8276e90 x15: 5f454c42495=
44150
[    8.599569] x14: 0000000000000000 x13: 3d4d554e51455300 x12: ffffcbdaa99=
571c0
[    8.600230] x11: 0000000000000000 x10: ffff3426602357e0 x9 : ffffcbdaa82=
70f94
[    8.600894] x8 : 0101010101010101 x7 : 0000000000736c6c x6 : 00000000000=
00000
[    8.601558] x5 : 030000000b050000 x4 : 0000000000000001 x3 : ffff342755b=
aa000
[    8.602223] x2 : ffff000104ec2680 x1 : 02ff342760bfa000 x0 : ffffffffff6=
00448
[    8.602885] Call trace:
[    8.603123]  __srcu_read_lock+0x38/0x98 (P)
[    8.603531]  gpio_device_find+0x6c/0x160
[    8.603913]  of_get_named_gpiod_flags+0xf4/0x3a0
[    8.604353]  of_find_gpio+0x90/0x1b0
[    8.604698]  gpiod_find_by_fwnode+0x148/0x208
[    8.605111]  gpiod_find_and_request+0xa0/0x4b0
[    8.605529]  gpiod_get_index+0x60/0x90
[    8.605883]  devm_gpiod_get_index+0x28/0xa0
[    8.606276]  devm_gpiod_get_optional+0x20/0x48
[    8.606691]  stmmac_mdio_reset+0x64/0x180 [stmmac]
[    8.607260]  __mdiobus_register+0x17c/0x460 [libphy]
[    8.607784]  __of_mdiobus_register+0xb8/0x240 [of_mdio]
[    8.608277]  stmmac_mdio_register+0x174/0x600 [stmmac]
[    8.608824]  stmmac_dvr_probe+0xb00/0xf40 [stmmac]
[    8.609315]  rk_gmac_probe+0x598/0x620 [dwmac_rk]
[    8.609773]  platform_probe+0x64/0xc0
[    8.610140]  really_probe+0xc8/0x3a0
[    8.610484]  __driver_probe_device+0x84/0x160
[    8.610896]  driver_probe_device+0x48/0x130
[    8.611292]  __device_attach_driver+0xc4/0x178
[    8.611710]  bus_for_each_drv+0x90/0xf8
[    8.612075]  __device_attach+0xa4/0x1c8
[    8.612439]  device_initial_probe+0x1c/0x38
[    8.612832]  bus_probe_device+0xa8/0xc0
[    8.613196]  deferred_probe_work_func+0xb8/0x120
[    8.613629]  process_one_work+0x170/0x3e0
[    8.614011]  worker_thread+0x25c/0x390
[    8.614365]  kthread+0x148/0x240
[    8.614678]  ret_from_fork+0x10/0x20
[    8.615029] Code: d2800024 aa0503e1 d53cd043 8b030021 (f824003f)
[    8.615592] ---[ end trace 0000000000000000 ]---
[    8.616085] note: kworker/u16:4[119] exited with preempt_count 1
[    8.625817] boost: Bringing 4700000uV into 5000000-5000000uV
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... =
done.
Begin: Running /scripts/local-premount ... done.
Begin: Waiting for root file system ... Begin: Running /scripts/local-block=
 ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
...
```

If you want/need more info, just ask.

Cheers,
  Diederik

