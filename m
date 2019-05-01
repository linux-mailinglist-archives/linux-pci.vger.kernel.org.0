Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3649810E15
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfEAUdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 16:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfEAUdH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 16:33:07 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4109320656;
        Wed,  1 May 2019 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556742787;
        bh=LdTsRCzaoQNzrcoNA2nRbCTlGfrrWBYSxkvRUBHq8nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xf/9OnhSqMDDSqm2TzMFntvGjJ0UePj1Y9KjdmVnz8ElJT2PlWHfauj3jbNaYxn3z
         gQ/G5IGFI+gErVIy+hpf6oLzNq8+TS1GWn2Fy677Be3fJIGml4RVxC0MUwgv3VFWQm
         kw72VJRnAkqpp4ChpiRuuyXvVwGn1L++6noqw9ks=
Date:   Wed, 1 May 2019 15:33:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:for-linus 7/7] portdrv_pci.c:undefined reference to
 `pcie_bandwidth_notification_init'
Message-ID: <20190501203306.GB47079@google.com>
References: <201905020410.fUt0VDkK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905020410.fUt0VDkK%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 04:19:13AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> head:   302b77157e6689d047d9e668ad1aadfa7a267940
> commit: 302b77157e6689d047d9e668ad1aadfa7a267940 [7/7] PCI/LINK: Add Kconfig option (default off)
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 302b77157e6689d047d9e668ad1aadfa7a267940
>         # save the attached .config to linux build tree
>         make ARCH=i386 

302b77157e66 was the first version of the patch, which I speculatively
applied before Keith's ack.  I've already replaced it with his v2 patch,
which should fix this issue, so no action needed AFAIK.

> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/pci/pcie/portdrv_pci.o: in function `pcie_portdrv_init':
> >> portdrv_pci.c:(.init.text+0x78): undefined reference to `pcie_bandwidth_notification_init'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


