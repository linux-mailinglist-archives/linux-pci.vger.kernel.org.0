Return-Path: <linux-pci+bounces-1617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F382299F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D21D1C2306F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005071799A;
	Wed,  3 Jan 2024 08:42:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344318636;
	Wed,  3 Jan 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rKwVf-00042W-Un; Wed, 03 Jan 2024 09:21:55 +0100
Message-ID: <1c65dc20-774b-4271-aa5e-3ad2c1db5b1e@leemhuis.info>
Date: Wed, 3 Jan 2024 09:21:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Content-Language: en-US, de-DE
To: Michael Schaller <michael@5challer.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, macro@orcam.me.uk, ajayagarwal@google.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, gregkh@linuxfoundation.org,
 hkallweit1@gmail.com, michael.a.bottini@linux.intel.com,
 johan+linaro@kernel.org
References: <20240101221554.GA1693060@bhelgaas>
 <5598b690-12da-4237-b2bf-c9c691c4647c@5challer.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5598b690-12da-4237-b2bf-c9c691c4647c@5challer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704271343;69f8e9d3;
X-HE-SMSGID: 1rKwVf-00042W-Un

On 02.01.24 14:50, Michael Schaller wrote:
> On 01.01.24 23:15, Bjorn Helgaas wrote:
>> On Mon, Jan 01, 2024 at 07:57:40PM +0100, Michael Schaller wrote:
>>> On 01.01.24 19:13, Bjorn Helgaas wrote:
>>>> On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
>>>> ...
>>
>>>> So unless somebody has a counter-argument, I plan to queue a revert of
>>>> 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
>>>> v6.7.
>>>
>>> If it helps I could also try if a partial revert of 08d0cc5f3426
>>> would be
>>> sufficient. This might also narrow down the issue and give more insight
>>> where the issue originates from.
>>
>> We're so close to the v6.7 final release that I doubt we can figure
>> out the problem and test a fix before v6.7.  I'm sure Kai-Heng would
>> appreciate any additional data, but I don't think it's urgent at this
>> point.
> 
> We're indeed close to the final v6.7 release, which in turn means that a
> last minute revert of a 16 month old commit might cause even more
> regressions as there have been quite a few ASPM changes afterwards and
> there won't be much testing anymore before the final release.
> 
> Furthermore, given the age of the commit and that it has been backported
> to kernel 5.15, the question is also if the revert would be backported
> to the affected LTS kernels?
> 
> If this regression risk is acceptable then I'm all for reverting the
> commit now and then working on a fix.

FWIW (just in case some of you might not be aware of this): Linus not
that long ago said this about regressions that are somewhat older:

"""
There's obviously a time limit: if that "regression in an earlier
release" was a year or more ago, and just took forever for people to
notice, and it had semantic changes that now mean that fixing the
regression could cause a _new_ regression, then that can cause me to
go "Oh, now the new semantics are what we have to live with".
"""

For full context see:
https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

