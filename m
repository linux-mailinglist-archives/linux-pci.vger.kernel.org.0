Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2799A265EC9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKL3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 07:29:47 -0400
Received: from foss.arm.com ([217.140.110.172]:60404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKL2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 07:28:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC2F113E;
        Fri, 11 Sep 2020 04:27:24 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59C303F68F;
        Fri, 11 Sep 2020 04:27:22 -0700 (PDT)
Subject: Re: [PATCH 2/3] ARM/keystone: move the DMA offset handling under
 ifdef CONFIG_ARM_LPAE
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-3-hch@lst.de>
 <20200911111551.GG1551@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <211af505-04fa-9cff-3178-1c8c24548485@arm.com>
Date:   Fri, 11 Sep 2020 12:27:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911111551.GG1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-09-11 12:15, Russell King - ARM Linux admin wrote:
> On Thu, Sep 10, 2020 at 07:40:37AM +0200, Christoph Hellwig wrote:
>> The DMA offset notifier can only be used if PHYS_OFFSET is at least
>> KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
>> phys_addr_t.  Currently the code compiles fine despite that, a pending
>> change to the DMA offset handling would create a compiler warning for
>> this case.  Add an ifdef to not compile the code except for LPAE
>> configs.
> 
> However, to have use of the high physical offset, LPAE needs to be
> enabled, which ensures that phys_addr_t is 64-bit.
> 
> I believe that DMA is non-coherent on this platform unless the high
> physical address is used. Or something like that.

Yeah, it's probably not a configuration that anyone would actually want 
to use in anger on Keystone itself, but as long as folks might have 
ARCH_KEYSTONE selected in their non-LPAE multiplatform config we should 
avoid build regressions. I did wonder if Keystone should simply have a 
hard dependency on LPAE, but there does appear to be some explicit 
support for running directly from the non-coherent low 2G alias :/

Robin.
