Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC276B41E8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCJN5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 08:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCJN5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 08:57:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7251151D5;
        Fri, 10 Mar 2023 05:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BF41B822C4;
        Fri, 10 Mar 2023 13:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401ACC433EF;
        Fri, 10 Mar 2023 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456656;
        bh=mT1HOidPYDpxr3nntqZI04qBLNZBAbmkfmHjty9P84o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SI81lqCXcL40716aiyF1qLrEV1MfzrAXv6tkwMPChYYpNR5Iv4bf2ReRHXXsBPuyu
         oFJv8JAAQM3yVtq3PUadz91x11qW1DfKk1BYakfNEYZUPcoURfd1Mqkb6F6lEOqKFe
         ddRpSQJ+Sv9UsJYy5+I7S5W5Uco4iA4xpmErG1o9SRlq8q356xayQKkAM6S8cshf0n
         G7b8p2VZQ9ukfd/LcEl7L0850tcQYRIe/RiqeY+u8kQLAJZ5+bkahvDjGo7X4lvM6g
         78RoBBK/ZRJT20dAsQ8hlWRpGY14ZxBJ6rlV7LUF6R8GBs+tYaW1DSEEIt4Z9n0htv
         0u5JS6GjgJiig==
Date:   Fri, 10 Mar 2023 14:57:30 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
Message-ID: <ZAs3SgNsYb31x4UU@lpieralisi>
References: <20220928122539.15116-1-pali@kernel.org>
 <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 04, 2022 at 09:56:18AM +0200, Linus Walleij wrote:
> On Wed, Sep 28, 2022 at 2:25 PM Pali Rohár <pali@kernel.org> wrote:
> 
> > Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro for
> > accessing PCI config space.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> I have no way to evaluate this change in my head, once the kernel test robot is
> happy I can test the patch on IXP4xx.

If you can manage to test it I can go ahead and merge it.

Thanks,
Lorenzo

> Yours,
> Linus Walleij
