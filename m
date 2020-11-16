Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A010E2B53F6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 22:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgKPVpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 16:45:47 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44878 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgKPVpr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 16:45:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kemJg-00BtGF-Sk; Mon, 16 Nov 2020 14:45:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kemJf-002Ocq-J5; Mon, 16 Nov 2020 14:45:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
References: <20201114212215.GA1194074@bjorn-Precision-5520>
        <87v9e6n2b2.fsf@x220.int.ebiederm.org>
        <87sg9almmg.fsf@x220.int.ebiederm.org>
        <874klqac40.fsf@nanos.tec.linutronix.de>
        <87lff2ic0h.fsf@x220.int.ebiederm.org>
        <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com>
Date:   Mon, 16 Nov 2020 15:45:22 -0600
In-Reply-To: <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com> (Guilherme
        G. Piccoli's message of "Mon, 16 Nov 2020 17:31:36 -0300")
Message-ID: <87a6vhht71.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kemJf-002Ocq-J5;;;mid=<87a6vhht71.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9/qTxT50adn+9bNQVbs1w9j5U4GCUEmk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_Multi_Part_URI autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Guilherme G. Piccoli" <gpiccoli@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 623 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.6 (0.6%), b_tie_ro: 2.5 (0.4%), parse: 0.73
        (0.1%), extract_message_metadata: 10 (1.6%), get_uri_detail_list: 3.1
        (0.5%), tests_pri_-1000: 3.8 (0.6%), tests_pri_-950: 0.93 (0.1%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 101 (16.2%), check_bayes:
        99 (15.9%), b_tokenize: 10 (1.7%), b_tok_get_all: 13 (2.1%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 69 (11.1%), b_finish: 0.68
        (0.1%), tests_pri_0: 493 (79.2%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 1.75 (0.3%), poll_dns_idle: 0.58 (0.1%),
        tests_pri_10: 1.70 (0.3%), tests_pri_500: 5 (0.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Guilherme G. Piccoli" <gpiccoli@canonical.com> writes:

> First of all, thanks everybody for the great insights/discussion! This
> thread ended-up being a great learning for (at least) me.
>
> Given the big amount of replies and intermixed comments, I wouldn't be
> able to respond inline to all, so I'll try another approach below.
>
>
> From Bjorn:
> "I think [0] proposes using early_quirks() to disable MSIs at boot-time.
> That doesn't seem like a robust solution because (a) the problem affects
> all arches but early_quirks() is x86-specific and (b) even on x86
> early_quirks() only works for PCI segment 0 because it relies on the
> 0xCF8/0xCFC I/O ports."
>
> Ah. I wasn't aware of that limitation, I thought enhancing the
> early_quirks() search to go through all buses would fix that, thanks for
> the clarification! And again, worth to clarify that this is not a
> problem affecting all arches _in practice_ - PowerPC for example has the
> FW primitives allowing a powerful PCI controller (out-of-band) reset,
> preventing this kind of issue usually.
>
> [0]
> https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
>
>
> From Bjorn:
> "A crash_device_shutdown() could do something at the host bridge level
> if that's possible, or reset/disable bus mastering/disable MSI/etc on
> individual PCI devices if necessary."
>
> From Lukas:
> "Guilherme's original patches from 2018 iterate over all 256 PCI buses.
> That might impact boot time negatively.  The reason he has to do that is
> because the crashing kernel doesn't know which devices exist and which
> have interrupts enabled.  However the crashing kernel has that
> information.  It should either disable interrupts itself or pass the
> necessary information to the crashing kernel as setup_data or whatever.
>
> Guilherme's patches add a "clearmsi" command line parameter.  I guess
> the idea is that the parameter is always passed to the crash kernel but
> the patches don't do that, which seems odd."
>
> Very good points Lukas, thanks! The reason of not adding the clearmsi
> thing as a default kdump procedure is kinda related to your first point:
> it impacts a bit boot-time, also it's an additional logic in the kdump
> kernel, which we know is (sometimes) the last resort in gathering
> additional data to debug a potentially complex issue. That said, I'd not
> like to enforce this kind of "policy" to everybody, so my implementation
> relies on having it as a parameter, and the kdump userspace counter-part
> could then have a choice in adding or not such mechanism to the kdump
> kernel parameter list.
>
> About passing the data to next kernel, this is very interesting, we
> could do something like that either through setup_data (as you said) or
> using a new proposal, the PKRAM thing [a].
> This way we wouldn't need a crash_device_shutdown(), but instead when
> kernel is loading a crash kernel (through kexec -p) we can collect all
> the necessary information that'll be passed to the crash kernel
> (obviously that if we are collecting PCI topology information, we need
> callbacks in the PCI hotplug add/del path to update this information).
>
> [a]
> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
>
> Below, inline reply to Eric's last message.
>
>
> On 15/11/2020 17:46, Eric W. Biederman wrote:
>>> [...]
>>> An MSI interrupt is a (DMA) write to the local APIC base address
>>> 0xfeexxxxx which has the target CPU and control bits encoded in the
>>> lower bits. The written data is the vector and more control bits.
>>>
>>> The only way to stop that is to shut it up at the PCI device level.
>> 
>> Or to write to magic chipset registers that will stop transforming DMA
>> writes to 0xfeexxxxx into x86 interrupts.  With an IOMMU I know x86 has
>> such registers (because the point of the IOMMU is to limit the problems
>> rogue devices can cause).  Without an IOMMU I don't know if x86 has any
>> such registers.  I remember that other platforms have an interrupt
>> controller that does provide some level of control.  That x86 does not
>> is what makes this an x86 specific problem.
>> [...]
>> Looking at patch 3/3 what this patchset does is an early disable of
>> of the msi registers.  Which is mostly reasonable.  Especially as has
>> been pointed out the only location the x86 vector and x86 cpu can
>> be found is in the msi configuration registers.
>> 
>> That also seems reasonable.  But Bjorn's concern about not finding all
>> devices in all domains does seem real.
>> [...]
>> So if we can safely and reliably disable DMA and MSI at the generic PCI
>> device level during boot up I am all for it.
>> 
>> 
>> How difficult would it be to tell the IOMMUs to stop passing traffic
>> through in an early pci quirk?  The problem setup was apparently someone
>> using the device directly from a VM.  So I presume there is an IOMMU
>> in that configuration.
>
> This is a good idea I think - we considered something like that in
> theory while working the problem back in 2018, but given I'm even less
> expert in IOMMU that I already am in PCI, the option was to go with the
> PCI approach. And you are right, the original problem is a device in
> PCI-PT to a VM, and a tool messing with the PF device in the SR-IOV (to
> collect some stats) from the host side, through VFIO IIRC.
>
> Anyway, we could split the problem in two after all the considerations
> in the thread, I believe:
>
> (1) If possible to set-up the IOMMU to prevent MSIs, by "blocking" the
> DMA writes for PCI devices *until* PCI core code properly initialize the
> devices, that'd handle the majority of the cases I guess (IOMMU usage is
> quite common nowadays).
>
> (2) Collecting PCI topology information in a running kernel and passing
> that to the kdump kernel would allow us to disable the PCI devices MSI
> capabilities, the only problem here is that I couldn't see how to do
> that early enough, before the 'sti' executes, without relying in
> early_quirks(). ACPI maybe? As per Bjorn comment when explaining the
> limitations of early_quirks(), this problem seems not to be trivial.
>
> I'm a bit against doing that in crash_kexec() for the reasons mentioned
> in the thread, specially by Thomas and Eric - but if there's no other
> way...maybe this is the way to go.

The way to do that would be to collect the set of pci devices when the
kexec on panic kernel is loaded, not during crash_kexec.  If someone
performs a device hotplug they would need to reload the kexec on panic
kernel.

I am not necessarily endorsing that just pointing out how it can be
done.

Eric
