Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419FF37498E
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhEEUlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 16:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234566AbhEEUlP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 16:41:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31733613E9;
        Wed,  5 May 2021 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247218;
        bh=sqlBJeP2BuEGyy+j2+DoZweK1T+0pBp8HGXOCvNJaVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e0ZdQzW323cvRis2z39theMLvgGcGhr1aRJdgJ+M+dyFQUK6B3neoJM7cRga3yDFA
         jZlEk/JbmihCRj3Mmctzvjjx6Nrf8zLT4+WEm5fvBuo3LR4H5ap9G4EsZ4zhbB112D
         q3bYplfp/mXVhEavQHjhtyHzsZkljyP6cQ4dPKCYmbF4hRgQFM6FuT6oj3L8m8Z97i
         pv1FJ13BnC/KQt8aNoPiQ1Wa3ljmayTEZTr+ap8QeeslviimkgBRahFOaU2k1XDI2S
         iVksPKXzeQGfLQjSaOJOWC+nWnTqJdjtyIJ1B3ov98JN4RVLxmFn6AQrgotZCSA/Wi
         vHwxDLv9gnJqw==
Date:   Wed, 5 May 2021 15:40:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210505204016.GA1330808@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505131357.07e55042@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 01:13:57PM -0600, Alex Williamson wrote:
> On Wed, 5 May 2021 23:10:32 +0530
> Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > On 21/05/05 01:56PM, Oliver O'Halloran wrote:
> > > On Wed, May 5, 2021 at 12:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > On Mon, May 03, 2021 at 09:07:11PM -0500, Shanker R Donthineni wrote:  
> > > > > On 5/3/21 5:42 PM, Bjorn Helgaas wrote:  
> > > > > > Obviously _RST only works for built-in devices, since there's no AML
> > > > > > for plug-in devices, right?  So if there's a plug-in card with this
> > > > > > GPU, neither SBR nor _RST will work?  
> > > > > These are not plug-in PCIe GPU cards, will exist on upcoming server
> > > > > baseboards. ACPI-reset should wok for plug-in devices as well as long
> > > > > as firmware has _RST method defined in ACPI-device associated with
> > > > > the PCIe hot-plug slot.  
> > > >
> > > > Maybe I'm missing something, but I don't see how _RST can work for
> > > > plug-in devices.  _RST is part of the system firmware, and that
> > > > firmware knows nothing about what will be plugged into the slot.  So
> > > > if system firmware supplies _RST that knows how to reset the Nvidia
> > > > GPU, it's not going to do the right thing if you plug in an NVMe
> > > > device instead.
> > > >
> > > > Can you elaborate on how _RST would work for plug-in devices?  
> 
> I'm not sure I really understand these concerns about plug-in devices.

I'm not really concerned about plug-in devices.  Shanker said above
that _RST would work for them:

  ACPI-reset should work for plug-in devices as well as long as
  firmware has _RST method defined in ACPI-device associated with the
  PCIe hot-plug slot.

and I disagreed.  _RST *cannot* work for plug-in devices because
firmware doesn't know what device will be plugged in and therefore
cannot provide the required device-specific _RST.

That's all I wanted to clarify.

Bjorn
