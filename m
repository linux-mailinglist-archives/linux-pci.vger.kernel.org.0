Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC292753A
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 06:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfEWEjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 00:39:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEWEjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 00:39:31 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hTfVo-0006qM-TB
        for linux-pci@vger.kernel.org; Thu, 23 May 2019 04:39:29 +0000
Received: by mail-pl1-f199.google.com with SMTP id b69so2718188plb.9
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2019 21:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N2Cryd12l6XdE1v5HeEzZ2LEH60y6s0KvcwUQwn47uU=;
        b=dsvyjFl4kNXJZt8oQHUQuI4eFsNBb9IOBc1EY/PYIRjg3mIULJpjk9hOXt7XGG8LN8
         i9SlB4OReFdKjxeywE+ak/MkXLF3iazWsVvwLbzZRAVTKcoiRBjWgwC+SvqYuS0rJlVa
         vVSjLJ3qNcGGJAHmXBGKYhFdI4hNWML7ZW0o2sjS6pgNrdU/8DbowORzi90XNZOs9pXO
         aGIynjdHJSbTS3o98dVQDpbkr6fN5ejIYwCzDNtEvjmoUARqprmRd3OcfEg/FoDQfkR2
         KepfFW1YVY94bHpxpbv9wn7XLNOdaz4JCvoRDAM2vZdy8+LSOIF3HIw9wL553IgQ0Sfc
         /+UA==
X-Gm-Message-State: APjAAAUcBSo/ofEXtqYMal3J4aduBxcPKRuZXJUght6rsq8nHe0i3Nv5
        tf/dzViVZA9qaLsDK+CJeU5WV7o7fQirW/9EmTzUto+fSBvPBChMFzu/So6SMUW/C7J+RrakKaz
        CABsQQAWiDZkP3EprS2floMsj1qpPbuwa9Z2XeA==
X-Received: by 2002:a62:128a:: with SMTP id 10mr100194244pfs.225.1558586367562;
        Wed, 22 May 2019 21:39:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrPG0z1duPKpO4cbTDxCLxWSzIR/wnV9OiZUrJRE/swS+01DwEmV0AvQYR5l0wVqtiIlfTWw==
X-Received: by 2002:a62:128a:: with SMTP id 10mr100194206pfs.225.1558586367174;
        Wed, 22 May 2019 21:39:27 -0700 (PDT)
Received: from 2001-b011-380f-14b9-35e2-b960-d580-9726.dynamic-ip6.hinet.net (2001-b011-380f-14b9-35e2-b960-d580-9726.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:35e2:b960:d580:9726])
        by smtp.gmail.com with ESMTPSA id s137sm39984426pfc.119.2019.05.22.21.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 21:39:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only supports
 wakeup from D0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190522205231.GD79339@google.com>
Date:   Thu, 23 May 2019 12:39:23 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <010C1D41-C66D-45C0-8AFF-6F746306CE29@canonical.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
 <20190522205231.GD79339@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 04:52, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, May 22, 2019 at 02:39:56PM -0400, Alan Stern wrote:
>> On Wed, 22 May 2019, Bjorn Helgaas wrote:
>>> On Wed, May 22, 2019 at 11:46:25PM +0800, Kai Heng Feng wrote:
>>>>> On May 22, 2019, at 9:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
>>>>>> at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
>>>>>>>> There's an xHC device that doesn't wake when a USB device gets  
>>>>>>>> plugged
>>>>>>>> to its USB port. The driver's own runtime suspend callback was  
>>>>>>>> called,
>>>>>>>> PME signaling was enabled, but it stays at PCI D0.
>>>
>>>>> ...
>>>>> And I guess this patch basically means we wouldn't call the driver's
>>>>> suspend callback if we're merely going to stay at D0, so the driver
>>>>> would have no idea anything happened.  That might match
>>>>> Documentation/power/pci.txt better, because it suggests that the
>>>>> suspend callback is related to putting a device in a low-power state,
>>>>> and D0 is not a low-power state.
>>>>
>>>> Yes, the patch is to let the device stay at D0 and don’t run driver’s  
>>>> own
>>>> runtime suspend routine.
>>>>
>>>> I guess I’ll just proceed to send a V2 with updated commit message?
>>>
>>> Now that I understand what "runtime suspended to D0" means, help me
>>> understand what's actually wrong.
>>
>> Kai's point is that the xhci-hcd driver thinks the device is now in
>> runtime suspend, because the runtime_suspend method has been executed.
>> But in fact the device is still in D0, and as a result, PME signalling
>> may not work correctly.
>
> The device claims to be able to signal PME from D0 (this is from the lspci
> in https://bugzilla.kernel.org/show_bug.cgi?id=203673):
>
>   00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller (rev 20) (prog-if 30 [XHCI])
>     Capabilities: [50] Power Management version 3
>       Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>
> From the xHCI spec r1.0, sec 4.15.2.3, it looks like a connect
> detected while in D0 should assert PME# if enabled (and WCE is set).

I think section 4.15.2.3 is about S3 wake up, no S0 we are discussing here.

>
>> On the other hand, it wasn't clear from the patch description whether
>> this actually causes a problem on real systems.  The description only
>> said that the problem was theoretical.
>
> Kai did say nothing happens when hot-adding a USB device, so I think
> there really is a problem.  This should be an obvious problem that
> lots of people would trip over, so I expect there should be reports in
> launchpad, etc.  I'd really like to have those bread crumbs.  Kai, can
> you add a complete dmesg log to the bugzilla?  Hints from the log,
> like the platform name, can help find related reports.

It’s a platform in development so the name can’t be disclosed.

>
>>> The PCI core apparently *does* enable PME when we "suspend to D0".
>>> But somehow calling the xHCI runtime suspend callback makes the
>>> driver unable to notice when the PME is signaled?
>>
>> According to Kai, PME signalling doesn't work in D0 -- or at least,
>> it is _documented_ not to work in D0 -- even though it is enabled
>> and the device claims to support it.
>
> I didn't understand this part.  From a PCI perspective, PME signaling
> while in D0 is an optional feature and should work if the device
> advertises support for it.  If it doesn't work on this device, we
> should have a quirk to indicate that.

The only document I can find is the "Device Working State D0” from Microsoft.
It says:
"As a best practice, the driver should configure the device to generate  
interrupts only when the device is in D0, and to generate wake signals only  
when the device is in a low-power Dx state.”

Wake-up capability
Not applicable.

Unfortunately PCI spec isn’t publicly available so I can only refer to  
Microsoft document.

>
> But I thought Kai said the device *can* signal PME from D0, but for
> some reason we don't handle it correctly if we have called the xHCI
> suspend callback.

Sorry, what I meant is PME signaling is enabled, i.e.
"Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-“

But no signal was actually regenerated when USB device gets plugged to the  
port.
So there’s no wake up event to let PCI know it should runtime resume the  
device.

>
> That's the part I don't understand.  Is this an xHCI driver issue?
> Should the suspend callback do something different if we're staying in
> D0?  I'm not sure the callback even knows what Dx state we're going
> to.

As there’s no PME signal to wakeup event to signal PCI to runtime resume, I  
don’t think it’s an xHCI bug.

Kai-Heng

