Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90FC62A112
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 19:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKOSIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiKOSH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 13:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522713F73;
        Tue, 15 Nov 2022 10:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CF04B81A5F;
        Tue, 15 Nov 2022 18:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EBEC433C1;
        Tue, 15 Nov 2022 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668535656;
        bh=gVYcutXI++9bdrHBHueMBmsjqWSHjeoLZDZVF1qz2gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kj7PrOhLg29hSgQ0mhZwTHKYN6ylN97waXxxyCaBF9rHt/ZmxWNR0yjFiG0VWZNBO
         7s6k6oaT/B4M6iA8qN9H9hmXAdr2jaYHY8FxJemnY9fSFMhtRaYpNoMYO2d56BZOQb
         qLDX6au8eVes2feP8rqwd4HC9EoOomckazimxAtkgSH2IvBMWjOBxnJFevFqH27pMg
         XDaML34HV0P5635S0Jp0Ri0GG35qf+mzDZ9WZJXTVl+kxM/SwjVO4qrh9p2a99PM5E
         vpWJtrjI/jAg1SLOJGYOdwbKxE+JfY9Wxb4zXiv+kXRXGDkMYh6PTMGFfBNEylgsRt
         kRTtgyUorBxRA==
Date:   Tue, 15 Nov 2022 12:07:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
Message-ID: <20221115180734.GA999206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVnJZGqwnC0fZTwyb1GT5Nu+4K9LND4CXU96cvYG+qEgg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 04:56:10PM +0100, Geert Uytterhoeven wrote:
> On Tue, Oct 25, 2022 at 9:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Many drivers depend on OF interfaces, so they won't be functional if
> > CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
> > the OF dependencies so we can at least compile-test the drivers.

> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -8,7 +8,6 @@ config PCI_MVEBU
> >         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> >         depends on MVEBU_MBUS
> >         depends on ARM
> > -       depends on OF
> 
> This is exactly why we have the COMPILE_TEST symbol.
> There is no point in bothering all users who configure kernels with
> questions about drivers that won't function anyway due to missing
> dependencies, unless the user explicitly wants to do compile-testing.
> 
> So all of these should become:
> 
>     depends on OF || COMPILE_TEST

Oh, yes, thanks for pointing this out, I totally blew it here.  I
dropped this while we figure it out.

Do you have a preference between this:

  depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
  depends on OF || COMPILE_TEST

and this:

  depends on ((ARCH_MVEBU || ARCH_DOVE) && OF) || COMPILE_TEST

The latter seems more common and doesn't repeat "COMPILE_TEST", but I
can see advantages to the former.

Bjorn
