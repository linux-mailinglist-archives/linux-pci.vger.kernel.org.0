Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E892141F64E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJAUa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:30:57 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35490 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhJAUa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 16:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=b69xBm+pTV8dYezsHJGDEqBysaYH6RziquJDPE33kv0=; b=YLVkivGIGRHypimDKWg8/gBClc
        38Ism2ZNuv+0zp0o4QhXQzgEC4i9IIksX6mGL2Gf41fFFRWWnl+5gY9tRE3eCGfZTlewd4qiVOnp3
        WDkz6fyRQ0hlUWLT5msVWw4DHxjPdBoIGsUwKH2jn7QfiwyqDqMJFQpWJZvxmqg7zBW6Ebhv8E9af
        epezHhhmcZawkGBZrCrcVoSZY2yY+QT/3Itm+L3Ffp5uurAMgbP4NfndSkv1DRxEmDq1QEtKC/Jfn
        BuWmRz4b3HVQTgS8U6qmqw+QibvSRdEINZFm1jWeLUVw/fRd7rfcWwLBi1YqNOGikpKu3M/NRS9u3
        8o6xdV4A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mWP9a-0006QQ-Bg; Fri, 01 Oct 2021 14:29:11 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>, kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvincao@outlook.com
References: <20211001201822.GA962472@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <21326395-6d4b-07aa-f445-ecc5dc189d17@deltatee.com>
Date:   Fri, 1 Oct 2021 14:29:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001201822.GA962472@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, kelvin.cao@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-10-01 2:18 p.m., Bjorn Helgaas wrote:
> On Fri, Sep 24, 2021 at 11:08:38AM +0000, kelvin.cao@microchip.com wrote:
>> From: Kelvin Cao <kelvin.cao@microchip.com>
>>
>> After a firmware hard reset, MRPC command executions, which are based
>> on the PCI BAR (which Microchip refers to as GAS) read/write, will hang
>> indefinitely. This is because after a reset, the host will fail all GAS
>> reads (get all 1s), in which case the driver won't get a valid MRPC
>> status.
> 
> Trying to write a merge commit log for this, but having a hard time
> summarizing it.  It sounds like it covers both Switchtec-specific
> (firmware and MRPC commands) and generic PCIe behavior (MMIO read
> failures).
> 
> This has something to do with a firmware hard reset.  What is that?
> Is that like a firmware reboot?  A device reset, e.g., FLR or
> secondary bus reset, that causes a firmware reboot?  A device reset
> initiated by firmware?
> 
> Anyway, apparently when that happens, MMIO reads to the switch fail
> (timeout or error completion on PCIe) for a while.  If a device reset
> is involved, that much is standard PCIe behavior.  And the driver sees
> ~0 data from those failed reads.  That's not part of the PCIe spec,
> but is typical root complex behavior.
> 
> But you said the MRPC commands hang indefinitely.  Presumably MMIO
> reads would start succeeding eventually when the device becomes ready,
> so I don't know how that translates to "indefinitely."

I suspect Kelvin can expand on this and fix the issue below. But in my
experience, the MMIO will read ~0 forever after a firmware reset, until
the system is rebooted. Presumably on systems that have good hot plug
support they are supposed to recover. Though I've never seen that.

The MMIO read that signals the MRPC status always returns ~0 and the
userspace request will eventually time out.

> Weird to refer to a PCI BAR as "GAS".  Maybe expanding the acronym
> would help it make sense.
GAS is the term used by the firmware developers and is in all their
documentation. It stands for Global Address Space.

> What does "host" refer to?  I guess it's the switch (the
> switchtec_dev), since you say it fails MMIO reads?

Yes, a bit confusing. The firmware is dead or not setup right so MMIO
reads are not succeeding and the root complex is returning ~0 to the
driver on reads.

Logan
