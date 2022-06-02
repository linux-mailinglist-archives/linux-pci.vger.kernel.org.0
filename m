Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAD53BC58
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiFBQUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiFBQUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A168997
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 09:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A17CCB81F7B
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 16:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130EEC34114;
        Thu,  2 Jun 2022 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186841;
        bh=RWecuZ793zKrWapXtLimrcEuj8YxwuWwynvq51ju7p8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BY0g5Xf0myB+EnWKRCRrdh/ach9la7CP73E97t6H6suB0NZKsxUfIypRi5JlkSz5k
         Uvu+FJzFSOTVTOywlhdMntYPted8UN4E3PB3PgXcysXzhVf19QFwFIe5VvPlTIrCag
         Y537T7vXTHxztI1xxMux4rFYwm8u06Ec0usiGmzixg76313dXjx0JHxioncWIc1x+T
         6tbF4uoDI3j6U8FwphH0VO8ADdik5FpC1aN8tMHEjX6q1JP9d6bnX9IfM6TufhL8rM
         zRemmsjXcLW0wK4MPe6F1dUKpsmCmQTHsU+OyXtmVLUeG7K+G/d7mtKvNTg8+GTzZB
         CtzfGLJuexk0w==
Date:   Thu, 2 Jun 2022 11:20:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
Message-ID: <20220602162039.GA20136@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d1f3d1-2864-458a-a1f0-ed3047b1cddf@www.fastmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jingoo, Gustavo, Kishon, Krzysztof]

On Wed, Jun 01, 2022 at 12:59:50PM +0100, Jiaxun Yang wrote:
> 在2022年6月1日六月 上午3:22，Bjorn Helgaas写道：
> > On Sat, Apr 30, 2022 at 04:48:44PM +0800, Huacai Chen wrote:
> >> In new revision of LS7A, some PCIe ports support larger value than 256,
> >> but their maximum supported MRRS values are not detectable. Moreover,
> >> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> >> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> >> will actually set a big value in its driver. So the only possible way
> >> is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> >> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> >> 
> >> However, according to PCIe Spec, it is legal for an OS to program any
> >> value for MRRS, and it is also legal for an endpoint to generate a Read
> >> Request with any size up to its MRRS. As the hardware engineers say, the
> >> root cause here is LS7A doesn't break up large read requests. In detail,
> >> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> >> request with a size that's "too big" ("too big" means larger than the
> >> PCIe ports can handle, which means 256 for some ports and 4096 for the
> >> others, and of course this is a problem in the LS7A's hardware design).
> >
> > This seems essentially similar to ks_pcie_quirk() [1].  Why are they
> > different, and why do you need no_inc_mrrs, when keystone doesn't?
> >
> > Or *does* keystone need it and we just haven't figured that out yet?
> > Are all callers of pcie_set_readrq() vulnerable to issues there?
> 
> Yes actually keystone may need to set this flag as well.
> 
> I think Huacai missed a point in his commit message about why he removed
> the process of walking through the bus and set proper MRRS. That’s
> because Loongson’s firmware will set proper MRRS and the only thing
> that Kernel needs to do is leave it as is. no_inc_mrrs is introduced for
> this purpose.

I'd really like to have a single implementation of whatever quirk
works around this.  I don't think we should have multiple copies just
because we assume some firmware takes care of part of this for us.

> In keystone’s case it’s likely that their firmware won’t do such thing, so
> their workaround shouldn’t be removed.
> And  no_inc_mrrs should be set for them to prevent device drivers modifying
> MRRS afterwards.

I have the vague impression that this issue is related to an arm64 AXI
bus property [2] or maybe a DesignWare controller property [3], so
this might affect several PCIe controller drivers.

> > Whatever we do should be as uniform as possible across host
> > controllers.
> >
> > [1] 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-keystone.c?id=v5.18#n528

[2] https://lore.kernel.org/all/20211126083119.16570-4-kishon@ti.com/
[3] https://lore.kernel.org/all/m3r1f08p83.fsf@t19.piap.pl/
