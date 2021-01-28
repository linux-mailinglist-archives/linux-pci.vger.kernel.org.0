Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD34A307A3F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhA1QDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 11:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1QDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 11:03:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08207C061573;
        Thu, 28 Jan 2021 08:02:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611849761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opwOYFvkdEM7XYU2EhAoDAkPWSc3olWO0Af++hxj9mU=;
        b=KnJPsfvvLNXw+V12/m2lcBaRfcQWAJKlVkXATHownTUMWvoMhf2Bw3vNXzzrc0clrXpR3W
        Zm+0xv+sQBluYgdSDqtOZGzCIzRC+emmEAIERDRABeAwLhDLF/QB2RcFq1aH/vYGolPl3S
        gQGQiRDfwcmA963lV0HU2KyW9e0OsYBsK3TAMM4fQXYSdW3MTfruNS1m1fK9SqUOYuXw8E
        ud/4KXWnh07kbcip812caDzgCBHD19LaM+Q2OokYlInd+Z+YsQGpb5TNvNh+XFxKSzICuA
        sZH9u07WpSGeD8jAVWT2VQQJuHeu0nYOAkdgiLALBqk0WQOEhYpIdI5Hm4C3sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611849761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opwOYFvkdEM7XYU2EhAoDAkPWSc3olWO0Af++hxj9mU=;
        b=lkf7myXefu6y6dhRY7jH1/YyUT7WrmfSbQcT+GqksICp5QmAuav2CcSIfs7OJwlxhZ5wka
        eEWw1peY/X9JUdAg==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <20210127121939.GA54725@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet>
Date:   Thu, 28 Jan 2021 17:02:41 +0100
Message-ID: <87r1m5can2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27 2021 at 09:19, Marcelo Tosatti wrote:
> On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
>> > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
>> > +	mask = housekeeping_cpumask(hk_flags);
>> 
>> AFAICS, this generally resolves to something based on cpu_possible_mask
>> rather than cpu_online_mask as before, so could now potentially return an
>> offline CPU. Was that an intentional change?
>
> Robin,
>
> AFAICS online CPUs should be filtered.

The whole pile wants to be reverted. It's simply broken in several ways.

Thanks,

        tglx
