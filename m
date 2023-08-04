Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDC770621
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHDQiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjHDQiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 12:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAF3B2;
        Fri,  4 Aug 2023 09:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF2B62097;
        Fri,  4 Aug 2023 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2A0C433C7;
        Fri,  4 Aug 2023 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167093;
        bh=Eby5n4ZE0AMvm51ITihJARaywMHTaI7+TdCZEB4JlBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EkYEymErHlsBYfc6voP/I5ipDUFZRX2PW1a0Dzn5Z52S+nlaFxKTFbCDZ4nzjTEAs
         G9AGKljmTcXzTTcO3fyjbOdtCB5aa31CKRvKZxZjx4q2zX1d55WJeuC8A1uhEBJ7Cr
         DfZ2z5kevHi7QuwwYHc+1qFUSoqRf1nlpS4mLi9gSStEHd/XFFbYG8X6qvz4Nbq8RF
         PVwLGTO47E8PcYGKpQeGGRIFrUMqbgKmkMd0zrW+NSUMKhsq+CEPqdOKkV7PX91S8n
         Ebw6qL0cZ/EEMaC9X3sqcZ/Y/stiL8kaZFgl1leJs3ZA7jVac9poDnPJJkwaxxKWMs
         7lMKwPPtVLU0A==
Date:   Fri, 4 Aug 2023 11:38:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        oe-kbuild-all@lists.linux.dev, bhelgaas@google.com
Subject: Re: [PATCH] PCI/VGA: Make the vga_is_firmware_default()
 arch-independent
Message-ID: <20230804163811.GA144900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e51eb50-aa7b-f771-e53b-499bf899e22e@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 11:11:12AM +0800, suijingfeng wrote:
> On 2023/8/3 20:25, kernel test robot wrote:
> > Hi Sui,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on pci/next]
> > [also build test ERROR on pci/for-linus linus/master v6.5-rc4 next-20230803]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/PCI-VGA-Make-the-vga_is_firmware_default-arch-independent/20230803-161838
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > patch link:    https://lore.kernel.org/r/20230803081758.968742-1-suijingfeng%40loongson.cn
> > patch subject: [PATCH] PCI/VGA: Make the vga_is_firmware_default() arch-independent
> > config: arm64-randconfig-r026-20230731 (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308032022.yiZngbbk-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > ld.lld: error: undefined symbol: screen_info
> >     >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
> >     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
> >     >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
> >     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
> >     >>> referenced by vgaarb.c:88 (drivers/pci/vgaarb.c:88)
> >     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
> >     >>> referenced 3 more times
> > 
> This is a more like arch-specific problem, It will be pain at many places on platforms
> that do not export the screen_info symbol. Not only here.
> 
> I have already explained that screen_info is arch-dependent many times, but no one cares about me.
> By using (looking at) screen_info, vgaarb gets infected, and becomes arch-dependent as well.
> vgaarb deals with VGA class (pdev->class == 0x0300XX) devices only, This makes it device-dependent.
> Hence, It only works correctly for a small set of PCIe devices on x86.

This build error report is from an automated service; there's nothing
personal about it and the automated service isn't going to respond to
you.

The build issue is just something that will have to be resolved before
we can consider merging the patch.

Any explanation needs to go in the commit logs for the relevant
patches.

> arch-dependent, device-dependent, subsystem-dependent (part of it rely on ACPI) and
> loading order dependent, those dependent itself are the problems.
> It results in various undefined (uncertain) behaviors on non-x86 architectures.
> 
> Even on x86, some platform choose to relay on the firmware to solve the multiple GPU coexist problem.
> so it is also firmware-dependent.
> 
> This patch solves part of the above problems listed, target at the *device level*, as early as possible.
> while they still a few problems could be only solved at the *driver level*.
> For an example, The display controller in Intel N2000 and d2000 series don't has a dedicated VRAM bar.
> they use the "stolen memory", which is carve out by somebody (either bios or kernel?).
> 
> 
