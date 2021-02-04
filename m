Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543530FBEA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbhBDStn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 13:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239375AbhBDStc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 13:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612464472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsNoUMCO1nEXOP2imOs5qf2e3v8YT9CdaCiUbwmZSYQ=;
        b=eGfM5ACF9Xt+Jex5RQQfA6Pl7SMQYW6sBgcENuLDbG2NRfg5xx9EC+CMMT0V0zUQnwOc9K
        8oM7aE6GNKEB6qS6Pd5wCRaaiomq+vpjVTko8o+e4Ad2yb7HfiRfGJ6X9kiP7xm/LmJzkh
        sUoUgzIXDyyF2pPxnpKKDjGn6kaunrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-4YY6d1skPqyXhYA2hOoK-w-1; Thu, 04 Feb 2021 13:47:50 -0500
X-MC-Unique: 4YY6d1skPqyXhYA2hOoK-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA26801968;
        Thu,  4 Feb 2021 18:47:47 +0000 (UTC)
Received: from [10.10.116.135] (ovpn-116-135.rdu2.redhat.com [10.10.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87DF960CCF;
        Thu,  4 Feb 2021 18:47:40 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <20210204181546.GA30113@fuller.cnet>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
Date:   Thu, 4 Feb 2021 13:47:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210204181546.GA30113@fuller.cnet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/4/21 1:15 PM, Marcelo Tosatti wrote:
> On Thu, Jan 28, 2021 at 09:01:37PM +0100, Thomas Gleixner wrote:
>> On Thu, Jan 28 2021 at 13:59, Marcelo Tosatti wrote:
>>>> The whole pile wants to be reverted. It's simply broken in several ways.
>>> I was asking for your comments on interaction with CPU hotplug :-)
>> Which I answered in an seperate mail :)
>>
>>> So housekeeping_cpumask has multiple meanings. In this case:
>> ...
>>
>>> So as long as the meaning of the flags are respected, seems
>>> alright.
>> Yes. Stuff like the managed interrupts preference for housekeeping CPUs
>> when a affinity mask spawns housekeeping and isolated is perfectly
>> fine. It's well thought out and has no limitations.
>>
>>> Nitesh, is there anything preventing this from being fixed
>>> in userspace ? (as Thomas suggested previously).
>> Everything with is not managed can be steered by user space.
> Yes, but it seems to be racy (that is, there is a window where the 
> interrupt can be delivered to an isolated CPU).
>
> ethtool ->
> xgbe_set_channels ->
> xgbe_full_restart_dev ->
> xgbe_alloc_memory ->
> xgbe_alloc_channels ->
> cpumask_local_spread
>
> Also ifconfig eth0 down / ifconfig eth0 up leads
> to cpumask_spread_local.

There's always that possibility.

We have to ensure that we move the IRQs by a tuned daemon or some other
userspace script every time there is a net-dev change (eg. device comes up,
creates VFs, etc).

> How about adding a new flag for isolcpus instead?
>

Do you mean a flag based on which we can switch the affinity mask to
housekeeping for all the devices at the time of IRQ distribution?

-- 
Thanks
Nitesh

