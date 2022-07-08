Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12E56C4A7
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiGHSoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiGHSoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 14:44:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185452CE31;
        Fri,  8 Jul 2022 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=I+36xi06bTumrN/9N1FZ7npvjpiN5tLAhX6oiL3sqlE=; b=v3YRvH2XBGC/E83Ng4nLRK9PYX
        jTi4Vzgqz2eJqNYvA84wPrk989Zftg2GaYEDU5qzBy2HASRyNtrl5I+HE6WqQsgxLeVA1sSIdZyrN
        aCl75lHWhYCMS5AS9RaU7gEsRfjO1qHid4ihT7uNjFyL9nc0eHpQNpVIUAF3ngrDVFlWz2fIZjQ2u
        TBwpJlikhuUoe1Fo8VC9as3Twx91xfQ/Iwtd7JgPm2k7Q4epww4HXwxpFM+pSQMJKpOj5+QlDZY6R
        J2Ccwn5x9zK/gjTWG63Th0jBfIw6z1WhClA8KpzlnrjqUgPVrlIh9fGvrQe7hHD16iIsloImFvOfp
        nudoecdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9sx4-003iaz-Hn; Fri, 08 Jul 2022 18:43:42 +0000
Date:   Fri, 8 Jul 2022 19:43:42 +0100
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
Message-ID: <Ysh63kRVGMFJMNfG@casper.infradead.org>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 06:35:48PM +0000, Nadav Amit wrote:
> On Jul 8, 2022, at 10:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> > ⚠ External Email
> > 
> > On Fri, Jul 08, 2022 at 04:45:00PM +0000, Nadav Amit wrote:
> >> On Jul 8, 2022, at 5:56 AM, Matthew Wilcox <willy@infradead.org> wrote:
> >> 
> >>> And looking at the results above, it's not so much the PIO vs MMIO
> >>> that makes a difference, it's the virtualisation. A mmio access goes
> >>> from 269ns to 85us. Rather than messing around with preferring MMIO
> >>> over PIO for config space, having an "enlightenment" to do config
> >>> space accesses would be a more profitable path.
> >> 
> >> I am unfamiliar with the motivation for this patch, but I just wanted to
> >> briefly regard the advice about enlightments.
> >> 
> >> “enlightenment”, AFAIK, is Microsoft’s term for "para-virtualization", so
> >> let’s regard the generic term. I think that you consider the bare-metal
> >> results as the possible results from a paravirtual machine, which is mostly
> >> wrong. Para-virtualization usually still requires a VM-exit and for the most
> >> part the hypervisor/host runs similar code for MMIO/hypercall (conceptually;
> >> the code of paravirtual and fully-virtual devices is often different, but
> >> IIUC, this is not what Ajay measured).
> >> 
> >> Para-virtualization could have *perhaps* helped to reduce the number of
> >> PIO/MMIO and improve performance this way. If, for instance, all the
> >> PIO/MMIO are done during initialization, a paravirtual interface can be use
> >> to batch them together, and that would help. But it is more complicated to
> >> get a performance benefit from paravirtualization if the PIO/MMIO accesses
> >> are “spread”, for instance, done after each interrupt.
> > 
> > What kind of lousy programming interface requires you to do a config
> > space access after every interrupt? This is looney-tunes.
> 
> Wild example, hence the “for instance”.

Stupid example that doesn't help.

> > You've used a lot of words to not answer the question that was so
> > important that I asked it twice. What's the use case, what's the
> > workload that would benefit from this patch?
> 
> Well, you used a lot of words to say “it causes problems” without saying
> which. It appeared you have misconceptions about paravirtualization that
> I wanted to correct.

Well now, that's some bullshit.  I did my fucking research.  I went
back 14+ years in history to figure out what was going on back then.
I cited commit IDs.  You're just tossing off some opinions.

I have no misconceptions about whatever you want to call the mechanism
for communicating with the hypervisor at a higher level than "prod this
byte".  For example, one of the more intensive things we use config
space for is sizing BARs.  If we had a hypercall to siz a BAR, that
would eliminate:

 - Read current value from BAR
 - Write all-ones to BAR
 - Read new value from BAR
 - Write original value back to BAR

Bingo, one hypercall instead of 4 MMIO or 8 PIO accesses.

Just because I don't use your terminology, you think I have
"misconceptions"?  Fuck you, you condescending piece of shit.

> As I said before, I am not familiar with the exact motivation for this
> patch. I now understood from Ajay that it shortens VM boot time
> considerably.

And yet, no numbers.  Yes, microbenchmark numbers that provde nothing,
but no numbers about how much it improves boot time.

> I was talking to Ajay to see if there is a possibility of a VMware specific
> solution. I am afraid that init_hypervisor_platform() might take place too
> late.
> 
