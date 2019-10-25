Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81BE4A9E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfJYL6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 07:58:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15731 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393497AbfJYL6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 07:58:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db2e36e0000>; Fri, 25 Oct 2019 04:58:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Oct 2019 04:58:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Oct 2019 04:58:34 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 11:58:33 +0000
Received: from [10.25.74.2] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 11:58:30 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Thierry Reding <treding@nvidia.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
 <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
 <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
 <afa16546-e63d-6eba-8be0-8e52339cd100@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <aed391af-f54c-c25e-43b9-ed9db01bd3cf@nvidia.com>
Date:   Fri, 25 Oct 2019 17:28:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <afa16546-e63d-6eba-8be0-8e52339cd100@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572004718; bh=IlDlcHct4/oq8rGYrubP5GYHoA3BlKdtsEE8gkKZRKM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dTQQnRakehi+GYBdyocVxDceZSLOHqx+7sxO60bvM5oKUwEXoe/LtN4WnIG0WrAq+
         +EDeRDl6kZcdSz68bjNxXX7u/6Y9dR+HWDLAdkSTctU9PIyCElN0FeEHN0qDEHst9G
         1i18y5+89LpohtpbhVvYi4kBwzOH72GDQlkzQIqEJ6Inc+OleG7eXznuj1UNhic5YQ
         CiwBmbYJSpojGeF7me93YvxDWHd7g6vilrzLClKd/kYUCxgYBaCRh7FFYl7ddvny35
         hOU+sAdkSOlB9UoE3MI0/k1rSzvewknkpo8ELxq/+lpVWV5rszpxSRhNIb5iQDV1RP
         ckpS1njanB9og==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/21/2019 11:13 AM, Vidya Sagar wrote:

Hi Sinan / Rafael,
Apologies for the ping again.
Do you guys have any further comments on this?

-Vidya Sagar

> On 10/15/2019 5:44 PM, Vidya Sagar wrote:
>=20
> Hi Sinan / Rafael,
> Do you have any further comments on this patch?
>=20
> - Vidya Sagar
>=20
>> On 10/15/2019 4:40 PM, Sinan Kaya wrote:
>>> +Rafael
>>>
>>> On 10/15/2019 2:30 AM, Thierry Reding wrote:
>>>> Vidya, can you clarify for which device you're seeing the issues? Soun=
ds
>>>> like adding a call to pci_pm_reset() (via pci_reset_function()) at som=
e
>>>> point.
>>>>
>>>> Sinan, it looks as if pci_pm_reset() (or any of its callers) is not us=
ed
>>>> very widely. Is that just because most drivers haven't had a need for =
it
>>>> yet? Or am I missing some core functionality that calls this for every
>>>> device anyway?
>>>
>>> pci_pm_reset() is there as an alternative reset path. We are not
>>> supposed to call this function. Sorry for giving you wrong direction
>>> here. pci_reset_function() should call it only if there is no other
>>> suitable reset function is found.
>>>
>>> I think the PCI core should be putting the device back D0 state as one
>>> of the first actions before enumerating. Wake up could be a combination
>>> of ACPI and/or PCI wake up depending on where your device sits in the
>>> topology.
>> Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
>> But, what is confusing to me is the order of the calls.
>> pci_power_up() has following calls in the same order.
>> =A0=A0=A0=A0=A0pci_raw_set_power_state(dev, PCI_D0);
>> =A0=A0=A0=A0=A0pci_update_current_state(dev, PCI_D0);
>> But, pci_raw_set_power_state() is accessing config space without calling
>> pci_device_is_present() whereas pci_update_current_state() which is call=
ed
>> later in the flow is calling pci_device_is_present()...!
>>
>>>
>>> On the other hand, wake up code doesn't perform the CRS wait. CRS
>>> wait is deferred until the first vendor id read in pci_scan_device().
>>> I see that it already waits for 60 seconds.
>>>
>>> Going back to the patch...
>>>
>>> I think we need to find the path that actually needs this sleep and
>>> put pci_dev_wait() there.
>> Following is the path in resume() flow.
>> [=A0=A0 36.380726] Call trace:
>> [=A0=A0 36.383270]=A0 dump_backtrace+0x0/0x158
>> [=A0=A0 36.386802]=A0 show_stack+0x14/0x20
>> [=A0=A0 36.389749]=A0 dump_stack+0xb0/0xf8
>> [=A0=A0 36.393451]=A0 pci_update_current_state+0x58/0xe0
>> [=A0=A0 36.398178]=A0 pci_power_up+0x60/0x70
>> [=A0=A0 36.401672]=A0 pci_pm_resume_noirq+0x6c/0x130
>> [=A0=A0 36.405669]=A0 dpm_run_callback.isra.16+0x20/0x70
>> [=A0=A0 36.410248]=A0 device_resume_noirq+0x120/0x238
>> [=A0=A0 36.414364]=A0 async_resume_noirq+0x24/0x58
>> [=A0=A0 36.418364]=A0 async_run_entry_fn+0x40/0x148
>> [=A0=A0 36.422418]=A0 process_one_work+0x1e8/0x360
>> [=A0=A0 36.426525]=A0 worker_thread+0x40/0x488
>> [=A0=A0 36.430201]=A0 kthread+0x118/0x120
>> [=A0=A0 36.433843]=A0 ret_from_fork+0x10/0x1c
>>
>>>
>>> +++ b/drivers/pci/pci.c
>>> @@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
>>>
>>> =A0=A0=A0=A0=A0 if (pci_dev_is_disconnected(pdev))
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
>>> -=A0=A0=A0 return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v=
, 0);
>>> +=A0=A0=A0 return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v=
,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCI_CR=
S_TIMEOUT);
>>> =A0 }
>>>
>>> pci_device_is_present() is a too low-level function and it may not
>>> be allowed to sleep. It uses 0 as timeout value.
>>>
>>>
>>
>=20

