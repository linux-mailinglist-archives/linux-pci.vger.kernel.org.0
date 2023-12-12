Return-Path: <linux-pci+bounces-801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454180EC86
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 13:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC062815EC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5B60EC1;
	Tue, 12 Dec 2023 12:50:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2DF7;
	Tue, 12 Dec 2023 04:50:24 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BF6D5469C0;
	Tue, 12 Dec 2023 13:50:21 +0100 (CET)
Message-ID: <62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
Date: Tue, 12 Dec 2023 13:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
 <20231207232815.GA771837@bhelgaas>
 <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
 <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
 <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
 <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.12.23 um 12:26 schrieb Igor Mammedov:
> 
> it's not necessary, but it would help to find out what's going wrong faster.
> Otherwise we would need to fallback to debugging over email.
> Are you willing to help with testing/providing debug logs to track down
> the cause?.
> 

I submitted the dmesg logs in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=218255

> Though debug over email would be slow, so our best option is to revert
> offending patches until the cause if found/fixed.
> 
>>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
>>>>> work reliably?  If we have to revert something, reverting one would be
>>>>> better than reverting both.    
>>>>  
>>
>> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
>> 40613da52b13f so I can't revert just 40613da52b13f).
> 
> With UEFI setup, it still works for me fine with current master.
> 
> Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> 

I also built from current master (still 26aff849438c) to verify and it's
still broken for me.

> 
> it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> However it's necessary to have -smp 4 for it to break,
> with -smp 1 it works fine as well.
> 

For me it's (always with build from current master):

-smp 1 -> it worked 5 times out of 5
-smp 2 -> it worked 3 times out of 5
-smp 4 -> it worked 0 times out of 5
-smp 8 -> it worked 0 times out of 5

Best Regards,
Fiona


