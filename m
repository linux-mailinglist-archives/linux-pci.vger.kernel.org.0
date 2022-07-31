Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB24586151
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jul 2022 22:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiGaU3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jul 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaU3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2022 16:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE4DF30
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 13:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DE361123
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 20:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F80CC433C1
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659299344;
        bh=pD5duAqAKVwZ2XGf4smSm37mjDhEE7Ll6IHePEhQ14E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uBI78kQb9x7rrpHq6Y1xVQWgtZYUEklJu5OGxqC3/veTOEEvScCyUozot4WJX6YcT
         cQBzUVc2UQk/DDdPHxRF0QbQ2IxPdDoIxYqtT7ssRmjLoaQWSGUxxLUrC6lhFUQ0Zy
         jGnEIwu0C4D/n/zms1uqg8Wxodriu/gDuHGuFt4JLyFq1rG4+kuN+bLEbOjzfeDIuf
         neRS7A9Av8T/9F+Fj3XIzJ5XSFBHkjGDcLqI9hPOCkau0Ba9cUhEi7ocJWt6+wTrN7
         naWXLJGHO0y93fXQCylkMb5ycRjGFjFqUGwAVwKwUWyrfhx4F/QsnNhagwiAFc7bNO
         QoFJPAODNOfUQ==
Received: by mail-wr1-f46.google.com with SMTP id bk11so1960572wrb.10
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 13:29:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo0Ta3kHu6IZCFLibyfCDq9oc5Df1CjppHBVPJhd8yqZB07W5/qe
        9dsqS5bbYfe3ZrZv0vf5ijwYxHurAfNTfi1XR5Y=
X-Google-Smtp-Source: AA6agR79tdJ0bQV19BgfmBoGyMqfLrs/n9gMBlKcjvcWjFGe8T3+J9h0DQKmrIgZBhtlhS3+X8OG7Qh/6u7mKrTo2dU=
X-Received: by 2002:a05:6000:2a4:b0:21e:6e0e:df1f with SMTP id
 l4-20020a05600002a400b0021e6e0edf1fmr8362159wry.516.1659299342640; Sun, 31
 Jul 2022 13:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <202207301404.VdeSPptt-lkp@intel.com>
In-Reply-To: <202207301404.VdeSPptt-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 31 Jul 2022 22:29:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w4iTQ9p+4Njfk8jPPv6dHn6dv-_VoE90rhToAwHY==A@mail.gmail.com>
Message-ID: <CAK8P3a0w4iTQ9p+4Njfk8jPPv6dHn6dv-_VoE90rhToAwHY==A@mail.gmail.com>
Subject: Re: [helgaas-pci:pci/header-cleanup-immutable 2/6]
 arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier 'isa_dma_bridge_buggy'
To:     kernel test robot <lkp@intel.com>
Cc:     Stafford Horne <shorne@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 30, 2022 at 8:53 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/header-cleanup-immutable
> head:   933c5a4f87d92a865d1db76caf190f1a4a1927f9
> commit: abb4970ac33514c84b143516583eaf8cc47abd67 [2/6] PCI: Move isa_dma_bridge_buggy out of asm/dma.h
> config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220730/202207301404.VdeSPptt-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=abb4970ac33514c84b143516583eaf8cc47abd67

> >> arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier 'isa_dma_bridge_buggy'
>                    isa_dma_bridge_buggy = 2;
>                    ^


This file now needs to #include the new linux/isa-dma.h header.

        Arnd
