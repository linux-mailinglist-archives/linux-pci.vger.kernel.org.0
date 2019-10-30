Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B7E99EB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJ3KWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 06:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfJ3KWb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 06:22:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A10AB59F;
        Wed, 30 Oct 2019 10:22:29 +0000 (UTC)
Date:   Wed, 30 Oct 2019 11:22:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com,
        axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com,
        linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tbogendoerfer@suse.de,
        linux-mips@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20191030102229.GY31513@dhcp22.suse.cz>
References: <1572428068-180880-1-git-send-email-linyunsheng@huawei.com>
 <20191030101449.GW4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030101449.GW4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 30-10-19 11:14:49, Peter Zijlstra wrote:
> On Wed, Oct 30, 2019 at 05:34:28PM +0800, Yunsheng Lin wrote:
> > When passing the return value of dev_to_node() to cpumask_of_node()
> > without checking if the device's node id is NUMA_NO_NODE, there is
> > global-out-of-bounds detected by KASAN.
> > 
> > From the discussion [1], NUMA_NO_NODE really means no node affinity,
> > which also means all cpus should be usable. So the cpumask_of_node()
> > should always return all cpus online when user passes the node id as
> > NUMA_NO_NODE, just like similar semantic that page allocator handles
> > NUMA_NO_NODE.
> > 
> > But we cannot really copy the page allocator logic. Simply because the
> > page allocator doesn't enforce the near node affinity. It just picks it
> > up as a preferred node but then it is free to fallback to any other numa
> > node. This is not the case here and node_to_cpumask_map will only restrict
> > to the particular node's cpus which would have really non deterministic
> > behavior depending on where the code is executed. So in fact we really
> > want to return cpu_online_mask for NUMA_NO_NODE.
> > 
> > Also there is a debugging version of node_to_cpumask_map() for x86 and
> > arm64, which is only used when CONFIG_DEBUG_PER_CPU_MAPS is defined, this
> > patch changes it to handle NUMA_NO_NODE as normal node_to_cpumask_map().
> > 
> > [1] https://lkml.org/lkml/2019/9/11/66
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Paul Burton <paul.burton@mips.com> # MIPS bits
> 
> Still:
> 
> Nacked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Do you have any other proposal that doesn't make any wild guesses about
which node to use instead of the undefined one?

-- 
Michal Hocko
SUSE Labs
