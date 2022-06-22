Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC0554079
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356000AbiFVCWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355471AbiFVCWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:22:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CB33A13;
        Tue, 21 Jun 2022 19:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655864549; x=1687400549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSywI1O13gdKLcRQ8txL+vbe2gWSenpDSQ+axalbyU4=;
  b=g9mJ37LRCW+fZWIikcp9GpjmB4+flN6N1CyQESjNbHj55ZjT2GC8VcEC
   VadM1pAalo5WpWlyScHdRxgbO5xMmbqbzQEm+EB+52iqN5uOR1tv09S6e
   Z8WVttPxY+kTfTsSQ7wuvh6UG6InBm13F5bsGUr8q7/LcEIszQUol9Ae8
   HGAoZ7Zr296uxyR9OqydinayAHaIgWRmeowhBWjfjebakQDaMkv/Ta5VS
   tdbMxx0743SSQN++tiFHu0UJPspx6NUdYCZjrXeEX2DFsZtqBAN4SANw1
   bbxHVB6WlWW+TXvnAueO0SVu6pjwyzOoRxHp5cZnFpuPbQpAYp8lvHYcK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341975920"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="341975920"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="655422205"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2022 19:22:25 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3q0e-0000iW-HJ;
        Wed, 22 Jun 2022 02:22:24 +0000
Date:   Wed, 22 Jun 2022 10:22:14 +0800
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
Message-ID: <202206221053.GV7BYwqL-lkp@intel.com>
References: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm-randconfig-s032-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221053.GV7BYwqL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/intel-lab-lkp/linux/commit/b20efcc877829b6f416cf111bd5ad2b13a0cd08e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wang-Wenhu/mm-eliminate-ifdef-of-HAVE_IOREMAP_PROT-in-c-files/20220615-140135
        git checkout b20efcc877829b6f416cf111bd5ad2b13a0cd08e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: drivers/char/mem.o:(.rodata+0x144): undefined reference to `generic_access_phys'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
