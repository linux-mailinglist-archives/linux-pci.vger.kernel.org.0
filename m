Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42616D5FAC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfJNKEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 06:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbfJNKEc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 06:04:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93474207FF;
        Mon, 14 Oct 2019 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571047470;
        bh=1L6BHHyZGzdbxZWv4acGRnc0Va1vbCVjc4KDhtWjTqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWTxU8aaHNdrVeedNaAfxRnATKwQqldi45eCabLzrJUjucHv6x6k8odH8CVoEQbPR
         w4oWGHOb3hLuaMuJ2jSTXq/ppPzZIjrhbS4OaxKJeinja9bxujNH+7bHo+Z4BvD0Vx
         z3dLPHIeCCsbnOLqYk6lsozxHfWvVXR06RTUURHI=
Date:   Mon, 14 Oct 2019 12:04:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, len.brown@intel.com, axboe@kernel.dk,
        dledford@redhat.com, jeffrey.t.kirsher@intel.com,
        linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tbogendoerfer@suse.de,
        linux-mips@vger.kernel.org, rafael@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20191014100427.GA6307@kroah.com>
References: <6cc94f9b-0d79-93a8-5ec2-4f6c21639268@huawei.com>
 <20191011111539.GX2311@hirez.programming.kicks-ass.net>
 <7fad58d6-5126-e8b8-a7d8-a91814da53ba@huawei.com>
 <20191012074014.GA2037204@kroah.com>
 <1e1ec851-b5e7-8f35-a627-4c12ca9c2d3c@huawei.com>
 <20191012104001.GA2052933@kroah.com>
 <20191012104742.GA2053473@kroah.com>
 <82000bc8-6912-205b-0251-25b9cc430973@huawei.com>
 <20191014092509.GA3050088@kroah.com>
 <20191014094912.GY2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014094912.GY2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 11:49:12AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 11:25:09AM +0200, Greg KH wrote:
> > Good luck, I don't really think that most, if any, of this is needed,
> > but hey, it's nice to clean it up where it can be :)
> 
> Some of the virtual devices we have (that use devm) really ought to set
> the node too, like drivers/base/cpu.c and driver/base/node.c and
> arguably the cooling devices too (they create a device per cpu).
> 
> The patch I had here:
> 
>   https://lkml.kernel.org/r/20190925214526.GA4643@worktop.programming.kicks-ass.net
> 
> takes the more radical approach of requiring a node, except when
> explicitly marked not (the fake devices that don't use devm for
> example).

I like that patch :)

> But yes, PCI and other physical busses really should be having a node
> set, no excuses.

Agreed, at least just warning on the bus creation will make it a bit
less "noisy", in contrast to your patch.  But the messages in your patch
show people just how broken their bioses really are.  Which is always
fun...

> Anyway, I don't think non-physical devices actually use
> cpumask_of_node() much, a quick grep didn't show any.

That's good.

thanks,

greg k-h
