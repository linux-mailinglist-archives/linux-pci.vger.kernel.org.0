Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708CE16DD7
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 01:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEGXcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 19:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGXcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 19:32:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DE7204FD;
        Tue,  7 May 2019 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557271932;
        bh=L7g4Lilcm1/YGr3V/gsofl8sG/YJE+vd1ca/w3DLfsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go474YudmVWHyYGAo8j2S+CHmWKPwqetHfQcqT4vGQxdvo/V7AcNmkkHB3WKMMoxN
         Xmg90IGH7g7triujtfpHN4mVOMKd8QzGWdmXXGJFFbm0ArcsdcO7R2ghNxAoRyqoOZ
         TVlZ25/iEL2nE/mVlRM3GWrTB/lb4JJVKOX7NCx0=
Date:   Tue, 7 May 2019 18:32:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v5 0/5] PCI: Patch series to support Thunderbolt without
 any BIOS support
Message-ID: <20190507233209.GH156478@google.com>
References: <PS2P216MB064229018EE9B0CE03EE274380370@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB064229018EE9B0CE03EE274380370@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 05, 2019 at 02:40:20PM +0000, Nicholas Johnson wrote:
> Since PATCH v4:
> 
> I have added some of the evidence and bug reports into the applicable
> patches.
> 
> Users of pci=hpmemsize should not notice any changes in functionality
> with this patch series when upgrading the kernel. I realised I could
> make the variable to achieve this reside in pci_setup, rather than
> globally.
> 
> Please let me know if anything else needs changing.
> 
> Nicholas Johnson (5):
>   PCI: Consider alignment of hot-added bridges when distributing
>     resources
>   PCI: Modify extend_bridge_window() to set resource size directly
>   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
>     window
>   PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size
>     independently

I didn't have time to go through the actual important stuff above,

>   PCI: Cleanup block comments in setup-bus.c to match kernel style

but I applied this one to pci/trivial for v5.2 to get it out of the
way for the next cycle.

I also have patches from Logan and Mika in the same area, so I'll have
to look at all of these together.

>  .../admin-guide/kernel-parameters.txt         |   7 +-
>  drivers/pci/pci.c                             |  18 +-
>  drivers/pci/setup-bus.c                       | 568 +++++++++---------
>  include/linux/pci.h                           |   3 +-
>  4 files changed, 317 insertions(+), 279 deletions(-)
> 
> -- 
> 2.19.1
> 
