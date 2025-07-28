Return-Path: <linux-pci+bounces-32999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE38B135D9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 09:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BEC3A1D42
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D91CAA92;
	Mon, 28 Jul 2025 07:49:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4718FDBE
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688983; cv=none; b=p1FRIHb8SzpVv8b81vq5NJNEJBzcAwTzDMPuDFNv23PAHhPuAq1MNN5qc/K8dEPUy8b7f/l+HGbt6XW13Ht5GTwU+8FQxQT5UbQVSXQKPGDQMPCvpFhWbNMKiSRk5fZNocArb31eq9ZpRp8/DMsb6YAhrgpu62rN4J6zK4GDv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688983; c=relaxed/simple;
	bh=B0Zs6ellNkr+FUFXYo85RanewyEW/5XMPUitU76wUxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCv8oeReiH8GBhu5WvAJabbRKPu+XcjuCLGwYv5jBNDODnb3/8uUDD+AWU017ySvlaD5NS1qyvaB6SUZt3lsralRus8myW6sWeLc2hH+sh/QNCrnzCcAHO7mnvMiet2LxKD49EuuKKSIS1pn1V6Q+dUkbsDTFiGvL51+MwDKMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p57bd9d4f.dip0.t-ipconnect.de [87.189.157.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 46E5561E64849;
	Mon, 28 Jul 2025 09:49:23 +0200 (CEST)
Message-ID: <3836001e-e2e3-4333-b2ad-141e9edf57ce@molgen.mpg.de>
Date: Mon, 28 Jul 2025 09:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igc: fix disabling L1.2 PCI-E link substate on I226 on
 init
To: ValdikSS <iam@valdikss.org.ru>
Cc: intel-wired-lan@osuosl.org, vitaly.lifshits@intel.com,
 linux-pci@vger.kernel.org
References: <8d1e606d-7320-4f02-98fe-e899702ac6e7@molgen.mpg.de>
 <20250727204331.564435-1-iam@valdikss.org.ru>
 <c3713450-605d-4b1e-ae41-bbbcaedc946f@molgen.mpg.de>
 <b99f8cdd-4adc-451e-9ccf-ba40f34fdb58@valdikss.org.ru>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <b99f8cdd-4adc-451e-9ccf-ba40f34fdb58@valdikss.org.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear ValdikSS,


Am 28.07.25 um 09:24 schrieb ValdikSS:
> On 28.07.2025 10:03 AM, Paul Menzel wrote:

>> Thank you for your patch. Please make sure to use `git format-patch - 
>> v<N>` (reroll count) to mark the iteration of the patch.
>>
>> Am 27.07.25 um 22:43 schrieb ValdikSS:
>>> Device ID comparison in igc_is_device_id_i226 is performed before
>>> the ID is set, resulting in always failing check on init.
>>>
>>> Before the patch:
>>> * L1.2 is not disabled on init
>>> * L1.2 is properly disabled after suspend-resume cycle
>>>
>>> With the patch:
>>> * L1.2 is properly disabled both on init and after suspend-resume
>>>
>>> How to test:
>>> Connect to the 1G link with 300+ mbit/s Internet speed, and run
>>> the download speed test, such as:
>>>
>>>      curl -o /dev/null http://speedtest.selectel.ru/1GB
>>>
>>> Without L1.2 disabled, the speed would be no more than ~200 mbit/s.
>>> With L1.2 disabled, the speed would reach 1 gbit/s.
>>> Note: it's required that the latency between your host and the remote
>>> be around 3-5 ms, the test inside LAN (<1 ms latency) won't trigger the
>>> issue.
>>
>> `sudo lspci -vv -s <x>` can be used to check L1.2 enablement under 
>> `L1SubCtl1`.
> 
> Is this what you suggest me to include and send the patch again?

I’d have added it, but others might say, it’s common knowledge, so *no 
need* to resend, no that it’s also documented in the list archive.

(Did you check, that L1.2 PCI-E link substate is disabled, or just the 
speed check.)

> I'd prefer not to be involved in the bug fixing process. I just sent a 
> patch because it works for me, as the suggestion for the fix. I did not 
> know it would require me to be involved in the process.

Yeah, it can be tedious. Sorry about that. As you sent the message 
tagged with [PATCH], I’d assumed you want it to be committed. (And it 
looks like it’s going to be as it adheres to all the requirements.) 
Thank you again!

>>> Link: https://lore.kernel.org/intel-wired-lan/15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com
>>> Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
>>> Signed-off-by: ValdikSS <iam@valdikss.org.ru>
>>> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/igc/igc_main.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index 031c332f6..1b4465d6b 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -7115,6 +7115,13 @@ static int igc_probe(struct pci_dev *pdev,
>>>       adapter->port_num = hw->bus.func;
>>>       adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
>>> +    /* PCI config space info */
>>> +    hw->vendor_id = pdev->vendor;
>>> +    hw->device_id = pdev->device;
>>> +    hw->revision_id = pdev->revision;
>>> +    hw->subsystem_vendor_id = pdev->subsystem_vendor;
>>> +    hw->subsystem_device_id = pdev->subsystem_device;
>>> +
>>>       /* Disable ASPM L1.2 on I226 devices to avoid packet loss */
>>>       if (igc_is_device_id_i226(hw))
>>>           pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>>> @@ -7141,13 +7148,6 @@ static int igc_probe(struct pci_dev *pdev,
>>>       netdev->mem_start = pci_resource_start(pdev, 0);
>>>       netdev->mem_end = pci_resource_end(pdev, 0);
>>> -    /* PCI config space info */
>>> -    hw->vendor_id = pdev->vendor;
>>> -    hw->device_id = pdev->device;
>>> -    hw->revision_id = pdev->revision;
>>> -    hw->subsystem_vendor_id = pdev->subsystem_vendor;
>>> -    hw->subsystem_device_id = pdev->subsystem_device;
>>> -
>>>       /* Copy the default MAC and PHY function pointers */
>>>       memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
>>>       memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Kind regards,

Paul

