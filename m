Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F34ADC62
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiBHPVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351513AbiBHPVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 10:21:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B514C061577;
        Tue,  8 Feb 2022 07:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC43615A9;
        Tue,  8 Feb 2022 15:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA49FC004E1;
        Tue,  8 Feb 2022 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644333668;
        bh=lrdpahtoYJMkygHUgb9le9T470vkRfKNDjH3vkLwGbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E4sQNblNYa15SBvxVJ+OImzGroFaQLkvFnmGLE2dJKUmWMWoMo2dDOqFYCYGxP6nw
         5sVn0PeO5rF+J1X+dLm2O8uh9W9VOY9WJScBZNPsRhU55kzFPjy5fGWarNczlzZ66h
         OToNdl7w9igkGADhcSTGrPBrxnilpXEjY+rHCRGklgNIxiyuV9k5I0T5BNbBLN751N
         CS+M5xZBH3WkSsWidbI2COz/A6WPeH0FcqkGWTEoqFrUbQ22doExNLI4Bw2tmUcHXv
         f+vPlvHAyMwEpwOBn5qojtZQv2I+55CVHQytZIPFCLq+VrPlGD1/b/UHPvMPFAgZI4
         CgpYroZYsiwYA==
Date:   Tue, 8 Feb 2022 09:21:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Chen <lchen.firstlove@zohomail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Message-ID: <20220208152106.GA476995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ed78f886f.d22c200668349.8594449941761827257@zohomail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 11:20:15PM -0500, Li Chen wrote:
>  ---- On Mon, 07 Feb 2022 12:56:13 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote ----
>  > On Mon, Feb 07, 2022 at 04:09:05AM -0500, Li Chen wrote:
>  > > #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
>  > > -                     miscdev)
>  > > +                        miscdev)
>  > 
>  > Always indent with tabs when possible:
>  > 
>  >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n18
>  > 
>  > Hmm, coding-style.rst is unfortunately not very explicit about that.
>  > 
>  > But it's obvious from the existing code in this file that things
>  > should not be indented four spaces, as you did in
>  > pci_endpoint_test_transfer_data().
> 
> So, can I say space is not allowed in indentation? If so, I should
> not use emacs's tabify, because it will not convert 4 space to
> 8-width tab. I'm also not sure is scripts/Lindent or clang-format is
> a good choice here, they do too much changes.

I don't know how emacs, Lindent, clang-format, etc work.  I *can* tell
you that in Linux code:

  - indents always use tabs (width 8) when possible,

  - up to 7 spaces are allowed after a tab when needed to align
    something with the previous line, and

  - a tab never directly follows a space.

Bjorn
