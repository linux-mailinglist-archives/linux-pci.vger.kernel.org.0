Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA8184DCC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCMRkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 13:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMRkZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 13:40:25 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF81206CD;
        Fri, 13 Mar 2020 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584121224;
        bh=6fvbImJM2+423L79v8Lios4o/jqMRhWF2FJx4TGFUJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E+CpSLv5KGlK5qw3uBSlQcDgr4O2ZWbnnYBpgsC9K7w8gYIZEn5faBPj0peeP6k3i
         c9Al6ee1xfP0Q6/ebnXRdicc7NSmwWO3qixPV1esrv8HsURpYr4YSVg6glDd+yOgRx
         UOX5ILm5yVyIj7McmMJb5DiGb8stjoKlIekwaY8E=
Date:   Fri, 13 Mar 2020 12:40:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
Message-ID: <20200313174022.GA148658@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313165613.GA26992@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 04:56:13PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 03, 2020 at 04:07:47PM +0530, Kishon Vijay Abraham I wrote:
> > Patch series uses dma engine APIs in pci-epf-test to transfer data using
> > DMA. It also adds an option "-d" in pcitest for the user to indicate
> > whether DMA has to be used for data transfer. This also prints
> > throughput information for data transfer.
> > 
> > Changes from v1:
> > *) Fixed some of the function names from pci_epf_* to pci_epf_test_*
> > since the DMA support is now been moved to pci-epf-test.c
> > 
> > Kishon Vijay Abraham I (5):
> >   PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer
> >     data
> >   PCI: endpoint: functions/pci-epf-test: Print throughput information
> >   misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation
> >   tools: PCI: Add 'd' command line option to support DMA
> >   misc: pci_endpoint_test: Add support to get DMA option from userspace
> > 
> >  drivers/misc/pci_endpoint_test.c              | 165 ++++++++++--
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 253 +++++++++++++++++-
> >  include/uapi/linux/pcitest.h                  |   5 +
> >  tools/pci/pcitest.c                           |  20 +-
> >  4 files changed, 412 insertions(+), 31 deletions(-)
> 
> Hi Kishon,
> 
> I had to drop this series - waiting for you to send an updated one
> to fix the x86 build breakage - force pushed pci/endpoint out.

I updated my "next" branch with this updated branch so we can at least
test the other things on the lorenzo/pci/endpoint branch.

The lorenzo/pci/mobiveil branch is also temporarily out completely for
a build issue.
