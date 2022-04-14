Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482425019C2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiDNROw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiDNRO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:14:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298ADA5;
        Thu, 14 Apr 2022 10:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D690EB82A6C;
        Thu, 14 Apr 2022 17:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747B6C385A5;
        Thu, 14 Apr 2022 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649956065;
        bh=5YkoqPSq1Of8JiZE0OEKwhrxhfofzOwFiiEpoy5f34c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZbrJgZIg0FRefcW1gdgijtUrx9kc1/gTdOSCPbzsL+/LRau6UcmWGyNBMTuMRjJ93
         lpju16b/PD9T7W3ENiGEhsQIUx279Errw/WSzFScPRtky50wFSbTddyPZ9znhWz2uC
         AV/MafQQG8GNbUR5X6ckcCkprF5wN6l/igpvAe1uBc0V5PEpwyVJ/HT8LC0l3hq/Vs
         SD+OLrqc5psnOVonKABN0h1+E1Z/gpDzYqpv+c+kiL4IM0x5PsDu5NYig9hn9XAqlD
         02crSggL08c+BC9RooKmJCVrAr99AUQeDb3inGixDPq+w0wLowv07IQ4vjYhFyuxQU
         8e7ADL9VVm6Gg==
Date:   Thu, 14 Apr 2022 12:07:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220414170743.GA753251@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204140118350.9383@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 02:10:43AM +0100, Maciej W. Rozycki wrote:
> On Wed, 13 Apr 2022, Bjorn Helgaas wrote:
> 
> > > Address 0 is treated specially however in many places, for example in 
> > > `pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
> > > address is non-zero, and even if we let such an address through, then 
> > > individual device drivers could reject a request to handle a device at 
> > > such an address, such as in `uart_configure_port'.  Consequently given
> > > devices configured as shown above only one is actually usable:
> > 
> > pci_iomap_range() tests the resource start, i.e., the CPU address.  I
> > guess the implication is that on RISC-V, the CPU-side port address is
> > the same as the PCI bus port address?
> 
>  Umm, for all systems I came across except x86, which have native port I/O 
> access machine instructions, a port I/O resource records PCI bus addresses 
> of the device rather than its CPU addresses, which encode the location of 
> an MMIO window the PCI port I/O space is accessed through.

My point is only that it is not necessary for the PCI bus address and
the struct resource address, i.e., the argument to inb(), to be the
same.

I tried to find the RISC-V definition of inb(), but it's obfuscated
too much to be easily discoverable.

Bjorn
