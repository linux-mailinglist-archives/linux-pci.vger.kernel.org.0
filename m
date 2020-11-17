Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7F2B55F1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 02:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKQBHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 20:07:06 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35896 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQBHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 20:07:05 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kepSU-00Ds8n-El; Mon, 16 Nov 2020 18:06:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kepST-002qfT-AH; Mon, 16 Nov 2020 18:06:58 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
References: <20201117001907.GA1342260@bjorn-Precision-5520>
Date:   Mon, 16 Nov 2020 19:06:40 -0600
In-Reply-To: <20201117001907.GA1342260@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Mon, 16 Nov 2020 18:19:07 -0600")
Message-ID: <87h7poeqqn.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kepST-002qfT-AH;;;mid=<87h7poeqqn.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188ydrQYzwMz6XyNvsZC3ptsCeXvn1fyKU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4679]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Bjorn Helgaas <helgaas@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 547 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 9 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.45 (0.3%),
        extract_message_metadata: 5 (0.9%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.73 (0.3%),
        tests_pri_-900: 1.48 (0.3%), tests_pri_-90: 98 (17.8%), check_bayes:
        95 (17.5%), b_tokenize: 8 (1.4%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 72 (13.2%), b_finish: 1.00
        (0.2%), tests_pri_0: 401 (73.4%), check_dkim_signature: 0.87 (0.2%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        3.1 (0.6%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> I don't think passing the device information to the kdump kernel is
> really practical.  The kdump kernel would use it to do PCI config
> writes to disable MSIs before enabling IRQs, and it doesn't know how
> to access config space that early.

I don't think it is particularly practical either.  But in practice
on x86 it is either mmio writes or 0xcf8 style writes and we could
pass a magic table that would have all of that information.

> We could invent special "early config access" things, but that gets
> really complicated really fast.  Config access depends on ACPI MCFG
> tables, firmware interfaces, and in many cases, on the native host
> bridge drivers in drivers/pci/controllers/.

I do agree that the practical problem with passing information early
is that gets us into the weeds and creates code that we only care
about in the case of kexec-on-panic.  It is much better to make the
existing code more robust, so that we reduce our dependency on firmware
doing the right thing.

> I think we need to disable MSIs in the crashing kernel before the
> kexec.  It adds a little more code in the crash_kexec() path, but it
> seems like a worthwhile tradeoff.

Disabling MSIs in the b0rken kernel is not possible.

Walking the device tree or even a significant subset of it hugely
decreases the chances that we will run into something that is incorrect
in the known broken kernel.  I expect the code to do that would double
or triple the amount of code that must be executed in the known broken
kernel.  The last time something like that happened (switching from xchg
to ordinary locks) we had cases that stopped working.  Walking all of
the pci devices in the system is much more invasive.

That is not to downplay the problems of figuring out how to disable
things in early boot.

My two top candidates are poking the IOMMUs early to shut things off,
and figuring out if we can delay enabling interrupts until we have
initialized pci.

Poking at IOMMUs early should work for most systems with ``enterprise''
hardware.  Systems where people care about kdump the most.

Eric
