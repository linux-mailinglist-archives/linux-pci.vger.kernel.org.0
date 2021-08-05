Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A316C3E0F74
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhHEHqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 03:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhHEHqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 03:46:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D52D260E52;
        Thu,  5 Aug 2021 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628149582;
        bh=OQMzqlGLWysC7ViHpXfROhIRuImNOkl09B3GGvOiqas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SDorkv9xbBYyu3KWS0FiKrw4oVXd1LFxiQINqV1GlwB8jZ+N/rMt02PgyHEf+DWaP
         DElXbggoFPpU6MC/ltSfIKr5GnuCqBBvw/LgLu7hoa/8Z6+APi7Cr3yprOG7YAMT4s
         SdNY2+8nGDNSolxZbB0Se0QoDaSFK7O3+xWtdq7pD6pp0q23xztx4NFEeR3k2nGqW+
         fa+Rlsa/5bc7XRqjvDFFPpYfoIKdc05ONNudZqtn6ZP4IyjcrHC6X5yYB9UACqdzAT
         o8kF98IkUQmDnXH8E+0mkJHs1KpSYamQFHLeGsue7YmgJH7G56xRt5+JdXUWvskAe7
         HHHIuitj7oNsg==
Date:   Thu, 5 Aug 2021 09:46:12 +0200
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
Message-ID: <20210805094612.2bc2c78f@coco.lan>
In-Reply-To: <YQrARd7wgYS1nywt@robh.at.kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
        <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
        <20210804085045.3dddbb9c@coco.lan>
        <YQrARd7wgYS1nywt@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 4 Aug 2021 10:28:53 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 3 Aug 2021 16:11:42 -0600
> > Rob Herring <robh+dt@kernel.org> escreveu:
> >   
> > > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:  
> > > >
> > > > Hi Rob,
> > > >
> > > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > > corresponding PHY.
> > > >
> > > > It is identical to v2, except by:
> > > >         -          pcie@7,0 { // Lane 7: Ethernet
> > > >         +          pcie@7,0 { // Lane 6: Ethernet    
> > > 
> > > Can you check whether you have DT node links in sysfs for the PCI
> > > devices? If you don't, then something is wrong still in the topology
> > > or the PCI core is failing to set the DT node pointer in struct
> > > device. Though you don't rely on that currently, we want the topology
> > > to match. It's possible this never worked on arm/arm64 as mainly
> > > powerpc relied on this.
> > >
> > > I'd like some way to validate the DT matches the PCI topology. We
> > > could have a tool that generates the DT structure based on the PCI
> > > topology.  
> > 
> > The of_node node link is on those places:
> > 
> > 	$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > 	/sys/devices/platform/soc/f4000000.pcie/of_node
> > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node  
> 
> Looks like we're missing some... 
> 
> It's not immediately obvious to me what's wrong here. Only the root 
> bus is getting it's DT node set. The relevant code is pci_scan_device(), 
> pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try 
> to reproduce and debug it.

I added a printk on both pci_set_*of_node() functions:

	[    4.872991]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	[    4.913806]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000
	[    4.978102] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    4.990622]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.052383] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
	[    5.059263]  (null): pci_set_of_node: of_node: (null)
	[    5.085552]  (null): pci_set_of_node: of_node: (null)
	[    5.112073]  (null): pci_set_of_node: of_node: (null)
	[    5.138320]  (null): pci_set_of_node: of_node: (null)
	[    5.164673]  (null): pci_set_of_node: of_node: (null)
	[    5.233759] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
	[    5.240539]  (null): pci_set_of_node: of_node: (null)
	[    5.310545] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
	[    5.324719] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
	[    5.338914] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
	[    5.345516]  (null): pci_set_of_node: of_node: (null)
	[    5.415795] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

It sounds that the parent is missing when pci_set_bus_of_node() is
called on some places. I'll try to identify why.

Thanks,
Mauro
