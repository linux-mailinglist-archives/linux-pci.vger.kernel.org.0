Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE15740FA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 03:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiGNBhg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 21:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGNBhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 21:37:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFB222BB
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657762655; x=1689298655;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SfjMJdPnKhD7RxhE5U1tg1mCbMhNYSPAft9eTesceVg=;
  b=aOc4ocUa+xmkJb3m3uEuWT7FMOr1wz+zZhfMZXlT+1g6A3sORQM+yApr
   AiRj1hcKfx3ULPwBBBcbwlRqTwcZBdLKzoCoqQ3Pgnmm0yNgmFuVj87ia
   SqY5XZ4xlhNK/OqZ+8dEV5veRZF9GpKq70/1aCpkYzVfyUoO0eNvcsS6e
   asHpx6z27swBgcPvDjt5X4BDRpXNzZE3KiFHDzRHZlH0cc6xk4IBaBL3C
   bydYLFfrtu4CYgCh59lfGkJwVNug/5sl2gEA1uZyCkHvefDvC+BHg8Fp2
   twBvn9Cn8nl06/+ItMlGLahB4i9AZlZMj0Btt2AKfZCAgqbA8FkebYNOY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347069583"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="347069583"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="922873551"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 18:37:32 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBnnI-00043D-A3;
        Thu, 14 Jul 2022 01:37:32 +0000
Date:   Thu, 14 Jul 2022 09:36:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/ctrl/dwc-edma] BUILD SUCCESS
 8353813c88ef2186abf96715b5f29b191c9a7732
Message-ID: <62cf7339./VWuybh6aou8Jwbc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/dwc-edma
branch HEAD: 8353813c88ef2186abf96715b5f29b191c9a7732  PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

elapsed time: 1971m

configs tested: 13
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
