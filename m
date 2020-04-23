Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497221B62B7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgDWRvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 13:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbgDWRvu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 13:51:50 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2DEC20857;
        Thu, 23 Apr 2020 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587664309;
        bh=6KM0KB+PvUFUfgNi+7pN69jYngCtJEP/2cKxibGIIQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToIL4StQfSDIZdYcoP6vMjyZKg+IvkIWYtsEBottzYfxNmRPvfEaXvap9lk7+H38o
         qzD4HDiVbD/f6VSMFmZDYcoxto92jIcnN/dz0pTmr6oba7HARzamYdOLruIk7FVwBb
         Oc6seR9Enis2mySZuYot+71RYA6jgcO4u2MtOVF8=
Received: by pali.im (Postfix)
        id D2CD376C; Thu, 23 Apr 2020 19:51:47 +0200 (CEST)
Date:   Thu, 23 Apr 2020 19:51:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/9] PCI: aardvark: don't write to read-only register
Message-ID: <20200423175147.vrl75tu2mpk5iju7@pali>
References: <20200421111701.17088-3-marek.behun@nic.cz>
 <20200423172713.GA191930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423172713.GA191930@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn!

On Thursday 23 April 2020 12:27:13 Bjorn Helgaas wrote:
> In the next round, please capitalize the first word of the subjects of
> the whole series to match:

Thank you for the review, I will fix subjects of all patches it in V3.

>   $ git log --oneline drivers/pci/controller/pci-aardvark.c
>   4e5be6f81be7 ("PCI: aardvark: Use pci_parse_request_of_pci_ranges()")
>   e078723f9ccc ("PCI: aardvark: Fix big endian support")
>   7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")
>   c0f05a6ab525 ("PCI: aardvark: Fix PCI_EXP_RTCTL register configuration")
>   f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready before training link")
>   364b3f1ff8f0 ("PCI: aardvark: Use LTSSM state to build link training flag")
> 
> The important thing for the subject of this patch is not the "don't
> write to read-only register" part; it's true that there's no point in
> writing to read-only registers, but removing that write would not fix
> any bugs.
> 
> The important thing is that we shouldn't blindly enable ASPM L0s, so
> that's what the subject should mention.

Ok understood, I will fix it in V3.
