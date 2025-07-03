Return-Path: <linux-pci+bounces-31323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26257AF667A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 02:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADB51C2115F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327C372;
	Thu,  3 Jul 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gGqwjYfc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E0366
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751501124; cv=none; b=BYb9Vj+UM1h0YDvv9N3QZ4z/QVr3TreNjBWtGI/vWxULQSqnxYCyRBDwoEH0Y1iqJl8E2J4V322hpcEQDUvKRvmyDRpyNUsvRMqXcdFPOwEfzS5zIqCQ0rdK9LgWU2gFfFaxcURDGReNn/Ux3VTRzo0+BP8n1AQPjYt8nWBUE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751501124; c=relaxed/simple;
	bh=o7KDpA6+kKpmT2cAieynXT9lwwpg58xW3hPjoKhST0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pZkAyv5hvKj/Al0MGvtA1NFMytBiaB0koBcAnmK/XwqwARm0oyYYCMSN7V0Xz/xekLXkdmUV3XrKOgVhMLZGUrl9xckG9boqjlAt22envN+dlvJp6Nzj92t/xN6iGeIlYa+BUztEp7WCdlN1oLTxNBBp8I14DcLMmN0vuizflhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gGqwjYfc; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.5.38] (unknown [120.85.104.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 52F3A40076;
	Thu,  3 Jul 2025 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751501113;
	bh=RdLSxwjRfZjdzuBbS6mnwwq2OPTyH8fgYIVWmySheVI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type;
	b=gGqwjYfctu/4ZkPbcmbmNXrEY+SxXg9d+40AouEbdrawEtAo0s8UZlztboYz3Xt5w
	 6G3MuLV04lHqwu9YI0E/B7dJKdIsOacsq+33zh82c7O9RGA5CvYR5Phc5107hCXfwU
	 YoDr9b0s+LL6YvoJhsUNAZiaIpVZO7805SeongZY9nHLtyw0BaBJNJHwUIaLxovs64
	 cCsDDt8VXgvN/AB8Hq9XXdBGWLPzAJCqwxARLnhpoNzz6oSN26hso7hk3Clww7KRQ1
	 FQndh8zBunaM5265jrPfo1JqFhvsGlkyVKyCEmdZ69cAQ+97ETLCfiE+XSyQEcs6x0
	 wEGewmJN6bySQ==
Message-ID: <eae31738-5d5d-4c74-af1c-66168c36ead5@canonical.com>
Date: Thu, 3 Jul 2025 08:05:05 +0800
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
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20250701232341.GA1859056@bhelgaas>
 <13f6c7df-9fd8-4ef4-b900-9a5173c5967f@canonical.com>
Content-Language: en-US
In-Reply-To: <13f6c7df-9fd8-4ef4-b900-9a5173c5967f@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/2/25 17:43, Hui Wang wrote:
>
> On 7/2/25 07:23, Bjorn Helgaas wrote:
>> On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
>>> Sorry for late response, I was OOO the past week.
>>>
>>> This is the log after applied your patch:
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61 
>>>
>>>
>>> Looks like the "retry" makes the nvme work.
>> Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
>> a long time after we think the device should be able to respond with
>> RRS.
>>
>> I always thought the spec required that after the delays, a device
>> should respond with RRS if it's not ready, but now I guess I'm not
>> 100% sure.  Maybe it's allowed to just do nothing, which would lead to
>> the Root Port timing out and logging an Unsupported Request error.
>>
>> Can I trouble you to try the patch below?  I think we might have to
>> start explicitly checking for that error.  That probably would require
>> some setup to enable the error, check for it, and clear it.  I hacked
>> in some of that here, but ultimately some of it should go elsewhere.
>
> OK, built a testing kernel, wait for bug reporter to test it and 
> collect the log.
>
This is the testing result and log. 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/65


>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e9448d55113b..c276d0a2b522 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1264,10 +1264,13 @@ void pci_resume_bus(struct pci_bus *bus)
>>     static int pci_dev_wait(struct pci_dev *dev, char *reset_type, 
>> int timeout)
>>   {
>> -    int delay = 1;
>> +    int delay = 10;
>>       bool retrain = false;
>>       struct pci_dev *root, *bridge;
>> +    u16 devctl, devsta;
>>   +    pci_info(dev, "%s: VF%c %s timeout %d\n", __func__,
>> +         dev->is_virtfn ? '+' : '-', reset_type, timeout);
>>       root = pcie_find_root_port(dev);
>>         if (pci_is_pcie(dev)) {
>> @@ -1276,6 +1279,19 @@ static int pci_dev_wait(struct pci_dev *dev, 
>> char *reset_type, int timeout)
>>               retrain = true;
>>       }
>>   +    if (root) {
>> +        pcie_capability_read_word(root, PCI_EXP_DEVCTL, &devctl);
>> +        if (!(devctl & PCI_EXP_DEVCTL_URRE))
>> +            pcie_capability_write_word(root, PCI_EXP_DEVCTL,
>> +                        devctl | PCI_EXP_DEVCTL_URRE);
>> +        pcie_capability_read_word(root, PCI_EXP_DEVSTA, &devsta);
>> +        if (devsta & PCI_EXP_DEVSTA_URD)
>> +            pcie_capability_write_word(root, PCI_EXP_DEVSTA,
>> +                           PCI_EXP_DEVSTA_URD);
>> +        pci_info(root, "%s: DEVCTL %#06x DEVSTA %#06x\n", __func__,
>> +             devctl, devsta);
>> +    }
>> +
>>       /*
>>        * The caller has already waited long enough after a reset that 
>> the
>>        * device should respond to config requests, but it may respond
>> @@ -1305,14 +1321,33 @@ static int pci_dev_wait(struct pci_dev *dev, 
>> char *reset_type, int timeout)
>>             if (root && root->config_rrs_sv) {
>>               pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
>> -            if (!pci_bus_rrs_vendor_id(id))
>> -                break;
>> +
>> +            if (pci_bus_rrs_vendor_id(id)) {
>> +                pci_info(dev, "%s: read %#06x (RRS)\n",
>> +                     __func__, id);
>> +                goto retry;
>> +            }
>> +
>> +            if (PCI_POSSIBLE_ERROR(id)) {
>> +                pcie_capability_read_word(root, PCI_EXP_DEVSTA,
>> +                              &devsta);
>> +                if (devsta & PCI_EXP_DEVSTA_URD)
>> +                    pcie_capability_write_word(root,
>> +                                PCI_EXP_DEVSTA,
>> +                                PCI_EXP_DEVSTA_URD);
>> +                pci_info(root, "%s: read %#06x DEVSTA %#06x\n",
>> +                     __func__, id, devsta);
>> +                goto retry;
>> +            }
>> +
>> +            break;
>>           } else {
>>               pci_read_config_dword(dev, PCI_COMMAND, &id);
>>               if (!PCI_POSSIBLE_ERROR(id))
>>                   break;
>>           }
>>   +retry:
>>           if (delay > timeout) {
>>               pci_warn(dev, "not ready %dms after %s; giving up\n",
>>                    delay - 1, reset_type);
>> @@ -1332,7 +1367,6 @@ static int pci_dev_wait(struct pci_dev *dev, 
>> char *reset_type, int timeout)
>>           }
>>             msleep(delay);
>> -        delay *= 2;
>>       }
>>         if (delay > PCI_RESET_WAIT)
>> @@ -4670,8 +4704,10 @@ static int pcie_wait_for_link_status(struct 
>> pci_dev *pdev,
>>       end_jiffies = jiffies + 
>> msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>>       do {
>>           pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>> -        if ((lnksta & lnksta_mask) == lnksta_match)
>> +        if ((lnksta & lnksta_mask) == lnksta_match) {
>> +            pci_info(pdev, "%s: LNKSTA %#06x\n", __func__, lnksta);
>>               return 0;
>> +        }
>>           msleep(1);
>>       } while (time_before(jiffies, end_jiffies));
>>   @@ -4760,6 +4796,8 @@ static bool pcie_wait_for_link_delay(struct 
>> pci_dev *pdev, bool active,
>>        * Some controllers might not implement link active reporting. 
>> In this
>>        * case, we wait for 1000 ms + any delay requested by the caller.
>>        */
>> +    pci_info(pdev, "%s: active %d delay %d link_active_reporting %d\n",
>> +         __func__, active, delay, pdev->link_active_reporting);
>>       if (!pdev->link_active_reporting) {
>>           msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
>>           return true;
>> @@ -4784,6 +4822,7 @@ static bool pcie_wait_for_link_delay(struct 
>> pci_dev *pdev, bool active,
>>               return false;
>>             msleep(delay);
>> +        pci_info(pdev, "%s: waited %dms\n", __func__, delay);
>>           return true;
>>       }
>>   @@ -4960,6 +4999,7 @@ void pci_reset_secondary_bus(struct pci_dev 
>> *dev)
>>         ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>>       pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>> +    pci_info(dev, "%s: PCI_BRIDGE_CTL_BUS_RESET deasserted\n", 
>> __func__);
>>   }
>>     void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)

