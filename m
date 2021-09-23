Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE0416048
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhIWNwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 09:52:50 -0400
Received: from smtp.radex.nl ([178.250.146.7]:34364 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhIWNwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 09:52:47 -0400
Received: from [192.168.1.35] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id F32742406A;
        Thu, 23 Sep 2021 15:51:13 +0200 (CEST)
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for
 ACPI
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com>
 <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
Message-ID: <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com>
Date:   Thu, 23 Sep 2021 15:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Repost (with formatting removed, sorry for the noise)
Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth<fntoth@gmail.com>  wrote:
>> Hi,
>> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
>>> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>
>>> Using struct pci_platform_pm_ops for ACPI adds unnecessary
>>> indirection to the interactions between the PCI core and ACPI PM,
>>> which is also subject to retpolines.
>>>
>>> Moreover, it is not particularly clear from the current code that,
>>> as far as PCI PM is concerned, "platform" really means just ACPI
>>> except for the special casess when Intel MID PCI PM is used or when
>>> ACPI support is disabled (through the kernel config or command line,
>>> or because there are no usable ACPI tables on the system).
>>>
>>> To address the above, rework the PCI PM code to invoke ACPI PM
>>> functions directly as needed and drop the acpi_pci_platform_pm
>>> object that is not necessary any more.
>>>
>>> Accordingly, update some of the ACPI PM functions in question to do
>>> extra checks in case the ACPI support is disabled (which previously
>>> was taken care of by avoiding to set the pci_platform_ops pointer
>>> in those cases).
>>>
>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2:
>>>       * Rebase on top of the new [1/7] and move dropping struct
>>>         pci_platform_pm_ops to a separate patch.
>> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
>> apply (after 1/7 applied). Should I apply this on another tree?
> This is on top of
> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
> which is not yet in any tree.
>
> Sorry for the confusion.
No problem at all. If I can I will try to report back tonight. Else, 
will be delayed 2 due to a short break.
