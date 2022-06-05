Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357F53DC8F
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiFEPYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jun 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiFEPYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jun 2022 11:24:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42132715B;
        Sun,  5 Jun 2022 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654442691; x=1685978691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yikPlj0wND/Abtn5F66hdIjP6Y6XeK5dIgxnMBNJi40=;
  b=U+n8p0VY44arlYpS+MtRouMvM+fIUVF9+GdLvMRlMI3Kt911/oc3phPa
   tIM0+4wFSJpLkKqgFhVy8Vth37Pz8HWSkzSzK/5XKoIRayadsx1W3sAG5
   3TgLF8vPah/aBcIQ2TWv9b7XDJaLpms/R4F+leWfz7Jp76Udz+qrun91F
   fsWTYqROQ05UUvFdbjzub63c65o2qpuNgfodl3s27cvoShxGi8RcHc3um
   9l9dBmXWyNTXsUOPg08He5h1NoqQUnA6NJZK26F/8rHZjL+ODX5kYcHBB
   nXhob77A7yraZR+kxNN2j3LMRHVSrjZUHUgdeVsMVp3AHXcLIVFmzYcJA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="264263845"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="264263845"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 08:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="613952476"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jun 2022 08:24:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxs7S-000C1B-UN;
        Sun, 05 Jun 2022 15:24:46 +0000
Date:   Sun, 5 Jun 2022 23:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 1/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <202206052344.Lkv2vI5x-lkp@intel.com>
References: <20220603084454.1861142-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603084454.1861142-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.18]
[also build test ERROR on next-20220603]
[cannot apply to clk/clk-next helgaas-pci/next agross-msm/qcom/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/PCI-qcom-Rework-pipe_clk-pipe_clk_src-handling/20220605-164136
base:    4b0986a3613c92f4ec1bdc7f60ec66fea135991f
config: mips-randconfig-r005-20220605 (https://download.01.org/0day-ci/archive/20220605/202206052344.Lkv2vI5x-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4fbc2ca1313223feb409121fa1028557f72a310b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Baryshkov/PCI-qcom-Rework-pipe_clk-pipe_clk_src-handling/20220605-164136
        git checkout 4fbc2ca1313223feb409121fa1028557f72a310b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/clk-regmap-phy-mux.c:30:8: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           val = FIELD_GET(PHY_MUX_MASK, val);
                 ^
>> drivers/clk/qcom/clk-regmap-phy-mux.c:44:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                     FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
                                     ^
   drivers/clk/qcom/clk-regmap-phy-mux.c:54:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                              FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC));
                              ^
   3 errors generated.


vim +/FIELD_GET +30 drivers/clk/qcom/clk-regmap-phy-mux.c

    22	
    23	static int phy_mux_is_enabled(struct clk_hw *hw)
    24	{
    25		struct clk_regmap *clkr = to_clk_regmap(hw);
    26		struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
    27		unsigned int val;
    28	
    29		regmap_read(clkr->regmap, phy_mux->reg, &val);
  > 30		val = FIELD_GET(PHY_MUX_MASK, val);
    31	
    32		WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
    33	
    34		return val == PHY_MUX_PHY_SRC;
    35	}
    36	
    37	static int phy_mux_enable(struct clk_hw *hw)
    38	{
    39		struct clk_regmap *clkr = to_clk_regmap(hw);
    40		struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
    41	
    42		return regmap_update_bits(clkr->regmap, phy_mux->reg,
    43					  PHY_MUX_MASK,
  > 44					  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
