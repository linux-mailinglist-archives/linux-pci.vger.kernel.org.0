Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB114582CA
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 10:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhKUJqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 04:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhKUJqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 04:46:39 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FAC061574
        for <linux-pci@vger.kernel.org>; Sun, 21 Nov 2021 01:43:34 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mojNi-0003AD-R7; Sun, 21 Nov 2021 10:43:30 +0100
Message-ID: <496aaef5-e542-342c-42ef-ccbc2833df7c@leemhuis.info>
Date:   Sun, 21 Nov 2021 10:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: PCIe regression on APM Merlin (aarch64 dev platform) preventing
 NVME initialization
Content-Language: en-BW
To:     =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        linux-pci@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637487814;cc57a2b3;
X-HE-SMSGID: 1mojNi-0003AD-R7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

CC in the regressions list.

On 18.11.21 19:10, Stéphane Graber wrote:
>
> I've recently been given access to a set of 4 APM X-Gene2 Merlin
> boards (old-ish development platform).
> Running them on Ubuntu 20.04's stock 5.4 kernel worked fine but trying
> to run anything else would fail to boot due to a NVME initialization
> timeout preventing the main drive from showing up at all.
> 
> Tracking this issue, I first moved to clean mainline kernels and then
> isolated the issue to be somewhere between 5.4.0 and 5.5.0-rc1, which
> sadly meant the merge window (so much for a quick bisect...). I've
> then bisected between those two points and came up with:
> 
>   6dce5aa59e0bf2430733d7a8b11c205ec10f408e (refs/bisect/bad) PCI:
> xgene: Use inbound resources for setup

TWIMC: To be sure this issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 6dce5aa59e0bf2430733d7a8b11c205ec10f408e
#regzbot ignore-activity

Ciao, Thorsten, your Linux kernel regression tracker.


P.S.: If you want to know more about regzbot, check out its
web-interface, the getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for the reporter: when reporting a regression it's in your interest
to tell #regzbot about it in the report, as that will ensure the
regression gets on the radar of regzbot and the regression tracker.
That's in your interest, as they will make sure the report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot, just
fix the issue as you normally would. Just remember to include a 'Link:'
tag to the report in the commit message, as explained in
Documentation/process/submitting-patches.rst, which recently was made
more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c
