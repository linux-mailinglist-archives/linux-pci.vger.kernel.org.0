Return-Path: <linux-pci+bounces-13729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B198E42D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB372858FB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF81D278D;
	Wed,  2 Oct 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vji+HlV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AA8F40;
	Wed,  2 Oct 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901110; cv=none; b=ss8VkZFLPwwzEsiPRYd4iwOarC8GDwTSKL50FDwpw1tta3FHPlZnT/aJiDI5ne+AzjfyyEDWNDgIn4twQNnKxFUC1HSPzCOu6wW0qdFSNh2ETogR1lfsZmRaC2561omqm4KvHSHkAvfA32bqQ7e5/7qAv2OzAk+DNGn9jqRkLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901110; c=relaxed/simple;
	bh=KaAmFhzd04eAox7spJuk0qeu7rbtVmLRzDE7I/JVG9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7HeTkuNwuikysyaJuUAH80kw6Qrz/vwuQMM2Msc6/1RR4Zjy+BPqWQnK0SP/WVmvo0+ZQt+8GRnyK5N2h7fZi1BBTPbBoSnixA9JPm/mK+qVD49Licak3Z59Z52AC12IdXOyXKUxaQBAtu03KTUnYzA4fM+7ZLtKbhos/LXIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vji+HlV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84484C4CEC2;
	Wed,  2 Oct 2024 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727901110;
	bh=KaAmFhzd04eAox7spJuk0qeu7rbtVmLRzDE7I/JVG9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vji+HlV1G4VVemK+0HXiQKxcdq+gTl1Nwq6POM94kvJIm4kdjZj0z0XvUS+eHj6Od
	 m+1M8PIefh8QAwNMMa4aAFHY85n9DjCcTLk5bZ5T4gMFnM+znnNgGeinqnP2jz2nM2
	 DuvjKX3TdaAiSCkW20vqQgHl+61V1KUcX+o5kxdPR54m9i2VOnHYTFf5dR9RAZg6Ig
	 eYtpzhMy6HOifBat5PsyloqdMDwedPoqvbvlAaGRT9tZ1xYmCAXOQ1+UGy7grg1DVr
	 JQ6AZfM9kUKcUsB41mgqBk+tnh988SLmcKSHRVzHwhj1LmAbwmSAu5z6dlpgBWQS61
	 6pVU5h7QuF+ug==
Message-ID: <7edd665b-274e-4abe-9e96-c29bbc662598@kernel.org>
Date: Wed, 2 Oct 2024 22:31:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: take the rescan lock when adding devices during host
 probe
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240926130924.36409-1-brgl@bgdev.pl>
 <20241001211102.GA227022@bhelgaas>
 <CAMRc=MeFww5wyj8XmUMT0zkD-D_EUS+4+7xNQYwgzsMaZ4zXBQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <CAMRc=MeFww5wyj8XmUMT0zkD-D_EUS+4+7xNQYwgzsMaZ4zXBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2.10.2024 10:36 AM, Bartosz Golaszewski wrote:
> On Tue, Oct 1, 2024 at 11:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Thu, Sep 26, 2024 at 03:09:23PM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Since adding the PCI power control code, we may end up with a race
>>> between the pwrctl platform device rescanning the bus and the host
>>> controller probe function. The latter needs to take the rescan lock when
>>> adding devices or may crash.
>>>
>>> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
>>> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  drivers/pci/probe.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 4f68414c3086..f1615805f5b0 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>>       list_for_each_entry(child, &bus->children, node)
>>>               pcie_bus_configure_settings(child);
>>>
>>> +     pci_lock_rescan_remove();
>>>       pci_bus_add_devices(bus);
>>> +     pci_unlock_rescan_remove();
>>
>> Seems like we do need locking here, but don't we need a more
>> comprehensive change?  There are many other callers of
>> pci_bus_add_devices(), and most of them look similarly unprotected.
>>
> 
> From a quick glance it looks like the majority of users are specific
> drivers (controller, hotplug, etc.). The calls inside pci_rescan_bus()
> and pci_rescan_bus_bridge_resize() are already protected from what I
> can tell. I'm not saying that the driver calls shouldn't be fixed but
> there's no immediate danger. This however fixes an issue we hit with
> PCI core so I'd send it upstream now and then we can think about the
> other use-cases.

Probably worth showing an example of how this can manifest:

removed a device through sysfs and called bus rescan:

[   63.851901] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   63.861048] Mem abort info:
[   63.863940]   ESR = 0x0000000096000004
[   63.867822]   EC = 0x25: DABT (current EL), IL = 32 bits
[   63.873291]   SET = 0, FnV = 0
[   63.876440]   EA = 0, S1PTW = 0
[   63.879688]   FSC = 0x04: level 0 translation fault
[   63.884711] Data abort info:
[   63.887697]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   63.893344]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   63.898549]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   63.904009] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000116c36000
[   63.910644] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[   63.917683] Internal error: Oops: 0000000096000004 [#1] SMP
[   63.923413] Modules linked in:
[   63.926561] CPU: 1 UID: 0 PID: 530 Comm: bash Tainted: G        W          <snip> #10176
[   63.938971] Tainted: [W]=WARN
[   63.942037] Hardware name: <snip>
[   63.951239] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   63.958398] pc : __pi_strlen+0x14/0x150
[   63.962350] lr : kernfs_name_hash+0x24/0x88
[   63.966668] sp : ffff800083c43af0
[   63.970089] x29: ffff800083c43af0 x28: ffff519888b83500 x27: 0000000000000000
[   63.977420] x26: 0000000000000000 x25: 0000000000000000 x24: ffff519888b83500
[   63.984751] x23: 0000000000000011 x22: ffff519886bd6040 x21: ffff519886bd5b00
[   63.992081] x20: 0000000000000000 x19: 0000000000000000 x18: ffff80008a0bd0a8
[   63.999410] x17: 0000000000000001 x16: ffff519888b83de8 x15: ffffa08dea3f5bf0
[   64.006741] x14: ffff519888b83de8 x13: ffffffffffffffff x12: 0000000000000028
[   64.014076] x11: ffffa08dea3f5bf0 x10: 0000000000000012 x9 : 0000000000000001
[   64.021403] x8 : 0101010101010101 x7 : ffffa08de7a5e844 x6 : 0000000000000000
[   64.028730] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   64.036062] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   64.043390] Call trace:
[   64.045918]  __pi_strlen+0x14/0x150
[   64.049508]  kernfs_find_ns+0x80/0x13c
[   64.053375]  kernfs_remove_by_name_ns+0x54/0xf0
[   64.058036]  sysfs_remove_bin_file+0x24/0x34
[   64.062436]  pci_remove_resource_files+0x3c/0x84
[   64.067190]  pci_remove_sysfs_dev_files+0x28/0x38
[   64.072025]  pci_stop_bus_device+0x8c/0xd8
[   64.076241]  pci_stop_bus_device+0x40/0xd8
[   64.080463]  pci_stop_and_remove_bus_device_locked+0x28/0x48
[   64.086277]  remove_store+0x70/0xb0
[   64.089878]  dev_attr_store+0x20/0x38
[   64.093649]  sysfs_kf_write+0x58/0x78
[   64.097426]  kernfs_fop_write_iter+0xe8/0x184
[   64.101905]  vfs_write+0x2dc/0x308
[   64.105413]  ksys_write+0x7c/0xec
[   64.108834]  __arm64_sys_write+0x24/0x34
[   64.112880]  invoke_syscall+0x48/0x100
[   64.116744]  el0_svc_common+0xb4/0xe8
[   64.120522]  do_el0_svc+0x24/0x34
[   64.123938]  el0_svc+0x58/0xb4
[   64.127085]  el0t_64_sync_handler+0x50/0x12c
[   64.131474]  el0t_64_sync+0x198/0x19c
[   64.135244] Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02) 
[   64.141508] ---[ end trace 0000000000000000 ]---

Konrad

