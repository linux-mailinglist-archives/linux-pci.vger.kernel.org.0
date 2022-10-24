Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D060A178
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJXLYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 07:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJXLYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 07:24:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830A29C8B;
        Mon, 24 Oct 2022 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666610693; x=1698146693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8WS9k6yY1h4VYlMCjfVXccX+U9VMX2rJ72saF3NwIgw=;
  b=CQsoYfkI6dpwm53hpePSMtPEje5A/SgH/pLJZMi9u2hJ6S25khBUA4+4
   ay+hmQ+LJZPn06OGkbVGefjIS1CzMbaZRwrpKRbMt/lbq4KIp6W/ZThHf
   cxkTEVocUwkdShNZD42Ngl1IxivEFnC2CrFagcPtPM2bvZb+Mb40GL88M
   SvEVnWYPt6RQTLtUFTcIRF/kIFy6UxJ3rjA3qa+Cl9dBW/davW8fVCN/A
   +XPHckLWGJtJapIrr2HpfyxvhO/lIVaMNzmg28AJuY+dNUJmMrlPCwa1Z
   bnapHU9VZPb8TXzx34uCtF4C5qPb9Lk3/8U/b5EIn9AIXECtJai/Rb+zn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="287111466"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287111466"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="664511203"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="664511203"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2022 04:24:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5F887291; Mon, 24 Oct 2022 14:25:12 +0300 (EEST)
Date:   Mon, 24 Oct 2022 14:25:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
 <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 24, 2022 at 02:13:10PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Oct 14, 2022 at 03:48:58PM +0100, Jonathan Cameron wrote:
> > > Thanks for the detailed report! I wonder if you could try the below
> > > patch and see if it changes anything?
> > Thanks for the quick response.
> > 
> > Doesn't fix it unfortunately.
> 
> I'm back now.
> 
> Trying to reproduce this with mainline kernel (arm64 defconfig) and the
> following command line:
> 
> qemu-system-aarch64 \
>         -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
>         -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
>         -nographic -no-reboot  \
>         -kernel Image \
>         -initrd rootfs.cpio.bz2 \
>         -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
>         -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
>         -device e1000,bus=root_port13,addr=0.1 \
>         -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3 \
>         -device e1000,bus=fun1
> 
> But the resulting PCIe topology is pretty flat:
> 
> # lspci
> 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> 00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
> 
> I wonder what I'm missing here? Do I need to enable additional drivers
> to get the topology to resemble yours?

Nevermind, I was missing one \ in the command line ;-) Now I can see the
topology similar to yours.
