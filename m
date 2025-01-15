Return-Path: <linux-pci+bounces-19883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A6A122D1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB833A24DC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5C2139C6;
	Wed, 15 Jan 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="af8st/85"
X-Original-To: linux-pci@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F422FAFD;
	Wed, 15 Jan 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941223; cv=none; b=gYmVNSitnWANNEne69409pwZwKlUa3I6N4AEoKCNQvlGCtDui1FZhNAgcRj4d8ppDWBLCjc9L23YXywBXepunRsOS6cLbZq/NgkDtTW+zN0RlvR3LQOA1K4fZb3Ngym0DCf6bHyTSw+rtEFcW89eElCaArW+uiHDqx54Q8y51pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941223; c=relaxed/simple;
	bh=TfqfF6IxDkTf5ScIMkGiV+CW/T4aU4XuiULw0iYiTFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brdGtzCCKFoRQyPXRgCrqugSBoba4vi/7VpLx52tCqzqBmWwD51H/PuwCmM1h3FjzB6xCSM35U67t1C/3S9lFY0F8ErVd+//1LVZzNoCmkyr4DcGitKtPhDQ+cznpMk8vJ8uAPJ2/ZMfEZ794SerlDxr0IuQsgvnOzzB8A013Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=af8st/85; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736941196; bh=qgx7NkO3A8znNBSz4u2sSrlT4a+03ZvQ7nOIsgEOWU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=af8st/858paaqZRYxhZCLtNo4qAzJ3IsZ68b8CXTbCgLoYWzYcZukPUcTuNU7a/vi
	 Lh1wUN6cZSR9TbsEIVUO5XZO98HJU2gcOj+e0xP5aUeTTBkFx7MWe+D/n9JxuzDS60
	 K7rubPJPxWfla/3AKIJU90/HnZmJWCsaaUiMqEGM=
Received: from [IPV6:2409:8a00:78e3:4720:c2b8:1f83:55c7:7976] ([2409:8a00:78e3:4720:c2b8:1f83:55c7:7976])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 9F401461; Wed, 15 Jan 2025 19:39:52 +0800
X-QQ-mid: xmsmtpt1736941192t6l1a18kn
Message-ID: <tencent_8AA30DDC0B9D7EF389EA172A43D5F245E80A@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTxpcAyaLkyhcAIl93uw4L0O6FQGk0DJpmhj11O35xo9iVyBIXju
	 g6m9jB82E0LEbQdxOrk52xycpL39OzCFfNSshDMf9g/nFoaWAJloy85mfjloXI2Sd9plm0gACb5+
	 F84fDTqh+zG9LzdCIsiBCxTtkaBIl35goWC13TtnfvWjaW+kAA/KxflYOWzJn2jjHLd7ApA4YgSj
	 lZB6W4aojsamg/abC0fy0237gUa5VsRdXMBV/BvpOToxbMxqkyIGlu0Vazic/BeZQ8CfVVRb2uOS
	 Zx9WE15oEzUDD/dV//baVWXqNiKK2+egP32uif1tvDT7f+UlT12Kfd4Do7D4+jxr1OJ1V/MK3yRV
	 Bnq27F8wl79LNjiZZm10dIficfSgwu0adPAMAEIA/7PDvQvAH0Po6mjH2YWNLwBpFTvK+gS2rYeq
	 LDeLmz+u8T9VLooM7SPv9kzrmDghbDlqJXDCFdQx3jphSaxkMdV9/2yO7LQis9oXa10TbnUkcOJl
	 P7h1JHVhQQZfKV/k3HypN+DrVNZYr6G5GHql+oOLjEdpDSST7croYrN+wfOFlnlZ7/jdmTPc+wVK
	 PeHeccu7t1WbGCtjSbVAcgd3Jxh45WxravAk73pizDdDnS0Bhm1JAqQsVomBp4Kgc/s3It43QJxa
	 1kXyW9OMLEw3/kvTiyukx8CCTo16MiH2C60oOMtR+F2y5WoQP61FLi/UjLucHcXWvT29c44HoIcT
	 dkkz0w8GmPoEzNwIWdJfi3Nf1z+QA4lhTLh074tXWw97Ftdvn91IGg/T0YLfZ55xkSTSBmLiXukv
	 HEMR3MdbsBdBXe9gN2+VqnekNDdE8oF+asXIbnab17cXsyWeEiTjmqMEOzCQ8QDwZcH+r/Pxk+9j
	 iQhntIuBHXSF6kdz9Kkf1kO+vrIsZLAr1pauc8vJmlgyGiGASr3Q0o/c6yFXStYtOx9Py4ir8XT1
	 aP3sxJljL9gNL3r6Bva8Ux6UnqoINJ2ddOYaGovqVIOYcqe/5zYiIuOgssFZs/LFFjrq7M3uuBpF
	 haA3pLLIz7GvhfRmnQjycI6ze9SvM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <8282d9b8-64a0-4d18-a4a6-a74630edf3d1@qq.com>
Date: Wed, 15 Jan 2025 19:39:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com,
 helgaas@kernel.org, ahuang12@lenovo.com, sunjw10@lenovo.com
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
 <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com>
 <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com>
 <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>
Content-Language: en-US
From: Jiwei <jiwei.sun.bj@qq.com>
In-Reply-To: <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/25 02:25, Ilpo Järvinen wrote:
> On Tue, 14 Jan 2025, Jiwei wrote:
>> On 1/13/25 23:08, Ilpo Järvinen wrote:
>>> On Fri, 10 Jan 2025, Jiwei Sun wrote:
>>>
>>>> From: Jiwei Sun <sunjw10@lenovo.com>
>>>>
>>>> When we do the quick hot-add/hot-remove test (within 1 second) with a PCIE
>>>> Gen 5 NVMe disk, there is a possibility that the PCIe bridge will decrease
>>>> to 2.5GT/s from 32GT/s
>>>>
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Link Down
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> ...
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: broken device, retraining non-functional downstream link at 2.5GT/s
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No link
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Link Up
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
>>>> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
>>>> pci 10002:02:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
>>>> pci 10002:02:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
>>>> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
>>>> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
>>>> pci 10002:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 10002:00:04.0 (capable of 126.028 Gb/s with 32.0 GT/s PCIe x4 link)
>>>>
>>>> If a NVMe disk is hot removed, the pciehp interrupt will be triggered, and
>>>> the kernel thread pciehp_ist will be woken up, the
>>>> pcie_failed_link_retrain() will be called as the following call trace.
>>>>
>>>>    irq/87-pciehp-2524    [121] ..... 152046.006765: pcie_failed_link_retrain <-pcie_wait_for_link
>>>>    irq/87-pciehp-2524    [121] ..... 152046.006782: <stack trace>
>>>>  => [FTRACE TRAMPOLINE]
>>>>  => pcie_failed_link_retrain
>>>>  => pcie_wait_for_link
>>>>  => pciehp_check_link_status
>>>>  => pciehp_enable_slot
>>>>  => pciehp_handle_presence_or_link_change
>>>>  => pciehp_ist
>>>>  => irq_thread_fn
>>>>  => irq_thread
>>>>  => kthread
>>>>  => ret_from_fork
>>>>  => ret_from_fork_asm
>>>>
>>>> Accorind to investigation, the issue is caused by the following scenerios,
>>>>
>>>> NVMe disk	pciehp hardirq
>>>> hot-remove 	top-half		pciehp irq kernel thread
>>>> ======================================================================
>>>> pciehp hardirq
>>>> will be triggered
>>>> 	    	cpu handle pciehp
>>>> 		hardirq
>>>> 		pciehp irq kthread will
>>>> 		be woken up
>>>> 					pciehp_ist
>>>> 					...
>>>> 					  pcie_failed_link_retrain
>>>> 					    read PCI_EXP_LNKCTL2 register
>>>> 					    read PCI_EXP_LNKSTA register
>>>> If NVMe disk
>>>> hot-add before
>>>> calling pcie_retrain_link()
>>>> 					    set target speed to 2_5GT
>>>
>>> This assumes LBMS has been seen but DLLLA isn't? Why is that?
>>
>> Please look at the content below.
>>
>>>
>>>> 					      pcie_bwctrl_change_speed
>>>> 	  				        pcie_retrain_link
>>>
>>>> 						: the retrain work will be
>>>> 						  successful, because
>>>> 						  pci_match_id() will be
>>>> 						  0 in
>>>> 						  pcie_failed_link_retrain()
>>>
>>> There's no pci_match_id() in pcie_retrain_link() ?? What does that : mean?
>>> I think the nesting level is wrong in your flow description?
>>
>> Sorry for the confusing information, the complete meaning I want to express
>> is as follows,
>> NVMe disk	pciehp hardirq
>> hot-remove 	top-half		pciehp irq kernel thread
>> ======================================================================
>> pciehp hardirq
>> will be triggered
>> 	    	cpu handle pciehp
>> 		hardirq 
>> 		"pciehp" irq kthread
>> 		will be woken up
>> 					pciehp_ist
>> 					...
>> 					  pcie_failed_link_retrain
>> 					    pcie_capability_read_word(PCI_EXP_LNKCTL2)
>> 					    pcie_capability_read_word(PCI_EXP_LNKSTA)
>> If NVMe disk
>> hot-add before
>> calling pcie_retrain_link()
>> 					    pcie_set_target_speed(PCIE_SPEED_2_5GT)
>> 					      pcie_bwctrl_change_speed
>> 					        pcie_retrain_link
>> 					    // (1) The target link speed field of LNKCTL2 was set to 0x1,
>> 					    //     the retrain work will be successful.
>> 					    // (2) Return to pcie_failed_link_retrain()
>> 					    pcie_capability_read_word(PCI_EXP_LNKSTA)
>> 					    if lnksta & PCI_EXP_LNKSTA_DLLLA
>> 					       and PCI_EXP_LNKCTL2_TLS_2_5GT was set
>> 					       and pci_match_id
>> 					      pcie_capability_read_dword(PCI_EXP_LNKCAP)
>> 					      pcie_set_target_speed(PCIE_LNKCAP_SLS2SPEED(lnkcap))
>> 					      
>> 					    // Although the target link speed field of LNKCTL2 was set to 0x1,
>> 					    // however the dev is not in ids[], the removing downstream 
>> 					    // link speed restriction can not be executed.
>> 					    // The target link speed field of LNKCTL2 could not be restored.
>>
>> Due to the limitation of a length of 75 characters per line, the original 
>> explanation omitted many details.
>>
>>> I don't understand how retrain success relates to the pci_match_id() as 
>>> there are two different steps in pcie_failed_link_retrain().
>>>
>>> In step 1, pcie_failed_link_retrain() sets speed to 2.5GT/s if DLLLA=0 and 
>>> LBMS has been seen. Why is that condition happening in your case? You 
>>
>> According to our test result, it seems so.
>> Maybe it is related to our test. Our test involves plugging and unplugging 
>> multiple times within a second. Below is the dmesg log taken from our testing
>> process. The log below is a portion of the dmesg log that I have captured,
>> (Please allow me to retain the timestamps, as this information is important.)
>>
>> -------------------------------dmesg log-----------------------------------------
>>
>> [  537.981302] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  537.981329] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  537.981338] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  538.014638] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  538.014662] ==== pciehp_ist 703 start running
>> [  538.014678] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
>> [  538.199104] ==== pcie_reset_lbms_count 281 lbms_count set to 0
>> [  538.199130] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  538.567377] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  538.567393] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
> 
> DLLLA=0 & LBMS=0
> 
>> [  538.616219] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
> 
> DLLLA=1 & LBMS=0
> 
> Are all of these for the same device? It would be nice to print the 
> pci_name() too so it's clear what device it's about.

Yes, they are from the same device. The following log print the device name.

[ 5218.875059] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
[ 5218.875080] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 256 lbms_count++
[ 5218.875090] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
[ 5218.908398] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
[ 5218.908420] pcieport 10001:80:02.0: pciehp: ==== pciehp_ist 703 start running
[ 5218.908432] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
[ 5219.104559] pcieport 10001:80:02.0: bwctrl: ==== pcie_reset_lbms_count 281 lbms_count set to 0
[ 5219.104582] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
[ 5219.460832] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
[ 5219.460848] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
[ 5219.519595] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x5841
[ 5219.519604] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 256 lbms_count++
[ 5219.519613] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x5841
[ 5220.104919] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
[ 5220.104931] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
[ 5220.124727] pcieport 10001:80:02.0: ======pcie_wait_for_link_delay 4787,wait for linksta:-110
[ 5220.124740] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1845
[ 5220.124750] pcieport 10001:80:02.0: ==== pcie_lbms_seen 48 count:0x1
[ 5220.124758] pcieport 10001:80:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
[ 5220.154323] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
[ 5220.154351] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
[ 5220.154358] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 256 lbms_count++
[ 5220.154366] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
[ 5220.154374] pcieport 10001:80:02.0: bwctrl: ==== pcie_reset_lbms_count 281 lbms_count set to 0
[ 5220.154380] pcieport 10001:80:02.0: bwctrl: ========== pcie_set_target_speed 189, bwctl change speed ret:0x0
[ 5220.154389] pcieport 10001:80:02.0: retraining sucessfully, but now is in Gen 1
[ 5220.154395] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x1,newlnksta:0x3841
[ 5220.168291] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x7041
[ 5220.168299] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 256 lbms_count++
[ 5220.168308] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 269(stop running),link_status:0x7041
[ 5220.259128] pcieport 10001:80:02.0: bwctrl: ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
[ 5221.311642] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
[ 5221.311652] pcieport 10001:80:02.0: pciehp: ==== pciehp_ist 759 stop running

According to the above log, I have simplified the code execution flow 
and provided an analysis of some key steps.

PCIe bwctrl irq handler			pciehp irq handler
(top-half)				(kernel thread)
=================================================================================
pcie_bwnotif_irq 
  atomic_inc(&data->lbms_count)
//link_status:0x7841 
//(LBMS==1 & DLLLA==1)
//lbms_count++

pcie_bwnotif_irq 
//link_status:0x1041
//(LBMS==0 & DLLLA==0) 
					pciehp_ist
					  pciehp_handle_presence_or_link_change
					    pciehp_disable_slot
					      __pciehp_disable_slot
						remove_board
						  pcie_reset_lbms_count  // set lbms_count = 0
					    pciehp_enable_slot
pcie_bwnotif_irq 
//link_status:0x9845
//(LBMS==0 & DLLLA==0)			      __pciehp_enable_slot

pcie_bwnotif_irq 
  atomic_inc(&data->lbms_count)			board_added
//link_status:0x5841				  pciehp_check_link_status
//(LBMS==1 & DLLLA==0)
//lbms_count++, now lbms_count=1 

pcie_bwnotif_irq 
//link_status:0x9845				    pcie_wait_for_link
//(LBMS==0 & DLLLA==0)				      pcie_wait_for_link_delay
							pcie_wait_for_link_status
							  pcie_failed_link_retrain //lnksta:0x1845
							    // because lbms_count=1, and DLLLA == 0
							    // the pcie_set_target_speed will be executed.	
							  pcie_set_target_speed(PCIE_SPEED_2_5GT)
							    // because the current link speed 
							    // field of lnksta is 0x5, 
							    // the lnkctl2 will be set to 0x1
							    // The speed will be limited to Gen 1
													
													
Based on the content above, we know that during the processing of pciehp_ist(), 
after remove_board() and before pcie_wait_for_link_status(), there are multiple
rapid remove/add. This causes the previously cleared lbms_count and start counting
again, which ultimately leads to entering the pcie_set_target_speed(PCIE_SPEED_2_5GT) process.

Thanks,
Regards,
Jiwei

> 
>> [  538.617594] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  539.362382] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  539.362393] ==== pcie_bwnotif_irq 256 lbms_count++
> 
> DLLLA=1 & LBMS=1
> 
>> [  539.362400] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  539.395720] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
> 
> DLLLA=0
> 
> But LBMS did not get reset.
> 
> So is this perhaps because hotplug cannot keep up with the rapid 
> remove/add going on, and thus will not always call the remove_board() 
> even if the device went away?
> 
> Lukas, do you know if there's a good way to resolve this within hotplug 
> side?
> 
>> [  539.787501] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  539.787514] ==== pciehp_ist 759 stop running
>> [  539.787521] ==== pciehp_ist 703 start running
>> [  539.787533] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  539.914182] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  540.503965] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  540.808415] ======pcie_wait_for_link_delay 4787,wait for linksta:-110
>> [  540.808430] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
>> [  540.808440] ==== pcie_lbms_seen 48 count:0x1
>> [  540.808448] pcieport 10001:80:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
>> [  540.808452] ========== pcie_set_target_speed 172, speed has been set
>> [  540.808459] pcieport 10001:80:02.0: retraining sucessfully, but now is in Gen 1
>> [  540.808466] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0x1041
> 
> --
>  i.
> 
>> [  541.041386] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  541.041398] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  541.091231] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  541.568126] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  541.568135] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  541.568142] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  541.568168] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  542.029334] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  542.029347] ==== pciehp_ist 759 stop running
>> [  542.029353] ==== pciehp_ist 703 start running
>> [  542.029362] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  542.120676] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  542.120687] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  542.170424] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  542.172337] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  542.223909] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  542.223917] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  542.223924] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  542.257249] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  542.809830] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  542.809841] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  542.859463] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  543.097871] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  543.097879] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  543.097885] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  543.097905] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  543.391250] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  543.391260] ==== pciehp_ist 759 stop running
>> [  543.391265] ==== pciehp_ist 703 start running
>> [  543.391273] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  543.650507] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  543.650517] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  543.700174] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  543.700205] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  544.296255] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
>> [  544.296298] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  544.296515] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  544.296522] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
>> [  544.297256] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  544.297279] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  544.297288] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  544.297295] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  544.297301] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  544.297314] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  544.297337] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  544.297344] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  544.297352] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  544.297363] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  544.297373] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  544.297385] PCI: No. 2 try to assign unassigned res
>> [  544.297390] release child resource [mem 0xbb000000-0xbb007fff 64bit]
>> [  544.297396] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0fffff] released
>> [  544.297403] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  544.297412] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  544.297422] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 81] add_size 300000 add_align 100000
>> [  544.297438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: can't assign; no space
>> [  544.297444] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: failed to assign
>> [  544.297451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  544.297457] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  544.297464] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: assigned
>> [  544.297473] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to expand by 0x300000
>> [  544.297481] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to add 300000
>> [  544.297488] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  544.297494] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  544.297503] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  544.297524] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  544.297530] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  544.297538] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  544.297558] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  544.297563] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  544.297569] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  544.297579] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  544.297588] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  544.298256] nvme nvme1: pci function 10001:81:00.0
>> [  544.298278] nvme 10001:81:00.0: enabling device (0000 -> 0002)
>> [  544.298291] pcieport 10001:80:02.0: can't derive routing for PCI INT A
>> [  544.298298] nvme 10001:81:00.0: PCI INT A: no GSI
>> [  544.875198] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  544.875208] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  544.875215] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  544.875231] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  544.875910] ==== pciehp_ist 759 stop running
>> [  544.875920] ==== pciehp_ist 703 start running
>> [  544.875928] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
>> [  544.876857] ==== pcie_reset_lbms_count 281 lbms_count set to 0
>> [  544.876868] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  545.427157] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  545.427169] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  545.476411] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  545.478099] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  545.857887] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  545.857896] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  545.857902] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  545.857929] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  546.410193] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  546.410205] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  546.460531] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  546.697008] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  546.697020] ==== pciehp_ist 759 stop running
>> [  546.697025] ==== pciehp_ist 703 start running
>> [  546.697034] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  546.697039] pcieport 10001:80:02.0: pciehp: Slot(77): Link Up
>> [  546.718015] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  546.987498] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  546.987507] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  546.987514] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  546.987542] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  547.539681] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  547.539693] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  547.589214] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  547.850003] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  547.850011] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  547.850018] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  547.850046] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  547.996918] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  547.996930] ==== pciehp_ist 759 stop running
>> [  547.996934] ==== pciehp_ist 703 start running
>> [  547.996944] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  548.401899] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  548.401911] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  548.451186] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  548.452886] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  548.682838] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  548.682846] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  548.682852] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  548.682871] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  549.235408] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  549.235420] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  549.284761] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  549.654883] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  549.654892] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  549.654899] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  549.654926] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  549.738806] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  549.738815] ==== pciehp_ist 759 stop running
>> [  549.738819] ==== pciehp_ist 703 start running
>> [  549.738829] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  550.207186] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  550.207198] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  550.256868] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  550.256890] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  550.575344] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  550.575353] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  550.575360] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  550.575386] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  551.127757] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  551.127768] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  551.177224] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  551.477699] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  551.477711] ==== pciehp_ist 759 stop running
>> [  551.477716] ==== pciehp_ist 703 start running
>> [  551.477725] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  551.477730] pcieport 10001:80:02.0: pciehp: Slot(77): Link Up
>> [  551.498667] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  551.788685] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
>> [  551.788723] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  551.788933] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  551.788941] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
>> [  551.789619] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  551.789653] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  551.789663] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  551.789672] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  551.789677] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  551.789688] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  551.789708] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  551.789715] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  551.789722] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  551.789733] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  551.789743] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  551.789755] PCI: No. 2 try to assign unassigned res
>> [  551.789759] release child resource [mem 0xbb000000-0xbb007fff 64bit]
>> [  551.789764] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0fffff] released
>> [  551.789771] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  551.789779] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  551.789790] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 81] add_size 300000 add_align 100000
>> [  551.789804] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: can't assign; no space
>> [  551.789811] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: failed to assign
>> [  551.789817] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  551.789823] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  551.789831] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: assigned
>> [  551.789839] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to expand by 0x300000
>> [  551.789847] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to add 300000
>> [  551.789854] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  551.789860] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  551.789869] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  551.789889] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  551.789895] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  551.789903] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  551.789921] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  551.789927] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  551.789933] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  551.789942] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  551.789951] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  551.790638] nvme nvme1: pci function 10001:81:00.0
>> [  551.790656] nvme 10001:81:00.0: enabling device (0000 -> 0002)
>> [  551.790667] pcieport 10001:80:02.0: can't derive routing for PCI INT A
>> [  551.790674] nvme 10001:81:00.0: PCI INT A: no GSI
>> [  552.546963] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  552.546973] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  552.546980] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  552.546996] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  552.547590] ==== pciehp_ist 759 stop running
>> [  552.547598] ==== pciehp_ist 703 start running
>> [  552.547605] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
>> [  552.548215] ==== pcie_reset_lbms_count 281 lbms_count set to 0
>> [  552.548224] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  553.098957] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  553.098969] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  553.148031] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  553.149553] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  553.499647] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  553.499654] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  553.499660] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  553.499683] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  554.052313] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  554.052325] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  554.102175] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  554.265181] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  554.265188] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  554.265194] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  554.265217] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  554.453449] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  554.453458] ==== pciehp_ist 759 stop running
>> [  554.453463] ==== pciehp_ist 703 start running
>> [  554.453472] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  554.743040] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  555.475369] ======pcie_wait_for_link_delay 4787,wait for linksta:-110
>> [  555.475384] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
>> [  555.475392] ==== pcie_lbms_seen 48 count:0x2
>> [  555.475398] pcieport 10001:80:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
>> [  555.475404] ========== pcie_set_target_speed 172, speed has been set
>> [  555.475409] pcieport 10001:80:02.0: retraining sucessfully, but now is in Gen 1
>> [  555.475417] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0x1041
>> [  556.633310] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  556.633322] ==== pciehp_ist 759 stop running
>> [  556.633328] ==== pciehp_ist 703 start running
>> [  556.633336] ==== pciehp_ist 759 stop running
>> [  556.828412] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  556.828440] ==== pciehp_ist 703 start running
>> [  556.828448] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  557.017389] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  557.017400] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  557.066666] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  557.066688] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  557.209334] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
>> [  557.209374] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  557.209585] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  557.209592] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
>> [  557.210275] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  557.210292] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  557.210300] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  557.210307] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  557.210312] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  557.210322] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  557.210342] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  557.210349] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  557.210356] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  557.210366] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  557.210376] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  557.210388] PCI: No. 2 try to assign unassigned res
>> [  557.210392] release child resource [mem 0xbb000000-0xbb007fff 64bit]
>> [  557.210397] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0fffff] released
>> [  557.210405] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  557.210414] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  557.210424] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 81] add_size 300000 add_align 100000
>> [  557.210438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: can't assign; no space
>> [  557.210445] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: failed to assign
>> [  557.210451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  557.210457] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  557.210464] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: assigned
>> [  557.210472] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to expand by 0x300000
>> [  557.210479] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to add 300000
>> [  557.210487] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  557.210492] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  557.210501] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  557.210521] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  557.210527] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  557.210534] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  557.210553] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  557.210559] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  557.210565] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  557.210574] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  557.210583] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  557.211286] nvme nvme1: pci function 10001:81:00.0
>> [  557.211303] nvme 10001:81:00.0: enabling device (0000 -> 0002)
>> [  557.211315] pcieport 10001:80:02.0: can't derive routing for PCI INT A
>> [  557.211322] nvme 10001:81:00.0: PCI INT A: no GSI
>> [  557.565811] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  557.565820] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  557.565827] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  557.565842] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  557.566410] ==== pciehp_ist 759 stop running
>> [  557.566416] ==== pciehp_ist 703 start running
>> [  557.566423] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
>> [  557.567592] ==== pcie_reset_lbms_count 281 lbms_count set to 0
>> [  557.567602] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  558.117581] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  558.117594] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  558.166639] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  558.168190] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  558.376176] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  558.376184] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  558.376190] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  558.376208] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  558.928611] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  558.928621] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  558.977769] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  559.186385] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  559.186394] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  559.186400] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  559.186419] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  559.459099] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  559.459111] ==== pciehp_ist 759 stop running
>> [  559.459116] ==== pciehp_ist 703 start running
>> [  559.459124] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  559.738599] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  559.738610] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  559.787690] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  559.787712] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  560.307243] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  560.307253] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  560.307260] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  560.307282] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  560.978997] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  560.979007] ==== pciehp_ist 759 stop running
>> [  560.979013] ==== pciehp_ist 703 start running
>> [  560.979022] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  561.410141] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  561.410153] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  561.459064] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  561.459087] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  561.648520] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  561.648528] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  561.648536] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  561.648559] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  562.247076] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  562.247087] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  562.296600] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  562.454228] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  562.454236] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  562.454244] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  562.487632] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  562.674863] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  562.674874] ==== pciehp_ist 759 stop running
>> [  562.674879] ==== pciehp_ist 703 start running
>> [  562.674888] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  563.696784] ======pcie_wait_for_link_delay 4787,wait for linksta:-110
>> [  563.696798] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
>> [  563.696806] ==== pcie_lbms_seen 48 count:0x5
>> [  563.696813] pcieport 10001:80:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
>> [  563.696817] ========== pcie_set_target_speed 172, speed has been set
>> [  563.696823] pcieport 10001:80:02.0: retraining sucessfully, but now is in Gen 1
>> [  563.696830] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0x1041
>> [  564.133582] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  564.133594] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  564.183003] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  564.364911] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  564.364921] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  564.364930] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  564.364954] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  564.889708] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  564.889719] ==== pciehp_ist 759 stop running
>> [  564.889724] ==== pciehp_ist 703 start running
>> [  564.889732] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  565.493151] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  565.493162] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  565.542478] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  565.542501] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  565.752276] ==== pcie_bwnotif_irq 247(start running),link_status:0x5041
>> [  565.752285] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  565.752291] ==== pcie_bwnotif_irq 269(stop running),link_status:0x5041
>> [  565.752316] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  566.359793] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  566.359804] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  566.408820] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  566.581150] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  566.581159] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  566.581166] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  566.614491] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  566.755582] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  566.755591] ==== pciehp_ist 759 stop running
>> [  566.755596] ==== pciehp_ist 703 start running
>> [  566.755605] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  567.751399] ==== pcie_bwnotif_irq 247(start running),link_status:0x9845
>> [  567.751412] ==== pcie_bwnotif_irq 269(stop running),link_status:0x9845
>> [  567.776517] ======pcie_wait_for_link_delay 4787,wait for linksta:-110
>> [  567.776529] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1845
>> [  567.776538] ==== pcie_lbms_seen 48 count:0x8
>> [  567.776544] pcieport 10001:80:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
>> [  567.801147] ==== pcie_bwnotif_irq 247(start running),link_status:0x3045
>> [  567.801177] ==== pcie_bwnotif_irq 247(start running),link_status:0x7841
>> [  567.801184] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  567.801192] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>> [  567.801201] ==== pcie_reset_lbms_count 281 lbms_count set to 0
>> [  567.801207] ========== pcie_set_target_speed 189, bwctl change speed ret:0x0
>> [  567.801214] pcieport 10001:80:02.0: retraining sucessfully, but now is in Gen 1
>> [  567.801220] pcieport 10001:80:02.0: ============ pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x1,newlnksta:0x3841
>> [  567.815102] ==== pcie_bwnotif_irq 247(start running),link_status:0x7041
>> [  567.815110] ==== pcie_bwnotif_irq 256 lbms_count++
>> [  567.815117] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7041
>> [  567.910155] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>> [  568.961434] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
>> [  568.961444] ==== pciehp_ist 759 stop running
>> [  568.961450] ==== pciehp_ist 703 start running
>> [  568.961459] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
>> [  569.008665] ==== pcie_bwnotif_irq 247(start running),link_status:0x3041
>> [  569.010428] ======pcie_wait_for_link_delay 4787,wait for linksta:0
>> [  569.391482] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
>> [  569.391549] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  569.391968] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
>> [  569.391975] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
>> [  569.392869] pci 10001:81:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 10001:80:02.0 (capable of 126.028 Gb/s with 32.0 GT/s PCIe x4 link)
>> [  569.393233] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  569.393249] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  569.393257] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  569.393264] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  569.393270] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  569.393279] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  569.393315] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  569.393322] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  569.393329] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  569.393340] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  569.393350] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  569.393362] PCI: No. 2 try to assign unassigned res
>> [  569.393366] release child resource [mem 0xbb000000-0xbb007fff 64bit]
>> [  569.393371] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0fffff] released
>> [  569.393378] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  569.393404] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
>> [  569.393414] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 81] add_size 300000 add_align 100000
>> [  569.393430] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: can't assign; no space
>> [  569.393438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000]: failed to assign
>> [  569.393445] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  569.393451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  569.393458] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: assigned
>> [  569.393466] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to expand by 0x300000
>> [  569.393474] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb0fffff]: failed to add 300000
>> [  569.393481] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [  569.393487] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: failed to assign
>> [  569.393495] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  569.393529] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  569.393536] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  569.393543] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]: assigned
>> [  569.393576] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
>> [  569.393582] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: failed to assign
>> [  569.393588] pcieport 10001:80:02.0: PCI bridge to [bus 81]
>> [  569.393597] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0xbb0fffff]
>> [  569.393606] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0xbbefffff 64bit pref]
>> [  569.394076] nvme nvme1: pci function 10001:81:00.0
>> [  569.394095] nvme 10001:81:00.0: enabling device (0000 -> 0002)
>> [  569.394109] pcieport 10001:80:02.0: can't derive routing for PCI INT A
>> [  569.394116] nvme 10001:81:00.0: PCI INT A: no GSI
>> [  570.158994] nvme nvme1: D3 entry latency set to 10 seconds
>> [  570.239267] nvme nvme1: 127/0/0 default/read/poll queues
>> [  570.287896] ==== pciehp_ist 759 stop running
>> [  570.287911] ==== pciehp_ist 703 start running
>> [  570.287918] ==== pciehp_ist 759 stop running
>> [  570.288953]  nvme1n1: p1 p2 p3 p4 p5 p6 p7
>>
>> -------------------------------dmesg log-----------------------------------------
>>
>> >From the log above, it can be seen that I added some debugging codes in the kernel. 
>> The specific modifications are as follows:
>>
>> -------------------------------diff file-----------------------------------------
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index bb5a8d9f03ad..c9f3ed86a084 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -700,6 +700,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>>  	irqreturn_t ret;
>>  	u32 events;
>>  
>> +	printk("==== %s %d start running\n", __func__, __LINE__);
>>  	ctrl->ist_running = true;
>>  	pci_config_pm_runtime_get(pdev);
>>  
>> @@ -755,6 +756,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>>  	pci_config_pm_runtime_put(pdev);
>>  	ctrl->ist_running = false;
>>  	wake_up(&ctrl->requester);
>> +	printk("==== %s %d stop running\n", __func__, __LINE__);
>>  	return ret;
>>  }
>>  
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 661f98c6c63a..ffa58f389456 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4784,6 +4784,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>>  	if (active)
>>  		msleep(20);
>>  	rc = pcie_wait_for_link_status(pdev, false, active);
>> +	printk("======%s %d,wait for linksta:%d\n", __func__, __LINE__, rc);
>>  	if (active) {
>>  		if (rc)
>>  			rc = pcie_failed_link_retrain(pdev);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e40fc63ba31..b7e5af859517 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -337,12 +337,13 @@ void pci_bus_put(struct pci_bus *bus);
>>  
>>  #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
>>  ({									\
>> -	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
>> +	u32 __lnkcap = (lnkcap) & PCI_EXP_LNKCAP_SLS;		\
>> +	(__lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
>>  	 PCI_SPEED_UNKNOWN);						\
>>  })
>>  
>> @@ -357,13 +358,16 @@ void pci_bus_put(struct pci_bus *bus);
>>  	 PCI_SPEED_UNKNOWN)
>>  
>>  #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
>> -	((lnkctl2) == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
>> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
>> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
>> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
>> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
>> -	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
>> -	 PCI_SPEED_UNKNOWN)
>> +({									\
>> +	u16 __lnkctl2 = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;	\
>> +	(__lnkctl2 == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
>> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
>> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
>> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
>> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
>> +	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
>> +	 PCI_SPEED_UNKNOWN);						\
>> +})
>>  
>>  /* PCIe speed to Mb/s reduced by encoding overhead */
>>  #define PCIE_SPEED2MBS_ENC(speed) \
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index b59cacc740fa..a8ce09f67d3b 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -168,8 +168,10 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
>>  		return -EINVAL;
>>  
>> -	if (bus && bus->cur_bus_speed == speed_req)
>> +	if (bus && bus->cur_bus_speed == speed_req) {
>> +		printk("========== %s %d, speed has been set\n", __func__, __LINE__);
>>  		return 0;
>> +	}
>>  
>>  	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>>  
>> @@ -184,6 +186,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			mutex_lock(&data->set_speed_mutex);
>>  
>>  		ret = pcie_bwctrl_change_speed(port, target_speed, use_lt);
>> +		printk("========== %s %d, bwctl change speed ret:0x%x\n", __func__, __LINE__,ret);
>>  
>>  		if (data)
>>  			mutex_unlock(&data->set_speed_mutex);
>> @@ -209,8 +212,10 @@ static void pcie_bwnotif_enable(struct pcie_device *srv)
>>  
>>  	/* Count LBMS seen so far as one */
>>  	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>> -	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS)
>> +	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS) {
>> +		printk("==== %s %d lbms_count++\n", __func__, __LINE__);
>>  		atomic_inc(&data->lbms_count);
>> +	}
>>  
>>  	pcie_capability_set_word(port, PCI_EXP_LNKCTL,
>>  				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
>> @@ -239,6 +244,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>>  	int ret;
>>  
>>  	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>> +	printk("==== %s %d(start running),link_status:0x%x\n", __func__, __LINE__,link_status);
>>  	if (ret != PCIBIOS_SUCCESSFUL)
>>  		return IRQ_NONE;
>>  
>> @@ -246,8 +252,10 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>>  	if (!events)
>>  		return IRQ_NONE;
>>  
>> -	if (events & PCI_EXP_LNKSTA_LBMS)
>> +	if (events & PCI_EXP_LNKSTA_LBMS) {
>> +		printk("==== %s %d lbms_count++\n", __func__, __LINE__);
>>  		atomic_inc(&data->lbms_count);
>> +	}
>>  
>>  	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>>  
>> @@ -258,6 +266,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>>  	 * cleared to avoid missing link speed changes.
>>  	 */
>>  	pcie_update_link_speed(port->subordinate);
>> +	printk("==== %s %d(stop running),link_status:0x%x\n", __func__, __LINE__,link_status);
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -268,8 +277,10 @@ void pcie_reset_lbms_count(struct pci_dev *port)
>>  
>>  	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
>>  	data = port->link_bwctrl;
>> -	if (data)
>> +	if (data) {
>> +		printk("==== %s %d lbms_count set to 0\n", __func__, __LINE__);
>>  		atomic_set(&data->lbms_count, 0);
>> +	}
>>  	else
>>  		pcie_capability_write_word(port, PCI_EXP_LNKSTA,
>>  					   PCI_EXP_LNKSTA_LBMS);
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 76f4df75b08a..a602f9aa5d6a 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -41,8 +41,11 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
>>  	int ret;
>>  
>>  	ret = pcie_lbms_count(dev, &count);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		printk("==== %s %d lnksta(0x%x) & LBMS\n", __func__, __LINE__, lnksta);
>>  		return lnksta & PCI_EXP_LNKSTA_LBMS;
>> +	}
>> +	printk("==== %s %d count:0x%lx\n", __func__, __LINE__, count);
>>  
>>  	return count > 0;
>>  }
>> @@ -110,6 +113,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>  
>>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>> +	pci_info(dev, "============ %s %d, lnkctl2:0x%x, lnksta:0x%x\n",
>> +			__func__, __LINE__, lnkctl2, lnksta);
>>  	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
>>  		u16 oldlnkctl2 = lnkctl2;
>>  
>> @@ -121,9 +126,14 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>  			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
>>  					      true);
>>  			return ret;
>> +		} else {
>> +			 pci_info(dev, "retraining sucessfully, but now is in Gen 1\n");
>>  		}
>>  
>> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>> +		pci_info(dev, "============ %s %d, oldlnkctl2:0x%x,newlnkctl2:0x%x,newlnksta:0x%x\n",
>> +				__func__, __LINE__, oldlnkctl2, lnkctl2, lnksta);
>>  	}
>>  
>>  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
>>
>> -------------------------------diff file-----------------------------------------
>>
>> Based on the information in the log from 566.755596 to 567.801220, the issue
>> has been reproduced. Between 566 and 567 seconds, the pcie_bwnotif_irq interrupt
>> was triggered 4 times, this indicates that during this period, the NVMe drive 
>> was plugged and unplugged multiple times.
>>
>> Thanks,
>> Regards,
>> Jiwei
>>
>>> didn't explain LBMS (nor DLLLA) in the above sequence so it's hard to 
>>> follow what is going on here. LBMS in particular is of high interest here 
>>> because I'm trying to understand if something should clear it on the 
>>> hotplug side (there's already one call to clear it in remove_board()).
>>>
>>> In step 2 (pcie_set_target_speed() in step 1 succeeded), 
>>> pcie_failed_link_retrain() attempts to restore >2.5GT/s speed, this only 
>>> occurs when pci_match_id() matches. I guess you're trying to say that step 
>>> 2 is not taken because pci_match_id() is not matching but the wording 
>>> above is very confusing.
>>>
>>> Overall, I failed to understand the scenario here fully despite trying to 
>>> think it through over these few days.
>>>
>>>> 						  the target link speed
>>>> 						  field of the Link Control
>>>> 						  2 Register will keep 0x1.
>>>>
>>>> In order to fix the issue, don't do the retraining work except ASMedia
>>>> ASM2824.
>>>>
>>>> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
>>>> Reported-by: Adrian Huang <ahuang12@lenovo.com>
>>>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>>>> ---
>>>>  drivers/pci/quirks.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 605628c810a5..ff04ebd9ae16 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -104,6 +104,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>>>  	u16 lnksta, lnkctl2;
>>>>  	int ret = -ENOTTY;
>>>>  
>>>> +	if (!pci_match_id(ids, dev))
>>>> +		return 0;
>>>> +
>>>>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>>>>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
>>>>  		return ret;
>>>> @@ -129,8 +132,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>>>  	}
>>>>  
>>>>  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
>>>> -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
>>>> -	    pci_match_id(ids, dev)) {
>>>> +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>>>>  		u32 lnkcap;
>>>>  
>>>>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>>>>
>>>


