Return-Path: <linux-pci+bounces-2972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F08466CF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8640F1C231CC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333BDF4C;
	Fri,  2 Feb 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN7iaCT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781BF4E3;
	Fri,  2 Feb 2024 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847056; cv=none; b=jEuuoSXcx2MjM+FiXl0j0GEToQxV8oUEZX1CRp6gDf2D+7opEYuFwZkcbZf1hRxGk8eqdWWPma0dNIobaO4frVRmCusUul5QZ/bKtRTSQchi5n9un12zb1otk0uAh8xdem04Bnbds1+ATi6xDVRTND7k/bCSNAV/z/7TsWTQO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847056; c=relaxed/simple;
	bh=+Ffo9v3Ht/o4mcti8U5GI4gV4HyIxKHb/r7AgyGznzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzT1VdwwU/26cpmgg449xOw6pYG184RKk9/Jf71SvV/SlYlLMV21EoSGImE2RyveQCdJ2AA1ek443R8YebAIqV+eEJRsYxg+BNPIo4BQQ7NoxrQJSckFW7Y+0krdD58YwMyUyS+0M166w/QMvAnm16tfm1Lnatg1KBoY5mBZtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN7iaCT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CAEC433C7;
	Fri,  2 Feb 2024 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706847056;
	bh=+Ffo9v3Ht/o4mcti8U5GI4gV4HyIxKHb/r7AgyGznzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN7iaCT9g4UWiQzXCpTiS8992VfmWKOI5qYCWbRbP+DIsqgQklSEpbY+p7AqtT7tg
	 P5asLrM3viXi7MubtEJJTaHlU7JJwsnFHVOJIlksNaQVcyXkoEURtC6Sa2+8eAaMLt
	 kGl3ioMfOqcHy/6G0bBdoFcn/jwu8yFgaH9aJFsYf7SPyc+W4zhpCYVHjVkbPRbxwm
	 XYhqmSOGuk70HljHMPBkCNleHVoFOLQoilp7AoR9dvXJieuBVP7jy52xvNNx1FAKSb
	 yYzRN53sehRA3J3AqjmhORvAH/QJW8z1WxeUM72y0P/2fDIBJHkXKogdKl8gL5LQMo
	 TBzQXd+kxFLXQ==
Date: Thu, 1 Feb 2024 22:10:52 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 0/9] power: sequencing: implement the subsystem and add
 first users
Message-ID: <2wrwli66ahwfpy6nkagzpacwvza7uvmrty7aw2cbujy2tq7bmx@axbtvmjv4tvn>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:23PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> I'd like to preface the cover letter by saying right away that this
> series is not complete. It's an RFC that presents my approach and is sent
> to the list for discussion. There are no DT bindings nor docs in
> Documentation/ yet. Please review it as an RFC and not an upstreambound
> series. If the approach is accepted as correct, I'll add missing bits.
> 
> The RFC[1] presenting my proposed device-tree representation of the
> QCA6391 package present on the RB5 board - while not really officially
> accepted - was not outright rejected which is a good sign.
> 
> This series incorporates it and builds a proposed power sequencing
> subsystem together with the first dedicated driver around it. Then it
> adds first two users: the Bluetooth and WLAN modules of the QCA6391.
> 
> The Bluetooth part is pretty straightforward. The WLAN however is a PCIe
> device and as such needs to be powered-up *before* it's detected on the
> PCI bus. To that end, we modify the PCI core to instantiate platform
> devices for existing DT child nodes of the PCIe ports. For those nodes
> for which a power-sequencing driver exists, we bind it and let it probe.
> The driver then triggers a rescan of the PCI bus with the aim of
> detecting the now powered-on device. The device will consume the same DT
> node as the platform, power-sequencing device. We use device links to
> make the latter become the parent of the former.
> 
> The main advantage of the above approach (both for PCI as well as
> generic power sequencers) is that we don't introduce significant changes
> in DT bindings and don't introduce new properties. We merely define new
> resources.
> 
> [1] https://lore.kernel.org/all/CAMRc=MckG32DQv7b1AQL-mbnYdx4fsdYWtLwCyXc5Ma7EeSAKw@mail.gmail.com/T/#md5dc62007d12f6833d4e51658b14e0493954ba68

FWIW, booting RB5 with this patch series does give me working working
WiFI. But I do see the following splat during boot:

[    5.880411] sysfs: cannot create duplicate filename '/devices/platform/soc@0/1c00000.pcie/pci0000:00/0000:00:00.0/resource0'
[    5.891938] CPU: 5 PID: 68 Comm: kworker/u16:4 Not tainted 6.8.0-rc2-next-20240131-00009-g079fdad54c8f #199
[    5.901927] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[    5.908808] Workqueue: events_unbound async_run_entry_fn
[    5.914274] Call trace:
[    5.916794]  dump_backtrace+0xec/0x108
[    5.920649]  show_stack+0x18/0x24
[    5.924062]  dump_stack_lvl+0x50/0x68
[    5.927826]  dump_stack+0x18/0x24
[    5.931238]  sysfs_warn_dup+0x64/0x80
[    5.935004]  sysfs_create_bin_file+0xf4/0x130
[    5.939480]  pci_create_attr+0x100/0x168
[    5.943509]  pci_create_sysfs_dev_files+0x6c/0xc0
[    5.948337]  pci_bus_add_device+0x60/0x114
[    5.952551]  pci_bus_add_devices+0x4c/0x7c
[    5.956762]  pci_host_probe+0x138/0x188
[    5.960700]  dw_pcie_host_init+0x290/0x334
[    5.964914]  qcom_pcie_probe+0x1f8/0x23c
[    5.968942]  platform_probe+0xa8/0xd0
[    5.972707]  really_probe+0x130/0x2e4
[    5.976469]  __driver_probe_device+0xa0/0x128
[    5.980944]  driver_probe_device+0x3c/0x1f8
[    5.985245]  __device_attach_driver+0x118/0x140
[    5.989897]  bus_for_each_drv+0xf4/0x14c
[    5.993923]  __device_attach_async_helper+0x78/0xd0
[    5.998937]  async_run_entry_fn+0x24/0xdc
[    6.003051]  process_scheduled_works+0x210/0x328
[    6.007793]  worker_thread+0x28c/0x450
[    6.011642]  kthread+0xfc/0x184
[    6.014865]  ret_from_fork+0x10/0x20
[    6.018572] ------------[ cut here ]------------
[    6.023339] proc_dir_entry '0000:00/00.0' already registered

Regards,
Bjorn

