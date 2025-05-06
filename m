Return-Path: <linux-pci+bounces-27299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509DAAD069
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 23:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94B63BCF3B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2D21885A;
	Tue,  6 May 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K81+nF7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4B2153DA
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568307; cv=none; b=t8YqOleKTZXywM594qluoPD/sSHhTQlw2cnAyiZrBfbTepV8a9DDV/w+AHH088VVjaLnYd3OXFAYQWD+gC7GxHcGA6OPKbU/EOM5+XEFMpwPo2oe3irCk6Ljdrc0g/VaxiSptqq4urANLkmqNzTrGatZSZ0ARW5WHd0uptWJ5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568307; c=relaxed/simple;
	bh=Tu6OY0COwpJ/B107l5phrJHddSlA7r/Gra+adhvlXXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgC15ThpLk8neXyYFIEt4ufVv3Dc8tL3RpHze7cQHOMwfhRJ+KkCmDsWgOKLfVQSSfIrBXBQfUtURNmUDXaJ1PXwq39yq8WLJPDPIWS3RWKOvRPKlxWP65AzupOrAfHRhKJj/0XxBKrLCORwxzYFTDjXH7tXgRKbdsDKDUwqFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K81+nF7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383D9C4CEE4;
	Tue,  6 May 2025 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568307;
	bh=Tu6OY0COwpJ/B107l5phrJHddSlA7r/Gra+adhvlXXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K81+nF7cQmPxfwl7EXyXrwRvTL+chvLptfiq6JVwv3/KlajtS2oASzzaURp/Jm6xg
	 Gk4xlsjHgmZOkmPZJBeICCJFhMTXrytgzvxbv+MHXpR1J2glOZDSEiLYmvSr0HqSKm
	 kVrnuf1+hIVXfO2jRVRq33srpy7ttPt7ieoHas+iUey9aRKJF6JztNM6SwJKufeHRx
	 kM+2o8EpmDj7qCy2i4+jGpgt8SBEjhpxo2FaAJ5B5R2I/k9YS/n3wq1cm0PS6475tQ
	 /ovsGMCVHuVKebgLGQHFrxywk523HzBurLanfiJ6ET4I/f44sIPpq5m874tG1saA9x
	 bMbd7NpKZ0wDw==
Message-ID: <ca936e18-619c-4faf-93ed-cafbe86f70bf@kernel.org>
Date: Tue, 6 May 2025 16:51:44 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>, bhelgaas@google.com,
 AceLan Kao <acelan.kao@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Denis Benato <benato.denis96@gmail.com>, =?UTF-8?Q?Merthan_Karaka=C5=9F?=
 <m3rthn.k@gmail.com>, linux-pci@vger.kernel.org
References: <20250506041934.1409302-1-superm1@kernel.org>
 <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
 <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
 <CAJZ5v0g8uYM2RE+VteviK_1zCxk-rRV=JQMcnF4Gvr6frEn4iA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0g8uYM2RE+VteviK_1zCxk-rRV=JQMcnF4Gvr6frEn4iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/2025 2:30 PM, Rafael J. Wysocki wrote:
> On Tue, May 6, 2025 at 7:32 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 5/6/2025 10:50 AM, Rafael J. Wysocki wrote:
>>> On Tue, May 6, 2025 at 6:19 AM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> From: Kai-Heng Feng <kaihengf@nvidia.com>
>>>>
>>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>>> connected.
>>>>
>>>> The following error message can be found during shutdown:
>>>> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
>>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>>>> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>>
>>>> Calling aer_remove() during shutdown can quiesce the error message,
>>>> however the spurious wakeup still happens.
>>>>
>>>> The issue won't happen if the device is in D3 before system shutdown, so
>>>> putting device to low power state before shutdown to solve the issue.
>>>>
>>>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>>>> compatible with the current Power Resource states. In other words, all
>>>> devices are in the D3 state when the system state is S4."
>>>>
>>>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>>>> state is similar to the S4 state except that OSPM does not save any
>>>> context." so it's safe to assume devices should be at D3 for S5.
>>>
>>> That's fine as long as you assume that ->shutdown() is only used for
>>> implementing ACPI S5, but it is not.
>>
>> I suppose you're meaning things like:
>>
>> kernel_restart_prepare()
>> ->device_shutdown()
>> ->->each device's shutdown() CB
>> ->->each driver's shutdown() CB
>>
>> Is there somewhere "better" to do this so it's truly only tied to S5?
> 
> On systems that use ACPI reboot is also a flavor of S5, but what about
> systems that have PCI, but don't use ACPI?
> 
> The change you are proposing is going to affect more systems than just
> the ones having the problem described in the patch changelog, so it is
> kind of risky and breaking reboot is a big deal.

How would you feel about if instead this was using one of the power off 
notifiers?  That could narrow this down to only being applied on ACPI 
systems.

Something like this (not yet tested):

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e5839..df83aed7d474c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -10,6 +10,7 @@
  #include <linux/delay.h>
  #include <linux/init.h>
  #include <linux/irqdomain.h>
+#include <linux/kexec.h>
  #include <linux/pci.h>
  #include <linux/msi.h>
  #include <linux/pci_hotplug.h>
@@ -18,6 +19,7 @@
  #include <linux/pci-ecam.h>
  #include <linux/pm_runtime.h>
  #include <linux/pm_qos.h>
+#include <linux/reboot.h>
  #include <linux/rwsem.h>
  #include "pci.h"

@@ -1438,6 +1440,16 @@ static void pci_acpi_set_external_facing(struct 
pci_dev *dev)
                 dev->external_facing = 1;
  }

+static int pci_acpi_power_off(struct sys_off_data *data)
+{
+       struct pci_dev *pci_dev = to_pci_dev(data->dev);
+
+       if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
+               pci_prepare_to_sleep(pci_dev);
+
+       return NOTIFY_DONE;
+}
+
  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
  {
         struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -1465,6 +1477,11 @@ void pci_acpi_setup(struct device *dev, struct 
acpi_device *adev)

         if (pci_is_bridge(pci_dev))
                 acpi_dev_power_up_children_with_adr(adev);
+
+       devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF_PREPARE,
+                                     SYS_OFF_PRIO_DEFAULT,
+                                     &pci_acpi_power_off, NULL);
+
  }

  void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)

> 
>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>>>> Cc: AceLan Kao <acelan.kao@canonical.com>
>>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Tested-by: Denis Benato <benato.denis96@gmail.com>
>>>> Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
>>>> Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia.com
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v3:
>>>>    * Pick up tags
>>>>    * V2 was waiting for Rafael to review, rebase on pci/next and resend.
>>>
>>> Is this change going to break kexec?
>>
>> There is an explicit check in the below code for kexec_in_progress, so
>> my expectation was that kexec kept working.  I didn't explicitly test
>> this myself when I tested KH's change before sending it again.
>>
>> KH, Did you double check that on your side?
>>
>>>
>>>> ---
>>>>    drivers/pci/pci-driver.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 0c5bdb8c2c07b..5bbe8af996390 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>>>           if (drv && drv->shutdown)
>>>>                   drv->shutdown(pci_dev);
>>>>
>>>> +       /*
>>>> +        * If driver already changed device's power state, it can mean the
>>>> +        * wakeup setting is in place, or a workaround is used. Hence keep it
>>>> +        * as is.
>>>> +        */
>>>> +       if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>>>> +               pci_prepare_to_sleep(pci_dev);
>>>> +
>>>>           /*
>>>>            * If this is a kexec reboot, turn off Bus Master bit on the
>>>>            * device to tell it to not continue to do DMA. Don't touch
>>>> --
>>


