Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870CD3EB6BE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhHMOd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhHMOd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 10:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5CC36103A;
        Fri, 13 Aug 2021 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865181;
        bh=Kst2wr3UnK7JgTeoig+Taeqy5rPFWjd6edmIyKqJMms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h9azIVg730xbLa8QfGj3GW3bw7S7QtOQXVGnkQLqh/kZpoYCFHzcXj2YMQWeyEcB8
         ujLWzguOBAHg2a9LQMVfceSVK1ckNWOsq4I4ZxNjb0A7/398h/G3Sjwuo+KzkHRZfS
         KR1olLdgJoYou4vQiKTk08Nob0HROUruHfbKkgZrc/dbDiG8E44BCxP9CAP+lzW8+E
         p1pnipY2juwQblmQhlnlb2WYZtjPBoGeFyxrDjMzkxw81rZPcpV+TKb+tmgcDJJFEo
         Lpxs02zCzHYfgb1iJRR+3QJaHUvVCQSsU203IqcCYU+mHGRipnP+8rcvWdsXIrOgrL
         HtLuO6SJF4BSA==
Date:   Fri, 13 Aug 2021 16:32:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: kirin: fix HiKey970 example
Message-ID: <20210813163255.3803fe41@coco.lan>
In-Reply-To: <YRUamNF18ese0DYw@robh.at.kernel.org>
References: <cover.1628754620.git.mchehab+huawei@kernel.org>
        <655e21422a14620ae2d55335eb72bcaa66f5384d.1628754620.git.mchehab+huawei@kernel.org>
        <YRUamNF18ese0DYw@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 12 Aug 2021 07:56:56 -0500
Rob Herring <robh@kernel.org> escreveu:

> > +          msi-parent = <&its_pcie>;  
> 
> Why do we need this change? Adding the child nodes shouldn't change 
> the behavior here. I'd expect that we'd walk the parent nodes until we 
> find a 'msi-parent' much like 'interrupt-parent'.
> 
> It looks like we walk PCI bus parents to get the MSI domain, but we 
> don't walk the DT node parents. 
> 
> Adding Marc for his thoughts.

This is actually not directly related with the pcie hierarchy needed by the
per-slot PERST# signal, but it seems to be related to the fact that, on
this device, we have this topology:


	+------------+
	| Kirin 970  |       +------------+
        | PCIe bus 0 |  ---> | PCIe bus 1 | ---> PCI bus (2 slots + Eth)
	+------------+       +------------+

With this change, we have ("version 1"):

    soc {
	its_pcie: interrupt-controller@f5100000 {
		reg = <0x0 0xf5100000 0x0 0x100000>;
		compatible = "arm,gic-v3-its";
		msi-controller;
	};
	pcie@f4000000 {
		#interrupt-cells = <1>;
		interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "msi";
		interrupt-map-mask = <0 0 0 7>;
		interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
		pcie@0,0 {
			msi-parent = <&its_pcie>;

		};		
	};
    };

While the original version ("version 2") was:

    soc {
	its_pcie: interrupt-controller@f5100000 {
		reg = <0x0 0xf5100000 0x0 0x100000>;
		compatible = "arm,gic-v3-its";
		msi-controller;
	};
	pcie@f4000000 {
		#interrupt-cells = <1>;
		interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "msi";
		interrupt-map-mask = <0 0 0 7>;
		interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
				<0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
		msi-parent = <&its_pcie>;
		pcie@0,0 {
			... (no msi-parent here)
		};		
	};
    };

With both versions, PCI works OK.

Wowever, "version 2" produce lots of crap at dmesg (see enclosed).

The root cause seems to be happening on this function:

	static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
	{
		struct irq_domain *domain;
	
		domain = dev_get_msi_domain(&dev->dev);
		if (domain && irq_domain_is_hierarchy(domain))
			return msi_domain_alloc_irqs(domain, &dev->dev, nvec);

		return arch_setup_msi_irqs(dev, nvec, type);
	}

It sounds that dev_get_msi_domain() fails with "version 1", probably
because of the additional PCIe bridge, but works fine with "version 2".

Thanks,
Mauro

[    5.034618] ------------[ cut here ]------------
[    5.039239] WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c
[    5.048035] Modules linked in: wl18xx(+) wlcore mac80211 libarc4 cfg80211 wlcore_sdio crct10dif_ce tcpci_rt1711h tcpci tcpm typec phy_hi3670_usb3 phy_hi3670_pcie pcie_kirin hisi_hikey_usb rfkill drm fuse ip_tables x_tables ipv6
[    5.068231] CPU: 4 PID: 7 Comm: kworker/u16:0 Not tainted 5.14.0-rc1+ #340
[    5.075103] Hardware name: HiKey970 (DT)
[    5.079020] Workqueue: events_unbound deferred_probe_work_func
[    5.084855] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    5.088800] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    5.090856] pc : __pci_enable_msi_range+0x398/0x59c
[    5.090860] lr : __pci_enable_msi_range+0x2b8/0x59c
[    5.109813] sp : ffff80001220b670
[    5.113119] x29: ffff80001220b670 x28: ffff000104547000 x27: 0000000000000001
[    5.120252] x26: ffff0001045472f0 x25: ffff80001216626c x24: 0000000000000000
[    5.127383] x23: ffff0001045470c8 x22: 0000000000000001 x21: 0000000000000001
[    5.129006] mmc_host mmc1: Bus speed (slot 0) = 25000000Hz (slot req 25000000Hz, actual 25000000HZ div = 0)
[    5.134515] x20: 0000000000000001 x19: ffff0001055b7d00 x18: 00000000fffffffd
[    5.134519] x17: 6572702066666666 x16: 6632376678302d30 x15: 0000000000000020
[    5.158527] x14: 0000000000000001 x13: ffff00010e9ec803 x12: 0000000000000040
[    5.165663] x11: ffff000100400248 x10: ffff00010040024a x9 : 0000000000000000
[    5.172805] x8 : ffff0001055b7d80 x7 : ffff800013000000 x6 : ffff800008f73190
[    5.185571] x5 : 0000000040000000 x4 : 0000000000000000 x3 : ffff800010808ba0
[    5.194702] x2 : 0000000000000000 x1 : ffff0001045472f0 x0 : 0000000000000000
[    5.201855] Call trace:
[    5.201859]  __pci_enable_msi_range+0x398/0x59c
[    5.201868]  pci_alloc_irq_vectors_affinity+0xe0/0x140
[    5.201872]  pcie_port_device_register+0x15c/0x4fc
[    5.201877]  pcie_portdrv_probe+0x44/0xfc
[    5.201881]  local_pci_probe+0x40/0xac
[    5.201886]  pci_device_probe+0x114/0x1b0
[    5.201891]  really_probe+0x1b0/0x42c
[    5.201895]  __driver_probe_device+0x114/0x190
[    5.201899]  driver_probe_device+0x40/0x100
[    5.242782]  __device_attach_driver+0x98/0x130
[    5.242789]  bus_for_each_drv+0x78/0xd0
[    5.242792]  __device_attach+0xdc/0x1c0
[    5.242795]  device_attach+0x14/0x20
[    5.242800]  pci_bus_add_device+0x50/0xb4
[    5.242806]  pci_bus_add_devices+0x3c/0x8c
[    5.266581]  pci_host_probe+0x40/0xc4
[    5.266593]  dw_pcie_host_init+0x198/0x470
[    5.266600]  kirin_pcie_probe+0x5cc/0x88c [pcie_kirin]
[    5.266610]  platform_probe+0x68/0xe0
[    5.266614]  really_probe+0x1b0/0x42c
[    5.272805] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    5.274366]  __driver_probe_device+0x114/0x190
[    5.300468]  driver_probe_device+0x40/0x100
[    5.300480]  __device_attach_driver+0x98/0x130
[    5.300484]  bus_for_each_drv+0x78/0xd0
[    5.300488]  __device_attach+0xdc/0x1c0
[    5.313196] mmc_host mmc1: Bus speed (slot 0) = 25000000Hz (slot req 25000000Hz, actual 25000000HZ div = 0)
[    5.316763]  device_initial_probe+0x14/0x20
[    5.316766]  bus_probe_device+0x98/0xa0
[    5.316770]  deferred_probe_work_func+0x9c/0xf0
[    5.339026]  process_one_work+0x1cc/0x350
[    5.339035]  worker_thread+0x138/0x46c
[    5.339040]  kthread+0x150/0x160
[    5.350007]  ret_from_fork+0x10/0x18
[    5.358700] ---[ end trace a4c2ccee5a840ad8 ]---
[    5.363529] ------------[ cut here ]------------
[    5.373739] WARNING: CPU: 4 PID: 7 at include/linux/msi.h:262 free_msi_irqs+0x54/0x1a0
[    5.373751] Modules linked in: wl18xx wlcore mac80211 libarc4 cfg80211 wlcore_sdio crct10dif_ce tcpci_rt1711h tcpci tcpm typec phy_hi3670_usb3 phy_hi3670_pcie pcie_kirin hisi_hikey_usb rfkill drm fuse ip_tables x_tables ipv6
[    5.402792] CPU: 4 PID: 7 Comm: kworker/u16:0 Tainted: G        W         5.14.0-rc1+ #340
[    5.402801] Hardware name: HiKey970 (DT)
[    5.402804] Workqueue: events_unbound deferred_probe_work_func
[    5.402816] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    5.402820] pc : free_msi_irqs+0x54/0x1a0
[    5.402825] lr : __pci_enable_msi_range+0x3dc/0x59c
[    5.402829] sp : ffff80001220b620
[    5.402830] x29: ffff80001220b620 x28: ffff000104547000 x27: 00000000ffffffed
[    5.402835] x26: ffff0001045472f0 x25: ffff0001045470c8 x24: 0000000000000000
[    5.402840] x23: ffff0001045470c8 x22: ffff000104547000 x21: ffff0001045472f0
[    5.402843] x20: 0000000000000001 x19: ffff0001045472f0 x18: 00000000fffffffd
[    5.402847] x17: 6572702066666666 x16: 6632376678302d30 x15: 0000000000000020
[    5.402851] x14: 0000000000000001 x13: ffff00010e9ec803 x12: 0000000000000040
[    5.402855] x11: ffff000100400248 x10: ffff00010040024a
[    5.424804] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    5.426863]  x9 : 0000000000000000
[    5.426866] x8 : ffff0001055b7d80 x7 : ffff800013000000 x6 : ffff800008f73190
[    5.461001] mmc_host mmc1: Bus speed (slot 0) = 25000000Hz (slot req 25000000Hz, actual 25000000HZ div = 0)
[    5.467547] x5 : 0000000040000000 x4 : 0000000000000000 x3 : ffff800010808ba0
[    5.467552] x2 : 0000000000000000 x1 : ffff0001000cd580 x0 : 0000000000000000
[    5.523618] Call trace:
[    5.523621]  free_msi_irqs+0x54/0x1a0
[    5.523625]  __pci_enable_msi_range+0x3dc/0x59c
[    5.541384]  pci_alloc_irq_vectors_affinity+0xe0/0x140
[    5.541392]  pcie_port_device_register+0x15c/0x4fc
[    5.541396]  pcie_portdrv_probe+0x44/0xfc
[    5.541400]  local_pci_probe+0x40/0xac
[    5.541404]  pci_device_probe+0x114/0x1b0
[    5.541407]  really_probe+0x1b0/0x42c
[    5.541412]  __driver_probe_device+0x114/0x190
[    5.571173]  driver_probe_device+0x40/0x100
[    5.571186]  __device_attach_driver+0x98/0x130
[    5.579813]  bus_for_each_drv+0x78/0xd0
[    5.579819]  __device_attach+0xdc/0x1c0
[    5.579822]  device_attach+0x14/0x20
[    5.579826]  pci_bus_add_device+0x50/0xb4
[    5.579830]  pci_bus_add_devices+0x3c/0x8c
[    5.603932]  pci_host_probe+0x40/0xc4
[    5.607754]  dw_pcie_host_init+0x198/0x470
[    5.611850]  kirin_pcie_probe+0x5cc/0x88c [pcie_kirin]
[    5.621932]  platform_probe+0x68/0xe0
[    5.625594]  really_probe+0x1b0/0x42c
[    5.629424]  __driver_probe_device+0x114/0x190
[    5.633870]  driver_probe_device+0x40/0x100
[    5.643685]  __device_attach_driver+0x98/0x130
[    5.648123]  bus_for_each_drv+0x78/0xd0
[    5.652121]  __device_attach+0xdc/0x1c0
[    5.656118]  device_initial_probe+0x14/0x20
[    5.660295]  bus_probe_device+0x98/0xa0
[    5.669763]  deferred_probe_work_func+0x9c/0xf0
[    5.674288]  process_one_work+0x1cc/0x350
[    5.678459]  worker_thread+0x138/0x46c
[    5.682202]  kthread+0x150/0x160
[    5.690802]  ret_from_fork+0x10/0x18
[    5.694375] ---[ end trace a4c2ccee5a840ad9 ]---
[    5.699345] pcieport 0000:00:00.0: PME: Signaling with IRQ 57
[    5.699721] pcieport 0000:00:00.0: AER: enabled with IRQ 57
[    5.716257] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[    5.716612] pcieport 0000:01:00.0: enabling device (0000 -> 0002)
[    5.729396] wlcore: WARNING Detected unconfigured mac address in nvs, derive from fuse instead.
[    5.734803] pcieport 0000:02:07.0: enabling device (0000 -> 0002)
[    5.742879] wlcore: WARNING This default nvs file can be removed from the file system
[    5.755469] ------------[ cut here ]------------
[    5.765439] wlcore: loaded
[    5.766377] WARNING: CPU: 6 PID: 7 at include/linux/msi.h:256 __pci_enable_msix_range+0x5ec/0x6b0
[    5.777977] Modules linked in: wl18xx wlcore mac80211 libarc4 cfg80211 wlcore_sdio crct10dif_ce tcpci_rt1711h tcpci tcpm typec phy_hi3670_usb3 phy_hi3670_pcie pcie_kirin hisi_hikey_usb rfkill drm fuse ip_tables x_tables ipv6
[    5.797948] CPU: 6 PID: 7 Comm: kworker/u16:0 Tainted: G        W         5.14.0-rc1+ #340
[    5.806233] Hardware name: HiKey970 (DT)
[    5.815789] Workqueue: events_unbound deferred_probe_work_func
[    5.821884] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    5.827915] pc : __pci_enable_msix_range+0x5ec/0x6b0
[    5.827937] lr : __pci_enable_msix_range+0x37c/0x6b0
[    5.827942] sp : ffff80001220b620
[    5.827944] x29: ffff80001220b620 x28: 0000000000000000 x27: ffff000108fce000
[    5.827954] x26: ffff000108fce0c8 x25: 0000000000000001 x24: 0000000000000000
[    5.827958] x23: 000000000000000c x22: 0000000000000001 x21: ffff000108fce2f0
[    5.827962] x20: 0000000000000001 x19: 0000000000000000 x18: 0000000000000002
[    5.827966] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    5.827970] x14: 0000000000000000 x13: 000000000000027e x12: ffff80001286b000
[    5.876878] x11: ffff800012869000 x10: 00000000f7200000 x9 : 0000000000000000
[    5.876886] x8 : 0000000000000039 x7 : 0000000000000000 x6 : 000000000000003f
[    5.876891] x5 : ffff000108fce2f0 x4 : ffff80001220b5e0 x3 : 0000000000000000
[    5.876896] x2 : ffff800012869000 x1 : 0000000000000004 x0 : 0000000000000000
[    5.876901] Call trace:
[    5.876904]  __pci_enable_msix_range+0x5ec/0x6b0
[    5.919629]  pci_alloc_irq_vectors_affinity+0xc0/0x140
[    5.919645]  rtl_init_one+0x55c/0xf90
[    5.919653]  local_pci_probe+0x40/0xac
[    5.932195]  pci_device_probe+0x114/0x1b0
[    5.932200]  really_probe+0x1b0/0x42c
[    5.932205]  __driver_probe_device+0x114/0x190
[    5.932209]  driver_probe_device+0x40/0x100
[    5.932212]  __device_attach_driver+0x98/0x130
[    5.932217]  bus_for_each_drv+0x78/0xd0
[    5.932220]  __device_attach+0xdc/0x1c0
[    5.932223]  device_attach+0x14/0x20
[    5.932227]  pci_bus_add_device+0x50/0xb4
[    5.932231]  pci_bus_add_devices+0x3c/0x8c
[    5.932234]  pci_bus_add_devices+0x68/0x8c
[    5.932236]  pci_bus_add_devices+0x68/0x8c
[    5.932239]  pci_bus_add_devices+0x68/0x8c
[    5.932241]  pci_host_probe+0x40/0xc4
[    5.932244]  dw_pcie_host_init+0x198/0x470
[    5.932250]  kirin_pcie_probe+0x5cc/0x88c [pcie_kirin]
[    5.932259]  platform_probe+0x68/0xe0
[    5.932262]  really_probe+0x1b0/0x42c
[    5.932265]  __driver_probe_device+0x114/0x190
[    5.932268]  driver_probe_device+0x40/0x100
[    5.932271]  __device_attach_driver+0x98/0x130
[    5.932274]  bus_for_each_drv+0x78/0xd0
[    5.932277]  __device_attach+0xdc/0x1c0
[    5.932280]  device_initial_probe+0x14/0x20
[    5.932283]  bus_probe_device+0x98/0xa0
[    5.932286]  deferred_probe_work_func+0x9c/0xf0
[    5.932289]  process_one_work+0x1cc/0x350
[    5.932295]  worker_thread+0x138/0x46c
[    5.932298]  kthread+0x150/0x160
[    5.932302]  ret_from_fork+0x10/0x18
[    5.932307] ---[ end trace a4c2ccee5a840ada ]---


