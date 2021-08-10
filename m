Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1473E5DCA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbhHJOXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 10:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241180AbhHJOVm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 10:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF8D60E9B;
        Tue, 10 Aug 2021 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628605262;
        bh=Jf9BAQHDOLAAEHv5iJTENz4dnZgoHXUPU3dW3pbYLsw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TkMUm4EdxyBFgBjVMbqm/dqsTL7LrKQjpIWObJTvxfbJ09IUoinUMVw+v+VoAGtB2
         8TUB93T6028FXDqRa8Z8c5quDyo5pciJizCNzL86o3LB/MhIHJ26VComcRLBKBcrCB
         AXrouJWEmvEADVl3g4dUnFhQIp+YMdRZYUTlZoxf2VDpYQ4eoz1YwoWXM9AzI8QLez
         SVI15ZFRJ59SW1g0R3gR3ynlyymICPLZ4Zi/NsIFI+lwPlZt9iXyXESbx3+/JecBw1
         N8Q0ySgwKbQ7C0TCbViqInRfKYe83MU6P5M330xphlLgojwZpZRh9MTiXzWTkQQCrI
         JH8l3ysO2/1LQ==
Date:   Tue, 10 Aug 2021 16:20:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to
 work
Message-ID: <20210810162054.1aa84b84@coco.lan>
In-Reply-To: <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
        <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
        <20210804085045.3dddbb9c@coco.lan>
        <YQrARd7wgYS1nywt@robh.at.kernel.org>
        <20210805094612.2bc2c78f@coco.lan>
        <20210805095848.464cf85c@coco.lan>
        <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
        <20210810114211.01df0246@coco.lan>
        <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 10 Aug 2021 07:44:50 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Aug 10, 2021 at 3:42 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Fri, 6 Aug 2021 10:23:35 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >  
> > > On Thu, Aug 5, 2021 at 1:58 AM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:  
> > > >
> > > > Em Thu, 5 Aug 2021 09:46:12 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > > >  
> > > > > Em Wed, 4 Aug 2021 10:28:53 -0600
> > > > > Rob Herring <robh@kernel.org> escreveu:
> > > > >  
> > > > > > On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:  
> > > > > > > Em Tue, 3 Aug 2021 16:11:42 -0600
> > > > > > > Rob Herring <robh+dt@kernel.org> escreveu:
> > > > > > >  
> > > > > > > > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > > > > > > > <mchehab+huawei@kernel.org> wrote:  
> > > > > > > > >
> > > > > > > > > Hi Rob,
> > > > > > > > >
> > > > > > > > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > > > > > > > corresponding PHY.
> > > > > > > > >
> > > > > > > > > It is identical to v2, except by:
> > > > > > > > >         -          pcie@7,0 { // Lane 7: Ethernet
> > > > > > > > >         +          pcie@7,0 { // Lane 6: Ethernet  
> > > > > > > >
> > > > > > > > Can you check whether you have DT node links in sysfs for the PCI
> > > > > > > > devices? If you don't, then something is wrong still in the topology
> > > > > > > > or the PCI core is failing to set the DT node pointer in struct
> > > > > > > > device. Though you don't rely on that currently, we want the topology
> > > > > > > > to match. It's possible this never worked on arm/arm64 as mainly
> > > > > > > > powerpc relied on this.
> > > > > > > >
> > > > > > > > I'd like some way to validate the DT matches the PCI topology. We
> > > > > > > > could have a tool that generates the DT structure based on the PCI
> > > > > > > > topology.  
> > > > > > >
> > > > > > > The of_node node link is on those places:
> > > > > > >
> > > > > > >   $ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > > > > > >   /sys/devices/platform/soc/f4000000.pcie/of_node
> > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node  
> > > > > >
> > > > > > Looks like we're missing some...
> > > > > >
> > > > > > It's not immediately obvious to me what's wrong here. Only the root
> > > > > > bus is getting it's DT node set. The relevant code is pci_scan_device(),
> > > > > > pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try
> > > > > > to reproduce and debug it.  
> > > > >
> > > > > I added a printk on both pci_set_*of_node() functions:
> > > > >
> > > > >       [    4.872991]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > > > >       [    4.913806]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000
> > > > >       [    4.978102] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > >       [    4.990622]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > >       [    5.052383] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
> > > > >       [    5.059263]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.085552]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.112073]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.138320]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.164673]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.233759] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> > > > >       [    5.240539]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.310545] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> > > > >       [    5.324719] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> > > > >       [    5.338914] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> > > > >       [    5.345516]  (null): pci_set_of_node: of_node: (null)
> > > > >       [    5.415795] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)  
> > > >
> > > > The enclosed patch makes the above a clearer:
> > > >
> > > >         [    4.800975]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > > >         [    4.855983] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
> > > >         [    4.879169] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > >         [    4.900602] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > >         [    4.953086] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)  
> > >
> > > I believe the issue is we need another bridge node in the DT
> > > hierarchy. What we have is:
> > >
> > > Bus 0 is node /soc/pcie@f4000000
> > > Bus 1 is device 0 on bus 0 is node /soc/pcie@f4000000/pcie@0,0
> > > Bus 2 is device 0 on bus 1 in node ... whoops, there's no device 0
> > > under /soc/pcie@f4000000/pcie@0,0
> > >
> > > So we need the hierarchy to be: /soc/pcie@f4000000/pcie@0/pcie@0/pcie@{1,5,7}  
> >
> > Adding a child pcie@0 produces the following output from my debug
> > patches:  
> 
> You removed your changes to the PCI code other than the debug print?

Yes.

> >
> > [    4.984278]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > [    5.042992] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
> > [    5.083738] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > [    5.124377] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > [    5.168395] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > [    5.200719] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0  
> 
> This should not happen. The devfn doesn't match.
> 
> > [    5.247777] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > [    5.276768] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > [    5.305018] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > [    5.333093] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > [    5.395620] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> > [    5.416333] pci 0000:03:00.0: pci_set_of_node: of_node: (null)
> > [    5.451353] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> > [    5.473970] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> > [    5.487765] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> > [    5.530219] pci 0000:06:00.0: pci_set_of_node: of_node: (null)
> > [    5.560896] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)
> >
> > It produces the following sysfs nodes:
> >
> >         $ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> >         /sys/devices/platform/soc/f4000000.pcie/of_node
> >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node
> >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node
> >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node
> >
> >
> > I'm enclosing the DT schema I'm using.
> >
> >
> >
> > Thanks,
> > Mauro
> >
> > ---
> >
> >                 pcie@f4000000 {
> >                         compatible = "hisilicon,kirin970-pcie";
> >                         reg = <0x0 0xf4000000 0x0 0x1000000>,
> >                               <0x0 0xfc180000 0x0 0x1000>,
> >                               <0x0 0xf5000000 0x0 0x2000>;
> >                         reg-names = "dbi", "apb", "config";
> >                         bus-range = <0x00 0xff>;
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> >                         device_type = "pci";
> >                         phys = <&pcie_phy>;
> >                         ranges = <0x02000000 0x0 0x00000000
> >                                   0x0 0xf6000000
> >                                   0x0 0x02000000>;
> >                         num-lanes = <1>;
> >                         #interrupt-cells = <1>;
> >                         interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> >                         interrupt-names = "msi";
> >                         interrupt-map-mask = <0 0 0 7>;
> >                         interrupt-map = <0x0 0 0 1
> >                                          &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0x0 0 0 2
> >                                          &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0x0 0 0 3
> >                                          &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> >                                         <0x0 0 0 4
> >                                          &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> >                         reset-gpios = <&gpio7 0 0>;
> >                         hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
> >                                                 <&gpio20 6 0>;
> >                         pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
> >                                 reg = <0x80 0 0 0 0>;  
> 
> s/0x80/0/
> 
> >                                 compatible = "pciclass,0604";
> >                                 device_type = "pci";
> >                                 #address-cells = <3>;
> >                                 #size-cells = <2>;
> >                                 ranges;
> >                                 bus-range = <0x01 0xff>;
> >                                 msi-parent = <&its_pcie>;
> >
> >                                 pcie@0,0 { // Lane 0: upstream
> >                                         reg = <0x010000 0 0 0 0>;  
> 
> While technically correct having the bus# in the address, that doesn't
> work for FDT since we don't know the bus assignment. So we should just
> use 0.

Using 0 causes DTB compilation to produce a warning, due to the
bus-range. Without the bus-range, there will be runtime warnings,
as this will be assigned as bus 1.

> 
> >                                         compatible = "pciclass,0604";
> >                                         device_type = "pci";
> >                                         #address-cells = <3>;
> >                                         #size-cells = <2>;
> >                                         ranges;
> >                                 };
> >                                 pcie@1,0 { // Lane 4: M.2  
> 
> These 3 nodes (1, 5, 7) need to be child nodes of the above node.
> 
> >                                         reg = <0x010800 0 0 0 0>;  
> 
> Just 0x800

The same applies here and to all the other nodes: they all need to have
the bus number on it, as otherwise either DTB compilation warnings
are generated, or runtime ones are produced, like:


            [    4.986196] kirin-pcie f4000000.pcie: PCI host bridge to bus 0000:00
            [    4.992572] pci_bus 0000:00: root bus resource [bus 00-01]
    ...
            [    5.065566] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-01] (conflicts with (null) [bus 00-01])
    
> 
> >                                         compatible = "pciclass,0604";
> >                                         device_type = "pci";
> >                                         reset-gpios = <&gpio3 1 0>;
> >                                         #address-cells = <3>;
> >                                         #size-cells = <2>;
> >                                         ranges;
> >                                 };
> >
> >                                 pcie@5,0 { // Lane 5: Mini PCIe
> >                                         reg = <0x012800 0 0 0 0>;  
> 
> 0x2800
> 
> >                                         compatible = "pciclass,0604";
> >                                         device_type = "pci";
> >                                         reset-gpios = <&gpio27 4 0 >;
> >                                         #address-cells = <3>;
> >                                         #size-cells = <2>;
> >                                         ranges;
> >                                 };
> >
> >                                 pcie@7,0 { // Lane 6: Ethernet
> >                                         reg = <0x013800 0 0 0 0>;  
> 
> 0x3800
> 
> >                                         compatible = "pciclass,0604";
> >                                         device_type = "pci";
> >                                         reset-gpios = <&gpio25 2 0 >;
> >                                         #address-cells = <3>;
> >                                         #size-cells = <2>;
> >                                         ranges;
> >                                 };
> >                         };
> >                 };
> >
> >
> >  



Thanks,
Mauro
