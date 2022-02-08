Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4C4ADDCD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiBHP7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBHP7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 10:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3613C061579
        for <linux-pci@vger.kernel.org>; Tue,  8 Feb 2022 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644335957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlwsX93v8/uDsNJTw9WiZgWB70ZjhyAy4HgLUlsk+JU=;
        b=akSmGCNeCxXjNnyCbE+wtpphrnuPE/XuaWFh1qZPvrpQi6dyiAd0NT1aowcWM0ajE3XNFB
        We1TU1KY8FnsFA/aj3wa6fZDppjfoGEJipxyBiYqUNQl+/vs2m2ONuPgboNnJW8FmfJN+d
        c7UGQIy7h2KXqWvS21PVt7T1RTdbZ1c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-4RAQmjOSOvy6thMvxmnd5A-1; Tue, 08 Feb 2022 10:59:16 -0500
X-MC-Unique: 4RAQmjOSOvy6thMvxmnd5A-1
Received: by mail-ed1-f69.google.com with SMTP id u24-20020a50d518000000b0040f8cef2463so2452113edi.21
        for <linux-pci@vger.kernel.org>; Tue, 08 Feb 2022 07:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PlwsX93v8/uDsNJTw9WiZgWB70ZjhyAy4HgLUlsk+JU=;
        b=M9I+xRQMadm+IsZtKNJVI+FlhOmMdczQjxSlbKSi/GR8PXc2Wc1fVXpyjadpH0RXl2
         F6KyunQgJDXHO5Q5rRwixpvEJM8yaL+QioEfiQt0SWr6W7Ctw1tvR1iRWOADmb31Zbpt
         1d11hzhoUTyWzRaCzttOqRXOekfYoaGK0IAWfv9wLsm5mEvYVaEbgNGnbwjCJ0xvHb++
         IuJKQJFLln7yiIn/C74oVLd6JL8WEz2ClLFpn40R2c+VW00OHUEhRfsda8nK+dXMA0Sm
         kTH3eoeeik1xDUaILcuSEOG96LHiDLo9zMmEvHsbae3IB8j0+BRqsQDUiwaQgK2kRsX0
         Nlog==
X-Gm-Message-State: AOAM531CEVnvrW/vf5hZ29d1n7rWiuJJzVpSRYF/OFMZ3vvcZvUtedRX
        QuhRtt3x6d/j8X0bWlvMmjWTyDpJJt5wohF7n5EsPIo/vILeku4cXO1OhlY8bCXLYvZ57qACNNo
        Dq10bz7uMtmhlALzkoIY/
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr5072794edd.363.1644335954696;
        Tue, 08 Feb 2022 07:59:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTF1YDJPIGG4cDjD1lyprXQikArGmVnKZPFLgjQS8/etKgsBhO7waVCKhb/P6kJxST02jpKA==
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr5072785edd.363.1644335954528;
        Tue, 08 Feb 2022 07:59:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id f16sm3414509eds.0.2022.02.08.07.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:59:13 -0800 (PST)
Message-ID: <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com>
Date:   Tue, 8 Feb 2022 16:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/8/22 16:25, Hans de Goede wrote:
> Hi All,
> 
> Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
> Ignore E820 reservations for bridge windows on newer systems"):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7
> 
> breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
> X1 gen 2, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> 
> This regression was actually caught be Fedora already carrying this
> patch for a while now and as such it has been reproduced with 5.15
> with an older version of the patch which still allowed turning the
> new behavior of by adding "pci=use_e820". Dmesg output with and
> without the option has just been attached to the bug, I've not
> analyzed this any further yet.
> 
> I guess that for now this means that we need to revert commit
> 7f7b4236f204. Rafael, I'll send you a revert with a commit msg
> explaining why this needs to be reverted tomorrow.
> 
> More interesting IMHO is finding out another solution. Both the touchpad
> problem which got me looking into this:
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> 
> As well as the thunderbolt hotplug issue Mika was looking at:
> https://bugzilla.kernel.org/show_bug.cgi?id=206459
> 
> both are cases where we fail to find a memory-window for a
> BAR which has not been setup yet.
> 
> So I see a couple of options here:
> 
> 1. Detect that the e820 reservations fully cover (one of)
> the PCI bridge main 32 bit memory windows and if that happens
> ignore them. This actually was my first plan when I started
> working on this. In the end I choose the other option
> because Bjorn indicated that in hindsight honoring the e820
> reservations might have been a mistake and maybe we should
> get rid of honoring them all together.
> 
> 2. Have a flag which, when we fail to alloc a 32 bit
> (or 64 bit) memory PCI BAR, is set if not already set
> and then retry the alloc. And make the e820 reservation
> carve-out get skipped in this case.
> 
> 3. When booting with pci=nocrs as a workaround for
> the touchpad case a 64 but memory window ends up getting
> used. There already is some special handling for some
> AMD bridges where if there are no 64 bit memory Windows
> in the _CRS for the bridge, one gets added. Maybe we need
> to do the same for Intel bridges ?

4. It seems that all devices which have issues with allocating
a PCI bar are Ice Lake based; and the model where the ignoring
of e820 reservations has been reported to cause issues is somewhat
old. It is a Haswell, but still getting BIOS updates causing
the BIOS date check to enable the new behavior. So another
solution might be to only ignore e820 reservations on machines
with Intel Ice Lake (and presumably also Tiger Lake) CPUs.


5. It also seems that the troublesome e820 entry on all devices
ends at 0xcfffffff and starts well below 0x8000000 :

Yoga C940:
[    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved

IdeaPad 3 15IIL05:
[    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved

Lenovo IdeaPad 5 14IIL05:
[    0.000000] BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved


Actually even the lower addresses seem to follow a pattern.

So I guess that we could do a really narrow fix here where we only
ignore the *this* e820 reservation using the properties that:

a) It is "huge"
b) Always ends at 0x00000000cfffffff

To identify it.



I was at first tempted to choose 1 as fix, which basically is also
based on this huge reservation covering the entire 32 bit mem window of
the pci-bridge(s) in the system. But that seems to boil down to the same
thing as 5. Where as 5 can be a really narrowly tailored fix, requiring
only changes to arch/x86/kernel/resource.c . So atm I'm leaning towards
trying 5.  As already said, plase let me know what you think.

Regards,

Hans


