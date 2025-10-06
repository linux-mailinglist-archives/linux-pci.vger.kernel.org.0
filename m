Return-Path: <linux-pci+bounces-37635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572DBBF26F
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 22:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F67B4F0987
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B81C3BFC;
	Mon,  6 Oct 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="FBetYUQO"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EE1A3172
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781337; cv=none; b=TETAn6MHmsoxjOZIEcaTKwgsNB5cRzWbR19k68jJGylYLoLRcEQikYbbUOBj1S6g+ZhfoQtrbFpFtibCpCghbocibFrJAkEuhUnKP22BPTolnPz+I+q1YknqSV62llcUZp3oVwTxbs2hZJaOK7QFdnccxhhA5oCj3QqZlhexpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781337; c=relaxed/simple;
	bh=W61JyJi8Eh/ITOIuWq0iJYp6lZazEq15UcS+7PfLBNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdqOzhkMrNr1qnAeh3iTfEdcueOPgyTiDvHF48QoCWGRAhJJ5kNgc3rTQrVTNXNViWO/XFSCw3FqT/CAUmZShmHZHKMZ4kmRB1SnPT9p66vBB+v+38ppeuqtH45p4tkoFwjug/st1q1Z+li672WcfBQHFNUmQZqpTLV0cfdKTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=FBetYUQO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1759781322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0BfeCjFg/Jjf92dnd5m+KCld3pdcB0zpR34sHmlReY=;
	b=FBetYUQOjWsHybTfl3GZeWMuBnyagHg0HXpUFbo2Ayof8jnkuBKbcfLTvNZmjYXyDbC47j
	K7vrkvFf/7VYvDDhvHFzFEmZDpKaAJD1Uv0wZkbFWCZ6nj7oHvyqrBio4dGsuJViKr3a5n
	Z6Df283kEEHdWyEN3fRTa2QO2SfkvHcB2S707r/isAzP2pcHW5OoPhTkyV0JX3PbkkBBRN
	Mu/AR6P/FFw7Ku501f4t6UtJJfCH3eLRg/C6A/kxTzOwO3lmNas+pQSGtc4qjxrvXMhWJU
	N82AM8WI45Z0NM/8FzFBgF8rVr7hU7g3s9AJ8oDZ64FyDnHRri70brF8WY/hjw==
Date: Mon, 6 Oct 2025 17:08:13 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
 <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/6/25 7:46 AM, Ilpo Järvinen wrote:
> On Mon, 6 Oct 2025, Val Packett wrote:
>> On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
>>> Bridge windows are read twice from PCI Config Space, the first read is
>>> made from pci_read_bridge_windows() which does not setup the device's
>>> resources. It causes problems down the road as child resources of the
>>> bridge cannot check whether they reside within the bridge window or
>>> not.
>>>
>>> Setup the bridge windows already in pci_read_bridge_windows().
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Looks like this change has broken the WiFi (but not NVMe) on my Snapdragon X1E
>> laptop (Latitude 7455):
> Thanks for the report.
>
>> qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
>> pci_bus 0004:00: root bus resource [bus 00-ff]
>> pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
> So this looks the first change visible in the fragment you've taken from
> the dmesg...
>
>> pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
>> pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
>> pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
>> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> ...What I don't understand in these logs is how can the code changed in
> pci_read_bridge_windows() affect the lines before this line as it is being
> printed from pci_read_bridge_windows(). Maybe there are more 'PCI bridge
> to' lines above the quoted part of the dmesg?

Sorry for the confusion, the 0x100000 shift was caused by unrelated 
changes (Qcom/DWC ECAM support) and I wasn't diligent enough with which 
exact log I picked as the working one.

Here's the actual difference. Good:

❯ dmesg | rg 0004: | rg brid
[    1.780172] qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
[    1.781930] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    1.781972] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
[    1.781998] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.782043] pci 0004:00:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    1.800769] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    1.976893] pcieport 0004:00:00.0: bridge window [mem 
0x7c400000-0x7c5fffff]: assigned

Bad:

❯ dmesg | rg 0004: | rg brid
[    1.380369] qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
[    1.442881] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    1.449496] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
[    1.462988] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.476661] pci 0004:00:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    1.502299] pci 0004:00:00.0: bridge window [mem 
0x7c300000-0x7c3fffff]: assigned
[    1.509028] pci 0004:00:00.0: bridge window [mem 
0x7c400000-0x7c4fffff 64bit pref]: assigned
[    1.509057] pci 0004:00:00.0: bridge window [io 0x100000-0x100fff]: 
assigned
[    1.509085] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    1.509099] pci 0004:00:00.0:   bridge window [io 0x100000-0x100fff]
[    1.509124] pci 0004:00:00.0:   bridge window [mem 0x7c300000-0x7c3fffff]
[    1.509133] pci 0004:00:00.0:   bridge window [mem 
0x7c400000-0x7c4fffff 64bit pref]

I've also added log lines to pci_read_bridge_bases where the other calls 
to the same pci_read_bridge_* functions are called, and turns out they 
did *not* happen.

So it seems to me that the good reason you were wondering about for why 
the resources were not set up in pci_read_bridge_windows, is that they 
must not be set up unconditionally!

I think it's that early check in pci_read_bridge_bases that avoids the 
setup here:

     if (pci_is_root_bus(child)) /* It's a host bus, nothing to read */
         return;

Thanks,
~val


