Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F031591B8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgBKOUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 09:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbgBKOUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 09:20:07 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2592086A;
        Tue, 11 Feb 2020 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581430806;
        bh=qUHvt02++DB65GtvuVl4+RfZ0lZlxaxq+z1TmR4f2wQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UYMmnnZdAcFaaPD/AUJqyqxfCbpvFYdNm6E4j6PbsN7g3LgMKQaaA1f/pRbatquaV
         cBtYdyVzixyYBLm1qr/zQJrcDrGOCKor7y4DDRV4d/X38EbjWYkB0blLQ86kOHoy3/
         oJVQx4jRgnyCf59e9cRKzsfTOxOKmJvvuoBZtMMc=
Date:   Tue, 11 Feb 2020 08:20:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [pci:pci/hotplug 2/3] drivers/pci/hotplug/pciehp_hpc.c:268:12:
 error: 'ctrl' undeclared; did you mean 'to_ctrl'?
Message-ID: <20200211142005.GA207907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002111451.U5ATnnUR%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 02:04:54PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
> head:   c4e85e3f147644d222f7d2da21a812f8ff3b7cbc
> commit: 8fe64774eb64d97900d4b0551b6cbedfe4358636 [2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
> config: sparc64-randconfig-a001-20200211 (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8fe64774eb64d97900d4b0551b6cbedfe4358636
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/device.h:15:0,
>                     from include/linux/pci.h:37,
>                     from drivers/pci/hotplug/pciehp_hpc.c:21:
>    drivers/pci/hotplug/pciehp_hpc.c: In function 'pcie_wait_for_presence':
> >> drivers/pci/hotplug/pciehp_hpc.c:268:12: error: 'ctrl' undeclared (first use in this function); did you mean 'to_ctrl'?
>      ctrl_info(ctrl, "Timeout waiting for Presence Detect\n");
>                ^
>    include/linux/dev_printk.h:110:12: note: in definition of macro 'dev_info'
>      _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
> >> drivers/pci/hotplug/pciehp.h:40:2: note: in expansion of macro 'pci_info'
>      pci_info(ctrl->pcie->port, format, ## arg)
>      ^~~~~~~~
> >> drivers/pci/hotplug/pciehp_hpc.c:268:2: note: in expansion of macro 'ctrl_info'
>      ctrl_info(ctrl, "Timeout waiting for Presence Detect\n");
>      ^~~~~~~~~
>    drivers/pci/hotplug/pciehp_hpc.c:268:12: note: each undeclared identifier is reported only once for each function it appears in
>      ctrl_info(ctrl, "Timeout waiting for Presence Detect\n");
>                ^
>    include/linux/dev_printk.h:110:12: note: in definition of macro 'dev_info'
>      _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
> >> drivers/pci/hotplug/pciehp.h:40:2: note: in expansion of macro 'pci_info'
>      pci_info(ctrl->pcie->port, format, ## arg)
>      ^~~~~~~~
> >> drivers/pci/hotplug/pciehp_hpc.c:268:2: note: in expansion of macro 'ctrl_info'
>      ctrl_info(ctrl, "Timeout waiting for Presence Detect\n");
>      ^~~~~~~~~

My fault, fixed.  Sorry, don't know what I was thinking.  Obviously
not much.
