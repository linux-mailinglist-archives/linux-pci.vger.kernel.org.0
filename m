Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67921333B07
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 12:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhCJLGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 06:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhCJLFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 06:05:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A05164FE4;
        Wed, 10 Mar 2021 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615374337;
        bh=250n1SIL81Lob3W2vemslcjdvU/uN2/HJ6ayL4zyAdg=;
        h=Date:From:To:Subject:From;
        b=bxadrJ8dKI0MtUl/3oZdJqcTMiCFuxi3pl2rfz+6uMEVcOjrajdFcIEFsGdzmzvNB
         egtiP8g8GkEYQs14JzMqWhK8T0Xsnc9O0Q48Uj2Kl/tvvBZr1Bh8ik6UEm7ZpD8bU9
         QVjZL7FlD0i0Ct2j/B09eH5FT7Q0zcb9opfbOiMATJTT08pz15U1rEmXy0WpsL1OaQ
         TAUMm9u463LP3W/bMk1t1qsncTrnpQ3t1sOxadpFihfKtjlgnvfzLMZX2pXvB3isH5
         YiGNVnGBjvnYUdJ/1RR7F87Sbd4CjG2sQu4jvBuf/+uVseorVeIvJgHdoOqW4b0dZr
         BLRnzVP8bYn7A==
Received: by pali.im (Postfix)
        id 36836A83; Wed, 10 Mar 2021 12:05:35 +0100 (CET)
Date:   Wed, 10 Mar 2021 12:05:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Amey Narkhede <ameynarkhede02@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How long should be PCIe card in Warm Reset state?
Message-ID: <20210310110535.zh4pnn4vpmvzwl5q@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I would like to open a question about PCIe Warm Reset. Warm Reset of
PCIe card is triggered by asserting PERST# signal and in most cases
PERST# signal is controlled by GPIO.

Basically every native Linux PCIe controller driver is doing this Warm
Reset of connected PCIe card during native driver initialization
procedure.

And now the important question is: How long should be PCIe card in Warm
Reset state? After which timeout can be PERST# signal de-asserted by
Linux controller driver?

Lorenzo and Rob already expressed concerns [1] [2] that this Warm Reset
timeout should not be driver specific and I agree with them.

I have done investigation which timeout is using which native PCIe
driver [3] and basically every driver is using different timeout.

I have tried to find timeouts in PCIe specifications, I was not able to
understand and deduce correct timeout value for Warm Reset from PCIe
specifications. What I have found is written in my email [4].

Alex (as a "reset expert"), could you look at this issue?

Or is there somebody else who understand PCIe specifications and PCIe
diagrams to figure out what is the minimal timeout for de-asserting
PERST# signal?

There are still some issues with WiFi cards (e.g. Compex one) which
sometimes do not appear on PCIe bus. And based on these "reset timeout
differences" in Linux PCIe controller drivers, I suspect that it is not
(only) the problems in WiFi cards but also in Linux PCIe controller
drivers. In my email [3] I have written that I figured out that WLE1216
card needs to be in Warm Reset state for at least 10ms, otherwise card
is not detected.

[1] - https://lore.kernel.org/linux-pci/20200513115940.fiemtnxfqcyqo6ik@pali/
[2] - https://lore.kernel.org/linux-pci/20200507212002.GA32182@bogus/
[3] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
[4] - https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/
