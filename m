Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C725E2D14
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbfJXJUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 05:20:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389413AbfJXJUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 05:20:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5CC2C00C;
        Thu, 24 Oct 2019 09:20:13 +0000 (UTC)
Date:   Thu, 24 Oct 2019 11:20:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, peterz@infradead.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191024092013.GW17610@dhcp22.suse.cz>
References: <76d37d5b-49bd-e45c-d42c-415235504893@huawei.com>
 <20191023171039.GA173290@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023171039.GA173290@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 23-10-19 12:10:39, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
> > On 2019/10/23 5:04, Bjorn Helgaas wrote:
> > > On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
> 
> > > I think the underlying problem you're addressing is that:
> > > 
> > >   - NUMA_NO_NODE == -1,
> > >   - dev_to_node(dev) may return NUMA_NO_NODE,
> > >   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
> > >   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
> > > 
> > > For example, on arm64, mips loongson, s390, and x86,
> > > cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
> > > an invalid array index.
> > 
> > The invalid array index of -1 is the underlying problem here when
> > cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
> > is not NUMA_NO_NODE aware yet.
> > 
> > In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
> > disscusion, it is requested that it is better to warn about the pcie
> > device without a node assigned by the firmware before making the
> > cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
> > devices of "NUMA_NO_NODE" node can be fixed by their vendor.
> > 
> > See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/
> 
> Right.  We should warn if the NUMA node number would help us but DT or
> the firmware didn't give us one.
> 
> But we can do that independently of any cpumask_of_node() changes.
> There's no need to do one patch before the other.  Even if you make
> cpumask_of_node() tolerate NUMA_NO_NODE, we'll still get the warning
> because we're not actually changing any node assignments.

Agreed. And this has been proposed previously I believe but my
understanding was that Petr was against that.

-- 
Michal Hocko
SUSE Labs
