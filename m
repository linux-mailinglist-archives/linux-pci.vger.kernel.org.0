Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE12B3939
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgKOUrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 15:47:02 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42308 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgKOUrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 15:47:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keOvH-00A939-9z; Sun, 15 Nov 2020 13:46:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keOvF-006gaV-U7; Sun, 15 Nov 2020 13:46:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com,
        bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com,
        jay.vosburgh@canonical.com, dyoung@redhat.com,
        gavin.guo@canonical.com,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de,
        bhelgaas@google.com, shan.gavin@linux.alibaba.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com
References: <20201114212215.GA1194074@bjorn-Precision-5520>
        <87v9e6n2b2.fsf@x220.int.ebiederm.org>
        <87sg9almmg.fsf@x220.int.ebiederm.org>
        <874klqac40.fsf@nanos.tec.linutronix.de>
Date:   Sun, 15 Nov 2020 14:46:38 -0600
In-Reply-To: <874klqac40.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Sun, 15 Nov 2020 16:11:43 +0100")
Message-ID: <87lff2ic0h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1keOvF-006gaV-U7;;;mid=<87lff2ic0h.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX195diDt5IkdLXnOpggrjLPJefxLwvfFAOo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMStockSpam_06,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4940]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMStockSpam_06 Stock Index Spam Sym,Price
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 698 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 9 (1.3%), parse: 0.94 (0.1%),
         extract_message_metadata: 16 (2.2%), get_uri_detail_list: 2.7 (0.4%),
        tests_pri_-1000: 16 (2.2%), tests_pri_-950: 1.86 (0.3%),
        tests_pri_-900: 1.65 (0.2%), tests_pri_-90: 122 (17.5%), check_bayes:
        120 (17.2%), b_tokenize: 19 (2.8%), b_tok_get_all: 13 (1.9%),
        b_comp_prob: 5 (0.8%), b_tok_touch_all: 78 (11.2%), b_finish: 0.91
        (0.1%), tests_pri_0: 411 (58.9%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 6 (0.9%), poll_dns_idle: 104 (14.9%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 113 (16.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Sun, Nov 15 2020 at 08:29, Eric W. Biederman wrote:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> For ordinary irqs you can have this with level triggered irqs
>> and the kernel has code that will shutdown the irq at the ioapic
>> level.  Then the kernel continues by polling the irq source.
>>
>> I am still missing details but my first question is can our general
>> solution to screaming level triggered irqs apply?
>
> No.
>
>> How can edge triggered MSI irqs be screaming?
>>
>> Is there something we can do in enabling the APICs or IOAPICs that
>> would allow this to be handled better.  My memory when we enable
>> the APICs and IOAPICs we completely clear the APIC entries and so
>> should be disabling sources.
>
> Yes, but MSI has nothing to do with APIC/IOAPIC

Yes, sorry.  It has been long enough that the details were paged out
of my memory.

>> Is the problem perhaps that we wind up using an APIC entry that was
>> previously used for the MSI interrupt as something else when we
>> reprogram them?  Even with this why doesn't the generic code
>> to stop screaming irqs apply here?
>
> Again. No. The problem cannot be solved at the APIC level. The APIC is
> the receiving end of MSI and has absolutely no control over it.
>
> An MSI interrupt is a (DMA) write to the local APIC base address
> 0xfeexxxxx which has the target CPU and control bits encoded in the
> lower bits. The written data is the vector and more control bits.
>
> The only way to stop that is to shut it up at the PCI device level.

Or to write to magic chipset registers that will stop transforming DMA
writes to 0xfeexxxxx into x86 interrupts.  With an IOMMU I know x86 has
such registers (because the point of the IOMMU is to limit the problems
rogue devices can cause).  Without an IOMMU I don't know if x86 has any
such registers.  I remember that other platforms have an interrupt
controller that does provide some level of control.  That x86 does not
is what makes this an x86 specific problem.

The generic solution is to have the PCI code set bus master disables
when it is enumerationg and initializing devices.  Last time I was
paying attention that was actually the policy of the pci layer and
drivers that did not enable bus mastering were considered buggy.

Looking at patch 3/3 what this patchset does is an early disable of
of the msi registers.  Which is mostly reasonable.  Especially as has
been pointed out the only location the x86 vector and x86 cpu can
be found is in the msi configuration registers.

That also seems reasonable.  But Bjorn's concern about not finding all
devices in all domains does seem real.

There are a handful of devices where the Bus master disable bit doesn't
disable bus mastering.  I wonder if there are devices where MSI and MSIX
disables don't fully work.  It seems completely possible to have MSI or
MSIX equivalent registers at a non-standard location as drivers must be
loaded to handle them.

So if we can safely and reliably disable DMA and MSI at the generic PCI
device level during boot up I am all for it.


How difficult would it be to tell the IOMMUs to stop passing traffic
through in an early pci quirk?  The problem setup was apparently someone
using the device directly from a VM.  So I presume there is an IOMMU
in that configuration.

> Unfortunately there is no way to tell the APIC "Mask vector X" and the
> dump kernel does neither know which device it comes from nor does it
> have enumerated PCI completely which would reset the device and shutup
> the spew. Due to the interrupt storm it does not get that far.

So the question is how do we make this robust?

Can we perhaps disable all interrupts in this case and limp along
in polling mode until the pci bus has been enumerated?

It is nice and desirable to be able to use the hardware in high
performance mode in a kexec-on-panic situation but if we can detect a
problem and figure out how to limp along sometimes that is acceptable.

The failure mode in the kexec-on-panic kernel is definitely the corect
one.  We could not figure out how to wrestle the hardware into usability
so we fail to take a crash dump or do anything else that might corrupt
the system.

Eric
