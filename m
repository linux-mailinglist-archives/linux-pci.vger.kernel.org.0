Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8A54F2E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfFYMqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:46:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13420 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFYMqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 08:46:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1217b30000>; Tue, 25 Jun 2019 05:46:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 05:46:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Jun 2019 05:46:45 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 12:46:42 +0000
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <1668247.RaJIPSxJUN@kreacher>
 <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
 <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
 <2287147.DxjcvLeq6l@kreacher>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f233d8fe-9525-05de-858d-e7456a17bd4b@nvidia.com>
Date:   Tue, 25 Jun 2019 13:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2287147.DxjcvLeq6l@kreacher>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561466803; bh=d78HqQ20KZYrh16yH9/J+FHIlCtyikzMQuzoMFGmiZ8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l6Hj3sj1CPlhmy+nhIdEC99hzmnMz5t9L7LDhKbLJrRoADGMrkeKX1Ancf8uVfE2y
         i2I5e/QuH3FvPzdYHjvHq/MILicIhcKLJJS/hmuB3v7zZkc9nSrTlKTjK8vcDqKgQ2
         eLLwBFgEUMsICRW0f2Qf1x/V6PFYIgQtzfEGr78eZCEu4OUbtgQSzhIOskynqqzan6
         c4KJbKi8ARv2Ul9EY6ifldM2+oN5dMi0Dd07jdrHwMSIYCDt9JrdxYOe0UF7V3LaJ7
         0rhK0ZUab5ZNeHQeZYYEYQ8yv0BiE7Yp9OdswcR7quJ0CffG5CheNVp6aymky1SR91
         vDS/gOpbJmfUQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 25/06/2019 00:09, Rafael J. Wysocki wrote:
> On Tuesday, June 25, 2019 12:20:26 AM CEST Rafael J. Wysocki wrote:
>> On Mon, Jun 24, 2019 at 11:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 13/06/2019 22:59, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>>>> attempted to avoid a problem with devices whose drivers want them to
>>>>> stay in D0 over suspend-to-idle and resume, but it did not go as far
>>>>> as it should with that.
>>>>>
>>>>> Namely, first of all, the power state of a PCI bridge with a
>>>>> downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
>>>>> sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
>>>>> transactions on its secondary bus), but that is not actively enforced
>>>>> during system-wide PM transitions, so use the skip_bus_pm flag
>>>>> introduced by commit d491f2b75237 for that.
>>>>>
>>>>> Second, the configuration of devices left in D0 (whatever the reason)
>>>>> during suspend-to-idle need not be changed and attempting to put them
>>>>> into D0 again by force is pointless, so explicitly avoid doing that.
>>>>>
>>>>> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>
>>>> I have noticed a regression in both the mainline and -next branches on
>>>> one of our boards when testing suspend. The bisect is point to this
>>>> commit and reverting on top of mainline does fix the problem. So far I
>>>> have not looked at this in close detail but kernel log is showing ...
>>>
>>> Can you please collect a log like that, but with dynamic debug in
>>> pci-driver.c enabled?
>>>
>>> Note that reverting this commit is rather out of the question, so we
>>> need to get to the bottom of the failure.
>>
>> I suspect that there is a problem with the pm_suspend_via_firmware()
>> check which returns 'false' on the affected board, but the platform
>> actually removes power from devices left in D0 during suspend.
>>
>> I guess it would be more appropriate to check something like
>> pm_suspend_no_platform() which would return 'true' in the
>> suspend-to-idle patch w/ ACPI.
> 
> So I wonder if the patch below makes any difference?

Thanks. I will try this now and let you know.

Cheers!
Jon

-- 
nvpublic
