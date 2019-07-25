Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5787A74F3E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfGYNZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 09:25:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44835 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfGYNZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 09:25:01 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hqdjv-0000Km-SN
        for linux-pci@vger.kernel.org; Thu, 25 Jul 2019 13:25:00 +0000
Received: by mail-pl1-f198.google.com with SMTP id s21so26276783plr.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2019 06:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+mGOsIHSIvgojzqiVIoMqn5Hiap5rQc5tbZermyoDyk=;
        b=W+K4wOWq1RvqaH+yFF4FwHrSwKBqJ2eHaj0A7X4nR7OsvISvXo6skDmCtLnkMp1JVD
         J+ZCataTQRvJVBsy18g2eyQMQdAOIhY3wQN4Fl+ShPv+lyDzml0OOLFMs5sKoRXBtahi
         tyARsZweWi2fhqJgpc8cpGWAvr/fikMcvPJ46+uw5Ln5kcnzC38ZN0+oB1S07Xry3z01
         0CkE8zjuMe/+aoTV371oJfTuESRf0j8Eo/oE58ZFiwDpvJ8rddnzBlyWTVXsHEdrMqSW
         j3dxOrIcXiXAq7uWIHH4Qp1OeSwt/HIQAQ1/61nr/5HZzW1fRC01EY99fSV5nMNKBBzz
         8/Ow==
X-Gm-Message-State: APjAAAW4C5UDosOufweo6CVX036apQzPQgg8/zevV6YlgL8vXycZT6Yu
        L3zEm4+w7T585m3qHZlNvOAWfrk2sVAU1S/W5xlW1o6Nbd3e4KsjpirbJKWfNX9gcRoSK4IUsPy
        wrJ/gdV31NhD4ZWT+vimAtL9hB7xbIxm/epNfGQ==
X-Received: by 2002:a65:4189:: with SMTP id a9mr59584986pgq.399.1564061098010;
        Thu, 25 Jul 2019 06:24:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMUyU+EaKbPj1yIaEmIYCB6carFRTPp7nW+CrQ1LapqUpkzRxF0k2lyRoNULULXOf94ddBSg==
X-Received: by 2002:a65:4189:: with SMTP id a9mr59584960pgq.399.1564061097591;
        Thu, 25 Jul 2019 06:24:57 -0700 (PDT)
Received: from 2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net (2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:160:ac1c:9209:b8ff])
        by smtp.gmail.com with ESMTPSA id e124sm80634112pfh.181.2019.07.25.06.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:24:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <8113f4a4-e96e-9b73-cd7a-1dbb800d68bb@linux.intel.com>
Date:   Thu, 25 Jul 2019 21:24:53 +0800
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <203745C2-85AF-4A37-8628-636632D14564@canonical.com>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
 <1562759399.5312.6.camel@suse.com> <87pnm6sd10.fsf@linux.intel.com>
 <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
 <87blxqs3fh.fsf@linux.intel.com>
 <749516DB-65B6-4D59-8C77-7883649D1F25@canonical.com>
 <8113f4a4-e96e-9b73-cd7a-1dbb800d68bb@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 22:45, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:

> On 22.7.2019 12.44, Kai-Heng Feng wrote:
>>>>>>> Hi Mika and Mathias,
>>>>>>>
>>>>>>> I’ve filed a bug [1] which renders docking station unusable.
>>>>>>>
>>>>>>> I am not sure it's a bug in PCI, Thunderbolt or xHCI so raise the  
>>>>>>> issue
>>>>>>> to
>>>>>>> you both.
>>>>>>>
>>>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203885
>>>>>>>
>>>>>>> Kai-Heng
>>>>
>>>> I upgraded the system firmware, TBT firmware and docking station  
>>>> firmware
>>>> to latest, and used latest mainline kernel.
>>>> Now the issue can be reproduced at the very first time I plugged the
>>>> docking station.
>> Request log attached to Bugzilla.
>
> After docking station unplug we see Transfer errors from
> devices connected to Titan Ridge xHC, driver tries to recover, fails,
> usb devices are disconnected.
>
> After this xhci driver runtime suspends xHC controller as runtime pm is  
> allowed
> by default for Titan Ridge xHC controllers.
>
> Interesting parts from log:
>
>>>> Unplug Docking Station <<<
>
> [  328.102279] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on  
> endpoint
> [  328.118279] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on  
> endpoint
> [  328.134291] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on  
> endpoint
> [  328.150355] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on  
> endpoint
> [  328.166342] xhci_hcd 0000:39:00.0: Transfer error for slot 36 ep 6 on  
> endpoint
> [  332.178710] usb usb4-port2: Cannot enable. Maybe the USB cable is bad?
> [  332.178765] usb 4-2: USB disconnect, device number 35
> [  332.178769] usb 4-2.3: USB disconnect, device number 36
> [  332.179973] usb 4-2.4: USB disconnect, device number 37
> [  332.414618] xhci_hcd 0000:39:00.0: set port remote wake mask, actual  
> port 0 status  = 0xe0002a0
> [  332.414639] xhci_hcd 0000:39:00.0: set port remote wake mask, actual  
> port 1 status  = 0xe0002b0
> [  332.414693] xhci_hcd 0000:39:00.0: xhci_hub_status_data: stopping port  
> polling.
> [  332.414703] xhci_hcd 0000:39:00.0: xhci_suspend: stopping port polling.
> [  332.414719] xhci_hcd 0000:39:00.0: // Setting command ring address to  
> 0x487da9001
>
>>>> Plug Docking Station <<<
>
> [  346.455568] pci_raw_set_power_state: 25 callbacks suppressed
> [  346.455574] xhci_hcd 0000:39:00.0: Refused to change power state,  
> currently in D3
> [  346.539451] xhci_hcd 0000:39:00.0: enabling device (0000 -> 0002)
> [  346.539482] xhci_hcd 0000:39:00.0: // Setting command ring address to  
> 0x487da903f
> [  346.539487] xhci_hcd 0000:39:00.0: WARN: xHC restore state timeout
> [  346.539489] xhci_hcd 0000:39:00.0: PCI post-resume error -110!
> [  346.539490] xhci_hcd 0000:39:00.0: HC died; cleaning up
>
>>>> We don't have 0000:39:00 anymore <<<
>
> When docking station is plugged back we try to resume Titan Ridge xHC,
> PCI log shows that changing power state to D0 failed, xHC is still in D3.
> Resume process continues anyway, and xhci driver tries to restore state,  
> but fails.
> Usb core will assume HC died if the pci resume callback failed
>
> Does disabling runtime PM for Titan Ridge xHC help?

Yes, disabling runtime PM can workaround this issue.

Kai-Heng

>
> -Mathias


