Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB34A425210
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhJGLez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 07:34:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:25522 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241054AbhJGLev (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 07:34:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="224998369"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="224998369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 04:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="524627725"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 04:32:44 -0700
Received: from [10.249.159.36] (mtkaczyk-MOBL1.ger.corp.intel.com [10.249.159.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 57BAE5807D3;
        Thu,  7 Oct 2021 04:32:42 -0700 (PDT)
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     Dan Williams <dan.j.williams@intel.com>,
        stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
 <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
 <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
Message-ID: <19dcfbea-efcd-b385-4031-23fae5c1c78b@linux.intel.com>
Date:   Thu, 7 Oct 2021 13:32:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06.10.2021 22:15, Dan Williams wrote:
>>>> +static struct led_state led_states[] = {
>>>> +       { .name = "ok",         .bit = 2 },
>>>> +       { .name = "locate",     .bit = 3 },
>>>> +       { .name = "failed",     .bit = 4 },
>>>> +       { .name = "rebuild",    .bit = 5 },
>>>> +       { .name = "pfa",        .bit = 6 },
>>>> +       { .name = "hotspare",   .bit = 7 },
>>>> +       { .name = "ica",        .bit = 8 },
>>>> +       { .name = "ifa",        .bit = 9 },
>>>> +       { .name = "invalid",    .bit = 10 },
>>>> +       { .name = "disabled",   .bit = 11 },
>>>> +};
>>> include/linux/enclosure.h has common ABI definitions of industry
>>> standard enclosure LED settings. The above looks to be open coding the
>>> same?
>>>
>> The LED states in inluce/linux/enclosure.h aren't exactly the same...
>> there are states defined in NPEM/_DSM that aren't defined in
>> enclosure.h.  In addition, while the enclosure driver allows "locate" to
>> be controlled independently, it looks like it will only allow a single
>> state (unsupported/ok/critical/etc) to be active at a time, while the
>> NPEM/_DSM allow all of the state bits to be independently set or
>> cleared.  Maybe only one of those states would need to be set at a time,
>> I don't know, but that would impose a limitation on what NPEM/_DSM can
>> do.  I'll take a closer look at this as an alternative to using
>> drivers/leds/led-class.c.
> Have a look. Maybe Mariusz can weigh in here with his experience with
> ledmon with what capabilities ledmon would need from this driver so we
> can decide what if any extensions need to be made to the enclosure
> infrastructure?

Hmm... In ledmon we are expecting one state to be set at the time. So,
I would expected from kernel to work the same.

Looking into ledmon code, all capabilities from this list could be
used[1].

 >>>> +       { .name = "ok",         .bit = 2 },
 >>>> +       { .name = "locate",     .bit = 3 },
 >>>> +       { .name = "failed",     .bit = 4 },
 >>>> +       { .name = "rebuild",    .bit = 5 },
 >>>> +       { .name = "pfa",        .bit = 6 },
 >>>> +       { .name = "hotspare",   .bit = 7 },
 >>>> +       { .name = "ica",        .bit = 8 },
 >>>> +       { .name = "ifa",        .bit = 9 },

[1]https://github.com/intel/ledmon/blob/master/src/ibpi.h#L60

Thanks,
Mariusz
