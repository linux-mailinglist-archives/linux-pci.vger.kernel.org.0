Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9515219AED6
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbgDAPf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 11:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbgDAPf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 11:35:59 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E6420CC7;
        Wed,  1 Apr 2020 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585755358;
        bh=8KrpUa+AUpMHC4Mq0y/PVswlQDU1AfW/xcFy2ETDmEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vkcq5LGO1TClLix1FhtAvVOUr7eWYHNRhimq7DcmANCOwkuWiN8M+ZQU/CoZjKDoH
         1i8kOv3FPoaTd1wNPwJH5wFwFD596f24Pqn/E60YxcfAScTUQkcbX00pRjuhycurlb
         84GS9IpaGbiisyrlTR2ks02MPl+NWsDBv4ozouDg=
Date:   Wed, 1 Apr 2020 10:35:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [linux-next:master 12786/13335] aarch64-linux-objdump: warning:
 drivers/pci/pcie/edr.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
Message-ID: <20200401153556.GA62560@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401152157.GA60873@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 01, 2020 at 10:22:00AM -0500, Bjorn Helgaas wrote:
> [+cc Sathy, Catalin, linux-pci]
> 
> On Wed, Apr 01, 2020 at 09:56:53PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   3eb7cccdb3ae41ebb6a2f5f1ccd2821550c61fe1
> > commit: 91db57acf85cc283cea7ed5d198e7f2e0c013d1e [12786/13335] Merge remote-tracking branch 'pci/next'
> > config: arm64-allyesconfig (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 91db57acf85cc283cea7ed5d198e7f2e0c013d1e
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=9.3.0 make.cross ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> aarch64-linux-objdump: warning: drivers/pci/pcie/edr.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> 
> I don't think this is an issue with edr.c.  I suspect this is the
> toolchain issue mentioned here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2020-April/721695.html

Sorry, here's a better link.  Google doesn't do a very good job of
indexing lore.kernel.org for some reason (I poked the kernel.org folks
to see if there's an obvious reason).

https://lore.kernel.org/linux-arm-kernel/20200401122805.GD9434@mbp/T/#u
