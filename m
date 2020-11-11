Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC52AFAA1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 22:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKVmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 16:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVmG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 16:42:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E19C0613D1;
        Wed, 11 Nov 2020 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/nMet02cFoPAk6ijRuL303bh3og81B8GTxl/a9qyXPA=; b=u1HVDyS3ORQannbJxvV2fh1Uhk
        SL7c8IYcqtKtxDE/bLoT8cFoZ29Z72r0BYcWECLbG3IcDZX0p48fNEyaIjOUlkqqBRVG7Is9WWa2a
        rjJSbW0z+sghHAT0LyEii901kvQFvmVoC2TacMJLLl9lYNHyh1P5+Bm4IWYMsWZ5gVcQttbeybH+W
        nVC/nNQtf5IJOhqpilDfCDddaiBSeZA6nso2hZWckD6FA0zV5Dm57UYnLI2qTqt+bwRLZsK9VPliz
        FNIOCf+msPLGe4/r5xHHi4qIlAeVPmGq28xP5W+Dko6CtnQR6ezEjAXP3d7fnb3BgOwDg563/3C1P
        e2pzWwhA==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcxsG-00033E-P2; Wed, 11 Nov 2020 21:41:59 +0000
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com>
 <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a8b5a64-7ba0-a275-744f-6642f98e2213@infradead.org>
Date:   Wed, 11 Nov 2020 13:41:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/20 9:17 AM, Dan Williams wrote:
> On Tue, Nov 10, 2020 at 11:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
>>> +config CXL_MEM
>>> +        tristate "CXL.mem Device Support"
>>> +        depends on PCI && CXL_BUS_PROVIDER != n
>>
>> depend on PCI && CXL_BUS_PROVIDER
>>
>>> +        default m if CXL_BUS_PROVIDER
>>
>> Please don't set weird defaults for new code.  Especially not default
>> to module crap like this.
> 
> This goes back to what people like Dave C. asked for LIBNVDIMM / DAX,
> a way to blanket turn on a subsystem without needing to go hunt down
> individual configs. All of CXL is "default n", but if someone turns on
> a piece of it they get all of it by default. The user can then opt-out
> on pieces after that first opt-in. If there's a better way to turn on
> suggested configs I'm open to switch to that style. As for the
> "default m" I was worried that it would be "default y" without the
> specificity, but I did not test that... will check. There have been
> times when I wished that distros defaulted bleeding edge new enabling
> to 'm' and putting that default in the Kconfig maybe saves me from
> needing to file individual config changes to distros after the fact.

What we as developers put into mainline kernel Kconfig files has nothing
to do with what distros use in their distro config files.
Or at least it shouldn't.  Maybe your experience has been different.

>>
>>> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
>>
>> Please don't use '//' for anything but the SPDX header.
> 
> Ok, I find // following by /* */ a bit ugly, but I don't care enough to fight.
> 

Hm, it's not in coding-style AFAICT but Linus has OK-ed C99 style comments:
http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html


>>> +MODULE_AUTHOR("Intel Corporation");
>>
>> A module author is not a company.
> 
> At least I don't have a copyright assignment clause, I don't agree
> with the vanity of listing multiple people here especially when
> MAINTAINERS has the contact info, and I don't want to maintain a list
> as people do drive-by contributions and we need to figure out at what
> level of contribution mandates a new MODULE_AUTHOR line. Now, that
> said I would be ok to duplicate the MAINTAINERS as MODULE_AUTHOR
> lines, but I otherwise expect MAINTAINERS is the central source for
> module contact info.

Sure, MAINTAINERS is fine, but the MODULE_AUTHOR() above provides
no useful information.
Even saying (made up) linux-devel@linux.intel.com would be slightly better,
but some kind of contact info would be great. Otherwise just delete that line.


-- 
~Randy

