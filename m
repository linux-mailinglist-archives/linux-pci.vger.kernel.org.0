Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F141E3C8913
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhGNQ5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 12:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235708AbhGNQ5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 12:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA8460FDB;
        Wed, 14 Jul 2021 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626281669;
        bh=XoYT5XtueQRXXtB7aZ+UqbVexLXfAeUARaQviMLwgTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lw3WMBXiXixRPnErDWDG83CLwjlpIfxH+PjHWY33vmJ6qAuniAVyG4ihw/+EKjFtH
         FnwySLvelkmbn/O9ZDrS7hH4ISo13/hkCae6QhVY6OWW0qQYUfQb5ime5L8zN8kZ/O
         PPNFNb/a0TL5drB/6TfHJZtYNUVeAoSRLrODarD0mfb991C/YQmuXk520dvL8oB0hJ
         1kS8+ewSsP0cvkaTpprA3PCpUWM+9B44XlHJXfZh5QtsECxLlYwbBixR9HZukoEeIN
         TQwbDOUAQpfLpPvmrgiWt9zzzJVEWxOTpzEBp4s0hsIrs1WjBazcaGNFYs0htGtb3d
         etB11pufahzqQ==
Date:   Wed, 14 Jul 2021 11:54:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com,
        lijinlin3@huawei.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [question]: Query regarding the PCI addresses
Message-ID: <20210714165427.GA1854138@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7e27ea-5957-21a0-34b4-5adf517c3546@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Matthew for "lspci -P"]

On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
> Since linux identify PCI peripheral by [domain:bus:device:function] number
> like following,
> 
> # lspci -D
> 0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> 0000:00:01.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
> 0000:00:02.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
> Express Root Port 0 (rev 02)
> 0000:00:02.1 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
> Express Root Port 0 (rev 02)
> 0000:00:02.2 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
> Express Root Port 0 (rev 02)
> 0000:00:02.3 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI
> Express Root Port 0 (rev 02)
> 0000:01:00.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
> 0000:02:01.0 USB controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
> USB2 EHCI Controller (rev 10)
> 0000:02:02.0 Unclassified device [00ff]: Virtio: Virtio memory balloon
> 0000:02:03.0 SCSI storage controller: Virtio: Virtio SCSI
> 0000:02:04.0 Display controller: Virtio: Virtio GPU (rev 01)
> 0000:03:00.0 Ethernet controller: Virtio: Virtio network device (rev 01)
> 
> Here are my questions: Are these [domain:bus:device:function] number
> come from hardware's physical connection or allocated by software
> dynamic?

The device and function numbers are completely determined by the
hardware and are not programmable.

Bus numbers are programmable and are determined by the Secondary Bus
Number of the bridge leading to the device.  These bus numbers are
generally programmed by the BIOS on x86.  It's possible for Linux to
reprogram them, but it generally leaves them alone if they are valid.

On x86 with ACPI, the domain number comes from the _SEG method of the
PNP0A03 device that describes the host bridge.  This may correspond to
a programmable hardware register, but that isn't visible to the OS and
Linux has no way to change it.

> If hardware do not change, can we guarantee these number do not
> change after system reboot?

For the typical x86 system with ACPI, this is really a question for
the BIOS.  If the hardware doesn't change, I would *expect* the
domain/bus/device/function numbers to stay the same, but only BIOS
folks can answer this definitively.

> If they are not fixed, then is there anyway I can get a fixed ID
> which can indicate physical connection.

You can look at the "lspci -P" option.  I'm not really familiar with
this, but I think Matthew (cc'd) implemented it.

Bjorn
