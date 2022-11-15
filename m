Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365BF62A1E3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKOTcF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 14:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKOTcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 14:32:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51599CE0E;
        Tue, 15 Nov 2022 11:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA7B9619E5;
        Tue, 15 Nov 2022 19:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31373C433D6;
        Tue, 15 Nov 2022 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668540719;
        bh=zkYCEiloeC0jrC/doDCxREldDQFPChzoKY0oT/AmWNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgVgJdAfwFz/rOfKkYrHzYehxkLe03kVZiQmUl0D14eFx7G3bDVpKibuahS/1pBHJ
         oGaeIgpi3LnkcuwZ7d2p33+pq8yXCkKqynGy9/dvee5GLtyjoTVpinWxWEUK2UMMvs
         mzEHcsZqU2s6pYqhFRZe8VyRxYXKIqO+g2HNsm+CLN0dtVK1AHz7InijfF7dthMeWx
         vuUUAYJdE9Arjn8AcJGq7mmPm2LqWb8taMjEvRwDpXUlQUbej92ZkXIaRUC3uUus/L
         sMaWmctwoY89Buisk9L6Ka1Iw2xPAlxHZ9nWpD3f+2rPh3cIM1v3nTgB4PO5XJuMNy
         D22TJpkm5Oh6w==
Received: by pali.im (Postfix)
        id 1BBD2805; Tue, 15 Nov 2022 20:31:56 +0100 (CET)
Date:   Tue, 15 Nov 2022 20:31:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
Message-ID: <20221115193155.mqdh6pzhiba4v4pa@pali>
References: <CAMuHMdVnJZGqwnC0fZTwyb1GT5Nu+4K9LND4CXU96cvYG+qEgg@mail.gmail.com>
 <20221115180734.GA999206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115180734.GA999206@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 15 November 2022 12:07:34 Bjorn Helgaas wrote:
> On Tue, Nov 15, 2022 at 04:56:10PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Oct 25, 2022 at 9:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Many drivers depend on OF interfaces, so they won't be functional if
> > > CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
> > > the OF dependencies so we can at least compile-test the drivers.
> 
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -8,7 +8,6 @@ config PCI_MVEBU
> > >         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> > >         depends on MVEBU_MBUS
> > >         depends on ARM
> > > -       depends on OF
> > 
> > This is exactly why we have the COMPILE_TEST symbol.
> > There is no point in bothering all users who configure kernels with
> > questions about drivers that won't function anyway due to missing
> > dependencies, unless the user explicitly wants to do compile-testing.
> > 
> > So all of these should become:
> > 
> >     depends on OF || COMPILE_TEST
> 
> Oh, yes, thanks for pointing this out, I totally blew it here.  I
> dropped this while we figure it out.

I agree too, it really makes sense to not provide pci-mvebu driver to
end users without OF - it would not work.

Anyway, it is needed to declare "depends on ARM" for pci-mvebu?
Both supported architectures (mvebu and dove) are ARM.

> Do you have a preference between this:
> 
>   depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>   depends on OF || COMPILE_TEST
> 
> and this:
> 
>   depends on ((ARCH_MVEBU || ARCH_DOVE) && OF) || COMPILE_TEST
> 
> The latter seems more common and doesn't repeat "COMPILE_TEST", but I
> can see advantages to the former.
> 
> Bjorn

First one looks to be more readable as it does not contain parenthesis.

And if one day there would be support also for other Marvell SoCs
currently missing in pci-mvebu.c then diff for new ARCH_ in Kconfig
would be smaller.
