Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9BB4628A1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 00:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhK2X4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 18:56:06 -0500
Received: from ale.deltatee.com ([204.191.154.188]:49136 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhK2X4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 18:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=Wk88kMip0Z/okfMWIXWV94wlf/VmCY/sBjrNS3bEyU4=; b=szTRgrh5UL+QyFipuIpsAIF5oS
        GNoH9sbYIgYnvttPDCUcjyL9BrNXn7rReX1abUnOaByGab6clnek4kOd/qolI81GoVfrvDZ/ygOor
        LlERjPpQ+2q1rQKSS6jF0uwzW4EERp+eZBZ6SwIjN71dJBbm2y1GVYJ1dW4HmraX5S41hGbXAhzXX
        eiawplEs8wI+KIsLqr3qKUBZvtI/whxEJ6sk60KXNIueiShJepAcEszivf360PprpVKDR3E15OE/Y
        LhebMBou0ONeNx2c9Z18FgvCo3u7ZJ+9K7YKdGofMJlVrCHgr6genXXW7qcjJGr5MtzcTihokBLud
        3iKvfFSw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mrqRq-00AS6I-Db; Mon, 29 Nov 2021 16:52:39 -0700
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <20211129233133.GA4670@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
Date:   Mon, 29 Nov 2021 16:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129233133.GA4670@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-29 4:31 p.m., Jason Gunthorpe wrote:
> On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:
> 
>> In most cases, the NTB code needs more interrupts than the hardware
>> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
>> for: it allows the driver to request more interrupts than the hardware
>> advertises (ie. pci_msix_vec_count()). These extra interrupts are
>> created, but get flagged with msi_attrib.is_virtual which ensures
>> functions that program the MSI-X table don't try to write past the end
>> of the hardware's table.
> 
> AFAICT what you've described is what Intel is calling IMS in other
> contexts.
> 
> IMS is fundamentally a way to control MSI interrupt descriptors that
> are not accessed through PCI SIG compliant means. In this case the NTB
> driver has to do its magic to relay the addr/data pairs to the real
> MSI storage in the hidden devices.

With current applications, it isn't that there is real "MSI storage"
anywhere; the device on the other side of the bridge is always another
Linux host which holds the address (or rather mw offset) and data in
memory to use when it needs to trigger the interrupt of the other
machine. There are many prototypes and proprietary messes that try to
have other PCI devices (ie NVMe, etc) behind the non-transparent bridge;
but the Linux subsystem has no support for this.

> PCI_IRQ_VIRTUAL should probably be fully replaced by the new dynamic
> APIs in the fullness of time..

Perhaps, I don't really know much about IMS or how close a match it is.

>> Existing NTB hardware does already have what's called a doorbell which
>> provides the same functionally as the above technique. However, existing
>> hardware implementations of doorbells have significant latency and thus
>> slow down performance substantially. Implementing the MSI interrupts as
>> described above increased the performance of ntb_transport by more than
>> three times[1].
> 
> Does the doorbell scheme allow as many interrupts?

No, but for current applications there are plenty of doorbells.

Switchtec hardware (and I think other hardware) typically have 64
doorbells for the entire network (they must be split among the number of
hosts in the network; a two host system could have 32 per host). The NTB
subsystem in Linux only currently supports 2 hosts, but switchtec
hardware supports up to 48 hosts, in which case you might only have 1
doorbell per host and that might be limiting depending on the application.

Logan
