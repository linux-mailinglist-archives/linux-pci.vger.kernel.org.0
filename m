Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A07E085E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 19:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKCSn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKCSny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 14:43:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F2D47;
        Fri,  3 Nov 2023 11:43:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB37C433C8;
        Fri,  3 Nov 2023 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699037031;
        bh=hgOga4pwl14WfU2MvnZsWLoM990ZOE+za5Yw+n+n0AU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CnIcbuLaur08qay3AX7v9cw5DW5fDgMbMkI0cv04BRTcupvPY1W6XPp5loPOD96nQ
         BQUwBm6Wyde6BMA+a2jo9seSmUbhBi26br/nPs3ohZwoO1cjqs91qDDtwsNx/uxyIN
         cw+sJqLSxMGeclL9jZ6jFQaLTUwH9QIXtvVb7kizMOyDnWe/V2Mdcu5UcwttsfiBPL
         WWvyiTIx2cZmpa04/1K4brcvKsZkfDmtDPY9AW+OkYvOFJCj0SkEqRh1X8bpFoRT7z
         4NU1d7qVOoQ9Ql+t4MdJBoY1qcg3m2baI+OW91aQYAm5mYi8hBgRaimlSxFjwL/aQf
         sobQEleYlFLOA==
Date:   Fri, 3 Nov 2023 13:43:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Epping <david.epping@missinglinkelectronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: Re: arm: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Message-ID: <20231103184348.GA162150@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUDd04c7FXUeusxK@nucnuc.mle>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Zhichang, Gabriele, John (INDIRECT_PIO); Joyce (altera maintainer)]

On Tue, Oct 31, 2023 at 11:58:27AM +0100, David Epping wrote:
> Hello ARM PCIe and especially Intel Altera SOCFPGA maintainers,
> 
> the Intel Altera Cyclone V PCIe Root Complex drivers afaik currently
> don’t support sending IO TLPs.  The Root Complex IP Core, seemingly
> unlike many other ARM Root Complexes, does not offer a memory
> mapping for the IO address space, but instead relies on indirect
> addressing via address and data registers. To my knowledge this IO
> space access has not been implemented in Linux, yet, and is
> currently only used for PCIe Configuration TLPs on this hardware,
> which use the same mechanism.
> 
> To support an AX99100 endpoint (which requires IO BARs for some of
> its features) connected to a Cyclone V PCIe root, we added support
> for IO TLPs to Kernels 4.14, 5.4, and 5.15.  For your reference the
> 4.14 patches are attached. They do _not_ apply to current mainline
> Linux and are meant to give you an idea of our current approach.  As
> you can see, in order to implement our own inb() and outb() family
> of functions, we had to remove multi-platform support for
> ARCH_SOCFPGA.
> 
> I would like to get some feedback on:
>
> a) Are you interested in adding IO TLP support for this FPGA/CPU to
> mainline? We would implement patches for the current mainline in
> that case and post them for discussion.
>
> b) Do you see an option to implement the IO space access functions
> without dropping multi-platform support? Is that a prerequisite for
> going mainline?

I don't understand INDIRECT_PIO very well, but does it help with this
at all?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/Kconfig?id=v6.6#n92
https://git.kernel.org/linus/031e3601869c

Beginning of thread, including full patch (for v4.14, not current
kernel) at: https://lore.kernel.org/all/ZUDd04c7FXUeusxK@nucnuc.mle/

Bjorn
