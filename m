Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4AF08BC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfKEVwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 16:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfKEVwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 16:52:46 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817CB2087E;
        Tue,  5 Nov 2019 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572990765;
        bh=sxWNe4Y2/PkPNShgV5wtkZvVWle4xhmQnfovMknBEd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kpfdMOPrVN92TidRBOejA3G/f0HNWzJf/0diHw62uvbMJqcbUDl8nWbHtUGXXtpGR
         lQxkzQ366fNPOCTLwW2FGqjdBEWnDhRDCYhxENauOkW/etAM/8ekgFUAR5TydekA9U
         gIvcQ1uWKKFJUNLVzjLLS8BR5RMvIM5MuPFzTMgA=
Date:   Tue, 5 Nov 2019 15:52:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI/PM: Minor fix and cleanups
Message-ID: <20191105215244.GA37902@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 01, 2019 at 03:45:52PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> First, fix our D2 delay (which I think was just a bug -- we delayed in
> microseconds instead of milliseconds, but I'm not sure we really even use
> D2).
> 
> The rest are just cleanups that should not change any behavior.  These are
> based on my current pci/pm branch (0d1685046e61) and I pushed them to
> pci/pm-2 for now.

I applied these with Rafael's reviewed-by (thanks!) to my pci/pm
branch for v5.5.

> Bjorn Helgaas (6):
>   PCI/PM: Apply D2 delay as milliseconds, not microseconds
>   PCI/PM: Expand PM reset messages to mention D3hot (not just D3)
>   PCI/PM: Simplify pci_set_power_state()
>   xen-platform: Convert to generic power management
>   PCI/PM: Remove unused pci_driver.resume_early() hook
>   PCI/PM: Remove unused pci_driver.suspend_late() hook
> 
>  Documentation/power/pci.rst | 10 ++++-----
>  drivers/pci/pci-driver.c    | 43 ++++++-------------------------------
>  drivers/pci/pci.c           |  8 +++----
>  drivers/xen/platform-pci.c  | 10 ++++++---
>  include/linux/pci.h         |  4 ----
>  5 files changed, 22 insertions(+), 53 deletions(-)
> 
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
