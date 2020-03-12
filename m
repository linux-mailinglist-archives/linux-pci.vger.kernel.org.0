Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403CE182D18
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 11:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCLKKx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Mar 2020 06:10:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgCLKKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 06:10:53 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jCKnj-00087u-0K
        for linux-pci@vger.kernel.org; Thu, 12 Mar 2020 10:10:51 +0000
Received: by mail-pj1-f70.google.com with SMTP id d2so2832712pjz.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2020 03:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZRJ3aPtX/tUgwNDGTcOJc8iWQLaiq+vRP5xXyXiSCXA=;
        b=HP2cwuUd5oY5c1Iwp8/CmWLRNGolebmCmty2CtyQf1kXngLrBy8sheGs5QkomGynpV
         s5ugyqew4kBpay9SzuGE6ie5SCveOJdJ20zFcQR9J8g69oP8HdNyPmoIyChlyELBXymo
         jxQP2DBl/thNlhgZQM6BvmWR2TnxtIEOkwyDamrB0904kz+cCUNq4sTokvrUrXeC4R6C
         HUyve7R0PP745l+EzWoLy8aAiPThxa6C8qZrBmnNW3ahNGGe2ntArZmvHLG1vEe2xBVv
         FdihfrRve5c460pKEXWZW1glYVfMxOoD2HZtgYjIKu2c0oBOOJSdIR/LzgKBynwc/4A0
         ymYg==
X-Gm-Message-State: ANhLgQ3lphXrzykmVHtPZOLXL+S4r6DmgpX6DOKOP4BG/hyIWdHHsYyq
        jSLfKoOfu0G3Qz4oeOdVgqOcKdaRUigOiYf3A12t/q9WzkiXUf2u7tAlLYKB7unDwQvs9pi51pt
        Ur3R7F4AN/aVt9S24+EZHxSfIU6upSruPLqsPmg==
X-Received: by 2002:a62:1dd0:: with SMTP id d199mr7657898pfd.9.1584007849542;
        Thu, 12 Mar 2020 03:10:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjWarGsemdejoZoz63lHwe1W7gnmL1NQxuf/kVvqF5q1wRoQDGkCL58Pvo/UkfDFa9jyfRJg==
X-Received: by 2002:a62:1dd0:: with SMTP id d199mr7657857pfd.9.1584007849079;
        Thu, 12 Mar 2020 03:10:49 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i6sm8090133pjt.3.2020.03.12.03.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:10:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200312081509.GI2540@lahna.fi.intel.com>
Date:   Thu, 12 Mar 2020 18:10:45 +0800
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C687BE86-1CCB-417B-8546-77F76127B266@canonical.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
 <20200311103840.GB2540@lahna.fi.intel.com>
 <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
 <20200312081509.GI2540@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Mar 12, 2020, at 16:15, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Thu, Mar 12, 2020 at 12:41:08PM +0800, Kai-Heng Feng wrote:
>> 
>> 
>>> On Mar 11, 2020, at 18:38, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>>> 
>>> On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
>>>> Hi,
>>>> 
>>>> I am currently investigating long suspend and resume time of suspend-to-idle.
>>>> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
>>>> 
>>>> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
>>>> 
>>>> 	/* Avoid direct_complete to let wakeup_path propagate. */
>>>> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
>>>> 			dev->power.direct_complete = false;
>>> 
>>> You need to be careful here because otherwise you end up situation where
>>> the link is not properly trained and we tear down the whole tree of
>>> devices which is worse than waiting bit more for resume.
>> 
>> My idea is to direct-complete when there's no PCI or USB device
>> plugged into the TBT, and use pm_reuqest_resume() in complete() so it
>> won't block resume() or resume_noirq().
> 
> Before doing that..
> 
>>>> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
>>>> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
>>>> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
>>>> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
>>>> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...
>>> 
>>> Which system this is? ICL?
>> 
>> CML-H + Titan Ridge.
> 
> .. we should really understand this better because CML-H PCH root ports
> and Titan/Alpine Ridge downstream ports all support active link
> reporting so instead of the 1000+100ms you should see something like
> this:

Root port for discrete graphics:
# lspci -vvnn -s 00:01.0                    
00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 02) (prog-if 00 [Normal decode])
        Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
                LnkCap: Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
   
Thunderbolt ports:
# lspci -vvvv -s 04:00
04:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
        Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

# lspci -vvnn -s 04:01
04:01.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
        Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
                LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

# lspci -vvnn -s 04:02 
04:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06) (prog-if 00 [Normal decode])
        Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
                LnkCap: Port #2, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

So both CML-H PCH and TBT ports report "LLActRep-".

> 
>  1. Wait for the link + 100ms for the root port
>  2. Wait for the link + 100ms for the Titan Ridge downstream ports
>    (these are run paraller wrt all Titan Ridge downstream ports that have
>     something connected)
> 
> If there is a TBT device connected then 2. is repeated for it and so on.
> 
> So the 1000ms+ is really unexpected. Are you running mainline kernel and
> if so, can you share dmesg with CONFIG_PCI_DEBUG=y so we can see the
> delays there? Maybe also add some debugging to
> pcie_wait_for_link_delay() where it checks for the
> !pdev->link_active_reporting and waits for 1100ms.

I added the debug log in another thread and it does reach !pdev->link_active_reporting.

Let me see if patch link active reporting for the ports in PCI quirks can help.

Kai-Heng

