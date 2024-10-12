Return-Path: <linux-pci+bounces-14349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323099AFCB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337B52863A3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 00:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A504C8E;
	Sat, 12 Oct 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lf+Xx5wn"
X-Original-To: linux-pci@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911CBA49
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694789; cv=none; b=AEuQaeDaYBUxbV2GtpzqGxZ1VNKihOLQnQvlUUlTwF4GvGoJJG35J3m3D6je0QWW9qPlDUVKn6wbQYOhms9KnuYK41ypFsYVV59qgMvugpnoAXMCR/bZ7W9V3m6pVnmvvJV8ocp0pNdE6HTZZ6KM+3rWGVhT2UZufo0XVJvTMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694789; c=relaxed/simple;
	bh=yDYkcV6cdnacrnapNq24AizVconi9kvrngRjijgkhZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zky+w2AovskLrkgCmpsmPu0S3NSka1zjdM6VjlNgSc8ZQWcQmr5H3CU8vP1TdIj6gGmn7o7x+1pfJYGdPXqeI/lWSA+oPQ/Gg/WQ1IewvZ8nr3GhtomqoYvwEVXt7bkoFvyvqqi8VFxSYghMvHeKd5rmO/1kECx4/PsYWSIzCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lf+Xx5wn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6AFC58941B;
	Sat, 12 Oct 2024 02:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728694785;
	bh=rA9XKhaCRgFuzm1aCCzhmVRj/xXetKx5VHobtlsICAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lf+Xx5wnL/KxxFow8BW1n+3JrwlVaFJ8UI+nSb6WYynuurjMLVHd6Wr74OcsM1ta9
	 JTa9yq0CL8sJCXZ70AGvN8M9R3gkh8y+bA4n7RoqyFLdHG0hdGrxpAYNdyZ/mItxJu
	 T8piQ40dmJ/B+eQZi/fBQyLPpQ3cysRm0KL95An0X18470rnV0+C6feCZ8ou5q76Kc
	 2VqDYQSgxcIp9GeuIpNjBeHegfK91KzAPx4byeg6BG2kh7NXRSmMts8m+KGqxsHPz7
	 FPKYDTPC0kk5rIfG1vYo7bHjABHStkYfZqUE7+aAZUbLvKAuZ3XzEFwl4gC/hNlxyl
	 FGkClUInnTj3Q==
Message-ID: <a1cdad18-369e-4b12-afed-8b6b60f4d86f@denx.de>
Date: Sat, 12 Oct 2024 02:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20241012004857.218874-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241012004857.218874-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/12/24 2:48 AM, Marek Vasut wrote:
> I am sending this as RFC, because I can only trigger it sporadically on
> Linux 6.6.54 , but I believe this was around for a while. The rationale
> might also be far from perfect. This is NOT a proper fix for the issue.
> 
> The pci_host_probe() and pci_bus_type RPM suspend seem to race against each
> other at least in Linux kernel up to 6.6.54 . The problem occurs when the
> PCIe host controller driver, in this case DWC i.MX6, is sufficiently delayed
> by EPROBE_DEFER from one if its clocks, in this case the PCIe bus clock
> provided by RS9 clock synthesizer driver which is compiled as a module and
> loaded about a minute after boot. Once the RS9 module is loaded and the
> bus clock become available, the probe of DWC iMX6 controller driver can
> proceed.
> 
> At that point, imx6_pcie_probe() triggers pci_host_probe(), while at the
> same time, devices instantiated with pci_bus_type can already enter RPM
> suspend via pci_bus_type pci_pm_runtime_idle() / pci_pm_runtime_suspend()
> callbacks.
> 
> The pci_host_probe() does reallocate BARs for devices which start up with
> uninitialized BAR addresses set to 0 by calling pci_bus_assign_resources(),
> which updates the device config space content.
> 
> At the same time, pci_pm_runtime_suspend() triggers pci_save_state() for
> all devices which do not have drivers assigned to them to store current
> content of their config space registers.
> 
> This leads to a race condition between pci_bus_assign_resources() and
> pci_save_state(). In case pci_save_state() wins and gets called before
> pci_bus_assign_resources(), the content stored by pci_save_state() is
> the incorrect pre-pci_bus_assign_resources() content, which is usually
> one with BARs set to invalid addresses and possibly other invalid
> configuration.
> 
> Once either a driver or manual RPM control attempts to start the device
> up, that invalid content is restored into the device config space and
> the device becomes inoperable. If the BARs are restored to zeroes, then
> the device stops responding to BAR memory accesses, while it still does
> respond to config space accesses.
> 
> Work around the issue by not suspending pci_bus_type devices which do
> not have driver assigned to them, keep those devices active to prevent
> pci_save_state() from being called. Once a proper driver takes over, it
> can RPM manage the device correctly.
> 
> Invalid ordering and backtrace is below, visualized with this extra print
> added to drivers/pci/setup-res.c :
> 
> "
> @@ -108,6 +108,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>                          resno, new, check);
>          }
> 
> +       pci_err(dev, "BAR %d: updated (%#010x != %#010x)\n", resno, new, check);
> +
>          if (res->flags & IORESOURCE_MEM_64) {
>                  new = region.start >> 16 >> 16;
>                  pci_write_config_dword(dev, reg + 4, new);
> "
> 
> "
> [   47.042906] pci 0000:01:00.0: save config 0x10: 0x00000004
> ...
> [   47.079863] pci 0000:01:00.0: BAR 0: updated (0x18100004 != 0x18100004)
> ...
> "
> 
> "
> [   47.274095]  pci_update_resource+0x1f0/0x260
> [   47.278370]  pci_assign_resource+0x22c/0x234
> [   47.282643]  assign_requested_resources_sorted+0x6c/0xac
> [   47.287959]  __assign_resources_sorted+0xfc/0x424
> [   47.292669]  __pci_bus_assign_resources+0x68/0x1f4
> [   47.297463]  __pci_bus_assign_resources+0xec/0x1f4
> [   47.302258]  pci_bus_assign_resources+0x1c/0x24
> [   47.306792]  pci_host_probe+0x88/0xa4
> [   47.310457]  dw_pcie_host_init+0x17c/0x530
> [   47.314560]  imx6_pcie_probe+0x698/0x708
> [   47.318487]  platform_probe+0x6c/0xb8
> [   47.322153]  really_probe+0x140/0x278
> [   47.325818]  __driver_probe_device+0xf4/0x10c
> [   47.330177]  driver_probe_device+0x40/0xf8
> [   47.334277]  __device_attach_driver+0x60/0xd4
> [   47.338638]  bus_for_each_drv+0xb4/0xdc
> [   47.342476]  __device_attach_async_helper+0x78/0xcc
> [   47.347357]  async_run_entry_fn+0x38/0xe0
> [   47.351369]  process_scheduled_works+0x1cc/0x2b8
> [   47.355991]  worker_thread+0x214/0x25c
> [   47.359744]  kthread+0xec/0xfc
> [   47.362804]  ret_from_fork+0x10/0x20
> "
> "
> [   47.575814]  pci_save_state+0xcc/0x224
> [   47.579567]  pci_pm_runtime_suspend+0x44/0x16c
> [   47.584013]  __rpm_callback+0x48/0x124
> [   47.587764]  rpm_callback+0x70/0x74
> [   47.591254]  rpm_suspend+0x26c/0x424
> [   47.594831]  rpm_idle+0x190/0x1c0
> [   47.598149]  pm_runtime_work+0x8c/0x9c
> [   47.601900]  process_scheduled_works+0x1cc/0x2b8
> [   47.606524]  worker_thread+0x214/0x25c
> [   47.610278]  kthread+0xec/0xfc
> [   47.613338]  ret_from_fork+0x10/0x20
The backtraces are collected at the very end of pci_update_resource() 
and pci_save_state() using WARN_ON(), so the timestamps do not match, 
but at least they include the call stack how those functions were 
reached when this problem occurred .

