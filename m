Return-Path: <linux-pci+bounces-2097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F177482C001
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 13:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805D0B20DC5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCCD41C67;
	Fri, 12 Jan 2024 12:51:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250D6BB22;
	Fri, 12 Jan 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rOH02-0000Pz-QE; Fri, 12 Jan 2024 13:51:02 +0100
Message-ID: <0cae38cd-5d3d-4cb8-b5eb-680afd977e0d@leemhuis.info>
Date: Fri, 12 Jan 2024 13:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Keystone PCI driver probing and SerDes PLL timeout
Content-Language: en-US, de-DE
To: Diogo Ivo <diogo.ivo@siemens.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
 tjoseph@cadence.com, linux-pci@vger.kernel.org, ylal@codeaurora.org,
 regressions@lists.linux.dev, jan.kiszka@siemens.com
References: <20240111141331.3715265-1-diogo.ivo@siemens.com>
 <2024011246-corned-disregard-7123@gregkh>
 <1cce86b1-b309-40e0-afff-45baeb013e1f@siemens.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1cce86b1-b309-40e0-afff-45baeb013e1f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705063879;4e16f47d;
X-HE-SMSGID: 1rOH02-0000Pz-QE

On 12.01.24 12:46, Diogo Ivo wrote:
> On 1/12/24 07:57, Greg KH wrote:
>> On Thu, Jan 11, 2024 at 02:13:30PM +0000, Diogo Ivo wrote:
>>>
>>> When testing the IOT2050 Advanced M.2 platform with Linux CIP 6.1
>>> we came across a breakage in the probing of the Keystone PCI driver
>>> (drivers/phy/ti/pci-keystone.c). This probing was working correctly
>>> in the previous version we were using, v5.10.
>>>
>>> In order to debug this we changed over to mainline Linux and bissecting
>>> lead us to find that commit e611f8cd8717 is the culprit, and with it
>>> applied
>>> we get the following messages:
>>>
>>> [   10.954597] phy-am654 910000.serdes: Failed to enable PLL
>>> [   10.960153] phy phy-910000.serdes.3: phy poweron failed --> -110
>>> [   10.967485] keystone-pcie 5500000.pcie: failed to enable phy
>>> [   10.973560] keystone-pcie: probe of 5500000.pcie failed with error
>>> -110
>>>
>>> This timeout is occuring in serdes_am654_enable_pll(), called from the
>>> phy_ops .power_on() hook.
>>>
>>> Due to the nature of the error messages and the contents of the
>>> commit we
>>> believe that this is due to an unidentified race condition in the
>>> probing of
>>> the Keystone PCI driver when enabling the PHY PLLs, since changes in the
>>> workqueue the deferred probing runs on should not affect if probing
>>> works
>>> or not. To further support the existence of a race condition, commit
>>> 86bfbb7ce4f6 (a scheduler commit) fixes probing, most likely
>>> unintentionally
>>> meaning that the problem may arise in the future again.
>>>
>>> One possible explanation is that there are pre-requisites for
>>> enabling the PLL
>>> that are not being met when e611f8cd8717 is applied; to see if this
>>> is the case
>>> help from people more familiar with the hardware details would be
>>> useful.
>>>
>>> As official support specifically for the IOT2050 Advanced M.2
>>> platform was
>>> introduced in Linux v6.3 (so in the middle of the commits mentioned
>>> above)
>>> all of our testing was done with the latest mainline DeviceTree with [1]
>>> applied on top.
>>>
>>> This is being reported as a regression even though technically things
>>> are
>>> working with the current state of mainline since we believe the
>>> current fix
>>> to be an unintended by-product of other work.
>>>
>>> #regzbot introduced: e611f8cd8717
>> A "regression" for a commit that was in 5.13, i.e. almost 2 years ago,
>> is a bit tough, and not something I would consider really a "regression"
>> as it is core code that everyone runs.

In case anyone cares: I'd call it a regression, but not one where the
"no regressions" rule applies. Primarily because the regression does not
 happen anymore in mainline (even if that was by chance). Furthermore I
think Linus once said that regressions become just bugs when they are
reported only after quite some time. Not sure if that is the case here,
but whatever, due to the previous point discussing this is moot. That's
why I'll drop it from the tracking:

#regzbot inconclusive: fixed in mainline (maybe accidentally), but not
in stable

> I see the point that this code has been living in the kernel for a
> long time now and that it becomes more difficult to justify it as
> a regression; I reported it as such based on the supposition that
> the current fix is not the proper one and that technically this
> support was broken between the identified commits.

True, but it apparently also doesn't happen anymore in mainline. To
technically nobody is afaics obliged to look into this afaics.

Of course it still would be nice to resolve this in the affected
longterm series. And hey, with a bit of luck this thread might lead to a
fix one way or another. I hope that will be the case!

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

