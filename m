Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D166709409
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjESJt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjESJtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 05:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F37A1;
        Fri, 19 May 2023 02:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B755461135;
        Fri, 19 May 2023 09:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880E7C433D2;
        Fri, 19 May 2023 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684489761;
        bh=JMyICyhpRS78nuPulWLReiYzHDvjBhYVqIXty0eAsEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdbeGFUx0Rf2qD281dHeVnTbaoklQ9oPEMXxDkNZP0xuM3defzaqDyB2/kp3r1Rfd
         a0babOIp1nEj6BgamEN9dtojFSnjbUMc8hc4ibWLb/Dw+zhJOP59P0XFao53FlQazJ
         KTeuHUH7K+Ai5fcdC6cB3hIRoRRtyoB4hBb1q+3M=
Date:   Fri, 19 May 2023 10:49:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     kernel test robot <lkp@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
Message-ID: <2023051951-snuff-fit-4cf6@gregkh>
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
 <202305190105.O6ycxCti-lkp@intel.com>
 <933c829f-0d27-f3b9-3db6-f2211495b086@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <933c829f-0d27-f3b9-3db6-f2211495b086@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 03:13:20PM +0800, zhuyinbo wrote:
> 
> 
> 在 2023/5/19 上午1:52, kernel test robot 写道:
> > Hi Yinbo,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on pci/next]
> > [also build test ERROR on pci/for-linus westeri-thunderbolt/next linus/master v6.4-rc2 next-20230518]
> > [cannot apply to usb/usb-testing usb/usb-next usb/usb-linus]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/usb-dwc2-add-pci_device_id-driver_data-parse-support/20230518-173721
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > patch link:    https://lore.kernel.org/r/20230518092240.8023-1-zhuyinbo%40loongson.cn
> > patch subject: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
> > config: powerpc-allmodconfig
> > compiler: powerpc-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://github.com/intel-lab-lkp/linux/commit/3ff56448e1442fe8b1e72651a8d4d6e1086ece32
> >          git remote add linux-review https://github.com/intel-lab-lkp/linux
> >          git fetch --no-tags linux-review Yinbo-Zhu/usb-dwc2-add-pci_device_id-driver_data-parse-support/20230518-173721
> >          git checkout 3ff56448e1442fe8b1e72651a8d4d6e1086ece32
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305190105.O6ycxCti-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > > > ERROR: modpost: "dwc2_pci_ids" [drivers/usb/dwc2/dwc2_pci.ko] undefined!
> 
> 
> I test it was set dwc2 pci driver as built-in, so no error, this compile
> error was that dwc2_pci_ids not export when driver as module and I will
> add EXPORT_SYMBOL_GPL(dwc2_pci_ids) to fix that compile issue.

Again, no, please do this properly, no one should ever be walking a pci
id list by hand like this...

thanks,

greg k-h
