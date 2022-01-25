Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAB49AF24
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454767AbiAYJAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 04:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1454238AbiAYI62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 03:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643101104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hJPkgKMKyrdhuh/ReLzRlMBQBnxQevcIKmrrryYVL0=;
        b=cwnHGejRVKm2Dol9PLEU2E9rQZ2HR9R8PfIGX8Ph6kCDMadxapJMoqTvQpWwbTVe2BgVwz
        5KntvMyi5iVEDHCo7PJamDfECTzeo72YjEkw85NXcxr9WJkoBKQSF2gaGzwtxmqrZriTgC
        6nheazKhvG9hEeUO2RRclNgIXa86Bo4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-2PdVeK3zP0Wq2pjzm1LCmA-1; Tue, 25 Jan 2022 03:58:21 -0500
X-MC-Unique: 2PdVeK3zP0Wq2pjzm1LCmA-1
Received: by mail-ej1-f69.google.com with SMTP id q19-20020a1709064c9300b006b39291ff3eso3228057eju.5
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 00:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9hJPkgKMKyrdhuh/ReLzRlMBQBnxQevcIKmrrryYVL0=;
        b=145myKZR9RjKJ5I/2yakh5lXKJGhWG8ltYL4OZNhj0YvHVONkgfGvBUY5dUO4by+i5
         2WvjcK6YZJTYmnIu5njvfmK2JiggREjxwGSg5n4JxMNPvi/ey87ZUn1+kZKd13+RpibH
         vbrOB6gkQC/ZOHLPN07RLhIWX1Jy7LEJs+cMzV58jD7y+F74Lq7jbSdkYFDl/btrOUoz
         1D896gt9NEFlD6JJpNXNDq5+u0d8vSSFEk46Y+eW9OUIR+Brqn4snZY3Zanu5fKp/o+R
         +X0GixwZWrckK5vpdC5R/s3otGMpK4pbodOY4uBl5UBou+A6JILel62ustjNJqDbBwNO
         bt+g==
X-Gm-Message-State: AOAM532bkgDRl1iw4b8HZ9qO6TNXFKL08xbUf62Klr2iEIAbZ09I9tCE
        /FfUQkbq3JXg64zn+ISY529nRyOlkh8HXQG8n+0qsdggTVreY+ix+719lHNktUtvPvyXqew+MkP
        3XMz35cZdE/VptsmsJdLh
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr19569676edt.111.1643101099882;
        Tue, 25 Jan 2022 00:58:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmbysy8sgPACubi83nNJN4S6lIDZXj6/heggPsJgslJm1E92EY2vKwjRRbsh3sBsI74KUNGQ==
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr19569664edt.111.1643101099706;
        Tue, 25 Jan 2022 00:58:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id u12sm7936862edq.8.2022.01.25.00.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 00:58:19 -0800 (PST)
Message-ID: <50702e5f-96e8-bc68-67ee-bcf11a5ccdc8@redhat.com>
Date:   Tue, 25 Jan 2022 09:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Blazej Kucman <blazej.kucman@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
References: <20220124214635.GA1553164@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220124214635.GA1553164@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/24/22 22:46, Bjorn Helgaas wrote:
> [+cc linux-pci, Hans, Lukas, Naveen, Keith, Nirmal, Jonathan]
> 
> On Mon, Jan 24, 2022 at 11:46:14AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215525
>>
>>             Bug ID: 215525
>>            Summary: HotPlug does not work on upstream kernel 5.17.0-rc1
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 5.17.0-rc1 upstream
>>           Hardware: x86-64
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: blazej.kucman@intel.com
>>         Regression: No
>>
>> Created attachment 300308
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=300308&action=edit
>> dmesg
>>
>> While testing on latest upstream
>> kernel(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/) we
>> noticed that with the merge commit
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0a231f01e5b25bacd23e6edc7c979a18a517b2b)
>> hotplug and hotunplug of nvme drives stopped working.
>>
>> Rescan PCI does not help.
>> echo "1" > /sys/bus/pci/rescan
>>
>> Issue does not reproduce on a kernel built on an antecedent
>> commit(88db8458086b1dcf20b56682504bdb34d2bca0e2).
>>
>>
>> During hot-remove device does not disappear, however when we try to do I/O on
>> the disk then there is an I/O error, and the device disappears.
>>
>> Before I/O no logs regarding the disk appeared in the dmesg, only after I/O the
>> entries appeared like below:
>> [  177.943703] nvme nvme5: controller is down; will reset: CSTS=0xffffffff,
>> PCI_STATUS=0xffff
>> [  177.971661] nvme 10000:0b:00.0: can't change power state from D3cold to D0
>> (config space inaccessible)
>> [  177.981121] pcieport 10000:00:02.0: can't derive routing for PCI INT A
>> [  177.987749] nvme 10000:0b:00.0: PCI INT A: no GSI
>> [  177.992633] nvme nvme5: Removing after probe failure status: -19
>> [  178.004633] nvme5n1: detected capacity change from 83984375 to 0
>> [  178.004677] I/O error, dev nvme5n1, sector 0 op 0x0:(READ) flags 0x0
>> phys_seg 1 prio class 0
>>
>>
>> OS: RHEL 8.4 GA
>> Platform: Intel Purley
>>
>> The logs are collected on a non-recent upstream kernel, but a issue also occurs
>> on the newest upstream kernel(dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0)
> 
> Apparently worked immediately before merging the PCI changes for
> v5.17 and failed immediately after:
> 
>   good: 88db8458086b ("Merge tag 'exfat-for-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat")
>   bad:  d0a231f01e5b ("Merge tag 'pci-v5.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")
> 
> Only three commits touch pciehp:
> 
>   085a9f43433f ("PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors")
>   23584c1ed3e1 ("PCI: pciehp: Fix infinite loop in IRQ handler upon power fault")
>   a3b0f10db148 ("PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check config reads")
> 
> None seems obviously related to me.  Blazej, could you try setting
> CONFIG_DYNAMIC_DEBUG=y and booting with 'dyndbg="file pciehp* +p"' to
> enable more debug messages?

Since there are only 3 commits maybe try reverting them 1 by 1 in reverse history order
(so revert latest commit first) ? And see if running a kernel with the reverted commit(s)
fixes things ?

Regards,

Hans

