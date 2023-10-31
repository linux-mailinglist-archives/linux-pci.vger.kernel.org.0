Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3017DD470
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjJaROH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjJaROH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 13:14:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F5292
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 10:14:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED629C433C7;
        Tue, 31 Oct 2023 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698772444;
        bh=npFSndHToZSvaMoEZZSmm7GPiJg3OA3ptZH/j0wep38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MJHc0FcODghJfmml4Q6bMCK8IwpbGLNIR7t+p1e6pVaz9jou8tZG7YAaDuxbuyN0B
         vcCLYsu+qUKw6P70bdmfQkxCoNs3yX4qlMyPbflAI5Lls0y8g6/42kzkkN3GEqmb08
         dUEzOAA5V+Wp2ERmQNyLr+zw1c1mzjw6bNmEPll+opnfPPnXQ4zlGn3aNNfQVJ7suW
         2FVr//Yl77jJUUEAxRM5uN5Ow6tALVhlNciXwwYTXfhxCzM5PNgkxuBOmXdOBrxyok
         4oQYdLcBG0NGL7XgTbP/SxANDXwFKD6Ya3SbDvrk1M5btfMLYj+A9cyjAxyypGMgYT
         h/QUfaOsQzyBA==
Date:   Tue, 31 Oct 2023 12:14:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION
 8d786149d78c7784144c7179e25134b6530b714b
Message-ID: <20231031171401.GA17989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmrFL4QQvttb8+xxV4hQp3fGovnFx222g+Q5aPpzV3Ahw@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 09:59:29AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 31, 2023 at 7:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Oct 28, 2023 at 08:22:54PM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx-xdma
> > > branch HEAD: 8d786149d78c7784144c7179e25134b6530b714b  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
> > >
> > > Error/Warning ids grouped by kconfigs:
> > >
> > > clang_recent_errors
> > > `-- powerpc-pmac32_defconfig
> > >     |-- arch-powerpc-sysdev-grackle.c:error:unused-function-grackle_set_stg-Werror-Wunused-function
> > >     |-- arch-powerpc-xmon-xmon.c:error:unused-function-get_output_lock-Werror-Wunused-function
> > >     `-- arch-powerpc-xmon-xmon.c:error:unused-function-release_output_lock-Werror-Wunused-function
> >
> > This report is close to useless.  It doesn't show the complete error
> > message, it doesn't show how to reproduce the issue, and the pci -next
> > branch (including controller/xilinx-xdma) doesn't reference any of
> > these functions:
> >
> >   $ git grep -E "grackle_set_stg|get_output_lock|release_output_lock" | cat
> >   arch/powerpc/sysdev/grackle.c:static inline void grackle_set_stg(struct pci_controller* bp, int enable)
> >   arch/powerpc/sysdev/grackle.c:        grackle_set_stg(hose, 1);
> >   arch/powerpc/xmon/xmon.c:static void get_output_lock(void)
> >   arch/powerpc/xmon/xmon.c:static void release_output_lock(void)
> >   arch/powerpc/xmon/xmon.c:static inline void get_output_lock(void) {}
> >   arch/powerpc/xmon/xmon.c:static inline void release_output_lock(void) {}
> >   arch/powerpc/xmon/xmon.c:             get_output_lock();
> >   arch/powerpc/xmon/xmon.c:             release_output_lock();
> >   arch/powerpc/xmon/xmon.c:                     get_output_lock();
> >   arch/powerpc/xmon/xmon.c:                     release_output_lock();
> >   arch/powerpc/xmon/xmon.c:             get_output_lock();
> >   arch/powerpc/xmon/xmon.c:             release_output_lock();
> >   arch/powerpc/xmon/xmon.c:             get_output_lock();
> >   arch/powerpc/xmon/xmon.c:             release_output_lock();
> >
> > That said, the unused functions do look legit:
> >
> > grackle_set_stg() is a static function and the only call is under
> > "#if 0".
> 
> Time to remove it then? Or is it a bug that it's not called?
> Otherwise the definition should be behind the same preprocessor guards
> as the caller.  Same for the below.

I don't really care whether we keep the warning or not.

My real complaint is that the 0-day report fingered
pci/controller/xilinx-xdma, which is completely unrelated, which is a
waste of time.

> > Same with get_output_lock() and release_output_lock(): they're static
> > and always defined in xmon.c, but only called if either CONFIG_SMP or
> > CONFIG_DEBUG_FS.
> >
> > But they're certainly not related to controller/xilinx-xdma, so I'm
> > going to ignore them.
> >
> > Bjorn
> >
> > P.S. Nathan & Nick, I cc'd you because of this earlier report that
> > also mentioned grackle_set_stg():
> > https://lore.kernel.org/lkml/202308121120.u2d3YPVt-lkp@intel.com/
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
