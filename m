Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76AA0265
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfH1NBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1NA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 09:00:59 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B3122CF8;
        Wed, 28 Aug 2019 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566997258;
        bh=lJERGNxV95DY7mdSVIbZ1K211HvqYQUsOZHd9sB573o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agv41za5BkMjlG8dxuClSPIbjoBlOUdN50ZkqYkKvkdJUQgjwDkNuGmUWqsU53S40
         Xg8HtiSUi09wNSRJnGp5iM7uhWHE51BeY3ZftTTCYQrSGxGZJnLHRT68t53eMm5PG2
         7qAWCDITDMXEFTkpJYlyn9qN91UXS4MjyxrGrI4Q=
Date:   Wed, 28 Aug 2019 08:00:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Fawad Lateef <fawadlateef@gmail.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: *_pcie_establish_link() usage
Message-ID: <20190828130056.GA4550@google.com>
References: <20190801212529.GE151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801212529.GE151852@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 04:25:29PM -0500, Bjorn Helgaas wrote:
> Hi,
> 
> I got the following dmesg log from Fawad [1]:
> 
>   imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
>   imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff -> 0x00000000
>   imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff -> 0x01000000
>   imx6q-pcie 1ffc000.pcie: Link up
>   imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
>   imx6q-pcie 1ffc000.pcie: Link up, Gen1
>   imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>   pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
>   pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> 
> This is unrelated to the problem Fawad is working on, but the above
> looks wrong to me because it associates the "Link up" and link speed
> info with the host bridge (imx6q-pcie 1ffc000.pcie), not the Root Port
> (pci 0000:00:00.0).
> 
> I see that *_pcie_establish_link() is generally called from
> *_pcie_host_init(), typically via the struct
> dw_pcie_host_ops.host_init pointer, e.g.,
> 
>   dra7xx_pcie_probe
>     dra7xx_add_pcie_port(dra7xx)
>       struct dw_pcie *pci = dra7xx->pci
>       struct pcie_port *pp = &pci->pp
>       dw_pcie_host_init(struct pcie_port *pp)
> 	bridge = devm_pci_alloc_host_bridge
> 	devm_of_pci_get_host_bridge_resources
> 	pp->ops->host_init(pp)
> 	  dra7xx_pcie_host_init               # .host_init
> 	    dra7xx_pcie_establish_link        # <--- bring up link
> 	    dw_pcie_wait_for_link
> 	pci_scan_root_bus_bridge(bridge)      # <--- enumerate
> 	pp->root_bus = bridge->bus
> 	pci_bus_add_devices(pp->root_bus)
> 
> AFAICT, the *_pcie_establish_link() functions all operate on a single
> PCIe link, i.e., they are bringing up the link going downstream from a
> single Root Port.
> 
> It looks like this only allows a single Root Port per struct dw_pcie
> device.  Is that true?  *Should* that be true?
> 
> It looks like we bring up the link before enumerating.  In some cases,
> (meson_pcie_host_init(), qcom_pcie_host_init(),
> uniphier_pcie_host_init()) if the link doesn't come up, we return
> failure, which means dw_pcie_host_init() will not enumerate devices at
> all.
> 
> That seems wrong -- can't we have Root Complex Integrated Endpoints
> and even other Root Ports on that root bus?  Those should be
> accessible and possibly useful even if we can't bring up a link on
> *one* Root Port.
> 
> I would *expect* that we would enumerate all the devices on the root
> bus.  Then if we find one or more Root Ports, we might try to bring up
> the link for each one, and if successful, enumerate the downstream
> devices.
> 
> I'm confused.  Is there some restriction that means there can only be
> a single Root Port in this design, and no RCiEPs?  Even if there is,
> can we change the code so it enumerates the root bus first and brings
> up links as necessary so it matches the generic PCIe topology better?

Anyone?  I'll add this to a list of projects for interested people to
work on unless somebody objects.

> [1] https://lore.kernel.org/linux-pci/CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com/
