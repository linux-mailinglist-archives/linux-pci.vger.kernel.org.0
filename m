Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C202311962
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhBFDDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 22:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhBFCx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 21:53:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD08C03BFFC;
        Fri,  5 Feb 2021 14:27:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612564020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VadslTTd+2N1rTvdy4wdiu4OS+/fi59Fn5i0loWcZCI=;
        b=cvaRnSQfaldfyTZrh9hwF4XpLuxM42vLwC92tAfeOnixBjonYDcx61OsV9PTWWQ1ZHB26y
        aGbDu6J4PkF0/+xJwYytkbbisJwoJowJeNEsoRhDo1wBvWYNL5ENg8ydDZ9NN//SiSw3z/
        iWGpSWN4IJtBn1u7/EQhn8Ql9Bd7TpVYeo1dgESYtrgV0bO8yhpCGha4pwktRNCNt1aS6l
        kujYc9is12XLVgHf+LhdQeASkxkF5vJPqb88MBlNd8dvfYb27HQ82/lt+Jz0kxGhNn5C12
        M6x+8u/bF7t5E18DsC/v+iXeDiOUbaj0sQpiCc9b5RCt/6tbOnevYngEvUzN0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612564020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VadslTTd+2N1rTvdy4wdiu4OS+/fi59Fn5i0loWcZCI=;
        b=Vu8aiJ5kKikjvjrDFS2pX1/kUhU60dKVlhHqMlfKorK2VmvnQ6tvI+jqLJICrsVeVgxZ24
        JU7asqv0T7JfaMBA==
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <87y2g26tnt.fsf@nanos.tec.linutronix.de>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de> <20210204181546.GA30113@fuller.cnet> <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com> <20210204190647.GA32868@fuller.cnet> <d8884413-84b4-b204-85c5-810342807d21@redhat.com> <87y2g26tnt.fsf@nanos.tec.linutronix.de>
Date:   Fri, 05 Feb 2021 23:26:59 +0100
Message-ID: <87v9b66tho.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 05 2021 at 23:23, Thomas Gleixner wrote:
> On Thu, Feb 04 2021 at 14:17, Nitesh Narayan Lal wrote:
>> On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
>>>>> How about adding a new flag for isolcpus instead?
>>>>>
>>>> Do you mean a flag based on which we can switch the affinity mask to
>>>> housekeeping for all the devices at the time of IRQ distribution?
>>> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>>
>> Does sounds like a nice idea to explore, lets see what Thomas thinks about it.

<.SNIP.>

> So I'm going to revert this commit because it _IS_ broken _AND_ useless
> and does not solve anything it claims to solve.

And no. HK_FLAG_IRQ_SPREAD is not going to solve anything either.

Thanks,

        tglx
