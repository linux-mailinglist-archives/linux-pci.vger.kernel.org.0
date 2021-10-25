Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2AB439B69
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhJYQYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 12:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233873AbhJYQYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 12:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B2E60EFF;
        Mon, 25 Oct 2021 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635178921;
        bh=XtSAlqkPhKe+oeJqzUHbjTm+HZ0V0fZX6iK2PC6DUys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBobkh7l3CSWwGVd2nNajP4w4YIAvNxXJ8/hKe9LykGqw3ATWxqQD+QDKaDUyejel
         b26S3B7BYDc3YninRz5tsuDF4J4gKvjwfpXk3otE5jpQCp/cKWCHsLP+qecch1uMQL
         MnkKnxH/D7mVJTDs28pWRwzW3NAzfudDcUxMwlU/T8Zt1QSJuo6OH7+7UJTHvWsuPc
         1FevFzK9puYMJmQAXyjgKSrCP9V0gvlOO5vDfrmTkjM6Vxv7af1lJAa7O1oucYjh3O
         QfCVRzhEn/O45p95KI2X69vU4kZz7R8qDT5Yv8S3rzYIo343Af+u32lKsnSsOT1imS
         0MoX+7EMNWrCg==
Date:   Mon, 25 Oct 2021 09:21:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Li Chen <lchen@ambarella.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: nvme may get timeout from dd when using different non-prefetch
 mmio outbound/ranges
Message-ID: <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025154739.GA4760@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 10:47:39AM -0500, Bjorn Helgaas wrote:
> [+cc Tom (Cadence maintainer), NVMe folks]
> 
> On Fri, Oct 22, 2021 at 10:08:20AM +0000, Li Chen wrote:
> > pciec: pcie-controller@2040000000 {
> >                                 compatible = "cdns,cdns-pcie-host";
> > 		device_type = "pci";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 		bus-range = <0 5>;
> > 		linux,pci-domain = <0>;
> > 		cdns,no-bar-match-nbits = <38>;
> > 		vendor-id = <0x17cd>;
> > 		device-id = <0x0100>;
> > 		reg-names = "reg", "cfg";
> > 		reg = <0x20 0x40000000 0x0 0x10000000>,
> > 		      <0x20 0x00000000 0x0 0x00001000>;	/* RC only */
> > 
> > 		/*
> > 		 * type: 0x00000000 cfg space
> > 		 * type: 0x01000000 IO
> > 		 * type: 0x02000000 32bit mem space No prefetch
> > 		 * type: 0x03000000 64bit mem space No prefetch
> > 		 * type: 0x43000000 64bit mem space prefetch
> > 		 * The First 16MB from BUS_DEV_FUNC=0:0:0 for cfg space
> > 		 * <0x00000000 0x00 0x00000000 0x20 0x00000000 0x00 0x01000000>, CFG_SPACE
> > 		*/
> > 		ranges = <0x01000000 0x00 0x00000000 0x20 0x00100000 0x00 0x00100000>,
> > 			 <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000>;
> > 
> > 		#interrupt-cells = <0x1>;
> > 		interrupt-map-mask = <0x00 0x0 0x0 0x7>;
> > 		interrupt-map = <0x0 0x0 0x0 0x1 &gic 0 229 0x4>,
> > 				<0x0 0x0 0x0 0x2 &gic 0 230 0x4>,
> > 				<0x0 0x0 0x0 0x3 &gic 0 231 0x4>,
> > 				<0x0 0x0 0x0 0x4 &gic 0 232 0x4>;
> > 		phys = <&pcie_phy>;
> > 		phy-names="pcie-phy";
> > 		status = "ok";
> > 	};
> > 
> > 
> > After some digging, I find if I change the controller's range
> > property from
> >
> > <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000> into
> > <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>,
> >
> > then dd will success without timeout. IIUC, range here
> > is only for non-prefetch 32bit mmio, but dd will use dma (maybe cpu
> > will send cmd to nvme controller via mmio?).

Generally speaking, an nvme driver notifies the controller of new
commands via a MMIO write to a specific nvme register. The nvme
controller fetches those commands from host memory with a DMA.

One exception to that description is if the nvme controller supports CMB
with SQEs, but they're not very common. If you had such a controller,
the driver will use MMIO to write commands directly into controller
memory instead of letting the controller DMA them from host memory. Do
you know if you have such a controller?

The data transfers associated with your 'dd' command will always use DMA.

> I don't know how to interpret "ranges".  Can you supply the dmesg and
> "lspci -vvs 0000:05:00.0" output both ways, e.g., 
> 
>   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
>   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
>   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
>   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> 
> > Question:
> > 1.  Why dd can cause nvme timeout? Is there more debug ways?

That means the nvme controller didn't provide a response to a posted
command within the driver's latency tolerance.

> > 2. How can this mmio range affect nvme timeout?

Let's see how those ranges affect what the kernel sees in the pci
topology, as Bjorn suggested.
