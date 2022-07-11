Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95795570D31
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGKWKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGKWKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:10:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72219248D6
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 15:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21A6BB81205
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 22:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9617FC34115;
        Mon, 11 Jul 2022 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657577428;
        bh=ZQBiXtGL+ZHBagQBJXK1HHTuODXllDo/Re3h/l2Dz7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TrdVZgqyesIrVA4tuRAtPSrq/7iH1q4XL/MLUvErnRl7h/S0k+RaOSq+IXrflYMMp
         tJgyvcMYlJGxeeOc8Y/+TWUtOZ7lUdGnbOCvLpv3cTCcT7F4srh3OsHiVwd8IucnSD
         Y95VtJrX1As/wLQniElor41SnK1MbPRaxR2GDKltQQdb6/9Ou8KEoqzXlH5nPzevy6
         NXw2wM1U6rtHT1ouz/oK+0fCKCOVe9yE+B8c/A00tynXsqMq+vNvUd5MBatmuJXRnX
         zy/UabyYDMgkVtqWHAuwZBypk+3hDr3JJuovNfaJdVY01E77atyVbzBi9aVs1Yw3FI
         x4390W0efrd1Q==
Date:   Mon, 11 Jul 2022 17:10:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Robert Marko <robimarko@gmail.com>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org
Subject: Re: [helgaas-pci:pci/ctrl/qcom-pending 3/8]
 drivers/pci/controller/dwc/pcie-qcom.c:410:9: error: 'ret' undeclared; did
 you mean 'net'?
Message-ID: <20220711221027.GA696464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207120610.HglByhl1-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 06:02:13AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom-pending
> head:   1a88605a3efd70bcd01aeb02494386f05f5dce8f
> commit: cdb32283bcf202d0db512abb80794056d44e7e9f [3/8] PCI: qcom: Move all DBI register accesses after phy_power_on()
> config: riscv-randconfig-r016-20220710 (https://download.01.org/0day-ci/archive/20220712/202207120610.HglByhl1-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=cdb32283bcf202d0db512abb80794056d44e7e9f
>         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>         git fetch --no-tags helgaas-pci pci/ctrl/qcom-pending
>         git checkout cdb32283bcf202d0db512abb80794056d44e7e9f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_post_init_2_1_0':
> >> drivers/pci/controller/dwc/pcie-qcom.c:410:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
>      410 |         ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);

Sheesh.  My fault, fixed.

Bjorn
