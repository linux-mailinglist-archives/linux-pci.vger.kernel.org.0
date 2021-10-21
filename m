Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F94368C9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJURNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 13:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhJURNr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 13:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4352461A0A;
        Thu, 21 Oct 2021 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634836291;
        bh=Q03u5Qex8eKAItP0Dg2YZHdrmPOdGUpwH80kTAfzZxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Td5mGM7w14Slx9FIzv7BOb28GJoHrB9ns/c4MS4UE5lQCExsNbqqBd7gbnQBfGK6d
         wCxieyrBp59hT2zKHPX6adnJws0vsRC9Sz+bubNuDJ6BlWOBOwuh6OWp92vMmSALXk
         ET8S21c0NbukPIMV1IoLs4s0V9meVjRT+WnoP5VUEHnqTr3J8/jQQRxcEAAym2TPR9
         YK+2Mxgf1DT4IBJEH8GBr8iGvsGquy5OFgog5NihLEVIZHqbw9WvybbrpeL0RXJ7cm
         csOEwYACYrD8Q33ogHm2srHLkyKi5Z1cLiH/+8dNAXVEDbUINAVTuB6JcJ3iBZTlBX
         C2fA8AKo22srQ==
Date:   Thu, 21 Oct 2021 12:11:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v4 5/8] PCI/DPC: Converge EDR and DPC Path of clearing
 AER registers
Message-ID: <20211021171130.GA2701430@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021165330.lcqajtwej4s7oadt@theprophet>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 10:23:30PM +0530, Naveen Naidu wrote:
> On 20/10, Bjorn Helgaas wrote:
> > On Tue, Oct 05, 2021 at 10:48:12PM +0530, Naveen Naidu wrote:

> > > In EDR path, AER status registers are cleared irrespective of whether
> > > the error was an RP PIO or unmasked uncorrectable error. But in DPC, the
> > > AER status registers are cleared only when it's an unmasked uncorrectable
> > > error.
> > > 
> > > This leads to two different behaviours for the same task (handling of
> > > DPC errors) in FFS systems and when native OS has control.
> > 
> > FFS?
> 
> Firmware First Systems

I assumed that's what it was, but it's helpful to use the same terms
used by the specs to make things easier to find.  I don't think it's
actually the case that "Firmware First" necessary applies to the
entire system, since the ACPI FIRMWARE_FIRST flag is a per-error
source thing, not a per-system thing.
