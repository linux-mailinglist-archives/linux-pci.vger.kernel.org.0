Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54653C4351
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhGLExe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 00:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhGLExd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 00:53:33 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ECAC0613DD;
        Sun, 11 Jul 2021 21:50:45 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so3017359ott.7;
        Sun, 11 Jul 2021 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jVzX1Ei7PdlhASQV0tljA6A5VeInYADZXzIMHbCEaU=;
        b=nePi5dFSpoBDuEkvKLCxyKDZQ+RxGtr3HXmqgmWE1IkB5hJxAtfYk4TKY2fdMmwqjz
         gIR3LCkmNRU0x2mzaEZgScW0e6azemTTE5xpNgwjlzeK9vQNnWzeKAKB5zrdVMa8JUYJ
         LWSiv6QZqhk/bEYB2UFhHDlT7Ubdt6+oG1RO98JQxABhCyLb330yFKHyDF6dhlT66xdi
         4/CXmIPQgISB68KPuTJEDIwQz0IYIfu5i14AuDoJNdGXEt8hmUSEfHEuRVAMMzaLDbnP
         7z62p/vzj4sXCsUIo74k1UACIr+Fru00pq0Nc6in20Idc9OS+lU+QK+i8j37fGKjuEnU
         nFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jVzX1Ei7PdlhASQV0tljA6A5VeInYADZXzIMHbCEaU=;
        b=j+O4Gyln/PWq33Vj0oiUA8bm+Fl5II8KO+kmFlB6VSYO3ZyJR6wqc797W5SEB+fgJ7
         mJ8SzDTzG0pI6V8UfoRboWZbriwzCaekRryRSR4/n5iEIHY3BlUJb/GUbUwKtjOhjKDY
         dpoxM+uSD8eNOOcih7wkcCEqi9cp49Pq7wmW2UJ2iqZ5+h6zARxOtF+L8VXQYJzFLVWk
         lmFY5oGoVEutF13p352HJd337HxaP2vMQ0Q1bAd8BNbbRe5WSDARji/5v/0PveJiTrcX
         xkUI6eEQiZHHGAvB4/GT8fXST3wCq0EKg09qLN6H9BrI27L4lTm2+Ar4dlH5FF0N9WKj
         oTYA==
X-Gm-Message-State: AOAM530igeVTB1TQnsABtIhrpiCyFIIUYn1PTVE8E6Vry6ebvn862nX1
        OmOSj8HGhEGBSpVj0qRUiY3L078dqQU=
X-Google-Smtp-Source: ABdhPJxusCMr7IMk6hwEtMKOO7CaTfOMZolrpYOsnxdBr9WkvUkSB/siN9fV6QwofJL1/akIxiKDtw==
X-Received: by 2002:a05:6830:1da1:: with SMTP id z1mr24825693oti.212.1626065444078;
        Sun, 11 Jul 2021 21:50:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm2879207otf.12.2021.07.11.21.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 21:50:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210401131252.531935-1-kai.heng.feng@canonical.com>
 <20210709231529.GA3270116@roeck-us.net>
 <CAAd53p7s=k7pa_GdaetQGQYp9GbQR+jkQWLQoe6-c0oTjCQXxw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f2239f52-8675-17fb-bf5f-80be0abe78d2@roeck-us.net>
Date:   Sun, 11 Jul 2021 21:50:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p7s=k7pa_GdaetQGQYp9GbQR+jkQWLQoe6-c0oTjCQXxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/21 8:50 PM, Kai-Heng Feng wrote:
> Hi Guenter,
> 
> On Sat, Jul 10, 2021 at 7:15 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
>>> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
>>> can't get the BAR it needs:
>>> [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
>>> [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
>>> ...
>>> [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
>>> [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
>>> [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
>>> [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
>>> [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
>>> [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
>>> [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
>>>
>>> However, the root bus has two contiguous regions that can contain the
>>> child resource requested.
>>>
>>> Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
>>> for host bridges, since host bridge don't have _SRS. So do that
>>> accordingly to make child resource can be contained. This change makes
>>> the graphics works on the system in question.
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
>>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> With this patch in place, I can no longer boot the ppc:sam460ex
>> qemu emulation from nvme. I see the following boot error:
>>
>> nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
>> nvme nvme0: Removing after probe failure status: -19
>>
>> A key difference seems to be swapped region addresses:
>>
>> ok:
>>
>> PCI host bridge to bus 0002:00^M
>> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>>
>> bad:
>>
>> PCI host bridge to bus 0002:00^M
>> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>>
>> and then bar address assignments are swapped/changed.
>>
>> ok:
>>
>> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
>> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
>> pci 0002:00:02.0: BAR 0: assigned [mem 0xd84200000-0xd84203fff 64bit]^M
>> pci 0002:00:01.0: BAR 5: assigned [mem 0xd84204000-0xd842041ff]^M
>> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
>> pci 0002:00:03.0: BAR 1: assigned [mem 0xd84204200-0xd8420427f]^M
>> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
>> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
>> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
>> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
>> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
>> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
>> pci_bus 0002:00: resource 5 [mem 0xd80000000-0xdffffffff]^M
>> pci_bus 0002:00: resource 6 [mem 0xc0ee00000-0xc0eefffff]^M
>>
>> bad:
>>
>> pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]^M
>> pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]^M
>> pci 0002:00:02.0: BAR 0: assigned [mem 0xc0ee00000-0xc0ee03fff 64bit]^M
>> pci 0002:00:01.0: BAR 5: assigned [mem 0xc0ee04000-0xc0ee041ff]^M
>> pci 0002:00:03.0: BAR 0: assigned [io  0x1000-0x107f]^M
>> pci 0002:00:03.0: BAR 1: assigned [mem 0xc0ee04200-0xc0ee0427f]^M
>> pci 0002:00:01.0: BAR 4: assigned [io  0x1080-0x108f]^M
>> pci 0002:00:01.0: BAR 0: assigned [io  0x1090-0x1097]^M
>> pci 0002:00:01.0: BAR 2: assigned [io  0x1098-0x109f]^M
>> pci 0002:00:01.0: BAR 1: assigned [io  0x10a0-0x10a3]^M
>> pci 0002:00:01.0: BAR 3: assigned [io  0x10a4-0x10a7]^M
>> pci_bus 0002:00: resource 4 [io  0x0000-0xffff]^M
>> pci_bus 0002:00: resource 5 [mem 0xc0ee00000-0xc0eefffff]^M
>> pci_bus 0002:00: resource 6 [mem 0xd80000000-0xdffffffff]^M
>>
>> Reverting this patch fixes the problem.
> 
> Can you please comment out the list_sort()? Seems like the precaution
> breaks your system...
> 

Yes, everything works if I re-apply your patch and comment out the
call to list_sort().

Guenter
