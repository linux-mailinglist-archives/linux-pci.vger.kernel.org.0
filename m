Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8FB429BE0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 05:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJLDYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 23:24:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38580
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbhJLDYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 23:24:14 -0400
Received: from [10.1.1.116] (unknown [103.229.218.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6FDA33F112;
        Tue, 12 Oct 2021 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634008930;
        bh=yp4QdxqP/gT9M/VQy0h5lM6TzTfPeMuLkazEpnjIXSY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=jMsqyRMx2gZirkLsa8f2mOnARgd5ntFqup1tdEaqMwVImGpI1wioszbyHl3zO1nkZ
         KNkAFCWE9cge8puVX5E/lkEwYj72M/hVgEMhkNnFKal/0FTpIXAwh3wEbnwzVU6+25
         u3/fisjTs1KQwmQOfRfaLnVTkOCD2Ez82/Y2ZW5UJ35iXAUOD/Q7UTrbPqfRZELLoS
         fqSJbmIJekd3y+uyOxiwi4pZvq0t+CbeNDno6LYIqii5+SItG0yENg8IAI/C+AAP5t
         JnPv2OPdSrrqsX/qgdp0fJK8dTOVS65Lh232ZNiH+nuyMXpB3yDHDnpfNExO7GmVAT
         IRK4TuY2Bmruw==
Subject: Re: [PATCH v2] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>
References: <20211011090531.244762-1-hdegoede@redhat.com>
 <YWRBvRcuTx8BrmX0@lahna>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <7545b263-b1a4-1c85-7f88-674ae0bb87ac@canonical.com>
Date:   Tue, 12 Oct 2021 11:22:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWRBvRcuTx8BrmX0@lahna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/11/21 9:53 PM, Mika Westerberg wrote:
> Hi Hans,
>
> On Mon, Oct 11, 2021 at 11:05:31AM +0200, Hans de Goede wrote:
>> Some BIOS-es contain a bug where they add addresses which map to system RAM
>> in the PCI bridge memory window returned by the ACPI _CRS method, see
>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>> space").
>>
>> To avoid this Linux by default excludes E820 reservations when allocating
>> addresses since 2010. Windows however ignores E820 reserved regions for PCI
>> mem allocations, so in hindsight Linux honoring them is a problem.
>>
>> Recently (2020) some systems have shown-up with E820 reservations which
>> cover the entire _CRS returned PCI bridge memory window, causing all
>> attempts to assign memory to PCI BARs which have not been setup by the BIOS
>> to fail. For example here are the relevant dmesg bits from a
>> Lenovo IdeaPad 3 15IIL 81WE:
>>
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> Ideally Linux would fully stop honoring E820 reservations for PCI mem
>> allocations, but then the old systems this was added for will regress.
>> Instead keep the old behavior for old systems, while ignoring the E820
>> reservations like Windows does for any systems from now on.
>>
>> Old systems are defined here as BIOS year < 2018, this was chosen to
>> make sure that pci_use_e820 will not be set on the currently affected
>> systems, while at the same time also taking into account that the
>> systems for which the E820 checking was orignally added may have
>> received BIOS updates for quite a while (esp. CVE related ones),
>> giving them a more recent BIOS year then 2010.
>>
>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
>> the BIOS year heuristic.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugs.launchpad.net/bugs/1878279
>> BugLink: https://bugs.launchpad.net/bugs/1931715
>> BugLink: https://bugs.launchpad.net/bugs/1932069
>> BugLink: https://bugs.launchpad.net/bugs/1921649
>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>> Cc: Hui Wang <hui.wang@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Thanks for fixing this! Few comments below. Otherwise looks good,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
Thanks for fixing this! We almost reach a solution. :-)

Thanks,

Hui.


