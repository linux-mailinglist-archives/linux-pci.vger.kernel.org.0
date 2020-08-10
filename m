Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFCE2412EB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 00:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHJWV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 18:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgHJWV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Aug 2020 18:21:26 -0400
Received: from localhost (130.sub-72-107-113.myvzw.com [72.107.113.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFACF206DA;
        Mon, 10 Aug 2020 22:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597098086;
        bh=iaADNcOSeb/CF7KwD+jVe/nkWI2t5hnF8e5DcMdeAM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XScJg6/O/63cPVacu5FdpC8xODgnY4mGvoWP+Lz/OksSvLUBUGHv8rv95CGvsWtQh
         AFUpXhjTDmspVp6OUklH0IUrPMaGbIy/LPQMZj2mgptbPxCiIaYmAJstjWt0EhQc2C
         FO/5z2yjk+473Sb2Mt4pQiXBAQC2d5rSwJBUn+vg=
Date:   Mon, 10 Aug 2020 17:21:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, linux@yadro.com
Subject: Re: [PATCH v8 00/24] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20200810222124.GA952697@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 09:23:34PM +0300, Sergei Miroshnichenko wrote:
> Currently PCI hotplug works on top of resources which are usually reserved
> not by the kernel, but by BIOS, bootloader, firmware, etc. These resources
> are gaps in the address space where BARs of new devices may fit, and extra
> bus number per port, so bridges can be hot-added. This series aim the BARs
> problem: it shows the kernel how to redistribute them on the run, so the
> hotplug becomes predictable and cross-platform. A follow-up patchset will
> propose a solution for bus numbers.
> 
> To arrange a space for BARs of new hotplugged devices, the kernel can pause
> the drivers of working PCI devices and reshuffle the assigned BARs. When a
> driver is un-paused by the kernel, it should ioremap() the new addresses of
> its BARs.
> 
> Drivers indicate their support of the feature by implementing the new hooks
> .rescan_prepare() and .rescan_done() in the struct pci_driver. If a driver
> doesn't yet support the feature, BARs of its devices will be considered as
> immovable and handled in the same way as resources with the PCI_FIXED flag:
> they are guaranteed to remain untouched.
> 
> Tested on a number of x86_64 machines without any special kernel command
> line arguments:
>  - PC: i7-5930K + ASUS X99-A;
>  - PC: i5-8500 + ASUS Z370-F;
>  - Supermicro Super Server/H11SSL-i: AMD EPYC 7251;
>  - HP ProLiant DL380 G5: Xeon X5460;
>  - Dell Inspiron N5010: i5 M 480;
>  - Dell Precision M6600: i7-2920XM.
> ...

There's a lot of good work here, and I apologize that we haven't made
much progress on merging it.  I suspect this will become more and more
important with Thunderbolt.

It does touch a lot of the ugliest and least maintainable code under
drivers/pci, which is *good* if we can clean it up a little bit in the
process, but it is also risky.

I expect that a few problems are inevitable because of BIOS issues,
driver issues, and devices that can't tolerate their BARs being moved.
We've tripped over a few of those devices in the past.

Those can be really hard to debug and fix since we won't have the
hardware in question.  To make them tractable, I think we will really
need some way to test at least the resource assignment pieces of this
"in vitro" without needing the actual hardware.  E.g., maybe we could
add enough diagnostics so that a dmesg log would contain all the
information needed to reproduce a PCI hierarchy, the initial resource
assignments, and subsequent hotplug events in some sort of test
fixture, maybe a qemu boot or similar.

Bjorn
