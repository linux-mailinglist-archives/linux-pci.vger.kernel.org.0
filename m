Return-Path: <linux-pci+bounces-7281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D28C0CD0
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FBCB21225
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2FD14A087;
	Thu,  9 May 2024 08:50:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83D149E19
	for <linux-pci@vger.kernel.org>; Thu,  9 May 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244643; cv=none; b=L8FGQZBtIvjqGC88fFD4tzWZdgQg1Qa4/XPuigTu178zAB1lKwae1UDTHjxvbC5JXcomUPjAsisJAIb+GDWIPcjh8Ju3gYTWhJh98q0Vuj0yh6324KpcjmYVDE0GJ54F9u2hgc+lxpBziHbB0VT/CKUbuy4MfUtR8N4o9Bt3v0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244643; c=relaxed/simple;
	bh=kz1qxPyo9dmTKO4NicjXjKlExY5D67C43u5RpO/2nhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d8GujsZrzQkSAzJMe3fNXORSzmRCdJlwTBJxAWQSdRHc3FYZYY0SsSYg8JrwlXLqmyTWQq1F7C+37sQtrAfZj9yZ9zYosG6/ySkgRq0ia47LiUwTrZFunaZ68Y7XD1QCZXGhZwYjNED2aJW1v1vlnSSC7PqhAH5/j2V3/k0n2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1715243991-086e2325cc0db20001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id jcY8zdEvtdy2KSos (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 09 May 2024 16:39:51 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 16:39:50 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 May
 2024 16:39:49 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <a70d141f-cec1-49b5-99d0-0f9e5f722afd@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Thu, 9 May 2024 16:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Parse the HEST PCIe AER and set to relevant
 registers
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 0/3] Parse the HEST PCIe AER and set to relevant
 registers
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>
References: <20240508220436.GA1789788@bhelgaas>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20240508220436.GA1789788@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1715243991
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2313
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.124625
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2024/5/9 6:04, Bjorn Helgaas 写道:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On Mon, Dec 18, 2023 at 11:04:27AM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
>> r6.5, the register value form HEST PCI Express AER Structure should be
>> written to relevant PCIe Device's AER Capabilities.So the purpose of the
>> patch set is to extract register value from HEST PCI Express AER
>> structures and program them into PCIe Device's AER registers. Refer to the
>> ACPI SPEC r6.5 for the more detailed description. This patch is an
>> effective supplement to _HPP/_HPX method when the Firmware does not
>> support the _HPP/_HPX method and can be specially configured for the AER
>> register of the specific device.
>>
>> ---
>>
>> v1->v2:
>> - Move the definition of structure "hest_parse_aer_info" to file apei.h.
> 
> Just noticed that this removes the ACPICA header dependency problem
> that Rafael pointed out.  This also applies (with minor offsets) to
> v6.9-rc1, so it's not very stale.  We're almost to the v6.9 final
> release, so when v6.10-rc1 is tagged, can you rebase to that and
> repost this?
> 

Thank you very much for your review. I will make a new patch version 
based on the kernel v6.10-rc1 according to your suggestion.

> I assume you have a platform that uses this.  It would be good to
> mention that in the commit log of patches 1 and 3 so we have some idea
> of where it's useful and where changes need to be tested.
> 
Okay, I will add hardware suitability information for this patch to the 
commit log.

Yours sincerely
Leoliu-oc

>> LeoLiuoc (3):
>>    ACPI/APEI: Add hest_parse_pcie_aer()
>>    PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
>>    PCI/ACPI: Add pci_acpi_program_hest_aer_params()
>>
>>   drivers/acpi/apei/hest.c      | 69 +++++++++++++++++++++++-
>>   drivers/pci/pci-acpi.c        | 98 +++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h             |  9 ++++
>>   drivers/pci/probe.c           |  1 +
>>   include/acpi/apei.h           | 17 ++++++
>>   include/uapi/linux/pci_regs.h |  3 ++
>>   6 files changed, 195 insertions(+), 2 deletions(-)
>>
>> --
>> 2.34.1
>>

