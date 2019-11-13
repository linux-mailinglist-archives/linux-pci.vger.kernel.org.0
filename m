Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F4FB599
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfKMQvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 11:51:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38646 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKMQvC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 11:51:02 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iUvr5-0004JU-OS; Wed, 13 Nov 2019 09:50:56 -0700
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
References: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7f824f5f-ee0f-0591-9170-1433c0813857@deltatee.com>
Date:   Wed, 13 Nov 2019 09:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: benh@kernel.crashing.org, corbet@lwn.net, mika.westerberg@linux.intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,LR_URI_NUMERIC_ENDING,MYRULES_FREE autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-13 8:25 a.m., Nicholas Johnson wrote:
> Currently, the kernel can sometimes assign the MMIO_PREF window
> additional size into the MMIO window, resulting in extra MMIO additional
> size, despite the MMIO_PREF additional size being assigned successfully
> into the MMIO_PREF window.
> 
> This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> fails. In the next pass, because MMIO_PREF is already assigned, the
> attempt to assign MMIO_PREF returns an error code instead of success
> (nothing more to do, already allocated). Hence, the size which is
> actually allocated, but thought to have failed, is placed in the MMIO
> window.
> 
> Example of problem (more context can be found in the bug report URL):
> 
> Mainline kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> 
> Patched kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> 
> This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> with the same configuration, with a Ubuntu mainline kernel and a kernel
> patched with this patch.
> 
> The bug results in the MMIO_PREF being added to the MMIO window, which
> means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
> the MMIO window will likely fail to be assigned altogether due to lack
> of 32-bit address space.
> 
> Change find_free_bus_resource() to do the following:
> - Return first unassigned resource of the correct type.
> - If none of the above, return first assigned resource of the correct type.
> - If none of the above, return NULL.
> 
> Returning an assigned resource of the correct type allows the caller to
> distinguish between already assigned and no resource of the correct type.
> 
> Rename find_free_bus_resource to find_bus_resource_of_type().
> 
> Add checks in pbus_size_io() and pbus_size_mem() to return success if
> resource returned from find_free_bus_resource() is already allocated.
> 
> This avoids pbus_size_io() and pbus_size_mem() returning error code to
> __pci_bus_size_bridges() when a resource has been successfully assigned
> in a previous pass. This fixes the existing behaviour where space for a
> resource could be reserved multiple times in different parent bridge
> windows.
> 
> Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243
> 
> Reported-by: Kit Chow <kchow@gigaio.com>
> Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

You can add mine as well:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
