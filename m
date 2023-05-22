Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52870C306
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjEVQKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVQKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 12:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95BB6;
        Mon, 22 May 2023 09:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B780561D14;
        Mon, 22 May 2023 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F5FC433D2;
        Mon, 22 May 2023 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684771850;
        bh=dl5gBDvuGabe6NnEiM5v+6b9yh126Z8E64wCTQABV84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MswPmM9NI3e5xAQ63TPGAmz4LWfmAxvmOAm1w6Nxd5caDVbDY6EJ5DO4JdAZZfyMw
         xX0IU8l5sn6Ptp0juO72gtGBhjWuou9urMmu6svigxrG3lxrr6JJBF5/aZILGlfJh3
         yuixiOI3kgB4WHVugbEt3UB6rBwWzWf2Ze0dprMUm6e/BpCrNJ+69Op93e+mfyboEg
         vfgmEZRTOlLHgPs4uQZwhBV5l2POLB4dhKt/IeKgUisBKPCZDn9cp3KW7CHnLDegNK
         MZyA85wQzQzmERMxYY4VGiZDG1pvVuNws7FOj8zy0ix1S62956R4kr/THBNpYb28Ze
         qiCDSKXDh3gpQ==
Date:   Mon, 22 May 2023 11:10:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5pu+56Wl57+8?= <xyzeng@stu.xidian.edu.cn>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: keystone: Free IRQ in `ks_pcie_remove` and the
 error handling section of `ks_pcie_probe`
Message-ID: <ZGuUCADcy6PfOYrR@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36474dbb-5020-9044-b47c-cb377fa5dea7@stu.xidian.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 02:07:10PM +0800, 曾祥翼 wrote:
> On 17/5/2023 03:49, Bjorn Helgaas wrote:
> > On Tue, May 16, 2023 at 01:16:59PM +0800, Xiangyi Zeng wrote:
> > ...

> > > Fixes: 0790eb175ee0 ("PCI: keystone: Cleanup error_irq configuration")
> > > Signed-off-by: Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
> > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> >
> > It's best if the Reviewed-by tag is not added until Dongliang sends
> > email with that tag directly to the mailing list.  Internal reviews
> > before posting to the mailing list aren't worth much.
>
> In our internal review process, only the patch with the Reviewed-by
> tag can be submitted to the mailing list. You can check this in our
> google group.
> https://groups.google.com/g/hust-os-kernel-patches/c/bt397rzVL24/m/l52XYbG4AgAJ
> We will consider omitting this tag when sending to the kernel mailing
> list in the future.

It's great that Dongliang has already reviewed it; I'm not suggesting
you omit any of that internal review.  My point is that it's best if
Dongliang's email review appears on linux-pci in addition to whatever
internal email list you use.  The hust-os-kernel-patches Google Group
is not archived and searchable the same way linux-pci@vger.kernel.org
is on https://lore.kernel.org/linux-pci/.

Bjorn
