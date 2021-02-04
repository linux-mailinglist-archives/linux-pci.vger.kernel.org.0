Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6093730FB32
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 19:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhBDSUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 13:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238969AbhBDSUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 13:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612462717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85mWqPkwgft3QumNJIv0lzUNsiwA9K0lxEl6eklMhqo=;
        b=TgaVa54lRxDKaLVTAjR9dUeqfZSC4Zpg8ljRdP0E7HZptnyDMWypdvfnWd1YVVpES4SAKN
        v3W7LTa3WPBN1sn6vZZnaAWH5KSXfu8RVkNX8XIHACL9xyEjFTBMgxVYko9xTX+vASSxwR
        uDD9FXx/roJmVNOckbKkLRAmqiDzcNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-9cQB1pZEPteiZ6b-1P1WOw-1; Thu, 04 Feb 2021 13:18:35 -0500
X-MC-Unique: 9cQB1pZEPteiZ6b-1P1WOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E564F80196E;
        Thu,  4 Feb 2021 18:18:32 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46B4460C05;
        Thu,  4 Feb 2021 18:18:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 20E9D4178901; Thu,  4 Feb 2021 15:15:46 -0300 (-03)
Date:   Thu, 4 Feb 2021 15:15:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
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
Message-ID: <20210204181546.GA30113@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet>
 <87h7n0de5a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7n0de5a.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 09:01:37PM +0100, Thomas Gleixner wrote:
> On Thu, Jan 28 2021 at 13:59, Marcelo Tosatti wrote:
> >> The whole pile wants to be reverted. It's simply broken in several ways.
> >
> > I was asking for your comments on interaction with CPU hotplug :-)
> 
> Which I answered in an seperate mail :)
> 
> > So housekeeping_cpumask has multiple meanings. In this case:
> 
> ...
> 
> > So as long as the meaning of the flags are respected, seems
> > alright.
> 
> Yes. Stuff like the managed interrupts preference for housekeeping CPUs
> when a affinity mask spawns housekeeping and isolated is perfectly
> fine. It's well thought out and has no limitations.
> 
> > Nitesh, is there anything preventing this from being fixed
> > in userspace ? (as Thomas suggested previously).
> 
> Everything with is not managed can be steered by user space.

Yes, but it seems to be racy (that is, there is a window where the 
interrupt can be delivered to an isolated CPU).

ethtool ->
xgbe_set_channels ->
xgbe_full_restart_dev ->
xgbe_alloc_memory ->
xgbe_alloc_channels ->
cpumask_local_spread

Also ifconfig eth0 down / ifconfig eth0 up leads
to cpumask_spread_local.

How about adding a new flag for isolcpus instead?

