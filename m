Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94727B389
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1Rq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 13:46:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10517 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Rq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 13:46:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f72215a0000>; Mon, 28 Sep 2020 10:46:02 -0700
Received: from [10.26.75.44] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 17:46:33 +0000
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <linux-pci@vger.kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@axis.com>, Vidya Sagar <vidyas@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-tegra@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Kukjin Kim" <kgene@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        <linux-arm-msm@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Yue Wang" <yue.wang@Amlogic.com>,
        <linux-samsung-soc@vger.kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        <linux-amlogic@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20200924190421.549cb8fc@xhacker.debian>
 <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
 <20200925171712.254a018d@xhacker.debian>
 <20200925172724.5bdf6aab@xhacker.debian>
 <d4715e17-147f-a4fe-32c1-32fdfe8548bb@nvidia.com>
 <20200927162830.3531ba60@xhacker.debian>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0818bea3-d993-0fa7-b924-8eb8e2eb8493@nvidia.com>
Date:   Mon, 28 Sep 2020 18:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200927162830.3531ba60@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601315162; bh=Idg9d3OZyxKyVn3C5vDYEJ7CX2ekA9vEdGPpSxNhCfs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=FaWtC0/jd3epme0wPiwNIz17d8V1Eh5t3Ko0f1g8JuPvFHFmeD9jTXoPLL3xcCUMc
         H3XIkhDfQBtmHkJcgo0we/T4D/DKuPzvIWV1gX4K0/KwzZcNbWQwVtOKRx+bEAYkEZ
         4HKMewYZ3QoTkb79OyGXmShI5Q0C3zR7j1T905DGgOaybpcR07l3C88+Y1Pm0ugaXK
         ACuey8b9trdu4xwnVYuPAHimu2PGFUCABAomPKEIbsz1RM3pHXGvcllqGpglY4/TpB
         yCUaovwDTOkssn7Dd6x1Xxra2G8jb4iigFRnjIJCK8d4cHD2Fkm/k2UBT6DRkdS/Z4
         1mhWpwhmlbmZg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 27/09/2020 09:28, Jisheng Zhang wrote:

...

> I see, the msi_domain_set_affinity() calls parent->chip->irq_set_affinity
> without checking, grepping the irqchip and pci dir, I found that
> if the MSI is based on some cascaded interrupt mechanism, they all
> point the irq_set_affinity to irq_chip_set_affinity_parent(), so I believe
> below patch works:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index bf25d783b5c5..093fba616736 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -137,12 +137,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  		(int)d->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static int dw_pci_msi_set_affinity(struct irq_data *d,
> -				   const struct cpumask *mask, bool force)
> -{
> -	return -EINVAL;
> -}
> -
>  static void dw_pci_bottom_mask(struct irq_data *d)
>  {
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> @@ -197,7 +191,7 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>  	.name = "DWPCI-MSI",
>  	.irq_ack = dw_pci_bottom_ack,
>  	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
> -	.irq_set_affinity = dw_pci_msi_set_affinity,
> +	.irq_set_affinity = irq_chip_set_affinity_parent,
>  	.irq_mask = dw_pci_bottom_mask,
>  	.irq_unmask = dw_pci_bottom_unmask,
>  };
> 


Unfortunately, this still crashes ...

[   11.521674] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[   11.530324] Mem abort info:
[   11.533089]   ESR = 0x96000004
[   11.536105]   EC = 0x25: DABT (current EL), IL = 32 bits
[   11.541333]   SET = 0, FnV = 0
[   11.544344]   EA = 0, S1PTW = 0
[   11.547441] Data abort info:
[   11.550279]   ISV = 0, ISS = 0x00000004
[   11.554056]   CM = 0, WnR = 0
[   11.557007] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000467341000
[   11.563333] [0000000000000018] pgd=0000000000000000, p4d=0000000000000000
[   11.570024] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   11.575517] Modules linked in: crct10dif_ce pwm_tegra snd_hda_core phy_tegra194_p2u lm90 pcie_tegra194 tegra_bpmp_thermal pwm_fan ip_tables x_tables ipv6
[   11.589046] CPU: 3 PID: 148 Comm: kworker/3:1 Not tainted 5.9.0-rc4-00009-g6fdf18edb995-dirty #7
[   11.597669] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[   11.604110] Workqueue: events deferred_probe_work_func
[   11.609174] pstate: 60c00089 (nZCv daIf +PAN +UAO BTYPE=--)
[   11.614657] pc : irq_chip_set_affinity_parent+0x4/0x30
[   11.619735] lr : msi_domain_set_affinity+0x44/0xc0
[   11.624448] sp : ffff800012d4b390
[   11.627744] x29: ffff800012d4b390 x28: ffff0003e7234c20 
[   11.632983] x27: ffff0003e913e460 x26: 0000000000000000 
[   11.638231] x25: ffff800011d7e890 x24: ffff800011d7e8b8 
[   11.643466] x23: 0000000000000000 x22: ffff0003e913e400 
[   11.648701] x21: ffff0003e913e460 x20: ffff0003e913e460 
[   11.653932] x19: ffff800011b19000 x18: ffffffffffffffff 
[   11.659160] x17: 0000000000000000 x16: 0000000000000000 
[   11.664390] x15: 0000000000000001 x14: 0000000000000040 
[   11.669636] x13: 0000000000000228 x12: 0000000000000030 
[   11.674864] x11: 0101010101010101 x10: 0000000000000040 
[   11.680111] x9 : 0000000000000000 x8 : 0000000000000004 
[   11.685363] x7 : ffffffffffffffff x6 : 00000000000000ff 
[   11.690596] x5 : 0000000000000000 x4 : 0000000000000000 
[   11.695843] x3 : ffff8000100d89a8 x2 : 0000000000000000 
[   11.701058] x1 : ffff800011d7e8d8 x0 : 0000000000000000 
[   11.706288] Call trace:
[   11.708708]  irq_chip_set_affinity_parent+0x4/0x30
[   11.713431]  irq_do_set_affinity+0x4c/0x178
[   11.717540]  irq_setup_affinity+0x124/0x1b0
[   11.721650]  irq_startup+0x6c/0x118
[   11.725081]  __setup_irq+0x810/0x8a0
[   11.728580]  request_threaded_irq+0xdc/0x188
[   11.732793]  pcie_pme_probe+0x98/0x110
[   11.736481]  pcie_port_probe_service+0x34/0x60
[   11.740848]  really_probe+0x110/0x400
[   11.744445]  driver_probe_device+0x54/0xb8
[   11.748482]  __device_attach_driver+0x90/0xc0
[   11.752758]  bus_for_each_drv+0x70/0xc8
[   11.756526]  __device_attach+0xec/0x150
[   11.760306]  device_initial_probe+0x10/0x18
[   11.764413]  bus_probe_device+0x94/0xa0
[   11.768203]  device_add+0x464/0x730
[   11.771630]  device_register+0x1c/0x28
[   11.775311]  pcie_port_device_register+0x2d0/0x3e8
[   11.780017]  pcie_portdrv_probe+0x34/0xd8
[   11.783957]  local_pci_probe+0x3c/0xa0
[   11.787647]  pci_device_probe+0x128/0x1c8
[   11.791588]  really_probe+0x110/0x400
[   11.795179]  driver_probe_device+0x54/0xb8
[   11.799202]  __device_attach_driver+0x90/0xc0
[   11.803480]  bus_for_each_drv+0x70/0xc8
[   11.807244]  __device_attach+0xec/0x150
[   11.811009]  device_attach+0x10/0x18
[   11.814518]  pci_bus_add_device+0x4c/0xb0
[   11.818456]  pci_bus_add_devices+0x44/0x90
[   11.822478]  dw_pcie_host_init+0x370/0x4f8
[   11.826504]  tegra_pcie_dw_probe+0x5e8/0xb50 [pcie_tegra194]
[   11.832044]  platform_drv_probe+0x50/0xa8
[   11.835984]  really_probe+0x110/0x400
[   11.839580]  driver_probe_device+0x54/0xb8
[   11.843608]  __device_attach_driver+0x90/0xc0
[   11.847887]  bus_for_each_drv+0x70/0xc8
[   11.851655]  __device_attach+0xec/0x150
[   11.855424]  device_initial_probe+0x10/0x18
[   11.859548]  bus_probe_device+0x94/0xa0
[   11.863317]  deferred_probe_work_func+0x6c/0xa0
[   11.867781]  process_one_work+0x1cc/0x360
[   11.871720]  worker_thread+0x48/0x450
[   11.875318]  kthread+0x120/0x150
[   11.878495]  ret_from_fork+0x10/0x1c
[   11.882027] Code: a8c17bfd d65f03c0 d503201f f9401400 (f9400c03) 

Cheers
Jon

-- 
nvpublic
