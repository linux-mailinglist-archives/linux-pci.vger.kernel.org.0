Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499FB315E07
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 05:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBJEFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 23:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhBJEFs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 23:05:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D563564E3E;
        Wed, 10 Feb 2021 04:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612929907;
        bh=aXk+E4JkTI1ArALfp/Qrm2K3Qp9xcTdEeQ0awh25x6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihtYHZcE+whEN1BKj94orHcD9SGFd70Seb/sqlr2jIBONwqNDEWPB4pIucM55r7Bj
         mnMXWHejOVDvG8bNZpcQAxXDgDzgI0zD4jGsvf3yaB67jSqzp5iA77kR+Zq0Bq0MAR
         xPT+KSXqpGiLjF9DGAi4QvV6eAGf548evN6mglvcJHDkYCGAOw9XxeHf6p2dtIvvuT
         CpnFbBBYCuSLeF3epYHoi2St3KSCUBnfucaEuXd7bYCr01AlF+5WoWdg/40XVTrD0T
         XC5wAkqsgIKagAQ82Q5os2esXt08GNzWVKgpRCGfFzTHZvWgLBjEQZIJ8h15NRx2vK
         lV7ZsquW0RUdg==
Date:   Wed, 10 Feb 2021 13:05:04 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210210040504.GB23363@redsun51.ssa.fujisawa.hgst.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210209230614.GA523701@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209230614.GA523701@bjorn-Precision-5520>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 09, 2021 at 05:06:14PM -0600, Bjorn Helgaas wrote:
> [+cc Hinko]
> 
> On Mon, Jan 04, 2021 at 03:02:55PM -0800, Keith Busch wrote:
> > Changes from v1:
> > 
> >   Added received Acks
> > 
> >   Split the kernel print identifying the port type being reset.
> > 
> >   Added a patch for the portdrv to ensure the slot_reset happens without
> >   relying on a downstream device driver..
> > 
> > Keith Busch (5):
> >   PCI/ERR: Clear status of the reporting device
> >   PCI/AER: Actually get the root port
> >   PCI/ERR: Retain status from error notification
> >   PCI/AER: Specify the type of port that was reset
> >   PCI/portdrv: Report reset for frozen channel
> > 
> >  drivers/pci/pcie/aer.c         |  5 +++--
> >  drivers/pci/pcie/err.c         | 16 +++++++---------
> >  drivers/pci/pcie/portdrv_pci.c |  3 ++-
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> I applied these to pci/error for v5.12, thanks!

Thanks!
 
> I *am* a little concerned about the issues Hinko saw because it
> doesn't look we found a root cause.  I didn't spend any time looking
> into it, but even if it only shows up on his specific platform or with
> some weird config combination, it's a problem.  But I guess we'll see
> if anybody else trips over it.

Yes, I'm also closely monitoring for AER issues. I think Hinko's
observation was seen without this series, and was just initially noticed
with it. I'm reasonably confident this is a safe improvement, but I want
to see this work well with everyone's hardware, too.
