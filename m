Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF5463F17
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbhK3USN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 15:18:13 -0500
Received: from ale.deltatee.com ([204.191.154.188]:58418 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbhK3USN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 15:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=0e6qph97LvKq8JPi/3FNd4qxcjAsoSfKpY9JBqr3S7c=; b=U+nEWKC8vX6L81PWLuyf8RU1/z
        qqqdUvc6OmN093ipgotV5I33+4FNd41c8SNkN6XbaMuGa63k6/CSH3iDUxaeRDLa88FTqqtxO76Qu
        CZngmEesymNwgDTm1GRuc159pfNMgAonPTSfdHROePpQ6NLvIUtyYaO5/12oK1G6+1zvUaPy0KBfx
        POhHjslTvMcQtxgHqXe6G24+FZw/Z5m6Wg+ueGbFL3z3o+Il3e7rB5YheZ9ac8E3DOvhJrl6TTiKv
        ppAJYTafyW7PPoPWYfeGf/nS0QNPjFUpfs+5+ej3cihOf8vl1wTIY/bHLOwprdCAaMUn+3yDZ+AAE
        Qunl9krw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ms9WX-00BD79-DR; Tue, 30 Nov 2021 13:14:46 -0700
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Doug Meyer <dmeyer@gigaio.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8a1fae8b-3811-6368-50da-9de9e286c8e5@deltatee.com>
Date:   Tue, 30 Nov 2021 13:14:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87v909bf2k.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, x86@kernel.org, borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, jgg@nvidia.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-30 12:48 p.m., Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
>> On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>>> I'm way too tired to come up with a proper solution for that, but that
>>> PCI_IRQ_VIRTUAL has to die ASAP.
>>
>> I'm willing to volunteer a bit of my time to clean this up, but I'd need
>> a bit more direction on what a proper solution would look like. The MSI
>> domain code is far from well documented nor is it easy to understand.
> 
> Fair enough. I'm struggling with finding time to document that properly.
> 
> I've not yet made my mind up what the best way forward for this is, but
> I have a few ideas which I want to explore deeper.
> 
> But the most important question is right now on which architectures
> these switchtec virtual interrupt things are used.
> 
> If it's used on any architecture which does not use hierarchical
> irqdomains for MSI (x86, arm, arm64, power64), then using irqdomains is
> obviously a non-starter unless falling back to a single interrupt would
> not be considered a regression :)

Well that's a hard question to answer. The switchtec hardware is a very
generic PCI switch that can technically be used on any architecture that
supports PCI. However, NTB is a very specialized use case and only a
handful of companies have attempted to use it for anything, as is. I
can't say I know for sure, but my gut says the vast majority (if not
all) are using x86. Maybe some are trying with arm64 or power64, but the
only architecture not in that list that I'd conceivably think someone
might care about down the road might be riscv.

Most other NTB hardware (specifically AMD and Intel) are built into x86
CPUs so should be fine with this restriction.

I personally expect it would be fine to add a dependency on
CONFIG_IRQ_DOMAIN_HIERARCHY to CONFIG_NTB_MSI. However, I've copied Doug
from GigaIO who's the only user I know that might have a better informed
opinion on this.

Logan
