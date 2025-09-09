Return-Path: <linux-pci+bounces-35745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC89B4FF6C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752FC366DAE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0D35083B;
	Tue,  9 Sep 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="DB9Pj+Ze"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C23019CD;
	Tue,  9 Sep 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428211; cv=none; b=GvxGrHlhJbPXBQER/cSmw7qh7jLbaixO7lvXe/CenqNQzcKCJSmeRwMiqyyopl8Y9EqRIOVItZPs6sKimU9oJpIoB78VZu7qPqWh9OLzFQfrljNH1On6ROo++TAymzyLZZUyla0yGSd02ve1o6wM7oXpKFMxoEGwC8c1c6y5SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428211; c=relaxed/simple;
	bh=tvgOl5hZ/ayhC5le0moYMV9PxbM9OE21ypsbbnW0Oe8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GTe+43U8/JikIxosWfIbBhbcl0mbZrpisaM5HmUsRCpfull2LgKTupP9uB0vL2YBKfe6i7aFA1gm9Hip6dZSa4KzJhTqHFBLYkILYWv1O2oPDikscJKKhjsx+9EfWmYRBKAGhh7oiN1ZPTCLhu+YunVq/i/uCYvITC40JvekxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=DB9Pj+Ze; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5D87A82876F1;
	Tue,  9 Sep 2025 09:21:32 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Dydv_4BgXdFD; Tue,  9 Sep 2025 09:21:30 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 64003828885E;
	Tue,  9 Sep 2025 09:21:30 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 64003828885E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1757427690; bh=sOZZKfKLnTxRbyDFyhBo2Qd9/gq0gRqxnoy3tvQJljA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=DB9Pj+ZehN+FJ8O/SLUb9okYIsSieeKSvT/LWt4FbQ+5V2pQaLg42gexndMuKVlUh
	 er64JXFL4ZbLss7bc+mJ4VgDZxCogFH8HSwm1pw/zryej9Sdf5VOzWHDZUcKhvzFrK
	 CQaWzeyYBhZ94NRgpUQEg57rweuMdP97ljdhnrXc=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1ojliU1CfFtx; Tue,  9 Sep 2025 09:21:30 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2B50882876F1;
	Tue,  9 Sep 2025 09:21:30 -0500 (CDT)
Date: Tue, 9 Sep 2025 09:21:27 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <304758063.1694752.1757427687463.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <bf390f9e-e06f-4743-a9dc-e0b995c2bab2@kernel.org>
References: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com> <2013845045.1359852.1752615367790.JavaMail.zimbra@raptorengineeringinc.com> <bf390f9e-e06f-4743-a9dc-e0b995c2bab2@kernel.org>
Subject: Re: [PATCH v3 1/6] PCI: pnv_php: Properly clean up allocated IRQs
 on unplug
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Properly clean up allocated IRQs on unplug
Thread-Index: zJ41UwgzYhwlCvtgYnXhkcd+rlAB7A==



----- Original Message -----
> From: "Jiri Slaby" <jirislaby@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Tuesday, September 9, 2025 4:00:41 AM
> Subject: Re: [PATCH v3 1/6] PCI: pnv_php: Properly clean up allocated IRQs on unplug

> On 15. 07. 25, 23:36, Timothy Pearson wrote:
>> In cases where the root of a nested PCIe bridge configuration is
>> unplugged, the pnv_php driver would leak the allocated IRQ resources for
>> the child bridges' hotplug event notifications, resulting in a panic.
>> Fix this by walking all child buses and deallocating all it's IRQ
>> resources before calling pci_hp_remove_devices.
>> 
>> Also modify the lifetime of the workqueue at struct pnv_php_slot::wq so
>> that it is only destroyed in pnv_php_free_slot, instead of
>> pnv_php_disable_irq. This is required since pnv_php_disable_irq will now
>> be called by workers triggered by hot unplug interrupts, so the
>> workqueue needs to stay allocated.
>> 
>> The abridged kernel panic that occurs without this patch is as follows:
>> 
>>    WARNING: CPU: 0 PID: 687 at kernel/irq/msi.c:292
>>    msi_device_data_release+0x6c/0x9c
>>    CPU: 0 UID: 0 PID: 687 Comm: bash Not tainted 6.14.0-rc5+ #2
>>    Call Trace:
>>     msi_device_data_release+0x34/0x9c (unreliable)
>>     release_nodes+0x64/0x13c
>>     devres_release_all+0xc0/0x140
>>     device_del+0x2d4/0x46c
>>     pci_destroy_dev+0x5c/0x194
>>     pci_hp_remove_devices+0x90/0x128
>>     pci_hp_remove_devices+0x44/0x128
>>     pnv_php_disable_slot+0x54/0xd4
>>     power_write_file+0xf8/0x18c
>>     pci_slot_attr_store+0x40/0x5c
>>     sysfs_kf_write+0x64/0x78
>>     kernfs_fop_write_iter+0x1b0/0x290
>>     vfs_write+0x3bc/0x50c
>>     ksys_write+0x84/0x140
>>     system_call_exception+0x124/0x230
>>     system_call_vectored_common+0x15c/0x2ec
>> 
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
>> ---
>>   drivers/pci/hotplug/pnv_php.c | 94 ++++++++++++++++++++++++++++-------
>>   1 file changed, 75 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>> index 573a41869c15..aec0a6d594ac 100644
>> --- a/drivers/pci/hotplug/pnv_php.c
>> +++ b/drivers/pci/hotplug/pnv_php.c
> ...
>> @@ -647,6 +702,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct
>> device_node *dn)
> 
> This is preceded by:
>         php_slot = kzalloc(sizeof(*php_slot), GFP_KERNEL);
> 
> Ie. php_slot is zeroed.
> 
>>   		return NULL;
>>   	}
>>   
>> +	/* Allocate workqueue for this slot's interrupt handling */
>> +	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
>> +	if (!php_slot->wq) {
>> +		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
> 
> I believe this introduced a (unlikely) NULL ptr dereference.
> 
>> +		kfree(php_slot->name);
>> +		kfree(php_slot);
>> +		return NULL;
>> +	}
>> +
>>   	if (dn->child && PCI_DN(dn->child))
>>   		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
>>   	else
> 
> This continues:
>         php_slot->pdev                  = bus->self;
>         php_slot->bus                   = bus;
> 
> 
> And SLOT_WARN() is defined as:
> #define SLOT_WARN(sl, x...) \
>         ((sl)->pdev ? pci_warn((sl)->pdev, x) :
> dev_warn(&(sl)->bus->dev, x))
> 
> The else branch is alkays taken in the 'if' above, which still
> dereferences NULLed (sl)->bus here.
> 
>> @@ -843,14 +907,6 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot,
>> int irq)
>>   	u16 sts, ctrl;
>>   	int ret;
>>   
>> -	/* Allocate workqueue */
>> -	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
>> -	if (!php_slot->wq) {
>> -		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
> 
> Here, php_slot used to have both ->pdev and ->bus assigned at this point.
> 
>> -		pnv_php_disable_irq(php_slot, true);
>> -		return;
>> -	}
>> -
> 
> Right?

That does look like an unlikely but definitely possible dereference -- good catch!

I can submit a patch to change

SLOT_WARN(php_slot, "Cannot alloc workqueue\n");

to

dev_warn(bus->dev, "Cannot alloc workqueue\n");

Would that work?

