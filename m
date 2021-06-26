Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC63B5025
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFZU5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 16:57:03 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31485 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFZU5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Jun 2021 16:57:02 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2021 16:57:02 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GC5Z45C8Zz9Y;
        Sat, 26 Jun 2021 22:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1624740525; bh=N3BHprkJhkvG8c5OZUcBjldm3+eO0q2pJn3cIdbUnEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7J4SSA1DiXs3EpahhSQb//SXpvQwA6+yFbBs73C0zcdAbQY34bn7ssK40TRSzQEp
         2RNivYNEYO7EbTHHTtGVzQjNb7dz6kWURY8IWVd1k93NIuUmvsrrlXqMloCGbBrxdb
         lC8XIFou1kxwmxkTOQe6sxxbETwihjMHEV0ZNq7p5g7uSRxLYBOT9EDJ+SzXZFXLxR
         K9PZ0wnMEAT2fPE7HlkhfBLlRwK8ONKlF9QFTCWtE+raQq9nlEOmYThBkdiKGKd4u7
         i9Ex+cIY89a8CA2ZNZZgPy+0gdoUS/4v9dOAj5WVaSwRgqEFSyiDGDNv2QmhKux6/r
         ZgtEMWAaAsFGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 26 Jun 2021 22:48:43 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, p.zabel@pengutronix.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <YNeSq7HcQOBza0x6@qmqm.qmqm.pl>
References: <1621213953-54030-1-git-send-email-tiantao6@hisilicon.com>
 <7e203ed5-526f-3a45-9f82-ba3f567bcc83@nvidia.com>
 <78dd0d27-aca7-9d99-a79d-8587a2fbbbfb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78dd0d27-aca7-9d99-a79d-8587a2fbbbfb@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 03:32:33PM +0530, Vidya Sagar wrote:
> I want to re-examine this patch.
> I don't see any references in the kernel where IRQ_NOAUTOEN is passed
> directly in request_irq APIs. It is always set explicitly through
> irq_set_status_flags() *before* calling request_irq APIs.
[...]

The request_irq() flag is called IRQF_NO_AUTOEN. As far as I can read
the cod, it does seem equivalent to changing irq_settings. I'm not sure
why we have two methods to do this in the kernel, though.

Hope that helps.

Best Regards
Micha³ Miros³aw
