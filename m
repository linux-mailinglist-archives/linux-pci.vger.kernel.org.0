Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFCE3A36
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503710AbfJXRkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfJXRkQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:40:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A33205ED;
        Thu, 24 Oct 2019 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571938815;
        bh=AK45cAJQgYYbDoTHmTcOed8M7pP/HdE/Bk3NCrRcZaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KxPqFPDpmWLQHZ26pvLm9fAZ0mxG3FW4vgzaRU1xKD1W9fy3p/EuUA8xCKtd4aTu7
         1SHQuuR6X+mQKC5fbEj1Xm1q97V7L6zld3x4EqKGWzzFiaT8zz8uHcYFW3Wk9FtlEY
         b48nNPkT99QWaSHAaYTz1gx6A/84W5ECHfhkbq1U=
Date:   Thu, 24 Oct 2019 12:40:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     peterz@infradead.org, Yunsheng Lin <linyunsheng@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191024174013.GA149516@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024092013.GW17610@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 11:20:13AM +0200, Michal Hocko wrote:
> On Wed 23-10-19 12:10:39, Bjorn Helgaas wrote:
> > On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
> > > On 2019/10/23 5:04, Bjorn Helgaas wrote:
> > > > On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
> > 
> > > > I think the underlying problem you're addressing is that:
> > > > 
> > > >   - NUMA_NO_NODE == -1,
> > > >   - dev_to_node(dev) may return NUMA_NO_NODE,
> > > >   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
> > > >   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
> > > > 
> > > > For example, on arm64, mips loongson, s390, and x86,
> > > > cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
> > > > an invalid array index.
> > > 
> > > The invalid array index of -1 is the underlying problem here when
> > > cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
> > > is not NUMA_NO_NODE aware yet.
> > > 
> > > In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
> > > disscusion, it is requested that it is better to warn about the pcie
> > > device without a node assigned by the firmware before making the
> > > cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
> > > devices of "NUMA_NO_NODE" node can be fixed by their vendor.
> > > 
> > > See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/
> > 
> > Right.  We should warn if the NUMA node number would help us but DT or
> > the firmware didn't give us one.
> > 
> > But we can do that independently of any cpumask_of_node() changes.
> > There's no need to do one patch before the other.  Even if you make
> > cpumask_of_node() tolerate NUMA_NO_NODE, we'll still get the warning
> > because we're not actually changing any node assignments.
> 
> Agreed. And this has been proposed previously I believe but my
> understanding was that Petr was against that.

I don't think Peter was opposed to a warning.  I assume you're
referring to [1], which is about how cpumask_of_node() should work.
That's not my area, so I don't have a strong opinion.  From that
discussion:

Yunsheng> From what I can see, the problem can be fixed in three
Yunsheng> place:
Yunsheng> 1. Make user dev_to_node return a valid node id
Yunsheng>    even when proximity domain is not set by bios(or node id
Yunsheng>    set by buggy bios is not valid), which may need info from
Yunsheng>    the numa system to make sure it will return a valid node.
Yunsheng>
Yunsheng> 2. User that call cpumask_of_node should ensure the node
Yunsheng>    id is valid before calling cpumask_of_node, and user also
Yunsheng>    need some info to make ensure node id is valid.
Yunsheng>
Yunsheng> 3. Make sure cpumask_of_node deal with invalid node id as
Yunsheng>    this patchset.

Peter> 1) because even it is not set, the device really does belong
Peter> to a node.  It is impossible a device will have magic
Peter> uniform access to memory when CPUs cannot.
Peter> 
Peter> 2) is already true today, cpumask_of_node() requires a valid
Peter> node_id.
Peter> 
Peter> 3) is just wrong and increases overhead for everyone.

I think Peter is advocating (1), i.e., if firmware doesn't tell us a
node ID, we just pick one.  We can certainly do that in *addition* to
adding a warning.  I'd like it to be a separate patch because I think
we want the warning no matter what so users have some clue that
performance could be better.

If we pick one, I guess we either assign some default, like node 0, to
everything; or we somehow pick a random node to assign.

FWIW, (3) might be wrong, but it is what alpha, ia64, mips (ip27),
powerpc, sparc do already.  It'd be nice if they were all the same one
way or the other.

[1] https://lore.kernel.org/linux-arm-kernel/20190831161247.GM2369@hirez.programming.kicks-ass.net/
