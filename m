Return-Path: <linux-pci+bounces-36816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45670B97C3C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3695619C8132
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E72236E8;
	Tue, 23 Sep 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfW/Ygyh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37C253B40
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668408; cv=none; b=ZHfszVw4keo9679wsijoFm/Nonrl/5u5yed3/DJDdcoDRyLCZvOhv1Xd2pdaMBLqwZ/78JzybSZBUrFXGwlj1r0e5NsfaI8CrqoaoZek0SswJZw2oyG1RyheFvdqDyejlB4qAPOiCO1MLm28CB2R5VbxpimZwHWCS4SkSN0ZYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668408; c=relaxed/simple;
	bh=DQfhhXIzQ4/yFuFqui8X9lnmS2vFtBgCOgajr6FqQaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hpRn65CSqNvIuLFaBC9O5eX2bIZZE5UqW/7YDuk5MD84kXVG6b1Q3XSWgthOqL/CLTg7YfJiv/2X/bEcqDKlpyuMC+pbtaLbDKB9LzRYjl162i0x6H1LOg7UqEDdAGyxGuJZWUns117NwokBhEGXDaURibVngQoQ1Rf7yd5bFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfW/Ygyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FFBC4CEF5;
	Tue, 23 Sep 2025 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758668407;
	bh=DQfhhXIzQ4/yFuFqui8X9lnmS2vFtBgCOgajr6FqQaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QfW/YgyhyF5gh9jlYNRZMfum65QehClQ1uQ9XSa31Qw9PNqwDM0CJyr+xbAz7uMIJ
	 aCtu6dVFnHG6V5LPSyJrQCF78N+ImKYN5VIoT8H21ncoQTxAJ2HQfwRkoTzjLypqXj
	 bRuV8rmVymuPtlqmpDrQaxzME5gInH0vF5a/G1BGlrl1yf00/oeiZY+aWP4GSbm2+K
	 +ABo3dnbqHhjjCrYbnyUCqYkLqptYgbKJfpeSv3sLsrd3uVwO0R8c/dvSe6ZkGvNC+
	 ZT8qODVwe7WZMbpCIRlAto/7jaQtJCTqITcIAO13UfyejxeTe/t6zpFfX6wFqWu6iQ
	 g1hLuHmjYIGOQ==
Date: Tue, 23 Sep 2025 18:00:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
Subject: Re: [i.MX8 PCIe] PCIe link fails after kexec
Message-ID: <20250923230006.GA2086105@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO6PR11MB558624C238AA9C39C9C6A936CD1DA@CO6PR11MB5586.namprd11.prod.outlook.com>

On Tue, Sep 23, 2025 at 03:35:56AM +0000, He, Guocai (CN) wrote:
> Hi all,
> 
> We are seeing a PCIe issue on i.MX8-based board when using kexec on
> Linux kernel 6.6,  we would appreciate your help to clarify whether
> this is a known problem or if there is a recommended fix.

Can you boot a recent kernel, e.g., v6.16 or v6.17-rc7, to make sure
you're not seeing an already-fixed problem?

If you can't try a recent kernel, please include your devicetree and
the complete dmesg log including both the initial boot and the kexec.

> ## Board & Setup
> Linux version 6.6.103-yocto-standard (oe-user@oe-host) (aarch64-wrs-linux-gcc (GCC) 13.4.0, GNU ld (GNU Binutils) 2
> .42.0.20240723) #1 SMP PREEMPT Wed Sep  3 20:13:35 UTC 2025
> 
> Machine model: Freescale i.MX8QM MEK
> PCIe device: Intel Corporation Wireless 7260
> 
> 
> ##Boot flow:
> #step 1: Initial boot: Linux kernel boot from tftp .
> setenv ipaddr 128.224.165.120
> setenv gatewayip 128.224.165.1
> setenv netmask 255.255.255.0
> setenv serverip 128.224.165.20
> 
> tftp 0x8a0000000 vlm-boards/29106/kernel
> tftp 0x8d0000000 vlm-boards/29106/dtb
> booti 0x8a0000000 - 0x8d0000000
> 
> 
> #step 2: Switch to another kernel on disk using kexec
> Reproduction steps
> root@nxp-imx8:~# mkdir /mnt/sdisk
> root@nxp-imx8:~# mount /dev/mmcblk0p1 /mnt/sdisk/
> root@nxp-imx8:~# scp ghe-cn@128.224.153.151:/folk/ghe-cn/images/Image /mnt/sdisk/kernel     //the images is the same.
> 
> root@nxp-imx8:~# kexec -l /mnt/sdisk/kernel --append="console=ttyLP0,115200 video=HDMI-A-1:1920x1080-32@60 rw root=
> /dev/nfs nfsroot=128.224.165.20:/export/pxeboot/vlm-boards/29105/rootfs,tcp,v3 ip=128.224.165.120:128.224.165.20:12
> 8.224.165.1:255.255.255.0::eth0:off selinux=0 enforcing=0"
> 
> root@nxp-imx8:~# kexec -e
> 
> 
> #After the second kernel boots, the PCIe link does not come up.
> #Key log differences
> 
> #####  boot (boot_cold.log):
> imx6q-pcie 5f010000.pcie: host bridge /bus@5f000000/pcie@5f010000 ranges:
> imx-drm display-subsystem: bound imx-drm-dpu-bliteng.2 (ops dpu_bliteng_ops)
> imx6q-pcie 5f000000.pcie: host bridge /bus@5f000000/pcie@5f000000 ranges:
> imx6q-pcie 5f000000.pcie:       IO 0x006ff80000..0x006ff8ffff -> 0x0000000000
> imx6q-pcie 5f000000.pcie:      MEM 0x0060000000..0x006fefffff -> 0x0060000000
> imx6q-pcie 5f000000.pcie: iATU: unroll F, 6 ob, 6 ib, align 4K, limit 4G
> imx6q-pcie 5f000000.pcie: eDMA: unroll F, 1 wr, 1 rd
> imx6q-pcie 5f000000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 5f000000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 5f000000.pcie: Link up, Gen1
> imx6q-pcie 5f000000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
> 
> #→ Link up successfully
> 
> root@nxp-imx8:~# lspci
> 00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
> 01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
> root@nxp-imx8:~#
> 
> 
> #####After kexec (boot_kexec.log):
> 
> imx6q-pcie 5f000000.pcie:       IO 0x006ff80000..0x006ff8ffff -> 0x0000000000
> imx6q-pcie 5f000000.pcie: iATU: unroll F, 6 ob, 6 ib, align 4K, limit 4G
> imx6q-pcie 5f000000.pcie: eDMA: unroll F, 1 wr, 1 rd
> 
> imx6q-pcie 5f000000.pcie: Phy link never came up
> imx6q-pcie 5f000000.pcie: Phy link never came up
> imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
> 
> #→ Link never comes up, no PCIe devices detected.
> 
> root@nxp-imx8:~# lspci
> 00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
> root@nxp-imx8:~#
> 
> 
> #Questions
> Are there existing patches or recommended workarounds for this scenario?
> Thanks for your time and any guidance you can provide.
> 
> Best regards,
> 
> Guocai

