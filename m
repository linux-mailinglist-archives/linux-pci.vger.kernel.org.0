Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86943AB08
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 06:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJZESF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 00:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhJZESE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 00:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDD360EDF;
        Tue, 26 Oct 2021 04:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635221741;
        bh=Upw18BMnAJNHZIJJpkphWj/uFqecyQTLJdSZFRJJJPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzAfIKq2hSoaUzW7YoqAGIOnLTuzUnaq2pQdkh0Iug5i0X7VdQz6TG/2QxUbIg80t
         2LBsKVXMtntLEKIhEGSzVo8H8nvxZalkrQS8XWjlT8PPIjj0TF8Y8NezKGjRHRo+6+
         WRehkG7fs1xGbuooYpfn1xccuePsl7oKhBX5eDU7h4f4uCg1wzT2aVvPyWad5MZ7cD
         oCCmVtikSjUPj9qU9FlSYA3Mxn/NbT7jexhdTVuCwdjN6LhCsooiozVuhYlEkLwDe4
         QOYpytUkqhZws97aGeK3Bmw49JefgJmPlS5/mZgY6DxNhIl9G5ygHkM5HnUofhhRKr
         6wmGShRuGQ+wQ==
Date:   Mon, 25 Oct 2021 21:15:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Message-ID: <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
 <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
 <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 980". From its datasheet, https://s3.ap-northeast-2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_Rev.1.1.pdf, it says nothing about CMB/SQEs, so I'm not sure. Is there other ways/tools(like nvme-cli) to query?

The driver will export a sysfs property for it if it is supported:

  # cat /sys/class/nvme/nvme0/cmb

If the file doesn't exist, then /dev/nvme0 doesn't have the capability.

> > > I don't know how to interpret "ranges".  Can you supply the dmesg and
> > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > >
> > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
> > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > >
> > > > Question:
> > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > 
> > That means the nvme controller didn't provide a response to a posted
> > command within the driver's latency tolerance.
> 
> FYI, with the help of pci bridger's vendor, they find something interesting: "From catc log, I saw some memory read pkts sent from SSD card, but its memory range is within the memory range of switch down port. So, switch down port will replay UR pkt. It seems not normal." and "Why SSD card send out some memory pkts which memory address is within switch down port's memory range. If so, switch will response UR pkts". I also don't understand how can this happen?

I think we can safely assume you're not attempting peer-to-peer, so that
behavior as described shouldn't be happening. It sounds like the memory
windows may be incorrect. The dmesg may help to show if something appears
wrong.
