Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C32E2E80
	for <lists+linux-pci@lfdr.de>; Sat, 26 Dec 2020 16:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgLZP1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Dec 2020 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLZP1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Dec 2020 10:27:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6EC0613C1;
        Sat, 26 Dec 2020 07:26:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c133so5585099wme.4;
        Sat, 26 Dec 2020 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xIRdlgq1jjLTt5aUq57YZH004Efua6+AzHdbtC1vjHY=;
        b=P9kztiEr24T4l16RyEqA/W1xXXJ5wEhKXg8GPBu6E1B6wmYxYSXgZdczmd5SS7Hj6T
         zCwSaXeQ0z4fpETN6Ed0ee5CpglRVp6C2oUxSEFTOTCEcwUSafxiayDQ9gLNVBSUV3Hc
         Oae93nkcXWv7VldWP8g+uT3Ci6Vf0MLtUYATh3684wA0AXABD6ssiNC+rfwT7hcEEWjm
         A4XYXyZuti0vZ3H8ucWge5x7U8lAOaA4Ww8tbHnQLsB+r72cIIZ01v/GPm65HnirgfcG
         ZzDChtbPfXOrcqlV/pTEc2CqvMNWL1Hfel/yg2ECJ2sN7VvY3PhRy8SoNKdZzMHvLWOv
         PSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xIRdlgq1jjLTt5aUq57YZH004Efua6+AzHdbtC1vjHY=;
        b=eX12yiGHQ9Kkj07CmclQXiWPKWHZuSuZL9oe4qhE9bpqFqlH7m86r8OjTFwEkcupiS
         1ierRaVxTMidgbLMF3GE9kb3m5TLd+dKgD1siWAMEaQcy0qMRtIjvWybg634JSrdN/ar
         ONKTsXnDk074Wm01qIqKT0dBjaHwY46rgHgFNZsMl/810WkJ4i9s6M0pgLpxwIelStnl
         RkP9hhVmIHFRE0shYRCT+tdAiaotVO3xRQmyWC/BlOCuP4I++4SRQVOlLrpljAT/AvBM
         jc5Ft0Oy8uNOI3Psk/P08Gur84q9zRqAJ9ZFihwAYz4zKy8g+Rat20knMmOZrrBkcS8I
         UetA==
X-Gm-Message-State: AOAM531F7wNJHoQzB/G//nC71NJO619nYmI+twedDRX3SECzaYnAGRdK
        gZ09KDYd1lgKGZMBUSCuwniG1kzXSwo=
X-Google-Smtp-Source: ABdhPJz2smZ3Xe7YlFw9TmxjjLc/qldwG3Hnw+O5Ca7Q9lfBebaCrg9aTOICYJMC2SB5q/wEoThCmg==
X-Received: by 2002:a1c:287:: with SMTP id 129mr12961595wmc.133.1608996409251;
        Sat, 26 Dec 2020 07:26:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:7d77:5a5b:aeb8:2b9f? (p200300ea8f0655007d775a5baeb82b9f.dip0.t-ipconnect.de. [2003:ea:8f06:5500:7d77:5a5b:aeb8:2b9f])
        by smtp.googlemail.com with ESMTPSA id v20sm12423907wml.34.2020.12.26.07.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 07:26:48 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b7bf02fd-c1aa-f430-524e-98922041ed81@gmail.com>
Date:   Sat, 26 Dec 2020 16:26:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.11.2020 17:57, Rafael J. Wysocki wrote:
> On Tue, Nov 17, 2020 at 5:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+to Rafael, author of the commit you mentioned,
>> +cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]
>>
>> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
>>> More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
>>> ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
>>>
>>> Reason given: "avoid breakage on systems where ACPI-based wake-up is
>>> known to fail for some devices"
>>> Unfortunately the commit message doesn't mention any affected  devices
>>> or systems.
> 
> Even if it did that, it wouldn't have been a full list almost for sure.
> 
> We had received multiple problem reports related to that, most likely
> because the ACPI PM in BIOSes at that time was tailored for
> system-wide PM transitions only.
> 

To follow up on this discussion:
We could call pm_runtime_forbid() conditionally, e.g. with the following
condition. This would enable runtime pm per default for all non-ACPI
systems, and it uses the BIOS date as an indicator for a hopefully
not that broken ACPI implementation. However I could understand the
argument that this looks a little hacky ..

if (IS_ENABLED(CONFIG_ACPI) && dmi_get_bios_year() <= 2016)



>>> With Runtime PM disabled e.g. the PHY on network devices may remain
>>> powered up even with no cable plugged in, affecting battery lifetime
>>> on mobile devices. Currently we have to rely on the respective distro
>>> or user to enable Runtime PM via sysfs (echo auto > power/control).
>>> Some devices work around this restriction by calling pm_runtime_allow
>>> in their probe routine, even though that's not recommended by
>>> https://www.kernel.org/doc/Documentation/power/pci.txt
>>>
>>> Disabling Runtime PM per default seems to be a big hammer, a quirk
>>> for affected devices / systems may had been better. And we still
>>> have the option to disable Runtime PM for selected devices via sysfs.
>>>
>>> So, to cut a long story short: Wouldn't it be time to remove this
>>> restriction?
>>
>> I don't know the history of this, but maybe Rafael or the others can
>> shed some light on it.
> 
> The systems that had those problems 10 years ago would still have
> them, but I expect there to be more systems where runtime PM can be
> enabled by default for PCI devices without issues.
> 

