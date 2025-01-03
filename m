Return-Path: <linux-pci+bounces-19219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B650A008AA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC001884ECD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA031F8F1C;
	Fri,  3 Jan 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO+H8Zv+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C11F9F6C;
	Fri,  3 Jan 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903895; cv=none; b=saf6qBLHJ+7SGug8SgQULObyCyQ9kGcLdDgsYRT8va0/3lk28Uy2fIFw3gNg4+46On+4lozMA2XurWDyCWbk/UFNcFEJA5+32XQmqWPUwHEE+5yvW1wgoKs9rfAVyvxmwrlQYNu+jhCpWcBRi3TsqWeAjoDtEWsT/Md5I6mV2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903895; c=relaxed/simple;
	bh=zYEH+HVQjOp1upkvfQMtNMfVF+BOz626fvcOYHVDo6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6tIWOl8dvnVz2B1xUvTOdRtadgfoxIHafwtYruS8r3jQukTjSD536bECTh7nzPcohXnn4LssMMKdqF4VIk0yJnd1CII9jubQsE68aRFaTyahEGIoQn287I4+RTsbBLdEku81k6aUlWkM14b9kimjlr79PMG1F3SM6+Oe2FZBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO+H8Zv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28306C4CECE;
	Fri,  3 Jan 2025 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735903894;
	bh=zYEH+HVQjOp1upkvfQMtNMfVF+BOz626fvcOYHVDo6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RO+H8Zv+AYqZ709oLqT2F7ocapWqt8d0OqGmNNoMpQcT9dVr27Uyr94u3PYCIi2Dk
	 ijLF4XIHQQNgc0OG7ufYgPctEwAWmggExBPmOwX/WVHqto4qQY96Ok3A55xcfeVOdK
	 ik7DNz9n4A0hzPvrrd/2fUN4P4BHCiHppPQuVUgsFK+PLZIEVAfhys7Wg8/iK4M44+
	 gIYSwsWYOu7Xq2X9q2/okmC5cM9UdWyZq1PKQcyrv6LQipFRt2zVPu+jgqDvYKp1Kb
	 ds+nf8go9SvpKEiUC4VjGkr3085EtR+5G96gEXPqobT2cV9QYNfBAl/J0/XTtqcFYN
	 Sl+K5uRqSybbw==
Date: Fri, 3 Jan 2025 12:31:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <Z3fKkTSFFcU9gQLg@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809073610.2517-1-linux.amoon@gmail.com>

On Fri, Aug 09, 2024 at 01:06:09PM +0530, Anand Moon wrote:
> Rockchip DWC PCIe driver currently waits for the combo PHY link
> (PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established link training
> during boot, it also waits for the link to be up, which could consume
> several milliseconds during boot.
>
> To optimize boot time, this commit allows asynchronous probing.
> This change enables the PCIe link establishment to occur in the
> background while other devices are being probed.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: update the commit message to describe the changs.
> ---

Hello Anand,

I tried this patch.

It gives me the following splat on rock5b (rk3588):

[    1.412108] WARNING: CPU: 5 PID: 59 at kernel/module/kmod.c:143 __request_module+0x1c0/0x298
[    1.412853] Modules linked in:
[    1.413125] CPU: 5 UID: 0 PID: 59 Comm: kworker/u32:1 Not tainted 6.13.0-rc1+ #38
[    1.413781] Hardware name: Radxa ROCK 5B (DT)
[    1.414163] Workqueue: async async_run_entry_fn
[    1.414565] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.415175] pc : __request_module+0x1c0/0x298
[    1.415559] lr : __request_module+0x1bc/0x298
[    1.415943] sp : ffff8000804333f0
[    1.416234] x29: ffff800080433470 x28: ffff42bec2e40000 x27: ffff42bec2e400c8
[    1.416860] x26: ffff42bec1739000 x25: ffffb5bec9400e18 x24: 0000000000000000
[    1.417485] x23: ffffb5bec93e1a90 x22: 0000000000000001 x21: ffffb5bec74298f8
[    1.418111] x20: ffff800080433620 x19: ffff800080433410 x18: 0000000000000006
[    1.418736] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    1.419360] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000000
[    1.419985] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb5bec750b834
[    1.420611] x8 : ffff800080433468 x7 : 0000000000000000 x6 : 0000000000000000
[    1.421235] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000030
[    1.421860] x2 : 0000000000000008 x1 : ffffb5bec750b708 x0 : 0000000000000001
[    1.422486] Call trace:
[    1.422701]  __request_module+0x1c0/0x298 (P)
[    1.423086]  __request_module+0x1bc/0x298 (L)
[    1.423471]  phy_request_driver_module+0x120/0x178
[    1.423895]  phy_device_create+0x230/0x250
[    1.424257]  get_phy_device+0x80/0x168
[    1.424588]  mdiobus_scan+0x20/0xa0
[    1.424896]  __mdiobus_register+0x21c/0x460
[    1.425265]  __devm_mdiobus_register+0x78/0xf8
[    1.425657]  rtl_init_one+0x7c8/0x1140
[    1.425989]  local_pci_probe+0x48/0xc0
[    1.426323]  pci_device_probe+0xcc/0x248
[    1.426671]  really_probe+0xc4/0x2d0
[    1.426989]  __driver_probe_device+0x80/0x130
[    1.427374]  driver_probe_device+0x44/0x168
[    1.427745]  __device_attach_driver+0xc0/0x148
[    1.428138]  bus_for_each_drv+0x90/0x100
[    1.428486]  __device_attach+0xa8/0x1a0
[    1.428826]  device_attach+0x1c/0x38
[    1.429143]  pci_bus_add_device+0xb4/0x1e0
[    1.429505]  pci_bus_add_devices+0x48/0xa0
[    1.429867]  pci_bus_add_devices+0x74/0xa0
[    1.430228]  pci_host_probe+0x94/0x100
[    1.430560]  dw_pcie_host_init+0x258/0x720
[    1.430923]  rockchip_pcie_probe+0x2ec/0x510
[    1.431300]  platform_probe+0x70/0xe8
[    1.431623]  really_probe+0xc4/0x2d0
[    1.431940]  __driver_probe_device+0x80/0x130
[    1.432326]  driver_probe_device+0x44/0x168
[    1.432696]  __device_attach_driver+0xc0/0x148
[    1.433089]  bus_for_each_drv+0x90/0x100
[    1.433436]  __device_attach_async_helper+0xbc/0xe8
[    1.433865]  async_run_entry_fn+0x3c/0xf0
[    1.434219]  process_one_work+0x158/0x3c8
[    1.434574]  worker_thread+0x2d4/0x3f8
[    1.434907]  kthread+0x118/0x128
[    1.435193]  ret_from_fork+0x10/0x20


Perhaps we should defer this patch until phylib core has been fixed?

For more info, see:
https://lore.kernel.org/netdev/Z3fJQEVV4ACpvP3L@ryzen/T/#u


Kind regards,
Niklas

