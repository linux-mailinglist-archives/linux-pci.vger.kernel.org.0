Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FA56BF78
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiGHR4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiGHR4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 13:56:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39065A467;
        Fri,  8 Jul 2022 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9hHckX53YDQa5nb13U0zKcPQMhp/7FlgpDGHpfNA0gQ=; b=LOVXAne1wYs5U555F1ZYS5Knvp
        +BzllGqyR1JUwv6RrS9lbb22AG83oaviOmJkTnhQpJPnGdsKl9mwvrQ3LkCJzBg59N0ZnCUZKaCrx
        DY9Eqd/z9jm2q5K6aOtmb8w5R3JRcJDyLqNC4S+cqBqgXVJF9xmyMVPoBre2prh+LX48/zYBVIDWO
        S5QCrZwNcQUNaLKDReKwQqh89pXe1q4QEom2iYdI/z4yiBbHlvoct2FKGbe84Fr1VD9pT6tmhDIXK
        SbzwS5yHQJf0v3+suaWduLeDF6G7oFw2L4x9nGzf62ueLAr6X/XbSzM+PSP5gJclYZfDKX82aHGyj
        Bg6CvUww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9sCc-003gX6-TH; Fri, 08 Jul 2022 17:55:42 +0000
Date:   Fri, 8 Jul 2022 18:55:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Message-ID: <YshvnodeqmJV6uIJ@casper.infradead.org>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 04:45:00PM +0000, Nadav Amit wrote:
> On Jul 8, 2022, at 5:56 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> > And looking at the results above, it's not so much the PIO vs MMIO
> > that makes a difference, it's the virtualisation. A mmio access goes
> > from 269ns to 85us. Rather than messing around with preferring MMIO
> > over PIO for config space, having an "enlightenment" to do config
> > space accesses would be a more profitable path.
> 
> I am unfamiliar with the motivation for this patch, but I just wanted to
> briefly regard the advice about enlightments.
> 
> “enlightenment”, AFAIK, is Microsoft’s term for "para-virtualization", so
> let’s regard the generic term. I think that you consider the bare-metal
> results as the possible results from a paravirtual machine, which is mostly
> wrong. Para-virtualization usually still requires a VM-exit and for the most
> part the hypervisor/host runs similar code for MMIO/hypercall (conceptually;
> the code of paravirtual and fully-virtual devices is often different, but
> IIUC, this is not what Ajay measured).
> 
> Para-virtualization could have *perhaps* helped to reduce the number of
> PIO/MMIO and improve performance this way. If, for instance, all the
> PIO/MMIO are done during initialization, a paravirtual interface can be use
> to batch them together, and that would help. But it is more complicated to
> get a performance benefit from paravirtualization if the PIO/MMIO accesses
> are “spread”, for instance, done after each interrupt.

What kind of lousy programming interface requires you to do a config
space access after every interrupt?  This is looney-tunes.

You've used a lot of words to not answer the question that was so
important that I asked it twice.  What's the use case, what's the
workload that would benefit from this patch?

> Para-virtauilzation and full-virtualization both have pros and cons.
> Para-virtualization is many times more efficient, but requires the VM to
> have dedicated device drivers for the matter. Try to run a less-common OS
> than Linux and it would not work since the OS would not have drivers for the
> paras-virtual devices. And even if you add support today for a para-virtual
> devices, there are many deployed OSes that do not have such support, and you
> would not be able to run them in a VM.
> 
> Regardless to virtualization, Ajay’s results show PIO is slower on
> bare-metal, and according to his numbers by 165ns, which is significant.
> Emulating PIO in hypervisors on x86 is inherently more complex than MMIO, so
> the results he got would most likely happen on all hypervisors.
> 
> tl;dr: Let’s keep this discussion focused and put paravirtualization aside.
> It is not a solution for all the problems in the world.
