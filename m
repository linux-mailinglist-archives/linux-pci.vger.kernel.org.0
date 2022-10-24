Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E25D609FEE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJXLNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJXLNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 07:13:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562E3BC6E;
        Mon, 24 Oct 2022 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666609974; x=1698145974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDfM8jGZjDfRkbfYuPxY5RjqRTTZCt2OQ32W3baC7Dc=;
  b=UwEGJkGgeLJmqQ31dTaoV2h9gdgbGVk73k4DeY8YVUDtjgvfGKlMoSU3
   ryMoJGrWYuEvWvAjU3woTnFs9dUntjTcmOFd3Hm9dsSTNHP35aTWAwCaY
   dHW720OfuFillBINz6ZkA0leRP1m5A+Au03XqAQphjYtHtMNgVa+QFGOP
   n5a46vbczN92k1F03nNdwwnclLCA1fGNNOPqd6NuLRhgeslsEoWOlSQkw
   270Xzg+wNGlwXFwZvb6ru/r9sHy2RqH1zzPKAxJvzfybNPzhCdPZkgZF2
   sAqJyl5A0gWgBdd6mXGukboN6uGcrClS4Fj5uCnV0NbeJaYVbzpw1QyXY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="307380897"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="307380897"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="626038379"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="626038379"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 04:12:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A6EE1291; Mon, 24 Oct 2022 14:13:10 +0300 (EEST)
Date:   Mon, 24 Oct 2022 14:13:10 +0300
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
Message-ID: <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014154858.000079f2@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Oct 14, 2022 at 03:48:58PM +0100, Jonathan Cameron wrote:
> > Thanks for the detailed report! I wonder if you could try the below
> > patch and see if it changes anything?
> Thanks for the quick response.
> 
> Doesn't fix it unfortunately.

I'm back now.

Trying to reproduce this with mainline kernel (arm64 defconfig) and the
following command line:

qemu-system-aarch64 \
        -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
        -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
        -nographic -no-reboot  \
        -kernel Image \
        -initrd rootfs.cpio.bz2 \
        -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
        -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
        -device e1000,bus=root_port13,addr=0.1 \
        -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3 \
        -device e1000,bus=fun1

But the resulting PCIe topology is pretty flat:

# lspci
00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device

I wonder what I'm missing here? Do I need to enable additional drivers
to get the topology to resemble yours?
