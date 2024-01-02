Return-Path: <linux-pci+bounces-1595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992B821D19
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754352837C6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176DFC0C;
	Tue,  2 Jan 2024 13:51:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sender3-of-o59.zoho.com (sender3-of-o59.zoho.com [136.143.184.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B697FC0D;
	Tue,  2 Jan 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5challer.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=5challer.de
ARC-Seal: i=1; a=rsa-sha256; t=1704203447; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mubb/eRwU0wPUE41heNujwRhOmtGWf+yG3KKpNFH/qoNDd0P972osLWKKVjqatYQ7HSm+XCXhbqwpl988WYx2cXI1txpZXTjNxnKspsqfr/uFa9PwsmEQ1kc2L5TVIPDwO5jylKxwQWPS5/IDidu+mM8qmGF2g4CEUNUS6rizzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1704203447; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cMclV7qdxAnRcBuYL1BKBnwM/zFyg469LYV6HFanklc=; 
	b=VnM8Gw7pSkNLd7zyOkFa4G3CKgEP/KHCqFOfjsbeAE5iGl7haKL6aMUd7t3jRZDi4iQaaQWE33dq205fJbxtd2hGxF8ORC4lxXJyJFJBBRihGjNj4F2hT7tfWAHgdfKN4rHhMt2xQSRXIMY839JHRMHHkbLUIAk+/3r2cPOGj8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=michael@5challer.de;
	dmarc=pass header.from=<michael@5challer.de>
Received: from [192.168.144.187] (ipbcc11913.dynamic.kabel-deutschland.de [188.193.25.19]) by mx.zohomail.com
	with SMTPS id 1704203444855745.8563886052651; Tue, 2 Jan 2024 05:50:44 -0800 (PST)
Message-ID: <5598b690-12da-4237-b2bf-c9c691c4647c@5challer.de>
Date: Tue, 2 Jan 2024 14:50:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, macro@orcam.me.uk, ajayagarwal@google.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, gregkh@linuxfoundation.org,
 hkallweit1@gmail.com, michael.a.bottini@linux.intel.com,
 johan+linaro@kernel.org
References: <20240101221554.GA1693060@bhelgaas>
Content-Language: en-US
From: Michael Schaller <michael@5challer.de>
In-Reply-To: <20240101221554.GA1693060@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 01.01.24 23:15, Bjorn Helgaas wrote:
> On Mon, Jan 01, 2024 at 07:57:40PM +0100, Michael Schaller wrote:
>> On 01.01.24 19:13, Bjorn Helgaas wrote:
>>> On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
>>> ...
> 
>>> So unless somebody has a counter-argument, I plan to queue a revert of
>>> 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
>>> v6.7.
>>
>> If it helps I could also try if a partial revert of 08d0cc5f3426 would be
>> sufficient. This might also narrow down the issue and give more insight
>> where the issue originates from.
> 
> We're so close to the v6.7 final release that I doubt we can figure
> out the problem and test a fix before v6.7.  I'm sure Kai-Heng would
> appreciate any additional data, but I don't think it's urgent at this
> point.
> 
> Bjorn

We're indeed close to the final v6.7 release, which in turn means that a 
last minute revert of a 16 month old commit might cause even more 
regressions as there have been quite a few ASPM changes afterwards and 
there won't be much testing anymore before the final release.

Furthermore, given the age of the commit and that it has been backported 
to kernel 5.15, the question is also if the revert would be backported 
to the affected LTS kernels?

If this regression risk is acceptable then I'm all for reverting the 
commit now and then working on a fix.

Michael

