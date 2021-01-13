Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7C2F52A5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbhAMSp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbhAMSpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 13:45:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B7C061575
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=6wWb0CbYNxqJgZPV91SAmgv6leRfeKA1ITu1yUiAr04=; b=LAO0KsK0dQPu7jiMA5F4NqenbD
        EW2Fm8PJI8N0jv3aX2Rzq5Hfb3w7Tgo+40iuGh5c2TYq6ssy1IyxKKtvRPIfj+5vSPc7rtcsMzLBO
        EQuOx+TYjKeiz7DF9+fvJXjWpF8nqo35PNj32geAk2jN03U0SqMXJ2ksivb5A+ZSqSxtUKPlztfWF
        2XCyeGeXz/WXMZ7FQjfihuvt87QhpLLPjiI6tbMikfUyzMnNysdPU+3hrzN2HsHVnPDobtFQtVJXQ
        DU/AHxZjUXPNGUs16/s9wrT4Y+AayjiIOJSGhw6SR5D/li4oh5R+MVmfwvh9xwAYhXbkL6rppdT3o
        P0yFrZrw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzl8p-00040h-Nb; Wed, 13 Jan 2021 18:45:12 +0000
Subject: Re: /proc/iomem and /proc/ioports show 0 for address range
To:     Hinko Kocevar <hinko.kocevar@ess.eu>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <375ef4e6-b9a1-d4f2-81b6-582f2152820d@ess.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae1da3a0-11d3-b1dd-601c-3169e783fcb4@infradead.org>
Date:   Wed, 13 Jan 2021 10:45:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <375ef4e6-b9a1-d4f2-81b6-582f2152820d@ess.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/13/21 2:29 AM, Hinko Kocevar wrote:
> [I noticed this while working on PCI devices; not sure which kernel list would be best for this, though]
> 
> I noticed that my system shows address range for iomem and ioports as all 0. Sometimes (after a power cycle) the addresses are proper, albeit I have not been able to see that in a while now, after performing numerous reboots in the last coupe of days.
> 
> FWIW, I think the list of devices (names, count) looks the same in both cases. The system seems to work in both cases; at least I have not seen any complaints in kernel logs, OTOH, not sure what the error message would be.
> 
> What may be the reason for not getting the proper addresses listed?

config STRICT_DEVMEM
	bool "Filter access to /dev/mem"

and

config IO_STRICT_DEVMEM
	bool "Filter I/O access to /dev/mem"

so what are your CONFIG_STRICT_DEVMEM and CONFIG_IO_STRICT_DEVMEM set to?

What do you see in /proc/iomem and /proc/ioports if you are admin/root?
That should be non-zero values.

> This likely poses any issues for userspace tools that would look at those /proc files, OTOH, I wonder if would kernel suffer in any way as well?

Yes, it could affect userspace.

> Kernel version is 5.10.0 (pci git tree).
> 
> [dev@bd-cpu18 ~]$ cat /proc/iomem
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : PCI Bus 0000:00
> 00000000-00000000 : Video ROM
> 00000000-00000000 : Reserved
>   00000000-00000000 : System ROM
> 00000000-00000000 : System RAM
>   00000000-00000000 : Kernel code
>   00000000-00000000 : Kernel rodata
>   00000000-00000000 : Kernel data
>   00000000-00000000 : Kernel bss


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
