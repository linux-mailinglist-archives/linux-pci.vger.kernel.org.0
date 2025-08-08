Return-Path: <linux-pci+bounces-33600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D74B1E09D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53CFC4E042D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223DB8F54;
	Fri,  8 Aug 2025 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HJfM8wTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449B7FD
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619856; cv=none; b=Tnf7TtkcokJNa98TvWwEBCsWJOcPlqOki4cFA+ZzVhjE2P+kRgKeaudM07mOTYwO79lutfoRhwoJlvL57oz3f4/WI/5BoIQnHlJSbeqkoj7fegxF0Y2I41GxM/68iABP+YcZhoiLNpbZm/pC2LkmyLCQyvh7lXrrx3G0vMvFk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619856; c=relaxed/simple;
	bh=mPdkbdQ1XL+tYvNwmgwuEXApYcWpe0msTWv5intRzio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iqZcVJNBABt2PgHy/no8O3TYXtmjbtBampx9CMH+YhoS+8MSO1ZwBPVkUYrvAQyLItnt6yJTc2vTLQbQ5GZEMui8W3NsxY8BexVSb2NlcYC4LJqYjOvxxjRG/3DL6jMhv6sdcgklSHMqjphUHKh/aSpUuCF413O+Q+ShMKPyiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HJfM8wTY; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.195.16] (1.general.hwang4.uk.vpn [10.172.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CB4FD3F5DB;
	Fri,  8 Aug 2025 02:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1754619843;
	bh=FLqjm27CDnVEDi7U/MuIo5LBLmMTJZ01gOl1gMIqYYQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type;
	b=HJfM8wTYRwLy2t978dFRyEnLrP77isT2R9xnqWcndMLPFz1Gaf88OLY/al0LaOQgT
	 js9dM2HJ2qVql9V8PPC1Py1ifVHwTI7TK0NUpw27mxXel4Qwy5nl37HKTrDJ8zPG+o
	 Gj6yHJkPjLbIJ+H83zudXP78ZHOFpTL1K3bLVfuj3s5zmLlxjH31RKVtAnmqHzJM+T
	 xdYOR+F9BOt3vJz7tgJNbQgYRVCsMTlfh2ASVqLDWBcVis14IPi5Nx8EMcS1fcCf/e
	 VYKyyz2Q2NEnpGdSRSN6pZQdcxpP62rN/FK3H9+Zj81Sc46pGLbSkZkxxrBj5jl3sF
	 ioK/j1s2AH7tQ==
Message-ID: <16f95861-6e71-49e4-b8f5-6d874e7db700@canonical.com>
Date: Fri, 8 Aug 2025 10:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
From: Hui Wang <hui.wang@canonical.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
 suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>
References: <20250701232341.GA1859056@bhelgaas>
 <13f6c7df-9fd8-4ef4-b900-9a5173c5967f@canonical.com>
 <eae31738-5d5d-4c74-af1c-66168c36ead5@canonical.com>
Content-Language: en-US
In-Reply-To: <eae31738-5d5d-4c74-af1c-66168c36ead5@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Any progress on this issue, do we have a fix for this now? The ubuntu 
users are waiting for a fix :-).

Thanks,

Hui.


On 7/3/25 08:05, Hui Wang wrote:
>
> On 7/2/25 17:43, Hui Wang wrote:
>>
>> On 7/2/25 07:23, Bjorn Helgaas wrote:
>>> On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
>>>> Sorry for late response, I was OOO the past week.
>>>>
>>>> This is the log after applied your patch:
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61 
>>>>
>>>>
>>>> Looks like the "retry" makes the nvme work.
>>> Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
>>> a long time after we think the device should be able to respond with
>>> RRS.
>>>
>>> I always thought the spec required that after the delays, a device
>>> should respond with RRS if it's not ready, but now I guess I'm not
>>> 100% sure.  Maybe it's allowed to just do nothing, which would lead to
>>> the Root Port timing out and logging an Unsupported Request error.
>>>
>>> Can I trouble you to try the patch below?  I think we might have to
>>> start explicitly checking for that error.  That probably would require
>>> some setup to enable the error, check for it, and clear it.  I hacked
>>> in some of that here, but ultimately some of it should go elsewhere.
>>
>> OK, built a testing kernel, wait for bug reporter to test it and 
>> collect the log.
>>
> This is the testing result and log. 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/65
>
>
>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index e9448d55113b..c276d0a2b522 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1264,10 +1264,13 @@ void pci_resume_bus(struct pci_bus *bus)
>>>     static int pci_dev_wait(struct pci_dev *dev, char *reset_type, 
>>> int timeout)
>>>   {
>>> -    int delay = 1;
>>> +    int delay = 10;
>>>       bool retrain = false;
>>>       struct pci_dev *root, *bridge;
>>> +    u16 devctl, devsta;
>>>   +    pci_info(dev, "%s: VF%c %s timeout %d\n", __func__,
>>> +         dev->is_virtfn ? '+' : '-', reset_type, timeout);
>>>       root = pcie_find_root_port(dev);
>>>         if (pci_is_pcie(dev)) {
>>> @@ -1276,6 +1279,19 @@ static int pci_dev_wait(struct pci_dev *dev, 
>>> char *reset_type, int timeout)
>>>               retrain = true;
>>>       }
>>>   +    if (root) {
>>> +        pcie_capability_read_word(root, PCI_EXP_DEVCTL, &devctl);
>>> +        if (!(devctl & PCI_EXP_DEVCTL_URRE))
>>> +            pcie_capability_write_word(root, PCI_EXP_DEVCTL,
>>> +                        devctl | PCI_EXP_DEVCTL_URRE);
>>> +        pcie_capability_read_word(root, PCI_EXP_DEVSTA, &devsta);
>>> +        if (devsta & PCI_EXP_DEVSTA_URD)
>>> +            pcie_capability_write_word(root, PCI_EXP_DEVSTA,
>>> +                           PCI_EXP_DEVSTA_URD);
>>> +        pci_info(root, "%s: DEVCTL %#06x DEVSTA %#06x\n", __func__,
>>> +             devctl, devsta);
>>> +    }
>>> +
>>>       /*
>>>        * The caller has already waited long enough after a reset 
>>> that the
>>>        * device should respond to config requests, but it may respond
>>> @@ -1305,14 +1321,33 @@ static int pci_dev_wait(struct pci_dev *dev, 
>>> char *reset_type, int timeout)
>>>             if (root && root->config_rrs_sv) {
>>>               pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
>>> -            if (!pci_bus_rrs_vendor_id(id))
>>> -                break;
>>> +
>>> +            if (pci_bus_rrs_vendor_id(id)) {
>>> +                pci_info(dev, "%s: read %#06x (RRS)\n",
>>> +                     __func__, id);
>>> +                goto retry;
>>> +            }
>>> +
>>> +            if (PCI_POSSIBLE_ERROR(id)) {
>>> +                pcie_capability_read_word(root, PCI_EXP_DEVSTA,
>>> +                              &devsta);
>>> +                if (devsta & PCI_EXP_DEVSTA_URD)
>>> +                    pcie_capability_write_word(root,
>>> +                                PCI_EXP_DEVSTA,
>>> +                                PCI_EXP_DEVSTA_URD);
>>> +                pci_info(root, "%s: read %#06x DEVSTA %#06x\n",
>>> +                     __func__, id, devsta);
>>> +                goto retry;
>>> +            }
>>> +
>>> +            break;
>>>           } else {
>>>               pci_read_config_dword(dev, PCI_COMMAND, &id);
>>>               if (!PCI_POSSIBLE_ERROR(id))
>>>                   break;
>>>           }
>>>   +retry:
>>>           if (delay > timeout) {
>>>               pci_warn(dev, "not ready %dms after %s; giving up\n",
>>>                    delay - 1, reset_type);
>>> @@ -1332,7 +1367,6 @@ static int pci_dev_wait(struct pci_dev *dev, 
>>> char *reset_type, int timeout)
>>>           }
>>>             msleep(delay);
>>> -        delay *= 2;
>>>       }
>>>         if (delay > PCI_RESET_WAIT)
>>> @@ -4670,8 +4704,10 @@ static int pcie_wait_for_link_status(struct 
>>> pci_dev *pdev,
>>>       end_jiffies = jiffies + 
>>> msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>>>       do {
>>>           pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>>> -        if ((lnksta & lnksta_mask) == lnksta_match)
>>> +        if ((lnksta & lnksta_mask) == lnksta_match) {
>>> +            pci_info(pdev, "%s: LNKSTA %#06x\n", __func__, lnksta);
>>>               return 0;
>>> +        }
>>>           msleep(1);
>>>       } while (time_before(jiffies, end_jiffies));
>>>   @@ -4760,6 +4796,8 @@ static bool pcie_wait_for_link_delay(struct 
>>> pci_dev *pdev, bool active,
>>>        * Some controllers might not implement link active reporting. 
>>> In this
>>>        * case, we wait for 1000 ms + any delay requested by the caller.
>>>        */
>>> +    pci_info(pdev, "%s: active %d delay %d link_active_reporting 
>>> %d\n",
>>> +         __func__, active, delay, pdev->link_active_reporting);
>>>       if (!pdev->link_active_reporting) {
>>>           msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
>>>           return true;
>>> @@ -4784,6 +4822,7 @@ static bool pcie_wait_for_link_delay(struct 
>>> pci_dev *pdev, bool active,
>>>               return false;
>>>             msleep(delay);
>>> +        pci_info(pdev, "%s: waited %dms\n", __func__, delay);
>>>           return true;
>>>       }
>>>   @@ -4960,6 +4999,7 @@ void pci_reset_secondary_bus(struct pci_dev 
>>> *dev)
>>>         ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>>>       pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>>> +    pci_info(dev, "%s: PCI_BRIDGE_CTL_BUS_RESET deasserted\n", 
>>> __func__);
>>>   }
>>>     void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)

