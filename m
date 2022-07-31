Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129E5861F0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiGaXC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jul 2022 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaXC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2022 19:02:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA98101EF
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 16:02:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c139so9073995pfc.2
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiqBkou7TsDXWZ2bZ9jDnOVGt8hHICY7VSsWQ2Opi0I=;
        b=IS3SvA25XetUr6LNZ+s3A/JfWHVWla1uJ3dL+GWYRa3wB0jbYs2SaFtdR1ONZmuo/7
         gEQyEVKf8LgB8ubET2nLYEzmlU4jidwAl9vlHXILgkm8ipNaP6p8albKDo3Qd9JjmBFu
         QvYa2G5IE/CJ69chHtBUWAWPPfdRzKUyOBIcNYxMebCZt4664vxJdhxO5Qn0xaSeit/N
         hL2/0w+/miUhMW7Vnxg08jCjKTHSbncRsh5JW89AqX4h4uZgmb/Tfet8UdKaASW6DcQQ
         WaxBj1SIEj0Qt5L1OiML2vPalCr1uzng0aV6wNIWnqFGe4nA0oBkr+/+hRre0G4wKbNm
         3SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiqBkou7TsDXWZ2bZ9jDnOVGt8hHICY7VSsWQ2Opi0I=;
        b=Am2YrL+5ndfWGN2/Tk9mP1bIcMIl7K0YXh6SDocW1U3au2tQYVXRdruvNFcTzwBuxS
         RWsYG/M1Lyw4tBYoVVP0RoHVamVi0T0Pmir7LhRE20dM36gkndIzDse5FV1NTTdsS99p
         A4llp49gaP492ovRTNEX9mb85CX9DzU7+vhr8hJ/NbZzrV1GBGKMG+t1SfKjfZsTJtgn
         4n0EdkRKFfTvH/NVU96cYo5gcFAQbQnFl+pPsKsw8AF3o6fcI6C3qkNCuB5jlu6xIWRg
         t++9lHUkq0U2qNOJZWRfplgUKIz5d6ZfwQqjW5jD0T+leCCk4a1hJQJmY/37wQLV2yi/
         V45g==
X-Gm-Message-State: AJIora9IZLzTJShUefsL8pav9jRlHLl5488rJ1bE0NMh6R3c12qT/1qL
        2Pf7pRo16P2JtloBHrFea+TefIXhqB0=
X-Google-Smtp-Source: AGRyM1sE4jYBZfkZMDOxr5DyoRi73yAzT1WIcsVuRu8+at9KvBjAeMycEocydbJLxo1scKp+wpJ7bQ==
X-Received: by 2002:a63:d055:0:b0:41b:539c:7125 with SMTP id s21-20020a63d055000000b0041b539c7125mr10860043pgi.461.1659308545891;
        Sun, 31 Jul 2022 16:02:25 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d710d8af7sm7957855pln.142.2022.07.31.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 16:02:25 -0700 (PDT)
Date:   Mon, 1 Aug 2022 08:02:23 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [helgaas-pci:pci/header-cleanup-immutable 2/6]
 arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier
 'isa_dma_bridge_buggy'
Message-ID: <YucJ/9tvO1t8EbZs@antec>
References: <202207301404.VdeSPptt-lkp@intel.com>
 <CAK8P3a0w4iTQ9p+4Njfk8jPPv6dHn6dv-_VoE90rhToAwHY==A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0w4iTQ9p+4Njfk8jPPv6dHn6dv-_VoE90rhToAwHY==A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 31, 2022 at 10:29:00PM +0200, Arnd Bergmann wrote:
> On Sat, Jul 30, 2022 at 8:53 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/header-cleanup-immutable
> > head:   933c5a4f87d92a865d1db76caf190f1a4a1927f9
> > commit: abb4970ac33514c84b143516583eaf8cc47abd67 [2/6] PCI: Move isa_dma_bridge_buggy out of asm/dma.h
> > config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220730/202207301404.VdeSPptt-lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=abb4970ac33514c84b143516583eaf8cc47abd67
> 
> > >> arch/x86/kernel/cpu/cyrix.c:277:3: error: use of undeclared identifier 'isa_dma_bridge_buggy'
> >                    isa_dma_bridge_buggy = 2;
> >                    ^
> 
> 
> This file now needs to #include the new linux/isa-dma.h header.

There is a patch on the branch that adds the include but it was not added into
the patch 2/6 as we took the branch to be immutable to allow riscv to have
branch to resolve a merge conflict.

-Stafford
