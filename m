Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31019307F21
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 21:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhA1UF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 15:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhA1UDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 15:03:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B78C061221;
        Thu, 28 Jan 2021 12:01:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611864097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eLkCvYAhriOPJ7z9HfTV78cQyqxpEiJgEGLW8Ug9OQ=;
        b=rgutv3+b4fCuQO2NPYLPM2A2LF4QtgxTtRCEhMqLfK2dt00gMtMdV9q8L3UUZQwSHs8nqV
        NzjwfoARCvHimHhCzQL0trvvJQ9CLz/u+9cafws4RLNRbyxfde6MPKuUGPrk0ho3YZMjvS
        JhxP5cELF4GcPbBgYJmeajT1gRLCfkJoIVgNGVyKIEZS5rulATe7u8Hiv081AJKVn3A6KI
        MvDcZnBcbXGxt0eFyyEiRR/O7PPBx+B81r5r3ykM/tqeB1gu6oG4rf4Y+E4EtFsaTLBJgU
        wINUReJQv/XStMHDY5Ahd8NExFJ4QCwnxp/Y2/KMkSjzaHg2hZKVYeFLmZf9qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611864097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eLkCvYAhriOPJ7z9HfTV78cQyqxpEiJgEGLW8Ug9OQ=;
        b=v7oE4IEZ8qTXtqCCRrOIGMvMr/fgmhz8b8qcg+0shet7zAWJFLgUt26gLWthcNVEwkr7Tr
        kgAjekNEjbSjyAAA==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <20210128165903.GB38339@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet>
Date:   Thu, 28 Jan 2021 21:01:37 +0100
Message-ID: <87h7n0de5a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28 2021 at 13:59, Marcelo Tosatti wrote:
>> The whole pile wants to be reverted. It's simply broken in several ways.
>
> I was asking for your comments on interaction with CPU hotplug :-)

Which I answered in an seperate mail :)

> So housekeeping_cpumask has multiple meanings. In this case:

...

> So as long as the meaning of the flags are respected, seems
> alright.

Yes. Stuff like the managed interrupts preference for housekeeping CPUs
when a affinity mask spawns housekeeping and isolated is perfectly
fine. It's well thought out and has no limitations.

> Nitesh, is there anything preventing this from being fixed
> in userspace ? (as Thomas suggested previously).

Everything with is not managed can be steered by user space.

Thanks,

        tglx
