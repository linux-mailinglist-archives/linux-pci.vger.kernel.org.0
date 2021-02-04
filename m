Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFD30FC41
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 20:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhBDTJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 14:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239632AbhBDTIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 14:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612465641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0h1TRSnNoeb31j50N9xUAbiVlfi+y4PqU4sAwNXXQg=;
        b=G1QRJ0Dc2OsSGs3O4FP/FScwBFifKNntwa6UCoSYLrEVkk6Fc04TCIXDW535aj98bqoLU5
        33nOAF2H2zDabzUI1ZSOUF6DVXT1e1OrSJAyT2svp8/fpkRYAK+xuc69GovoybKXnke8i0
        YRMzd1hAe7JbFK8Wywf2xovS3q7DV40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-MX5dYmLtO7qIUFiQcs3ULw-1; Thu, 04 Feb 2021 14:07:18 -0500
X-MC-Unique: MX5dYmLtO7qIUFiQcs3ULw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C08CE777;
        Thu,  4 Feb 2021 19:07:15 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B2305C257;
        Thu,  4 Feb 2021 19:07:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 404CE416D87F; Thu,  4 Feb 2021 16:06:47 -0300 (-03)
Date:   Thu, 4 Feb 2021 16:06:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20210204190647.GA32868@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet>
 <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 01:47:38PM -0500, Nitesh Narayan Lal wrote:
> 
> On 2/4/21 1:15 PM, Marcelo Tosatti wrote:
> > On Thu, Jan 28, 2021 at 09:01:37PM +0100, Thomas Gleixner wrote:
> >> On Thu, Jan 28 2021 at 13:59, Marcelo Tosatti wrote:
> >>>> The whole pile wants to be reverted. It's simply broken in several ways.
> >>> I was asking for your comments on interaction with CPU hotplug :-)
> >> Which I answered in an seperate mail :)
> >>
> >>> So housekeeping_cpumask has multiple meanings. In this case:
> >> ...
> >>
> >>> So as long as the meaning of the flags are respected, seems
> >>> alright.
> >> Yes. Stuff like the managed interrupts preference for housekeeping CPUs
> >> when a affinity mask spawns housekeeping and isolated is perfectly
> >> fine. It's well thought out and has no limitations.
> >>
> >>> Nitesh, is there anything preventing this from being fixed
> >>> in userspace ? (as Thomas suggested previously).
> >> Everything with is not managed can be steered by user space.
> > Yes, but it seems to be racy (that is, there is a window where the 
> > interrupt can be delivered to an isolated CPU).
> >
> > ethtool ->
> > xgbe_set_channels ->
> > xgbe_full_restart_dev ->
> > xgbe_alloc_memory ->
> > xgbe_alloc_channels ->
> > cpumask_local_spread
> >
> > Also ifconfig eth0 down / ifconfig eth0 up leads
> > to cpumask_spread_local.
> 
> There's always that possibility.

Then there is a window where isolation can be broken.

> We have to ensure that we move the IRQs by a tuned daemon or some other
> userspace script every time there is a net-dev change (eg. device comes up,
> creates VFs, etc).

Again, race window open can result in interrupt to isolated CPU.

> > How about adding a new flag for isolcpus instead?
> >
> 
> Do you mean a flag based on which we can switch the affinity mask to
> housekeeping for all the devices at the time of IRQ distribution?

Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.


