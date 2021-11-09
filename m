Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E143044B3E9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 21:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbhKIU2h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 15:28:37 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33469 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244263AbhKIU2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 15:28:37 -0500
Received: from [192.168.0.2] (ip5f5aef56.dynamic.kabel-deutschland.de [95.90.239.86])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD90461EA1931;
        Tue,  9 Nov 2021 21:25:48 +0100 (CET)
Message-ID: <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
Date:   Tue, 9 Nov 2021 21:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
 <YYlb2w1UVaiVYigW@rocinante>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YYlb2w1UVaiVYigW@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Krzysztof,


Thank you for your reply.


Am 08.11.21 um 18:18 schrieb Krzysztof Wilczyński:

>> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes
>> almost five seconds to initialize PCI. According to the timestamps, 1.5 s
>> are from assigning the PCI devices to the 142 IOMMU groups.
> [...]
>> Is there anything that could be done to reduce the time?
> 
> I am curious - why is this a problem?  Are you power-cycling your servers
> so often to the point where the cumulative time spent in enumerating PCI
> devices and adding them later to IOMMU groups is a problem?
> 
> I am simply wondering why you decided to signal out the PCI enumeration as
> slow in particular, especially given that a large server hardware tends to
> have (most of the time, as per my experience) rather long initialisation
> time either from being powered off or after being power cycled.  I can take
> a while before the actual operating system itself will start.

It’s not a problem per se, and more a pet peeve of mine. Systems get 
faster and faster, and boottime slower and slower. On desktop systems, 
it’s much more important with firmware like coreboot taking less than 
one second to initialize the hardware and passing control to the 
payload/operating system. If we are lucky, we are going to have servers 
with FLOSS firmware.

But, already now, using kexec to reboot a system, avoids the problems 
you pointed out on servers, and being able to reboot a system as quickly 
as possible, lowers the bar for people to reboot systems more often to, 
for example, so updates take effect.

> We talked about this briefly with Bjorn, and there might be an option to
> perhaps add some caching, as we suspect that the culprit here is doing PCI
> configuration space read for each device, which can be slow on some
> platforms.
> 
> However, we would need to profile this to get some quantitative data to see
> whether doing anything would even be worthwhile.  It would definitely help
> us understand better where the bottlenecks really are and of what magnitude.
> 
> I personally don't have access to such a large hardware like the one you
> have access to, thus I was wondering whether you would have some time, and
> be willing, to profile this for us on the hardware you have.
> 
> Let me know what do you think?

Sounds good. I’d be willing to help. Note, that I won’t have time before 
Wednesday next week though.


Kind regards,

Paul
