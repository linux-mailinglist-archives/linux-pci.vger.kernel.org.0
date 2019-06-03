Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4186B33A28
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFCVuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 17:50:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35962 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCVuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 17:50:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so11366448pfm.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2019 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QXe1q2zoQhM8mrIXiP1zmtjet7FIsQQVo+jNhQzIKKY=;
        b=fuItLAVWVd3R4wiL7seEnIKyn3cimQpacQ5KyC3muYyd5ND/Anuj8lVgOcUF83Cwo/
         KYTINCBVoor6OacJJA142/HPZhJUNO37/FFKGMLA14GNOS+M1Y6P+/1XzhDfUUsmtATU
         q9Sm3TfvT6Ra9zBytNZ66mb4uaOHYAjfVEpPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QXe1q2zoQhM8mrIXiP1zmtjet7FIsQQVo+jNhQzIKKY=;
        b=EHagyad4Ok9JHsN1Ze9zfJU2X2IEHINhvwCG+rq2XKFhE7YGM/7OJHcssL/8DONZxr
         /hDrE69pyxb6Y/ay+b/voUKWs5BsJR3opY/aOZ3118DGWiXv44vDDlJYc0G7K4QSUF4O
         vBwsdipmP3cSLNBvfkbCdGRc8wvmrZ2/Uj1BZ3eD0HtTvWu3idF4GrmGx4xqdMGuwJG3
         rsxZUJF6N036LEyOAau/u4EFBQYSGijCPan22MOOfVT7VShxLeVdD1xJU7kipzb/g84U
         dBkkqkG8w0buXopRCbgirRXT+DvAMk85GTaQS3fjnfVzfnqKBTc02TBiCMErgvg6lAMb
         tydA==
X-Gm-Message-State: APjAAAUnv5ZyEfNesstm7ucWi9yadOSDXS/63HVGz+wu1oR+2NnLa9/2
        Z12ujZOpQuUQCLpmdj24FHnjL6xLGVc=
X-Google-Smtp-Source: APXvYqzFWBT/QzNj4YFy2RIkKCvg29kMSvPLG8SXnlZPedHNDkj+gC+CaVMGmB8lc4w88mXTFfVNFg==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr7751513pjg.113.1559596660707;
        Mon, 03 Jun 2019 14:17:40 -0700 (PDT)
Received: from [10.136.8.140] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o192sm9299232pgo.74.2019.06.03.14.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 14:17:39 -0700 (PDT)
Subject: Re: SSD surprise removal leads to long wait inside pci_dev_wait() and
 FLR 65s timeout
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, keith.busch@intel.com,
        bcm-kernel-feedback-list@broadcom.com,
        Lukas Wunner <lukas@wunner.de>
References: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
 <20190603004414.GA189360@google.com> <20190602194011.51ceaa23@x1.home>
From:   JD Zheng <jiandong.zheng@broadcom.com>
Message-ID: <78f95dfe-ac2b-408f-0e2a-b3b9d69575dd@broadcom.com>
Date:   Mon, 3 Jun 2019 14:17:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602194011.51ceaa23@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/2/19 6:40 PM, Alex Williamson wrote:
> On Sun, 2 Jun 2019 19:44:14 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> [+cc Alex, Lukas]
>>
>> On Fri, May 31, 2019 at 09:55:20AM -0700, JD Zheng wrote:
>>> Hello,
>>>
>>> I am running DPDK 18.11+SPDK 19.04 with v5.1 kernel. DPDK/SPDK uses SSD vfio
>>> devices and after running SPDK's nvmf_tgt, unplugging a SSD cause kernel to
>>> print out following:
>>> [  105.426952] vfio-pci 0000:04:00.0: not ready 2047ms after FLR; waiting
>>> [  107.698953] vfio-pci 0000:04:00.0: not ready 4095ms after FLR; waiting
>>> [  112.050960] vfio-pci 0000:04:00.0: not ready 8191ms after FLR; waiting
>>> [  120.498953] vfio-pci 0000:04:00.0: not ready 16383ms after FLR; waiting
>>> [  138.418957] vfio-pci 0000:04:00.0: not ready 32767ms after FLR; waiting
>>> [  173.234953] vfio-pci 0000:04:00.0: not ready 65535ms after FLR; giving up
>>>
>>> Looks like it is a PCI hotplug racing condition between DPDK's
>>> eal-intr-thread thread and kernel's pciehp thread. And it causes lockup in
>>> pci_dev_wait() at kernel side.
>>>
>>> When SSD is removed, eal-intr-thread immediately receives
>>> RTE_INTR_HANDLE_ALARM and handler calls rte_pci_detach_dev() and at kernel
>>> side vfio_pci_release() is triggered to release this vfio device, which
>>> calls pci_try_reset_function(), then _pci_reset_function_locked().
>>> pci_try_reset_function acquires the device lock but
>>> _pci_reset_function_locked() doesn't return, therefore lock is NOT released.
> 
> To what extent does vfio-pci need to learn about surprise hotplug?  My
> expectation is that the current state of the code would only support
> cooperative hotplug.  When a device is surprise removed, what backs a
> user's mmaps?  AIUI, we don't have a revoke interface to invalidate
> these.  We should probably start with an RFE or some development effort
> to harden vfio-pci for surprise hotplug, it's not surprising it doesn't
> just work TBH.  Thanks,
> 
> Alex
> 
> 

I did see other issues that DPDK unmap vifo device memory was stuck due 
to surprise removal.

Are you saying that vfio-pci surprise removal is not fully implemented yet?

>>> Inside _pci_reset_function_locked(), pcie_has_flr(), pci_pm_reset(), etc.
>>> call pci_dev_wait() at the end but it doesn't return and print out above
>>> message until 65s timeout.
>>>
>>> At kernel pciehp side, it also detects the removal but doesn't run
>>> immediately as it is configured as "pciehp.pciehp_poll_time=5". So a couple
>>> of seconds later, it calls pciehp_unconfigure_device -> pci_walk_bus ->
>>> pci_dev_set_disconnected. pci_dev_set_disconnected() couldn't get the device
>>> lock and is stuck too because the lock is hold by eal-intr-thread.
>>>
>>> The first issue is in pci_dev_wait(). It calls pci_read_config_dword() and
>>> only when id is not all ones, it can return. But when SSD is physically
>>> removed, id retrieved is always all ones therefore, it has to wait for FLR
>>> 65s timeout to return.
>>>
>>> I did the following to check return value of pci_read_config_dword() to fix
>>> this:
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4439,7 +4439,11 @@ static int pci_dev_wait(struct pci_dev *dev, char
>>> *reset_type, int timeout)
>>>
>>>                  msleep(delay);
>>>                  delay *= 2;
>>> -               pci_read_config_dword(dev, PCI_COMMAND, &id);
>>> +               if (pci_read_config_dword(dev, PCI_COMMAND, &id) ==
>>> +                   PCIBIOS_DEVICE_NOT_FOUND) {
>>> +                       pci_info(dev, "device disconnected\n");
>>> +                       return -ENODEV;
>>> +               }
>>>          }
>>>
>>>          if (delay > 1000)
>>>
>>> The second issue is that due to lock up described above, the
>>> pci_dev_set_disconnected() is stuck and pci_read_config_dword() won't return
>>> PCIBIOS_DEVICE_NOT_FOUND.
>>>
>>> I didn't find a easy way to fix it. Maybe use device lock in
>>> pci_dev_set_disconnected() is too coarse and we need a finer device
>>> err_state lock?
>>>
>>> BTW, pci_dev_set_disconnected wasn't using device lock until this change
>>> a6bd101b8f.
>>>
>>> Any suggestions to fix this problem?
>>
>> Would you mind opening a report at https://bugzilla.kernel.org and
>> attaching the complete dmesg log and "lspci -vv" output?

I submitted one as https://bugzilla.kernel.org/show_bug.cgi?id=203797

>>
>> Out of curiosity, why do you use "pciehp.pciehp_poll_time=5"?

This was chosen by other engineer. I tried shorter polling time, which 
doesn't make difference.

I also tried pciehp.pciehp_poll_mode=0 but hotplug doesn't seem working.
Should I use poll mode or not?

>>
>> Bjorn
> 
