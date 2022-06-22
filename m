Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B739554156
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 06:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356650AbiFVEOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 00:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356942AbiFVENw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 00:13:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9A34B90;
        Tue, 21 Jun 2022 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655871220; x=1687407220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B/bYItcHLvNJYHpcF6HLJkuCKPwbVggAy5q3voJHv0A=;
  b=Xy75RLUJsTjQf/t4bpFjms6CUbxXOKdwZtH/rku9CdRs9IGEBpTqRFPw
   Owro08vFAPEZC6shbpauPeZ4dJSE4/HYaiC7jNvTLHLi9KdVaWL75URTA
   gDbcNfsTOK63RoCgEc6VruUFZMohCEKJfUoM6xlRMbt5XdB4ACFvadHvw
   TUYGFb4dQcgPIHT9wjC07KfAwWyQwZtnUoasFuZnH0GLCW9x7JmF7sCC9
   E/cepmIi4ba4X2C+VrOtL6mFmqihANygrCMsOVhcVUDRKx8bjO0Paj24u
   Dfz9ibrgvHXGeUt4UsfKBwTMP1KpOJCv3a8uh4EDFPS++EsDRPbDrwEmp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277855656"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="277855656"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="715230316"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2022 21:13:35 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3rkA-0000on-5h;
        Wed, 22 Jun 2022 04:13:30 +0000
Date:   Wed, 22 Jun 2022 12:13:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Wenhu <wenhu.wang@hotmail.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, bhelgaas@google.com, akpm@linux-foundation.org,
        linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, wenhu.wang@hotmail.com
Subject: Re: [PATCHv2 1/2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c
 files
Message-ID: <202206221102.w7hylFXN-lkp@intel.com>
References: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Wenhu/mm-eliminate-ifdef-of-HAVE_IOREMAP_PROT-in-c-files/20220615-140135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: m68k-buildonly-randconfig-r001-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221102.w7hylFXN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b20efcc877829b6f416cf111bd5ad2b13a0cd08e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wang-Wenhu/mm-eliminate-ifdef-of-HAVE_IOREMAP_PROT-in-c-files/20220615-140135
        git checkout b20efcc877829b6f416cf111bd5ad2b13a0cd08e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> m68k-linux-ld: drivers/char/mem.o:(.rodata+0x37c): undefined reference to `generic_access_phys'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
