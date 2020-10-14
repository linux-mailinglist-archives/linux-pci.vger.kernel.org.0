Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19328DBAA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJNIe1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 14 Oct 2020 04:34:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgJNIeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 04:34:24 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kScEo-000572-Cj
        for linux-pci@vger.kernel.org; Wed, 14 Oct 2020 08:34:22 +0000
Received: by mail-pf1-f200.google.com with SMTP id a27so1371633pfl.17
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yBdJSdAgHQ+xdK/RUk2/DLJnGrMIoCgxx45HedDifeI=;
        b=Q+ZrBSp084yOq65NCzxJmAgeC3ntFVJ+EKlk6yggoZB0Js5c1bFq9SehzR+IpRQGnH
         PMOmWB19SiOAUARYGo030XNYlQoNAMofsHWfghpsfNzrZQ9UmSX+7EuCc4KY2KdIKTqP
         YMwu+Kyz5LOxyWaAeBPz0Ndcw7Y2g117up1OayVL7BgqY4Fs6hq9C6JnC9foIO3GrjxK
         8ioJF0kM2LTl68e5GOM08C4P9Ijqig+BMFOJwU6ugjjwQfSY8XnUz7vERz8ETRclMF4P
         IYVK0J8AWOY6Er+/uniVCq6GuTU2J9CXMp38GM0+F7Mdwlc1DJWDPW4XSVCqm7geWjyI
         /8yA==
X-Gm-Message-State: AOAM532xgzw3Rw/flo4BVBzRFDwowsYuMjJc1xmZfc7bR4StmKTiY2nT
        32VsvIEDSGbS5dOBJABRrGAfN8IOcVLUL5vXsw/S4zh/UA7LaJRSq1RAxajO/zlZqc6+jn8NtGs
        1oUX/hXxrUs60vKRwDU0hRl4ujZ8GdO0qBd1sMQ==
X-Received: by 2002:a17:90a:4609:: with SMTP id w9mr2447508pjg.89.1602664460942;
        Wed, 14 Oct 2020 01:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygxca7mZi3M5gWFGoIqtwuKxHzbZLjcG5iTaM4jwCnZuCJPYOS3SEu7ybsEZlYUhIyXiEV4Q==
X-Received: by 2002:a17:90a:4609:: with SMTP id w9mr2447476pjg.89.1602664460415;
        Wed, 14 Oct 2020 01:34:20 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w74sm2441309pff.200.2020.10.14.01.34.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 01:34:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAA85sZsxLZ5m9SNe=5RD9oA7FV0mdwEvGqnXkdtbp_-e_6G5LQ@mail.gmail.com>
Date:   Wed, 14 Oct 2020 16:34:17 +0800
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0AD07E1E-02D1-4208-B90F-1949C85ECB64@canonical.com>
References: <20201007132808.647589-1-ian.kumlien@gmail.com>
 <20201008161312.GA3261279@bjorn-Precision-5520>
 <CAA85sZsxLZ5m9SNe=5RD9oA7FV0mdwEvGqnXkdtbp_-e_6G5LQ@mail.gmail.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 12, 2020, at 18:20, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> 
> On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> 
>> On Wed, Oct 07, 2020 at 03:28:08PM +0200, Ian Kumlien wrote:
>>> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
>>> "5.4.1.2.2. Exit from the L1 State"
>>> 
>>> Which makes it clear that each switch is required to initiate a
>>> transition within 1μs from receiving it, accumulating this latency and
>>> then we have to wait for the slowest link along the path before
>>> entering L0 state from L1.
>>> 
>>> The current code doesn't take the maximum latency into account.
>>> 
>>> From the example:
>>>   +----------------+
>>>   |                |
>>>   |  Root complex  |
>>>   |                |
>>>   |    +-----+     |
>>>   |    |32 μs|     |
>>>   +----------------+
>>>           |
>>>           |  Link 1
>>>           |
>>>   +----------------+
>>>   |     |8 μs|     |
>>>   |     +----+     |
>>>   |    Switch A    |
>>>   |     +----+     |
>>>   |     |8 μs|     |
>>>   +----------------+
>>>           |
>>>           |  Link 2
>>>           |
>>>   +----------------+
>>>   |    |32 μs|     |
>>>   |    +-----+     |
>>>   |    Switch B    |
>>>   |    +-----+     |
>>>   |    |32 μs|     |
>>>   +----------------+
>>>           |
>>>           |  Link 3
>>>           |
>>>   +----------------+
>>>   |     |8μs|      |
>>>   |     +---+      |
>>>   |   Endpoint C   |
>>>   |                |
>>>   |                |
>>>   +----------------+
>>> 
>>> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
>>> transition to L0 at time T. Since switch B takes 32 μs to exit L1 on
>>> it's ports, Link 3 will transition to L0 at T+32 (longest time
>>> considering T+8 for endpoint C and T+32 for switch B).
>>> 
>>> Switch B is required to initiate a transition from the L1 state on it's
>>> upstream port after no more than 1 μs from the beginning of the
>>> transition from L1 state on the downstream port. Therefore, transition from
>>> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
>>> 
>>> The path will exit L1 at T+34.
>>> 
>>> On my specific system:
>>> lspci -PP -s 04:00.0
>>> 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 816e (rev 1a)
>>> 
>>> lspci -vvv -s 04:00.0
>>>              DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>>> ...
>>>              LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
>>> ...
>>> 
>>> Which means that it can't be followed by any switch that is in L1 state.
>>> 
>>> This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.
>>> 
>>>                                                    LnkCtl    LnkCtl
>>>           ------DevCap-------  ----LnkCap-------  -Before-  -After--
>>>  00:01.2                                L1 <32us       L1+       L1-
>>>  01:00.0                                L1 <32us       L1+       L1-
>>>  02:04.0                                L1 <32us       L1+       L1-
>>>  04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-
>> 
>> OK, now we're getting close.  We just need to flesh out the
>> justification.  We need:
>> 
>>  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
>>    and follow the example.
> 
> Will do
> 
>>  - Description of the problem.  I think it's poor bandwidth on your
>>    Intel I211 device, but we don't have the complete picture because
>>    that NIC is 03:00.0, which doesn't appear above at all.
> 
> I think we'll use Kai-Hengs issue, since it's actually more related to
> the change itself...
> 
> Mine is a side effect while Kai-Heng is actually hitting an issue
> caused by the bug.

I filed a bug here:
https://bugzilla.kernel.org/show_bug.cgi?id=209671

Kai-Heng

> 
>>  - Explanation of what's wrong with the "before" ASPM configuration.
>>    I want to identify what is wrong on your system.  The generic
>>    "doesn't match spec" part is good, but step 1 is the specific
>>    details, step 2 is the generalization to relate it to the spec.
>> 
>>  - Complete "sudo lspci -vv" information for before and after the
>>    patch below.  https://bugzilla.kernel.org/show_bug.cgi?id=208741
>>    has some of this, but some of the lspci output appears to be
>>    copy/pasted and lost all its formatting, and it's not clear how
>>    some was collected (what kernel version, with/without patch, etc).
>>    Since I'm asking for bugzilla attachments, there's no space
>>    constraint, so just attach the complete unedited output for the
>>    whole system.
>> 
>>  - URL to the bugzilla.  Please open a new one with just the relevant
>>    problem report ("NIC is slow") and attach (1) "before" lspci
>>    output, (2) proposed patch, (3) "after" lspci output.  The
>>    existing 208741 report is full of distractions and jumps to the
>>    conclusion without actually starting with the details of the
>>    problem.
>> 
>> Some of this I would normally just do myself, but I can't get the
>> lspci info.  It would be really nice if Kai-Heng could also add
>> before/after lspci output from the system he tested.
>> 
>>> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
>>> ---
>>> drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
>>> 1 file changed, 15 insertions(+), 8 deletions(-)
>>> 
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 253c30cc1967..893b37669087 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>>> 
>>> static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>>> {
>>> -     u32 latency, l1_switch_latency = 0;
>>> +     u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
>>>      struct aspm_latency *acceptable;
>>>      struct pcie_link_state *link;
>>> 
>>> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>>>              if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
>>>                  (link->latency_dw.l0s > acceptable->l0s))
>>>                      link->aspm_capable &= ~ASPM_STATE_L0S_DW;
>>> +
>>>              /*
>>>               * Check L1 latency.
>>> -              * Every switch on the path to root complex need 1
>>> -              * more microsecond for L1. Spec doesn't mention L0s.
>>> +              *
>>> +              * PCIe r5.0, sec 5.4.1.2.2 states:
>>> +              * A Switch is required to initiate an L1 exit transition on its
>>> +              * Upstream Port Link after no more than 1 μs from the beginning of an
>>> +              * L1 exit transition on any of its Downstream Port Links.
>>>               *
>>>               * The exit latencies for L1 substates are not advertised
>>>               * by a device.  Since the spec also doesn't mention a way
>>> @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>>>               * L1 exit latencies advertised by a device include L1
>>>               * substate latencies (and hence do not do any check).
>>>               */
>>> -             latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
>>> -             if ((link->aspm_capable & ASPM_STATE_L1) &&
>>> -                 (latency + l1_switch_latency > acceptable->l1))
>>> -                     link->aspm_capable &= ~ASPM_STATE_L1;
>>> -             l1_switch_latency += 1000;
>>> +             if (link->aspm_capable & ASPM_STATE_L1) {
>>> +                     latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
>>> +                     l1_max_latency = max_t(u32, latency, l1_max_latency);
>>> +                     if (l1_max_latency + l1_switch_latency > acceptable->l1)
>>> +                             link->aspm_capable &= ~ASPM_STATE_L1;
>>> +
>>> +                     l1_switch_latency += 1000;
>>> +             }
>>> 
>>>              link = link->parent;
>>>      }
>>> --
>>> 2.28.0
>>> 

