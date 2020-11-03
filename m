Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8B2A4412
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgKCLUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 06:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgKCLUX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 06:20:23 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58329C0613D1;
        Tue,  3 Nov 2020 03:20:23 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CQS4j1msrzQlRK;
        Tue,  3 Nov 2020 12:20:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1604402419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ntKwVzau1rpH4tXAridL0K/HmVvW0PPupY9CHzUmhA=;
        b=cBYp90DOdgzcTd6ApYQxHZkUHqePpO38gCDqHxwguleNiVE9h7Z/KFcuhoW39WgfC9J7/g
        ZkMmwW5W6Rsjb2kubpNk1tMOugMoTwskCMcNREiijQCPDopduMm9SFW3vB6gwq5T+1SBs2
        T2dKyCwU38tf21VEwdzqsNyH31vKoTn2O1q9dM2XtvgcStIpZDnT1WWgL17AikLd69eZrE
        YB91umQWjfGgOezYo+Y8jOBkEpu0l5tHfDH53ztlhSYSONk0WniAZ8ltftMC4U9c0DCZZO
        Pz5oWnzH+3/AX1OZtU8VTIR1PwXbYamHdVjId3rEPqr8Sa9Az2NTK9Lrx7IAVQ==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id PnB2f-Ds9VKV; Tue,  3 Nov 2020 12:20:18 +0100 (CET)
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Thomas Krause <thomaskrause@posteo.de>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
References: <20201102205752.GA34153@bjorn-Precision-5520>
From:   Devin Bayer <dev@doubly.so>
Message-ID: <8996fd9c-0d6c-5c0c-670e-86c537509030@doubly.so>
Date:   Tue, 3 Nov 2020 12:20:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201102205752.GA34153@bjorn-Precision-5520>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.74 / 15.00 / 15.00
X-Rspamd-Queue-Id: 27E001778
X-Rspamd-UID: 5f2554
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/11/2020 21.57, Bjorn Helgaas wrote:
>>>
>>> CONFIG_IRQ_REMAP did not do the trick. I noticed that the Wi-Fi card
>>> is behind a PCI bridge which is also disabled, could this be a
>>> problem?

Just to provide another case, I have the same issue with this driver.

CONFIG_IRQ_REMAP=y and doesn't have any effect.

I'm unsure if the issue could be my system (Atom / Intel J1900) or the
that I'm using a slightly different card. Is there anyway to tell from the
lspci output? Here is what I guess is most relevant:

00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI Express Root Port 3 (rev 0e) (prog-if 00 [Normal decode])
        Memory behind bridge: d0000000-d0ffffff [size=16M]
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee08004  Data: 4021

03:00.0 Unassigned class [ff00]: Qualcomm Device 1101
        Subsystem: Qualcomm Device 0108
        Region 0: Memory at d0000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
                Address: fee01004  Data: 40ef
                Masking: ffffffff  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00

Thanks,
Devin
