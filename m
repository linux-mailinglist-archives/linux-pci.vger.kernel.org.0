Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040DB2B3544
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKOO3e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 09:29:34 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33422 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKOO3e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 09:29:34 -0500
X-Greylist: delayed 1445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 09:29:33 EST
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keJ1z-00B2x5-FR; Sun, 15 Nov 2020 07:29:27 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1keJ1y-0005NA-HT; Sun, 15 Nov 2020 07:29:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de,
        bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>,
        shan.gavin@linux.alibaba.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com
References: <20201114212215.GA1194074@bjorn-Precision-5520>
        <87v9e6n2b2.fsf@x220.int.ebiederm.org>
Date:   Sun, 15 Nov 2020 08:29:11 -0600
In-Reply-To: <87v9e6n2b2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sun, 15 Nov 2020 08:05:05 -0600")
Message-ID: <87sg9almmg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1keJ1y-0005NA-HT;;;mid=<87sg9almmg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18USQMsDws9+UPi52CWJBMghebgIcmoTWY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Bjorn Helgaas <helgaas@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 577 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.45
        (0.3%), extract_message_metadata: 18 (3.1%), get_uri_detail_list: 4.1
        (0.7%), tests_pri_-1000: 18 (3.1%), tests_pri_-950: 1.63 (0.3%),
        tests_pri_-900: 1.29 (0.2%), tests_pri_-90: 93 (16.0%), check_bayes:
        90 (15.6%), b_tokenize: 13 (2.3%), b_tok_get_all: 12 (2.1%),
        b_comp_prob: 4.0 (0.7%), b_tok_touch_all: 57 (9.8%), b_finish: 1.03
        (0.2%), tests_pri_0: 412 (71.4%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 0.86 (0.1%), tests_pri_10:
        4.4 (0.8%), tests_pri_500: 12 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> [+cc Rafael for question about ACPI method for PCI host bridge reset]
>>
>> On Sat, Nov 14, 2020 at 09:58:08PM +0100, Thomas Gleixner wrote:
>>> On Sat, Nov 14 2020 at 14:39, Bjorn Helgaas wrote:
>>> > On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
>>> >> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
>>> >> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>>> >> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>>> >> >> doing a kexec and the device is in D0-D3hot, which should also disable
>>> >> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>>> >> >> device causing the storm was in PCI_UNKNOWN state?
>>> >> >
>>> >> > That's indeed a really good question.
>>> >> 
>>> >> So we do that on kexec, but is that true when starting a kdump kernel
>>> >> from a kernel crash? I doubt it.
>>> >
>>> > Ah, right, I bet that's it, thanks.  The kdump path is basically this:
>>> >
>>> >   crash_kexec
>>> >     machine_kexec
>>> >
>>> > while the usual kexec path is:
>>> >
>>> >   kernel_kexec
>>> >     kernel_restart_prepare
>>> >       device_shutdown
>>> >         while (!list_empty(&devices_kset->list))
>>> >           dev->bus->shutdown
>>> >             pci_device_shutdown            # pci_bus_type.shutdown
>>> >     machine_kexec
>>> >
>>> > So maybe we need to explore doing some or all of device_shutdown() in
>>> > the crash_kexec() path as well as in the kernel_kexec() path.
>>> 
>>> The problem is that if the machine crashed anything you try to attempt
>>> before starting the crash kernel is reducing the chance that the crash
>>> kernel actually starts.
>>
>> Right.
>>
>>> Is there something at the root bridge level which allows to tell the
>>> underlying busses to shut up, reset or go into a defined state? That
>>> might avoid chasing lists which might be already unreliable.
>>
>> Maybe we need some kind of crash_device_shutdown() that does the
>> minimal thing to protect the kdump kernel from devices.
>
> The kdump kernel does not use any memory the original kernel uses.
> Which should be a minimal and fairly robust level of protection
> until the device drivers can be loaded and get ahold of things.
>
>> The programming model for conventional PCI host bridges and PCIe Root
>> Complexes is device-specific since they're outside the PCI domain.
>> There probably *are* ways to do those things, but you would need a
>> native host bridge driver or something like an ACPI method.  I'm not
>> aware of an ACPI way to do this, but I added Rafael in case he is.
>>
>> A crash_device_shutdown() could do something at the host bridge level
>> if that's possible, or reset/disable bus mastering/disable MSI/etc on
>> individual PCI devices if necessary.
>
> Unless I am confused DMA'ing to memory that is not already in use
> is completely broken wether or not you are using the kdump kernel.

Bah.  I was confused because I had not read up-thread.

MSI mixes DMA and irqs so confusion is easy.

So the problem is screaming irqs when the kernel is booting up.
This is a fundamentally tricky problem.

For ordinary irqs you can have this with level triggered irqs
and the kernel has code that will shutdown the irq at the ioapic
level.  Then the kernel continues by polling the irq source.

I am still missing details but my first question is can our general
solution to screaming level triggered irqs apply?

How can edge triggered MSI irqs be screaming?

Is there something we can do in enabling the APICs or IOAPICs that
would allow this to be handled better.  My memory when we enable
the APICs and IOAPICs we completely clear the APIC entries and so
should be disabling sources.

Is the problem perhaps that we wind up using an APIC entry that was
previously used for the MSI interrupt as something else when we
reprogram them?  Even with this why doesn't the generic code
to stop screaming irqs apply here?

Eric
