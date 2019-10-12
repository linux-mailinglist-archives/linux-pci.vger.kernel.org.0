Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE57D4F14
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2019 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfJLKmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Oct 2019 06:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfJLKkK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 12 Oct 2019 06:40:10 -0400
Received: from localhost (unknown [84.241.192.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21836206A1;
        Sat, 12 Oct 2019 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570876807;
        bh=Ct3kT+xNZzomUoOHSl3j9vFEqmUcJVCQgXZFn+esWOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhK6p65dsNjpWKMlH5Z/S77VSw/OawTEefkJ5bFoty44O22zb9+HsdWkKCgOrZlvg
         z+O6ugk9vrUWQCU5tMgVYN0Ch1ZoRdmp5yrZdc06g1GsEaSH5pLBh4ruPiYQniHtaz
         zvh7nzRLwKHoWOCyO7ub91SuvQZ0wyayC1/4J9Uo=
Date:   Sat, 12 Oct 2019 12:40:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20191012104001.GA2052933@kroah.com>
References: <20190925104108.GE4553@hirez.programming.kicks-ass.net>
 <47fa4cee-8528-7c23-c7de-7be1b65aa2ae@huawei.com>
 <bec80499-86d9-bf1f-df23-9044a8099992@arm.com>
 <a5f0fc80-8e88-b781-77ce-1213e5d62125@huawei.com>
 <20191010073212.GB18412@dhcp22.suse.cz>
 <6cc94f9b-0d79-93a8-5ec2-4f6c21639268@huawei.com>
 <20191011111539.GX2311@hirez.programming.kicks-ass.net>
 <7fad58d6-5126-e8b8-a7d8-a91814da53ba@huawei.com>
 <20191012074014.GA2037204@kroah.com>
 <1e1ec851-b5e7-8f35-a627-4c12ca9c2d3c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1ec851-b5e7-8f35-a627-4c12ca9c2d3c@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 12, 2019 at 05:47:56PM +0800, Yunsheng Lin wrote:
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
> Ok, thanks for clarifying.
> 
> Will send a patch to catch the case when a pcie device without numa node
> being set and warn about it.
> 
> Maybe use dev->bus to verify if it is a pci device?

No, do that in the pci bus core code itself, when creating the devices
as that is when you know, or do not know, the numa node, right?

This can't be in the driver core only, as each bus type will have a
different way of determining what the node the device is on.  For some
reason, I thought the PCI core code already does this, right?

thanks,

greg k-h
