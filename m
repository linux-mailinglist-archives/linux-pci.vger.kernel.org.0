Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA513E8387
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 09:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJ2Ixv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 04:53:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbfJ2Ixv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 04:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3A1DB43E;
        Tue, 29 Oct 2019 08:53:44 +0000 (UTC)
Date:   Tue, 29 Oct 2019 09:53:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20191029085336.GF31513@dhcp22.suse.cz>
References: <20190925104108.GE4553@hirez.programming.kicks-ass.net>
 <47fa4cee-8528-7c23-c7de-7be1b65aa2ae@huawei.com>
 <bec80499-86d9-bf1f-df23-9044a8099992@arm.com>
 <a5f0fc80-8e88-b781-77ce-1213e5d62125@huawei.com>
 <20191010073212.GB18412@dhcp22.suse.cz>
 <6cc94f9b-0d79-93a8-5ec2-4f6c21639268@huawei.com>
 <20191011111539.GX2311@hirez.programming.kicks-ass.net>
 <7fad58d6-5126-e8b8-a7d8-a91814da53ba@huawei.com>
 <20191012074014.GA2037204@kroah.com>
 <1ec704df-97a5-04b7-1f20-8e3db19440a3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec704df-97a5-04b7-1f20-8e3db19440a3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon 28-10-19 17:20:33, Yunsheng Lin wrote:
> On 2019/10/12 15:40, Greg KH wrote:
> > On Sat, Oct 12, 2019 at 02:17:26PM +0800, Yunsheng Lin wrote:
> >> add pci and acpi maintainer
> >> cc linux-pci@vger.kernel.org and linux-acpi@vger.kernel.org
> >>
> >> On 2019/10/11 19:15, Peter Zijlstra wrote:
> >>> On Fri, Oct 11, 2019 at 11:27:54AM +0800, Yunsheng Lin wrote:
> >>>> But I failed to see why the above is related to making node_to_cpumask_map()
> >>>> NUMA_NO_NODE aware?
> >>>
> >>> Your initial bug is for hns3, which is a PCI device, which really _MUST_
> >>> have a node assigned.
> >>>
> >>> It not having one, is a straight up bug. We must not silently accept
> >>> NO_NODE there, ever.
> >>>
> >>
> >> I suppose you mean reporting a lack of affinity when the node of a pcie
> >> device is not set by "not silently accept NO_NODE".
> > 
> > If the firmware of a pci device does not provide the node information,
> > then yes, warn about that.
> > 
> >> As Greg has asked about in [1]:
> >> what is a user to do when the user sees the kernel reporting that?
> >>
> >> We may tell user to contact their vendor for info or updates about
> >> that when they do not know about their system well enough, but their
> >> vendor may get away with this by quoting ACPI spec as the spec
> >> considering this optional. Should the user believe this is indeed a
> >> fw bug or a misreport from the kernel?
> > 
> > Say it is a firmware bug, if it is a firmware bug, that's simple.
> > 
> >> If this kind of reporting is common pratice and will not cause any
> >> misunderstanding, then maybe we can report that.
> > 
> > Yes, please do so, that's the only way those boxes are ever going to get
> > fixed.  And go add the test to the "firmware testing" tool that is based
> > on Linux that Intel has somewhere, to give vendors a chance to fix this
> > before they ship hardware.
> > 
> > This shouldn't be a big deal, we warn of other hardware bugs all the
> > time.
> 
> Hi, all.
> 
> The warning for the above case has been added in [1].
> 
> So maybe it makes sense to make node_to_cpumask_map() NUMA_NO_NODE aware
> now?
> 
> If Yes, this patch still can be applied to the latest linus' tree cleanly,
> Do I need to resend it?
> 

By this patch you mean http://lkml.kernel.org/r/1568724534-146242-1-git-send-email-linyunsheng@huawei.com
right?

I would just resend it unless there is still a clear disagreement over
it.

> [1] https://lore.kernel.org/linux-pci/1571467543-26125-1-git-send-email-linyunsheng@huawei.com/

-- 
Michal Hocko
SUSE Labs
