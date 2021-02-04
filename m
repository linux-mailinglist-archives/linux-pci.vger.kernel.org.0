Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B283330FC78
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 20:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbhBDTTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 14:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239707AbhBDTSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 14:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612466249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuIGPrkquiyKP7NWTe6w6zn2YZQsyebCmH47vP2wk2I=;
        b=R8FH49FRD4j/x0dBuB2VJnZQ79hwBqNC0jjo0An8nIVuYAfQffEf2aaDb5HaN/n+Taq6yN
        lygSO3FUpGjcyrGXSSUxiXobmDGZeQ8tj1KGPLHvu9DK22Z6qf5T8Jgvn7qew/TtsjJcTl
        t8VRYU0GRcPszb+R9eAP62wZNTz6rHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-k-GaTCxMN7GdZNtj9zi2jg-1; Thu, 04 Feb 2021 14:17:25 -0500
X-MC-Unique: k-GaTCxMN7GdZNtj9zi2jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64921800D41;
        Thu,  4 Feb 2021 19:17:22 +0000 (UTC)
Received: from [10.10.116.135] (ovpn-116-135.rdu2.redhat.com [10.10.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 929F760C16;
        Thu,  4 Feb 2021 19:17:17 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
 <20210204190647.GA32868@fuller.cnet>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
Date:   Thu, 4 Feb 2021 14:17:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210204190647.GA32868@fuller.cnet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
> On Thu, Feb 04, 2021 at 01:47:38PM -0500, Nitesh Narayan Lal wrote:

[...]

>>>>> Nitesh, is there anything preventing this from being fixed
>>>>> in userspace ? (as Thomas suggested previously).
>>>> Everything with is not managed can be steered by user space.
>>> Yes, but it seems to be racy (that is, there is a window where the 
>>> interrupt can be delivered to an isolated CPU).
>>>
>>> ethtool ->
>>> xgbe_set_channels ->
>>> xgbe_full_restart_dev ->
>>> xgbe_alloc_memory ->
>>> xgbe_alloc_channels ->
>>> cpumask_local_spread
>>>
>>> Also ifconfig eth0 down / ifconfig eth0 up leads
>>> to cpumask_spread_local.
>> There's always that possibility.
> Then there is a window where isolation can be broken.
>
>> We have to ensure that we move the IRQs by a tuned daemon or some other
>> userspace script every time there is a net-dev change (eg. device comes up,
>> creates VFs, etc).
> Again, race window open can result in interrupt to isolated CPU.


Yes, and if I am not mistaken then that always has been a problem with
these userspace solutions.

>
>>> How about adding a new flag for isolcpus instead?
>>>
>> Do you mean a flag based on which we can switch the affinity mask to
>> housekeeping for all the devices at the time of IRQ distribution?
> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>
>

Does sounds like a nice idea to explore, lets see what Thomas thinks about it.

-- 
Thanks
Nitesh

