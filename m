Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8623454892
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbhKQOYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238513AbhKQOXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:14 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3F661BE3;
        Wed, 17 Nov 2021 14:20:16 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mnLnI-0065lc-9p; Wed, 17 Nov 2021 14:20:14 +0000
Date:   Wed, 17 Nov 2021 14:20:11 +0000
Message-ID: <87wnl67tk4.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Yuji Nakao <contact@yujinakao.com>
Cc:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
In-Reply-To: <87sfvuvqhg.fsf@yujinakao.com>
References: <87h7ccw9qc.fsf@yujinakao.com>
        <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
        <YZQ+GhRR+CPbQ5dX@rocinante>
        <8735nv880m.wl-maz@kernel.org>
        <87sfvuvqhg.fsf@yujinakao.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: contact@yujinakao.com, kw@linux.com, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, arnd@arndb.de, sashal@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>
> I installed plane 5.16-rc1 using pre-built image[1] by linux-mainline
> aur package[2] maintainer and 5.16-rc1 with the patch provided from
> Mark. Both versions succeeded to boot. Thank you for quick
> investigation. I'll wait for backporting the fix.

So vanilla 5.16-rc1 works correctly on your machine, without any other
patch?

If so, I don't know what fixed it. Someone with the right HW should
try and identify the fix so that we can backport it.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
