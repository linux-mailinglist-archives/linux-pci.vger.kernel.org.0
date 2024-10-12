Return-Path: <linux-pci+bounces-14360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351C99B127
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B631C2169A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDA86277;
	Sat, 12 Oct 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf2xl8gI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703383CDB
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713022; cv=none; b=maGVedleObUH/Z2Cd+yfUEGX+meHHjvVG07M0aLAkIIqvvF4wYsAoCKcSqrpZAbi4a5c+aj3esh66BAA5cssoDvIBA1vA7kFHndA2UAc66OoqKIy7XUIDckApyk1Al1rxjrdWuk5cUixFevKcBsKn/G7aFwNiFvgdJ9jM7kbJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713022; c=relaxed/simple;
	bh=J2TustJFmQhWXjGx6NOiuh9awKxLdvCa94b52DO9Lqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1usDeixC7cPnt1TckfgFXhpcCpWoBCdrDLd+fzu1sJe75cFHBWVaK2qJToXI4ntPfSQY4e7rKQXl2VDcV5ud+N3xf2qydzmLWKBLg3V/q0s38cM4D3eUDkd0Jm+Ya0KJkDIeZSvd2Op9EoZI2PqJYqpm2Xi+ThGHd6CTbbm9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bf2xl8gI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1329423a91.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728713020; x=1729317820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7i1vG7nS3MEbwW7yINVeMEOCisWKNqd/JkjCeZOvZc=;
        b=bf2xl8gIq5ftwov/YcCzzPOw6je5BFRUVJVUQPy3pgS+pCDMIKBI53KORZxTL7VmmT
         pPCuPdGrwlUTysum6syNshzM6VDeh7jR0glhU5izZ/p8vbHY1mloBwBJtQnJJyRiZI4n
         vfsljGK1hs7sMEseT17kySDSEoL4fdXFqVbYpneBQmkHmNXtT/fq2sq8hyjis9dHKeZy
         j2N3C1jZLYQONE/tgyaKOohUB6aiz93HqqrX/pCB+oA1pe5Wij3W5iW3T8hZfrE1cELB
         PItjZkuWUoznWYZqLVxLQwmM5Zym3KC76qomTcH96X0pqgk6FUFgNCGtG2eArXHs5oom
         Wvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713020; x=1729317820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7i1vG7nS3MEbwW7yINVeMEOCisWKNqd/JkjCeZOvZc=;
        b=kJEsvzk7iNMClkuGJ0Z2SYcqMsoNBJ/JtSHz6mf4qwxLnYdqTvJNUax8WYiUmLTPA7
         w/hwIUQbAuLVD42wydgcDQWa/+i+H5usNTcvNYp3fVNn+/VFhxbYVMVbrnWOq/8ABnil
         O0G3hNhGjJkOEE+U/9VcieYODRFCqY3V0h9J/B7BoN4z9Wj2MXoj6ELaAGQ3wt9K5/V+
         zECXkEliNjemo+LGDDmApy/ooTg6pif+xMANQG8smNGbWkwNyUPCPPsOua0Ia1iJHG2j
         qJjYHtsYB9nAiFUDITTRzX0YAb9TA/oBe5tO+TmiHOutKLzIEOay00Q3DO5+jrKR9Y4G
         MirA==
X-Forwarded-Encrypted: i=1; AJvYcCWnMIjI2jiFYaqLbWDvzsWmOnXerlPyrzGA7PRm0Dkhskz6IzZbUOqdeRrdgwXsTX4xxOdK6BC9BYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbzCfxpvj8anXJ8c4VgHtVgWwq3xOnJYIC7Ci6sdl422UIi86
	rezGt6De83MjHETV+qqS/pcI+huCxqFzJrjccBCcXpSYQNkGU561XvrPoAZItw==
X-Google-Smtp-Source: AGHT+IF4cxofKdamMXoh6GejxCThsjFpoK4fI8ENq63PGBWZFrQ03WP1/0ig+veyGFwj0STjKLLEwg==
X-Received: by 2002:a17:90a:ff0e:b0:2e2:d3ab:2d77 with SMTP id 98e67ed59e1d1-2e31538f3edmr2150039a91.39.1728713019980;
        Fri, 11 Oct 2024 23:03:39 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa6fc6sm4294003a91.43.2024.10.11.23.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:03:39 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:33:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
	hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241012060332.54ppztpztp37p224@thinkpad>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb>
 <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
 <Zwk35efNI4EO1eir@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwk35efNI4EO1eir@eichest-laptop>

On Fri, Oct 11, 2024 at 04:36:21PM +0200, Stefan Eichenberger wrote:

[...]

> However, what I figured out with kernel v6.12-rc1 I get the following
> warning when booting on an i.MX6QDL even without my patch applied:
> [    1.901199] PCI: bus0: Fast back to back transfers disabled
> [    1.904754] mmc1: SDHCI controller on 2190000.mmc [2190000.mmc] using ADMA
> [    1.904914] mmc2: SDHCI controller on 2194000.mmc [2194000.mmc] using ADMA
> [    1.910686] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
> [    1.918390] NET: Registered PF_PACKET protocol family
> [    1.918573] mmc0: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
> [    1.924322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> [    1.931635] Key type dns_resolver registered
> [    1.936764] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> [    1.961043] pci 0000:01:00.0: supports D1 D2
> [    1.961526] Registering SWP/SWPB emulation handler
> [    1.965601] mmc0: new DDR MMC card at address 0001
> [    1.976575] mmcblk0: mmc0:0001 Q2J54A 3.59 GiB
> [    1.979794] Loading compiled-in X.509 certificates
> [    1.985036] PCI: bus1: Fast back to back transfers disabled
> [    1.991531] pci 0000:00:00.0: bridge window [mem 0x01000000-0x011fffff]: assigned
> [    1.998742]  mmcblk0: p1 p2 p3
> [    1.999163] pci 0000:00:00.0: BAR 0 [mem 0x01200000-0x012fffff]: assigned
> [    2.003947] mmcblk0boot0: mmc0:0001 Q2J54A 16.0 MiB
> [    2.008990] pci 0000:00:00.0: bridge window [mem 0x01300000-0x013fffff pref]: assigned
> [    2.009023] pci 0000:00:00.0: ROM [mem 0x01400000-0x0140ffff pref]: assigned
> [    2.009054] pci 0000:01:00.0: BAR 0 [mem 0x01000000-0x011fffff 64bit]: assigned
> [    2.017526] mmcblk0boot1: mmc0:0001 Q2J54A 16.0 MiB
> [    2.022015] pci 0000:01:00.0: ROM [mem 0x01300000-0x0130ffff pref]: assigned
> [    2.032133] mmcblk0rpmb: mmc0:0001 Q2J54A 512 KiB, chardev (242:0)
> [    2.036347] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    2.036370] pci 0000:00:00.0:   bridge window [mem 0x01000000-0x011fffff]
> [    2.036384] pci 0000:00:00.0:   bridge window [mem 0x01300000-0x013fffff pref]
> [    2.042552] pps pps0: new PPS source ptp0
> [    2.048338] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
> [    2.083626] pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> [    2.089972] pci_bus 0000:01: resource 1 [mem 0x01000000-0x011fffff]
> [    2.093461] fec 2188000.ethernet eth0: registered PHC device 0
> [    2.096283] pci_bus 0000:01: resource 2 [mem 0x01300000-0x013fffff pref]
> [    2.096352] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/resource0'
> [    2.096365] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
> [    2.096381] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.096391] Workqueue: async async_run_entry_fn
> [    2.103025] imx_thermal 20c8000.anatop:tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
> [    2.108932]
> [    2.108940] Call trace:
> [    2.108950]  unwind_backtrace from show_stack+0x10/0x14
> [    2.121391] clk: Disabling unused clocks
> [    2.127423]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.127451]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> [    2.134265] PM: genpd: Disabling unused power domains
> [    2.138525]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> [    2.138547]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
> [    2.149242] ALSA device list:
> [    2.150647]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
> [    2.153183]   No soundcards found.
> [    2.158407]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
> [    2.211699]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> [    2.217930]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> [    2.223806]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> [    2.229682]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> [    2.235559]  imx_pcie_probe from platform_probe+0x5c/0xb0
> [    2.241010]  platform_probe from really_probe+0xd0/0x3a4
> [    2.246364]  really_probe from __driver_probe_device+0x8c/0x1d4
> [    2.252321]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [    2.258803]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> [    2.265892]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> [    2.272980]  async_run_entry_fn from process_one_work+0x154/0x2dc
> [    2.279115]  process_one_work from worker_thread+0x250/0x3f0
> [    2.284811]  worker_thread from kthread+0x110/0x12c
> [    2.289726]  kthread from ret_from_fork+0x14/0x28
> [    2.294461] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> [    2.299535] dfa0:                                     00000000 00000000 00000000 00000000
> [    2.307740] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.315942] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.323156] pcieport 0000:00:00.0: PME: Signaling with IRQ 293
> [    2.329645] pcieport 0000:00:00.0: AER: enabled with IRQ 293
> [    2.335553] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/resource0'
> [    2.347794] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
> [    2.355229] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.361779] Workqueue: async async_run_entry_fn
> [    2.366349] Call trace:
> [    2.366362]  unwind_backtrace from show_stack+0x10/0x14
> [    2.374183]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.379273]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> [    2.384706]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> [    2.391183]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
> [    2.398270]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
> [    2.405360]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
> [    2.412113]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> [    2.418334]  pci_bus_add_devices from pci_bus_add_devices+0x60/0x70
> [    2.424642]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> [    2.430511]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> [    2.436384]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> [    2.442258]  imx_pcie_probe from platform_probe+0x5c/0xb0
> [    2.447704]  platform_probe from really_probe+0xd0/0x3a4
> [    2.453057]  really_probe from __driver_probe_device+0x8c/0x1d4
> [    2.459014]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [    2.465493]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> [    2.472580]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> [    2.479666]  async_run_entry_fn from process_one_work+0x154/0x2dc
> [    2.485800]  process_one_work from worker_thread+0x250/0x3f0
> [    2.491494]  worker_thread from kthread+0x110/0x12c
> [    2.496408]  kthread from ret_from_fork+0x14/0x28
> [    2.501140] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> [    2.506214] dfa0:                                     00000000 00000000 00000000 00000000
> [    2.514418] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.522620] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> This was not the case with kernel v6.11, do you have an idea where this
> comes from? I did not dig into more detail yet but it looks a bit like a
> regression. The driver still works, it just prints this duplicate
> filename warning.

Could you please do bisect to find the offending commit?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

