Return-Path: <linux-pci+bounces-14327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C852F99A66D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C9928564C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4002BCFF;
	Fri, 11 Oct 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAksQDnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573E2C181;
	Fri, 11 Oct 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657387; cv=none; b=FEhuNRGfRXIJKzW/UeLJ7+eVNagEiV1YhLGBC2rO6VTqSs8XJRAFODNCSWtHGa3EVvqTfGdcbk625xNftJSBH99jhN17p02tn/0Qm5SNNwaG3VMMG0A75CLsqnYhfLicfQdsrMdu8BoDqpF3cdCfD74IAuUCTm3eQbRYUK9JrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657387; c=relaxed/simple;
	bh=S/gBI6wBV/CBFfLTQS/Sr9jpxcODjvvha33rK1iqEkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQXgVTW6A6/akyjDHnZvvCPLaywkn0043T9bUxGxU+7ezUYl8/gGFC32aPxe7xJrXoUgnDdLtAHoMMPwP92kj9S59yEDt/AdEmnM9kLR7SY5XTVSu47smNsLCIVVlb2aDz3hY7ZWHZjh3wqjDSBErGA0ctUgtHS10rMd28SaIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAksQDnY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so22798235e9.3;
        Fri, 11 Oct 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728657384; x=1729262184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/UtyB2uWIm739F4MXYMRShLe9+F8H6vI52MdDvVTyA=;
        b=kAksQDnYxIvBuKhktmbGf8IrR7agYnrMgMgMf1NMOK8JmxJuKyRdCgBN8OIdmtMrnM
         bnawpScXtVK6M5g9IPN/C0jaeyTW/Rt9hAh5KJclAL3zB7VN8Cb9MfoheUaGfOwCKM3Q
         9EWkx8CiiHxA40k8BYb7CI4mJ1uaFT7VJk6SWNEt3VENlFv1GlTnsp2H4OpB4tdHEzHh
         rCc8S4jFbLt+0OUcb9QQ+oE9bbGXU93bJP0oPfNzb83HLMExBmIij25PBIJq2MzevKe1
         PmUZyeXqcOxSeS//cZkX82WanbnLpwV1E/x/0QRaEUVD4NWgQW3ebQhjQtxEtCfzI3g3
         rQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657384; x=1729262184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/UtyB2uWIm739F4MXYMRShLe9+F8H6vI52MdDvVTyA=;
        b=II13Cgo/09NRKn/WV8qmuHX6o+x/dghDCnDtz+HvC/k0MEo2DYj/WcjIt9tvnL78Ku
         RDLtXxhNnro8IIhQcmwt0qQahVXDwT9bCGeUnwfAtxr+mhsAuw35Ipbeka0zyBEilx7H
         AuIucq5ifYftpaDIr8loZDnc5QVKO1ZLXDpv7LgKn+ILy6uzqQN0rkqz23fKqHvrIv7H
         QMK+u2FXnkZt3c5ANY35XEF33kz15uYqMAM/ExcuFWIk2QY2AOpt0W2++Qx84Hde6yq0
         /JPp0OF8Chp7kcwyNkqp4tYM384L6rWrxV2d6Q++K12mgSHxiyDw8BFM6JI4RH5E82w0
         wlDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3eVwzkIxXOp8Vxq3V6RoilHqqV/jB3RO0qGhCZ/6jHMt46NbhRbGWIn0Hdx9LUCgcf/Hh6nBC9Ne2bVU=@vger.kernel.org, AJvYcCWo4BDB3lizvhDXbPFG3R7UT8WPZjgg2wZ4/ghhuZceVIpRshc2ZEdsfz5BQk0aqWqFwjsgcdYX1QTE@vger.kernel.org
X-Gm-Message-State: AOJu0YwtegW22NyKip4SfApz1r3CbxV7Fn43CDZKe4Bw4c98HC8OKhJx
	SwhI4r4gkYJ7m2M7hm8IzsU/riVHGklqt9Ayy8ExZzDcbZrRRhiU
X-Google-Smtp-Source: AGHT+IFlnrR3OqGd8XdhiXG/glDXZS1+OWZdJWElmbQjUA5D2o+fvQ2WDzXsVd68UTgo7ViCacocYQ==
X-Received: by 2002:a5d:62c2:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d55199c2dmr2624425f8f.16.1728657383878;
        Fri, 11 Oct 2024 07:36:23 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:5e49:8e15:b881:5968])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9180f8sm4071123f8f.115.2024.10.11.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:36:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:36:21 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <Zwk35efNI4EO1eir@eichest-laptop>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb>
 <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>

Hi Frank,

On Thu, Oct 10, 2024 at 06:45:17PM -0400, Frank Li wrote:
> On Thu, Oct 10, 2024 at 10:11:21PM +0200, Francesco Dolcini wrote:
> > Hello Frank,
> >
> > On Thu, Oct 10, 2024 at 04:01:21PM -0400, Frank Li wrote:
> > > On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > >
> > > > The suspend/resume support is broken on the i.MX6QDL platform. This
> > > > patch resets the link upon resuming to recover functionality. It shares
> > > > most of the sequences with other i.MX devices but does not touch the
> > > > critical registers, which might break PCIe. This patch addresses the
> > > > same issue as the following downstream commit:
> > > > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > > > In comparison this patch will also reset the device if possible. Without
> > > > this patch suspend/resume will not work if a PCIe device is connected.
> > > > The kernel will hang on resume and print an error:
> > > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > > > 8<--- cut here ---
> > > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > > >
> > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > ---
> > >
> > > Thank you for your patch.
> > >
> > > But it may conflict with another suspend/resume patch
> > > https://lore.kernel.org/imx/1727245477-15961-8-git-send-email-hongxing.zhu@nxp.com/
> >
> > Thanks for the head-up.
> >
> > Do you see any issue with this patch apart that? Because this patch is
> > fixing a crash, so I would expect this to be merged, once ready, and
> > such a series rebased afterward.
> >
> > I am writing this explicitly since you wrote a similar comment on the
> > v1 (https://lore.kernel.org/all/ZsNXDq%2FkidZdyhvD@lizhi-Precision-Tower-5810/)
> > and I would like to prevent to have this fix starving for long just because
> > multiple people is working on the same driver.
> 
> My key comment for this patch is use flags IMX_PCIE_FLAG_SKIP_TURN_OFF
> in suspend()/resume(), it is up to kw to pick which one firstly.

I will try to implement it as you proposed with the new flag. 

However, what I figured out with kernel v6.12-rc1 I get the following
warning when booting on an i.MX6QDL even without my patch applied:
[    1.901199] PCI: bus0: Fast back to back transfers disabled
[    1.904754] mmc1: SDHCI controller on 2190000.mmc [2190000.mmc] using ADMA
[    1.904914] mmc2: SDHCI controller on 2194000.mmc [2194000.mmc] using ADMA
[    1.910686] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
[    1.918390] NET: Registered PF_PACKET protocol family
[    1.918573] mmc0: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
[    1.924322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    1.931635] Key type dns_resolver registered
[    1.936764] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    1.961043] pci 0000:01:00.0: supports D1 D2
[    1.961526] Registering SWP/SWPB emulation handler
[    1.965601] mmc0: new DDR MMC card at address 0001
[    1.976575] mmcblk0: mmc0:0001 Q2J54A 3.59 GiB
[    1.979794] Loading compiled-in X.509 certificates
[    1.985036] PCI: bus1: Fast back to back transfers disabled
[    1.991531] pci 0000:00:00.0: bridge window [mem 0x01000000-0x011fffff]: assigned
[    1.998742]  mmcblk0: p1 p2 p3
[    1.999163] pci 0000:00:00.0: BAR 0 [mem 0x01200000-0x012fffff]: assigned
[    2.003947] mmcblk0boot0: mmc0:0001 Q2J54A 16.0 MiB
[    2.008990] pci 0000:00:00.0: bridge window [mem 0x01300000-0x013fffff pref]: assigned
[    2.009023] pci 0000:00:00.0: ROM [mem 0x01400000-0x0140ffff pref]: assigned
[    2.009054] pci 0000:01:00.0: BAR 0 [mem 0x01000000-0x011fffff 64bit]: assigned
[    2.017526] mmcblk0boot1: mmc0:0001 Q2J54A 16.0 MiB
[    2.022015] pci 0000:01:00.0: ROM [mem 0x01300000-0x0130ffff pref]: assigned
[    2.032133] mmcblk0rpmb: mmc0:0001 Q2J54A 512 KiB, chardev (242:0)
[    2.036347] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.036370] pci 0000:00:00.0:   bridge window [mem 0x01000000-0x011fffff]
[    2.036384] pci 0000:00:00.0:   bridge window [mem 0x01300000-0x013fffff pref]
[    2.042552] pps pps0: new PPS source ptp0
[    2.048338] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    2.083626] pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
[    2.089972] pci_bus 0000:01: resource 1 [mem 0x01000000-0x011fffff]
[    2.093461] fec 2188000.ethernet eth0: registered PHC device 0
[    2.096283] pci_bus 0000:01: resource 2 [mem 0x01300000-0x013fffff pref]
[    2.096352] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/resource0'
[    2.096365] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
[    2.096381] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.096391] Workqueue: async async_run_entry_fn
[    2.103025] imx_thermal 20c8000.anatop:tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
[    2.108932]
[    2.108940] Call trace:
[    2.108950]  unwind_backtrace from show_stack+0x10/0x14
[    2.121391] clk: Disabling unused clocks
[    2.127423]  show_stack from dump_stack_lvl+0x54/0x68
[    2.127451]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
[    2.134265] PM: genpd: Disabling unused power domains
[    2.138525]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
[    2.138547]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
[    2.149242] ALSA device list:
[    2.150647]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
[    2.153183]   No soundcards found.
[    2.158407]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
[    2.211699]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
[    2.217930]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
[    2.223806]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
[    2.229682]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
[    2.235559]  imx_pcie_probe from platform_probe+0x5c/0xb0
[    2.241010]  platform_probe from really_probe+0xd0/0x3a4
[    2.246364]  really_probe from __driver_probe_device+0x8c/0x1d4
[    2.252321]  __driver_probe_device from driver_probe_device+0x30/0xc0
[    2.258803]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
[    2.265892]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
[    2.272980]  async_run_entry_fn from process_one_work+0x154/0x2dc
[    2.279115]  process_one_work from worker_thread+0x250/0x3f0
[    2.284811]  worker_thread from kthread+0x110/0x12c
[    2.289726]  kthread from ret_from_fork+0x14/0x28
[    2.294461] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
[    2.299535] dfa0:                                     00000000 00000000 00000000 00000000
[    2.307740] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.315942] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.323156] pcieport 0000:00:00.0: PME: Signaling with IRQ 293
[    2.329645] pcieport 0000:00:00.0: AER: enabled with IRQ 293
[    2.335553] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/resource0'
[    2.347794] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
[    2.355229] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.361779] Workqueue: async async_run_entry_fn
[    2.366349] Call trace:
[    2.366362]  unwind_backtrace from show_stack+0x10/0x14
[    2.374183]  show_stack from dump_stack_lvl+0x54/0x68
[    2.379273]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
[    2.384706]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
[    2.391183]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
[    2.398270]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
[    2.405360]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
[    2.412113]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
[    2.418334]  pci_bus_add_devices from pci_bus_add_devices+0x60/0x70
[    2.424642]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
[    2.430511]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
[    2.436384]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
[    2.442258]  imx_pcie_probe from platform_probe+0x5c/0xb0
[    2.447704]  platform_probe from really_probe+0xd0/0x3a4
[    2.453057]  really_probe from __driver_probe_device+0x8c/0x1d4
[    2.459014]  __driver_probe_device from driver_probe_device+0x30/0xc0
[    2.465493]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
[    2.472580]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
[    2.479666]  async_run_entry_fn from process_one_work+0x154/0x2dc
[    2.485800]  process_one_work from worker_thread+0x250/0x3f0
[    2.491494]  worker_thread from kthread+0x110/0x12c
[    2.496408]  kthread from ret_from_fork+0x14/0x28
[    2.501140] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
[    2.506214] dfa0:                                     00000000 00000000 00000000 00000000
[    2.514418] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.522620] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

This was not the case with kernel v6.11, do you have an idea where this
comes from? I did not dig into more detail yet but it looks a bit like a
regression. The driver still works, it just prints this duplicate
filename warning.

Regards,
Stefan

