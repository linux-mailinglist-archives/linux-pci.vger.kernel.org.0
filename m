Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA50D31727B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhBJVjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 16:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhBJVjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 16:39:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10E4B64EDF;
        Wed, 10 Feb 2021 21:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612993103;
        bh=UbH/tLYAbl2fNaigChteBMhfrn79Xt1ml3xGjhPvAtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H+uUE2YwEG0KvSYCq1Yh8FR3KNp70FVVy3XL1jADalzd3Sdjzh10JPu32V5k1me0Y
         uO68igXntmUusKmLxw0ecybxbIkuAVWXGGrsVcnFZyGRxHLegVGQdB6y6okJNgXXEC
         J4EAoHcTkTS6f0sewL/ecvnOJHfPlfqP5V2TmhV6je06uLBec7tnJUuCttzNR4AGbl
         KcOMEcK0S6nwVo8uVSlnx7AoF3bAmPCujKNL5APF9kRij/eyYc4Fd20dyRIjyV76Ck
         gOEq4Wef4kKd/ZLgkdo55u7yYF14SRY9m0uQw+7ZLd1dMW1sTcSX93tgMNt7XDdnZE
         1YWxqQ3EC9gyQ==
Date:   Wed, 10 Feb 2021 15:38:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210210213821.GA610734@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210040504.GB23363@redsun51.ssa.fujisawa.hgst.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 01:05:04PM +0900, Keith Busch wrote:
> On Tue, Feb 09, 2021 at 05:06:14PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 04, 2021 at 03:02:55PM -0800, Keith Busch wrote:
> > > Changes from v1:
> > > 
> > >   Added received Acks
> > > 
> > >   Split the kernel print identifying the port type being reset.
> > > 
> > >   Added a patch for the portdrv to ensure the slot_reset happens without
> > >   relying on a downstream device driver..
> > > 
> > > Keith Busch (5):
> > >   PCI/ERR: Clear status of the reporting device
> > >   PCI/AER: Actually get the root port
> > >   PCI/ERR: Retain status from error notification
> > >   PCI/AER: Specify the type of port that was reset
> > >   PCI/portdrv: Report reset for frozen channel
> > > 
> > >  drivers/pci/pcie/aer.c         |  5 +++--
> > >  drivers/pci/pcie/err.c         | 16 +++++++---------
> > >  drivers/pci/pcie/portdrv_pci.c |  3 ++-
> > >  3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > I applied these to pci/error for v5.12, thanks!
> 
> Thanks!
>  
> > I *am* a little concerned about the issues Hinko saw because it
> > doesn't look we found a root cause.  I didn't spend any time looking
> > into it, but even if it only shows up on his specific platform or with
> > some weird config combination, it's a problem.  But I guess we'll see
> > if anybody else trips over it.
> 
> Yes, I'm also closely monitoring for AER issues. I think Hinko's
> observation was seen without this series, and was just initially noticed
> with it. I'm reasonably confident this is a safe improvement, but I want
> to see this work well with everyone's hardware, too.

Oh, good.  I missed the fact that it was seen even *without* this
series.
