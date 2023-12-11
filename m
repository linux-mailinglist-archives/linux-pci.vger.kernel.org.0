Return-Path: <linux-pci+bounces-753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B180CEB3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 15:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372551F216A0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC1495E3;
	Mon, 11 Dec 2023 14:53:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F75C3;
	Mon, 11 Dec 2023 06:53:50 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5F00145B45;
	Mon, 11 Dec 2023 15:53:47 +0100 (CET)
Message-ID: <a5121397-2a40-4c77-9dd3-8f0f47ec1360@proxmox.com>
Date: Mon, 11 Dec 2023 15:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231211141239.GA909479@bhelgaas>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231211141239.GA909479@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.12.23 um 15:12 schrieb Bjorn Helgaas:
> On Mon, Dec 11, 2023 at 02:52:42PM +0100, Fiona Ebner wrote:
>> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
>>> On Fri, 8 Dec 2023 16:47:23 +0100
>>> Igor Mammedov <imammedo@redhat.com> wrote:
>>>> On Thu, 7 Dec 2023 17:28:15 -0600
>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>>> What's the actual symptom that this is broken?  All these log
>>>>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
>>>>> bridge windows.
>>
>> The disk never shows up in /dev
>>
>>>>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
>>>>> bridge leading to it?
>>>>>
>>>>> Can you put the complete dmesg logs somewhere?  There's a lot of
>>>>> context missing here.
>>
>> Is this still necessary with Igor being able to reproduce the issue?
> 
> Only if you want help resolving the problem.  I don't have time to
> guess what interesting things might be missing and go back and forth
> to get them.
> 

I put the output of dmesg with my original QEMU commandline and kernel
6.7.0-rc3 here:

https://pastebin.com/UvpGAYf2

Best Regards,
Fiona


