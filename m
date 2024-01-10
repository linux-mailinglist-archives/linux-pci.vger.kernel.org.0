Return-Path: <linux-pci+bounces-1992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD4829A7F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 13:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F2C1F270B0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB853C092;
	Wed, 10 Jan 2024 12:40:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sender3-of-o59.zoho.com (sender3-of-o59.zoho.com [136.143.184.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0284360BF;
	Wed, 10 Jan 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5challer.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=5challer.de
ARC-Seal: i=1; a=rsa-sha256; t=1704890402; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mG81irjWHD2GNpjXHI6NXTaBaUt6KnE8HU9ckk8n1HZnSkyNIKLDqS6iCCPn7vnSuHAnu6bsX1+q571wM1phLbwMWntNqdhLY4twSFPBxXiwgFA7Zp1AAejeV16lIbv5S6jlcmsix+ZPl46/n6DBtd6LLX8PBfeBfC4ySiUWmpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1704890402; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kQJVZ8eFzAvmE5pkA462bXLU4g6YIbvStnFGD7XPwXo=; 
	b=inlhKa9pYKX77SPbldFG2ZiTLavAEaJrVAr6oJkwxxd2uMDVDBjPpOypEx2mrFNeb6Bzs4gsPyU4GU1bDoZCnWH4RTStwXX850cnqM3etMQpsEf8kVT4xsHiAWJzxUhAFqwCMc8Doxmi3PxShCRtNK7ibvpgWCNuqp93eO806/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=michael@5challer.de;
	dmarc=pass header.from=<michael@5challer.de>
Received: from [192.168.144.187] (ipbcc11913.dynamic.kabel-deutschland.de [188.193.25.19]) by mx.zohomail.com
	with SMTPS id 1704890400279286.1034435570938; Wed, 10 Jan 2024 04:40:00 -0800 (PST)
Message-ID: <9f0f9de4-2d34-4ff3-a901-c3e4b48e4ab0@5challer.de>
Date: Wed, 10 Jan 2024 13:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 macro@orcam.me.uk, ajayagarwal@google.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, gregkh@linuxfoundation.org,
 hkallweit1@gmail.com, michael.a.bottini@linux.intel.com,
 johan+linaro@kernel.org
References: <954f0b86-dd9e-4d84-8d67-fba7e80bc94e@5challer.de>
 <20240105155100.GA1861423@bhelgaas>
 <CAAd53p5Eg4J9bRtAHY+JZ11cy1D0TnKmAaLfzcRJzw15VRBxXw@mail.gmail.com>
Content-Language: en-US
From: Michael Schaller <michael@5challer.de>
In-Reply-To: <CAAd53p5Eg4J9bRtAHY+JZ11cy1D0TnKmAaLfzcRJzw15VRBxXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External


On 10.01.24 04:43, Kai-Heng Feng wrote:
> On Fri, Jan 5, 2024 at 11:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
>>> On 05.01.24 04:25, Kai-Heng Feng wrote:
>>>> Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
>>>
>>> Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also result in a
>>> working resume. I've tested this on kernel 6.6.9 (which still has commit
>>> 08d0cc5f3426). I've also attached the relevant dmesg output of the
>>> suspend/resume cycle in case this helps.
>>
>> Thanks for testing that!
>>
>>> Furthermore does this mean that commit 08d0cc5f3426 isn't at fault but
>>> rather that we are dealing with a timing issue?
>>
>> PCI does have a few software timing requirements, mostly related to
>> reset and power state (D0/D3cold).  ASPM has some timing parameters,
>> too, but I think they're all requirements on the hardware, not on
>> software.
>>
>> Adding an arbitrary delay anywhere shouldn't break anything, and other
>> than those few required situations, it shouldn't fix anything either.
> 
> At least it means 8d0cc5f3426 isn't the culprit?
> 
> Michael, does the issue happen when iwlwifi module is not loaded? It
> can be related to iwlwifi firmware.
> 
> Kai-Heng
>
The issue still happens if the iwlwifi module has been blacklisted and 
after a reboot. This was again with vanilla kernel 6.6.9 and I've 
confirmed via dmesg that iwlwifi wasn't loaded.

I've also checked if there is a newer firmware but Ubuntu 23.10 is 
already using the newest firmware available from 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/iwlwifi-8265-36.ucode 
(version 36.ca7b901d.0 according to dmesg).

Michael

>>
>> Bjorn

