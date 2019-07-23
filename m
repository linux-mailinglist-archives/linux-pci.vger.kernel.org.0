Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A984371A61
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfGWOaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 10:30:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3107 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfGWOaM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 10:30:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3719f00001>; Tue, 23 Jul 2019 07:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 07:30:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 07:30:10 -0700
Received: from [10.25.74.243] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 14:28:51 +0000
Subject: RE: [PATCH V13 12/12] PCI: tegra: Add Tegra194 PCIe support
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-13-vidyas@nvidia.com>
 <20190711125433.GB26088@e121166-lin.cambridge.arm.com>
 <986d0b1a-666a-7b05-a9f3-e761518bdc92@nvidia.com>
 <20190712160754.GA24285@e121166-lin.cambridge.arm.com>
 <a5f8689b-1358-dd2d-4f54-7e68a6ab158b@nvidia.com>
 <20190716112225.GA24335@e121166-lin.cambridge.arm.com>
 <20190716190013.GB4470@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9ecdeefe-ed22-47bc-50dc-139dd05029b4@nvidia.com>
Date:   Tue, 23 Jul 2019 19:58:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716190013.GB4470@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563892208; bh=y3iFx42LYhbEL+dlk0IO97VXY77VlAHy2wWmhXVOoNw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qlaXao0Hm4EbazMDNs0zsUCfqJhGXMIJzOnKIlOtQgFO+h939gPrIQNWVV6uU7u7G
         TnYT3vSEXX3oS39rSU8UKYISRNsiObI9sLbr1o4PI5hSqizdo8+/Y9aPqxgl9Dt2U4
         92PlAEamCxZjc65BYwmr+QYHIF7d2U/JBtRWW4qZyzDI144Ge2WKXjUKSyJ2j1U2Iy
         BSjY7aKXpVvjy6rW+J/FvKj06w5t0e0vlfnTqK/A52Tn+zY+ISSC1ZdkpGQHVYjC2O
         tjejFEjGn7SR9pwt1PHlSufRokL/jeepQqjlU8gu2uZnyUvSwLIN4fdMAyh6eZpavJ
         ROk5kO4F8UDHg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org <devicetree-owner@vger.kernel.org>
> On Behalf Of Bjorn Helgaas
> Sent: Wednesday, July 17, 2019 12:30 AM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; kishon@ti.com; catalin.marinas@arm.com;
> will.deacon@arm.com; jingoohan1@gmail.com;
> gustavo.pimentel@synopsys.com; digetx@gmail.com; Mikko Perttunen
> <mperttunen@nvidia.com>; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Krishna Thota
> <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;
> sagar.tv@gmail.com
> Subject: Re: [PATCH V13 12/12] PCI: tegra: Add Tegra194 PCIe support
> 
> On Tue, Jul 16, 2019 at 12:22:25PM +0100, Lorenzo Pieralisi wrote:
> > On Sat, Jul 13, 2019 at 12:34:34PM +0530, Vidya Sagar wrote:
> 
> > > > > > So if the link is not up we still go ahead and make probe
> > > > > > succeed. What for ?
> > > > > We may need root port to be available to support hot-plugging of
> > > > > endpoint devices, so, we don't fail the probe.
> > > >
> > > > We need it or we don't. If you do support hotplugging of endpoint
> > > > devices point me at the code, otherwise link up failure means
> > > > failure to probe.
> > > Currently hotplugging of endpoint is not supported, but it is one of
> > > the use cases that we may add support for in future.
> >
> > You should elaborate on this, I do not understand what you mean,
> > either the root port(s) supports hotplug or it does not.
> >
> > > But, why should we fail probe if link up doesn't happen? As such,
> > > nothing went wrong in terms of root port initialization right?  I
> > > checked other DWC based implementations and following are not
> > > failing the probe pci-dra7xx.c, pcie-armada8k.c, pcie-artpec6.c,
> > > pcie-histb.c, pcie-kirin.c, pcie-spear13xx.c, pci-exynos.c,
> > > pci-imx6.c, pci-keystone.c, pci-layerscape.c
> > >
> > > Although following do fail the probe if link is not up.
> > > pcie-qcom.c, pcie-uniphier.c, pci-meson.c
> > >
> > > So, to me, it looks more like a choice we can make whether to fail
> > > the probe or not and in this case we are choosing not to fail.
> >
> > I disagree. I had an offline chat with Bjorn and whether link-up
> > should fail the probe or not depends on whether the root port(s) is
> > hotplug capable or not and this in turn relies on the root port "Slot
> > implemented" bit in the PCI Express capabilities register.
> 
> There might be a little more we can talk about in this regard.  I did bring up the
> "Slot implemented" bit, but after thinking about it more, I don't really think the
> host bridge driver should be looking at that.
> That's a PCIe concept, and it's really *downstream* from the host bridge itself.
> The host bridge is logically a device on the CPU bus, not the PCI bus.
> 
> I'm starting to think that the host bridge driver probe should be disconnected
> from question of whether the root port links are up.
> 
> Logically, the host bridge driver connects the CPU bus to a PCI root bus, so it
> converts CPU-side accesses to PCI config, memory, or I/O port transactions.
> Given that, the PCI core can enumerate devices on the root bus and downstream
> buses.
> 
> Devices on the root bus typically include Root Ports, but might also include
> endpoints, Root Complex Integrated Endpoints, Root Complex Event Collectors,
> etc.  I think in principle, we would want the host bridge probe to succeed so we
> can use these devices even if none of the Root Ports have a link.
> 
> If a Root Port is present, I think users will expect to see it in the "lspci" output,
> even if its downstream link is not up.  That will enable things like manually
> poking the Root Port via "setpci" for debug.  And if it has a connector, the
> generic pciehp should be able to handle hot-add events without any special help
> from the host bridge driver.
> 
> On ACPI systems there is no concept of the host bridge driver probe failing
> because of lack of link on a Root Port.  If a Root Port doesn't have an
> operational link, we still keep the pci_root.c driver, and we'll enumerate the
> Root Port itself.  So I tend to think DT systems should behave the same way, i.e.,
> the driver probe should succeed unless it fails to allocate resources or something
> similar.  I think this is analogous to a NIC or USB adapter driver, where the probe
> succeeds even if there's no network cable or USB device attached.
> 
> Bjorn
Thanks Bjorn for your valuable inputs. I hope we are good here to not power down host
even if there are no endpoints detected.

- Vidya Sagar
