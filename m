Return-Path: <linux-pci+bounces-568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB1806F3D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 12:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851551F21597
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B054321B9;
	Wed,  6 Dec 2023 11:54:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB81986;
	Wed,  6 Dec 2023 03:54:17 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rAqTn-0000PU-8z; Wed, 06 Dec 2023 12:54:15 +0100
Message-ID: <cb450c07-2df2-45a7-a77a-25ce2a0a18bc@leemhuis.info>
Date: Wed, 6 Dec 2023 12:54:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Content-Language: en-US, de-DE
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-3-helgaas@kernel.org>
 <20231012153347.GA26695@polanet.pl>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20231012153347.GA26695@polanet.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701863657;e3b9cb1e;
X-HE-SMSGID: 1rAqTn-0000PU-8z

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 12.10.23 17:33, Tomasz Pala wrote:
> Hello,
> 
> On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:
> 
>> Normally we reject ECAM space unless it is reported as reserved in the E820
>> table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
>> means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> 
> I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.

#regzbot fix: x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02
_CRS
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

