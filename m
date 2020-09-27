Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389C8279F98
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgI0I3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 04:29:04 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:20049
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbgI0I3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 04:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw4K4dcJSnTc6wb8NdpeuaODU8Plmoe5bp635yPaD9iE3AfYrjtd1nVmfip/Oia7dauGzT5BTJQIlevDqfjPJRSwv8pB37dWocpaeph6Vyf27W6NyU1vmkBDMY7MKIrwwTj9JCwxIEm1ADLFvKUmlw6Km7+MEYffSh7Ys1A0mjXH/FM+0nfhc5VzmHzt78KRoJpDZrrIYHS+2YzPqr/f4WfF6P+pccevPhPumf20pZXEwv5k6w9DPDIn7sutzChvKVdouucEvdUwtg5eQNQuCHTkoj1cjftquDCi20Kl6OE9QQJbqF2VVPxB63zKUwpVScWirE8hJ6HGgSX2f4leIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcvROOIHPrTzckOCuezDgMG5OlL8Hu7mxuVTl5wJLRo=;
 b=amOGcRLPjocqCoBMs0akfhwj6OVbP/DwNSHSjrxp4MH0Gl9gANqNvm2dE515S6PONSljUrLe57IiB9rOFhmbhjnbxDZ7ThWDqKzj6qcfaSjJlEYooD5sdvk5JwhQj3A6wkc1ZAXw4CKgQiKjC4rN3RLpYrkHHJQ/EAD9DR1y0OdTsFfbBgIzo0tzfX0WU2itAXzTssP95M+1p8GVoRuTlLdXQrOEydmc3ZHoxt3L2tvo7rOHfi6Yx4X5K+mw5zD6Gll/sHiY1wA4kMQBekePaC+c2Rzm7UthWbGzq52DThR0WE7k3N3eMFwOWpdmEFezBbz3NyVoN7mfG8xKfWd5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcvROOIHPrTzckOCuezDgMG5OlL8Hu7mxuVTl5wJLRo=;
 b=e2CVVbN/aEC1ehRlBkh/cwmqphAUSoi1GFdBz0SFdS7NOsY8jSdpIHpPp+QJbNwwnoC7VrtM0b3lXTvlxIsaFk7+Lj0nJMb0qpVM3x+CwiMBoPQalvbe9Apa+JNtGkQ15d1VtZHtbdqtt2Qi7TOE89uQjGW9nKxdFKvWPgN4rxI=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5035.namprd03.prod.outlook.com (2603:10b6:5:1e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Sun, 27 Sep
 2020 08:29:00 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3412.028; Sun, 27 Sep 2020
 08:28:59 +0000
Date:   Sun, 27 Sep 2020 16:28:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
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
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
Message-ID: <20200927162830.3531ba60@xhacker.debian>
In-Reply-To: <d4715e17-147f-a4fe-32c1-32fdfe8548bb@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
        <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
        <20200925171712.254a018d@xhacker.debian>
        <20200925172724.5bdf6aab@xhacker.debian>
        <d4715e17-147f-a4fe-32c1-32fdfe8548bb@nvidia.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8014::8) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAP286CA0021.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8014::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25 via Frontend Transport; Sun, 27 Sep 2020 08:28:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bbd68cb-aa5b-4171-2507-08d862bf61c2
X-MS-TrafficTypeDiagnostic: DM6PR03MB5035:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5035F6550012254F09AB883AED340@DM6PR03MB5035.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ks4IXRB0R5h4WoxZtkqy7g8LmoJs4i5kkHXTh3sHFxyOL4LuMQ5Ms+ZT2pi0B11fibhQlx6s+6SnJ5rUyzHeTgtkj4fCGzGMVQ8BanmLHAL7e9fixgNmPDwY2cDiLtvTwjgY6tsggnUn/Vgo5+r/Vp8OsShURp0Uqakj+99OMJ+hQ0UVJP77UhlG5j8rbyfG4ki2yZKO5OoUmmVXR3kONubYDpwIUJCzzKDqyAALgyDwVtTyPFCxhMTRRW19eDkbhnUQLCupRRXcDGmOAKBfo20dVBV8BbRDHTDfK3tsnP0eyh4lBJxRyJutOYrtlkMWx2By92/Rk5SsqbR0GgYGRYoTLqkIrqweC7S6J4D1AcvGWqUb9pIvZSEC3LfsDE6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(396003)(376002)(136003)(366004)(8676002)(5660300002)(26005)(8936002)(956004)(1076003)(16526019)(186003)(4326008)(7696005)(52116002)(66556008)(66476007)(2906002)(316002)(478600001)(6666004)(45080400002)(55016002)(86362001)(7416002)(6916009)(7406005)(6506007)(53546011)(54906003)(9686003)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0+uIc/TwuvtvuBShW8Tk1e4AjnT9HnXLc8Ac/CHWTBVJT2JHPZgn7JhVqTdX30njeIiS8Sp8EfkBDXcWbzRxmVCi+FX7PNbcmY+072f616R9GMp2bgYUC9YDBKBqxRsQsTBp1R/Ez7acTxswD+lappaEk307SgwSzCWErKXzF8j4SGRzwqHL4dNsIB21jhgY/LKxaeW+PgyN62Sbp4W03kU8oiznro2Dt2T67nSWvPWWoixsNJBSbxzQzHg2Zkr3JC+CVU72NI5e7DteogZ89zQnwcm9OyvJCdZkpRmF8On8VVZCpf+PtzCdwtEEz6c6Fz6TMwPzoatekqwDkuEyqBEBrIDG1cjAHhNEurRc+7+DwEztVZkBwWa/J4FqNXsp03Vn7TIGQUgBlfBYddSyIPDiH4cUMMqYMtH//tbwAsNcebd7vKLizIL8e/Bbq+eoY5wtnkqZbfXv1YkFJfHoLbPp+qylZxcvrhrujXFfhSGvVAoQxET+pXKSurtngszaaxTea9mhbP8c3ms08XF2lsAB5R6KIG7QZjB3oMYd7v2AMwToUKnj4T4tH9++MUH+kTPdRpSXdpzEjgz0GsrpO5mVP5R+fIJ6A/ytZZcL7doZeBYfrieOynKD9qML2bHtlYcRhHIKjT+jUQ1JPsPy+g==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbd68cb-aa5b-4171-2507-08d862bf61c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2020 08:28:59.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1Ll9ZESZy8pzq9tJoDO/Co/cFM+bD6oxopVyXuVQLCYXKw6hdDzhCtsXlv1ESoxIKL6+McEDdKmRNlcEazmbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5035
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, 25 Sep 2020 16:13:02 +0100 Jon Hunter wrote:

> 
> Hi Jisheng,
> 
> On 25/09/2020 10:27, Jisheng Zhang wrote:
> 
> ...
> 
> >> Could you please try below patch?
> >>
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index bf25d783b5c5..7e5dc54d060e 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -197,7 +197,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> >>         .name = "DWPCI-MSI",
> >>         .irq_ack = dw_pci_bottom_ack,
> >>         .irq_compose_msi_msg = dw_pci_setup_msi_msg,
> >> -       .irq_set_affinity = dw_pci_msi_set_affinity,
> >>         .irq_mask = dw_pci_bottom_mask,
> >>         .irq_unmask = dw_pci_bottom_unmask,
> >>  };  
> >
> > A complete patch w/o compiler warning:
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index bf25d783b5c5..18f719cfed0b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -137,12 +137,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
> >               (int)d->hwirq, msg->address_hi, msg->address_lo);
> >  }
> >
> > -static int dw_pci_msi_set_affinity(struct irq_data *d,
> > -                                const struct cpumask *mask, bool force)
> > -{
> > -     return -EINVAL;
> > -}
> > -
> >  static void dw_pci_bottom_mask(struct irq_data *d)
> >  {
> >       struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > @@ -197,7 +191,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> >       .name = "DWPCI-MSI",
> >       .irq_ack = dw_pci_bottom_ack,
> >       .irq_compose_msi_msg = dw_pci_setup_msi_msg,
> > -     .irq_set_affinity = dw_pci_msi_set_affinity,
> >       .irq_mask = dw_pci_bottom_mask,
> >       .irq_unmask = dw_pci_bottom_unmask,
> >  };
> >  
> 
> 
> Thanks I was not expecting this to work because ...
> 
>  int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>                          bool force)
>  {
>          struct irq_desc *desc = irq_data_to_desc(data);
>          struct irq_chip *chip = irq_data_get_irq_chip(data);
>          int ret;
> 
>          if (!chip || !chip->irq_set_affinity)
>                  return -EINVAL;
> 
> However, with your patch Tegra crashes on boot ...
> 
> [   11.613853] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [   11.622500] Mem abort info:
> [   11.622515]   ESR = 0x86000004
> [   11.622524]   EC = 0x21: IABT (current EL), IL = 32 bits
> [   11.622540]   SET = 0, FnV = 0
> [   11.636544]   EA = 0, S1PTW = 0
> [   11.636554] user pgtable: 4k pages, 48-bit VAs, pgdp=000000046a28e000
> [   11.636559] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [   11.652652] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [   11.652658] Modules linked in: pwm_tegra phy_tegra194_p2u crct10dif_ce lm90 pwm_fan tegra_bpmp_thermal pcie_tegra194 ip_tables x_tables ipv6
> [   11.670525] CPU: 3 PID: 138 Comm: kworker/3:3 Not tainted 5.9.0-rc4-dirty #12
> [   11.670534] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
> [   11.683967] Workqueue: events deferred_probe_work_func
> [   11.683974] pstate: 60c00089 (nZCv daIf +PAN +UAO BTYPE=--)
> [   11.683985] pc : 0x0
> [   11.696669] lr : msi_domain_set_affinity+0x44/0xc0
> [   11.696672] sp : ffff800012bcb390
> [   11.696680] x29: ffff800012bcb390 x28: ffff0003e3033c20
> [   11.709891] x27: ffff0003e76cfe58 x26: 0000000000000000
> [   11.709900] x25: ffff800011d7e850 x24: ffff800011d7e878
> [   11.709908] x23: 0000000000000000 x22: ffff0003e76cfe00
> [   11.709914] x21: ffff0003e76cfe58 x20: ffff0003e76cfe58
> [   11.709921] x19: ffff800011b19000 x18: ffffffffffffffff
> [   11.709927] x17: 0000000000000000 x16: 0000000000000000
> [   11.741262] x15: ffff800011b19948 x14: 0000000000000040
> [   11.741267] x13: 0000000000000228 x12: 0000000000000030
> [   11.741272] x11: 0101010101010101 x10: 0000000000000040
> [   11.741277] x9 : 0000000000000000 x8 : 0000000000000004
> [   11.741281] x7 : ffffffffffffffff x6 : 00000000000000ff
> [   11.767374] x5 : 0000000000000000 x4 : 0000000000000000
> [   11.767379] x3 : 0000000000000000 x2 : 0000000000000000
> [   11.767384] x1 : ffff800011d7e898 x0 : ffff0003e262bf00
> [   11.767406] Call trace:
> [   11.767410]  0x0
> [   11.767424]  irq_do_set_affinity+0x4c/0x178
> [   11.791400]  irq_setup_affinity+0x124/0x1b0
> [   11.791423]  irq_startup+0x6c/0x118
> [   11.791434]  __setup_irq+0x810/0x8a0
> [   11.802510]  request_threaded_irq+0xdc/0x188
> [   11.802517]  pcie_pme_probe+0x98/0x110
> [   11.802536]  pcie_port_probe_service+0x34/0x60
> [   11.814799]  really_probe+0x110/0x400
> [   11.814809]  driver_probe_device+0x54/0xb8
> [   11.822438]  __device_attach_driver+0x90/0xc0
> [   11.822463]  bus_for_each_drv+0x70/0xc8
> [   11.822471]  __device_attach+0xec/0x150
> [   11.834307]  device_initial_probe+0x10/0x18
> [   11.834311]  bus_probe_device+0x94/0xa0
> [   11.834315]  device_add+0x464/0x730
> [   11.834338]  device_register+0x1c/0x28
> [   11.834349]  pcie_port_device_register+0x2d0/0x3e8
> [   11.854056]  pcie_portdrv_probe+0x34/0xd8
> [   11.854063]  local_pci_probe+0x3c/0xa0
> [   11.854088]  pci_device_probe+0x128/0x1c8
> [   11.854103]  really_probe+0x110/0x400
> [   11.869283]  driver_probe_device+0x54/0xb8
> [   11.869311]  __device_attach_driver+0x90/0xc0
> [   11.877638]  bus_for_each_drv+0x70/0xc8
> [   11.877645]  __device_attach+0xec/0x150
> [   11.877669]  device_attach+0x10/0x18
> [   11.877680]  pci_bus_add_device+0x4c/0xb0
> [   11.892642]  pci_bus_add_devices+0x44/0x90
> [   11.892646]  dw_pcie_host_init+0x370/0x4f8
> [   11.892653]  tegra_pcie_dw_probe+0x5e8/0xb50 [pcie_tegra194]
> [   11.892661]  platform_drv_probe+0x50/0xa8
> [   11.910179]  really_probe+0x110/0x400
> [   11.910183]  driver_probe_device+0x54/0xb8
> [   11.910186]  __device_attach_driver+0x90/0xc0
> [   11.910213]  bus_for_each_drv+0x70/0xc8
> [   11.910240]  __device_attach+0xec/0x150
> [   11.929689]  device_initial_probe+0x10/0x18
> [   11.929694]  bus_probe_device+0x94/0xa0
> [   11.929719]  deferred_probe_work_func+0x6c/0xa0
> [   11.929730]  process_one_work+0x1cc/0x360
> [   11.946008]  worker_thread+0x48/0x450
> [   11.949602]  kthread+0x120/0x150
> [   11.952803]  ret_from_fork+0x10/0x1c
> [   11.956332] Code: bad PC value
> [   11.959360] ---[ end trace 03c30e252fe4e40b ]---
> 
> To be honest, I am not sure I completely understand why it crashes here.
> 

I see, the msi_domain_set_affinity() calls parent->chip->irq_set_affinity
without checking, grepping the irqchip and pci dir, I found that
if the MSI is based on some cascaded interrupt mechanism, they all
point the irq_set_affinity to irq_chip_set_affinity_parent(), so I believe
below patch works:

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bf25d783b5c5..093fba616736 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -137,12 +137,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int dw_pci_msi_set_affinity(struct irq_data *d,
-				   const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
@@ -197,7 +191,7 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name = "DWPCI-MSI",
 	.irq_ack = dw_pci_bottom_ack,
 	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_set_affinity = dw_pci_msi_set_affinity,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
 	.irq_mask = dw_pci_bottom_mask,
 	.irq_unmask = dw_pci_bottom_unmask,
 };

