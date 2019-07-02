Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22A5CC01
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGBI0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 04:26:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45493 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGBI0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2019 04:26:16 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hiE7C-0007Qy-TS
        for linux-pci@vger.kernel.org; Tue, 02 Jul 2019 08:26:15 +0000
Received: by mail-wm1-f69.google.com with SMTP id w126so561395wmb.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2019 01:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=trl/WIaWKJT6HVXal0DvRqg1PD1vdTs1Z0wlP41mFoI=;
        b=E7jL7L64A5dLg6TmM0grz+zGdN63OA8q3Fyq6JxgwFgepaguXrm/OMUWitO7+gNplf
         ZM4hBqampaR5sZ1lvdtjBoZWsk2NwSu8P7n+BuT5Yoe+2n0NE1iSdkRVABo7WoPm/Kcy
         A6RWVtbMiNbF3oKMtojqZnOTyxfufc3EBDIJn2FW9mR/MaWZLeuttnw3ZoDVHj2Btj+a
         HDkIdlUJLx9fDW2aJpJx7pTuq0AZ+ioR4sgZvqw+WUd6v+ebqbbEld1LlfcQhL7ei/8f
         X8pVEPCL15iTBaTY/s9FlEN61M6bYGucufYH1ivpzg4tWtdUm1WBpLY70oSgMW7BQdvG
         Vw2g==
X-Gm-Message-State: APjAAAX/jFN4rz1135MTUBYrxLQzzLtTXEmnU1D9hKFjAkqzNhApGI2D
        BJhVMbyWL7H/x+d/XR3YTCdJoBCK4tJKO/YuGdrD7Pxu/Ylux3rSv6A8eoE9Rp2fy5rfCgsoCTN
        TYN1esHJqq9eU32JiwWLmkaZNE/AIgov8vdVbTA==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr12785078wru.311.1562055974599;
        Tue, 02 Jul 2019 01:26:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+FTyT/cxUiGg2GivGHqjxcLBglyyxVajY50jh2Isvt0G30XDYj+xriC7qEnS0qKyUqyM0aw==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr12785044wru.311.1562055974297;
        Tue, 02 Jul 2019 01:26:14 -0700 (PDT)
Received: from [10.101.46.178] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id z1sm13636806wrv.90.2019.07.02.01.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:26:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
Date:   Tue, 2 Jul 2019 16:25:59 +0800
Cc:     jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <E29A2CD2-1632-4575-9910-0808BD15F4D3@canonical.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
 <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
 <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-pci

Hi Sasha,

at 6:49 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> at 14:26, Neftin, Sasha <sasha.neftin@intel.com> wrote:
>
>> On 6/26/2019 09:14, Kai Heng Feng wrote:
>>> Hi Sasha
>>> at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> Hi Jeffrey,
>>>>
>>>> We’ve encountered another issue, which causes multiple CRC errors and  
>>>> renders ethernet completely useless, here’s the network stats:
>>> I also tried ignore_ltr for this issue, seems like it alleviates the  
>>> symptom a bit for a while, then the network still becomes useless after  
>>> some usage.
>>> And yes, it’s also a Whiskey Lake platform. What’s the next step to  
>>> debug this problem?
>>> Kai-Heng
>> CRC errors not related to the LTR. Please, try to disable the ME on your  
>> platform. Hope you have this option in BIOS. Another way is to contact  
>> your PC vendor and ask to provide NVM without ME. Let's start debugging  
>> with these steps.
>
> According to ODM, the ME can be physically disabled by a jumper.
> But after disabling the ME the same issue can still be observed.

We’ve found that this issue doesn’t happen to SATA SSD, it only happens  
when NVMe SSD is in use.

Here are the steps:
- Disable NVMe ASPM, issue persists
- modprobe -r e1000e && modprobe e1000e, issue doesn’t happen
- Enabling NVMe ASPM, issue doesn’t happen

As long as NVMe ASPM gets enabled after e1000e gets loaded, the issue  
doesn’t happen.

Do you have any idea how those two are intertwined together?

Kai-Heng

>
> Kai-Heng
>
>>>> /sys/class/net/eno1/statistics$ grep . *
>>>> collisions:0
>>>> multicast:95
>>>> rx_bytes:1499851
>>>> rx_compressed:0
>>>> rx_crc_errors:1165
>>>> rx_dropped:0
>>>> rx_errors:2330
>>>> rx_fifo_errors:0
>>>> rx_frame_errors:0
>>>> rx_length_errors:0
>>>> rx_missed_errors:0
>>>> rx_nohandler:0
>>>> rx_over_errors:0
>>>> rx_packets:4789
>>>> tx_aborted_errors:0
>>>> tx_bytes:864312
>>>> tx_carrier_errors:0
>>>> tx_compressed:0
>>>> tx_dropped:0
>>>> tx_errors:0
>>>> tx_fifo_errors:0
>>>> tx_heartbeat_errors:0
>>>> tx_packets:7370
>>>> tx_window_errors:0
>>>>
>>>> Same behavior can be observed on both mainline kernel and on your  
>>>> dev-queue branch.
>>>> OTOH, the same issue can’t be observed on out-of-tree e1000e.
>>>>
>>>> Is there any plan to close the gap between upstream and out-of-tree  
>>>> version?
>>>>
>>>> Kai-Heng


