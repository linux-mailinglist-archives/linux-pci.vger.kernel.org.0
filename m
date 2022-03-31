Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B14EDC96
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiCaPUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiCaPUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 11:20:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15951700BF
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 08:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79FD1B82146
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 15:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3348C340ED;
        Thu, 31 Mar 2022 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648739921;
        bh=PYLr8qp1wJdfbq/pUxCn3mH3CnhVoPA5ejUvs1YCAHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fN/vtJs2b9t0UNVL6YzKV2euqkJvjqW+OBhiClwnZELD9dX+COXQXCClME1KYS51y
         nCD/3Wjy/XzAa2ve2OiuY41qwQpoX5Bkjx+fCBOIYBGSaqlGut9TQBbC1eejErXvV/
         558LdtXPz3rOYokA0UcKRN0mN4NcB26meZDcLwd6K1nJzrW5/YBYVLayWSjMRKUQFA
         X5Hkd93CxNOLapyKEjVxJfLEZeQ3qXUj6L9YOFqz2JYDHKKSM+0/mj3uQvvSG83Rhf
         HADT+3iId28TgUMeblgjdGF6iQPBwbkAEATd4+C8anVhGz648OowJazVyLGm1eXa0S
         Wh2V2Z8+DUPrg==
Date:   Thu, 31 Mar 2022 10:18:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        YueHaibing <yuehaibing@huawei.com>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org
Subject: Re: [helgaas-pci:for-linus 4/4]
 drivers/pci/controller/pci-hyperv.c:1486:9: error: implicit declaration of
 function 'hv_set_msi_entry_from_desc'
Message-ID: <20220331151839.GA10149@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkTeyaGRutWCrZoE@thelio-3990X>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 03:50:49PM -0700, Nathan Chancellor wrote:
> On Thu, Mar 31, 2022 at 06:43:32AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> > head:   18146f25ac6695ce2ed09503de46dafd2b1f36a6
> > commit: 18146f25ac6695ce2ed09503de46dafd2b1f36a6 [4/4] PCI: hv: Remove unused hv_set_msi_entry_from_desc()
> > config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203310629.C8KmndLW-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=18146f25ac6695ce2ed09503de46dafd2b1f36a6
> >         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> >         git fetch --no-tags helgaas-pci for-linus
> >         git checkout 18146f25ac6695ce2ed09503de46dafd2b1f36a6
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/pci/controller/pci-hyperv.c: In function 'hv_irq_unmask':
> > >> drivers/pci/controller/pci-hyperv.c:1486:9: error: implicit declaration of function 'hv_set_msi_entry_from_desc' [-Werror=implicit-function-declaration]
> >     1486 |         hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> 
> 18146f25ac66 ("PCI: hv: Remove unused hv_set_msi_entry_from_desc()")
> does not have d06957d7a692 ("PCI: hv: Avoid the retarget interrupt
> hypercall in irq_unmask() on ARM64") as a parent, since it is only in
> mainline with no tag, whereas 18146f25ac66 is based on v5.17-rc7, which
> does not have the problem that 18146f25ac66 addresses.
> 
> I think that rebasing the pending fixes on the 5.18 PCI changes would
> properly resolve this.

Yep, sorry, I blew it.  I rebased my for-linus branch to 148a65047695
("Merge tag 'pci-v5.18-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"), which
does have d06957d7a692, and added this fix (PCI: hv: Remove unused
hv_set_msi_entry_from_desc()).
