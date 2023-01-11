Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33B665FE8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjAKQCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 11:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAKQCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 11:02:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C6140F5;
        Wed, 11 Jan 2023 08:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6958A61D8F;
        Wed, 11 Jan 2023 16:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06ADC433EF;
        Wed, 11 Jan 2023 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673452939;
        bh=WDPK4ezOCWydIceMJVIpzVu3xHbUz8bsTbKyssT5l9A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sh0Erk94yVz5Y+9iwmzpb1XW5N3jNnDPLYkBDHOoP/UoyAOkO8S0QiVtcO896KS5q
         J03RTgedaKSYofVgiPNPOg9PXk2jquJzH2RNZ0Bv6T/wPq+Of5Mtfj7gWcp2UoedOl
         kL9z2liB6IAydXzXxXmeLs/WcXzLXcTtm0FPTBYrJG2fVOEq5yZ+lHHhknJW9uAkBO
         zJw4mhoDAsLksgFK937mI8MoqFamN6AsjkKOFLk86IpfyKs813G1MyKxhWAF+WVT+f
         waKi3Xhi6LZabmIoJMuQEYZPZuKjUZDPsiD1Z412va0XbBylIwRpga81y+zK42mLv9
         bnrFRZkxSZY7Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
References: <20221124230505.073418677@linutronix.de>
        <20221124232326.034672592@linutronix.de> <Y7VyXNbWMdWWAC6d@nvidia.com>
        <87eds2k2nr.ffs@tglx> <Y719OcFueTg09OUV@nvidia.com>
Date:   Wed, 11 Jan 2023 18:02:13 +0200
In-Reply-To: <Y719OcFueTg09OUV@nvidia.com> (Jason Gunthorpe's message of "Tue,
        10 Jan 2023 10:59:05 -0400")
Message-ID: <87o7r5dpq2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Jan 10, 2023 at 01:14:00PM +0100, Thomas Gleixner wrote:
>
>> Care to send a proper patch with changelog?
>
> Yes, I'll post it in a few days once the test team confirms it

I think I'm seeing the same leak and it's spamming logs on my test box a
lot. Let me know if you need any help with testing, I can do that pretty
quickly.

unreferenced object 0xffff888113dc7520 (size 96):
comm "insmod", pid 50676, jiffies 4301551867 (age 1463.666s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 25 68 a5 ff ff ff ff  .........%h.....
00 00 00 00 00 00 00 00 38 75 dc 13 81 88 ff ff  ........8u......
backtrace:
[<ffffffffa3105532>] __kmem_cache_alloc_node+0x1d2/0x2b0
[<ffffffffa2fdfb45>] kmalloc_trace+0x25/0x60
[<ffffffffa2cb8b42>] __irq_domain_alloc_fwnode+0x52/0x2b0
[<ffffffffa2cc6add>] msi_create_device_irq_domain+0x27d/0x630
[<ffffffffa3aaf5a9>] pci_setup_msi_device_domain+0xe9/0x120
[<ffffffffa3aababd>] __pci_enable_msi_range+0x3fd/0x5a0
[<ffffffffa3aa8ac3>] pci_alloc_irq_vectors_affinity+0x153/0x200
[<ffffffffa3aa8b7c>] pci_alloc_irq_vectors+0xc/0x10
[<ffffffffc0b75287>] ath11k_pci_alloc_msi+0xb7/0x610 [ath11k_pci]
[<ffffffffc0b7696e>] ath11k_pci_probe+0x5be/0x1090 [ath11k_pci]
[<ffffffffa3a8d4e9>] local_pci_probe+0xd9/0x170
[<ffffffffa3a8f687>] pci_call_probe+0x167/0x440
[<ffffffffa3a919f6>] pci_device_probe+0xa6/0x100
[<ffffffffa43c2c09>] really_probe+0x1c9/0xa50
[<ffffffffa43c361a>] __driver_probe_device+0x18a/0x460
[<ffffffffa43c393a>] driver_probe_device+0x4a/0x120

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
