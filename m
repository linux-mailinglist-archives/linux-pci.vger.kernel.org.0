Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C239B5D9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFDJXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 05:23:55 -0400
Received: from foss.arm.com ([217.140.110.172]:33702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhFDJXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 05:23:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 194F21063;
        Fri,  4 Jun 2021 02:22:09 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830EA3F774;
        Fri,  4 Jun 2021 02:22:07 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:22:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Add panic handler and shutdown func
Message-ID: <20210604092202.GA598@lpieralisi>
References: <20210427175140.17800-1-jim2101024@gmail.com>
 <20210603163213.GB19835@lpieralisi>
 <CA+-6iNyf7K7pQ1un8KJVuxr-h=_QN97MrKHS+5WA_fSm7yh85Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyf7K7pQ1un8KJVuxr-h=_QN97MrKHS+5WA_fSm7yh85Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 01:31:01PM -0400, Jim Quinlan wrote:
> On Thu, Jun 3, 2021 at 12:32 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 01:51:35PM -0400, Jim Quinlan wrote:
> > > v1 -- These commits were part of a previous pullreq but have
> > >       been split off because they are unrelated to said pullreq's
> > >       other more complex commits.
> >
> > Can I drop this series ?
> >
> > https://patchwork.kernel.org/user/todo/linux-pci/?series=459871
> 
> 
> I will be submitting the voltage regulator commits -- but not the
> panic handler -- from the series above -- I just haven't had time to
> get around it (sorry).

So the series above can be marked as superseded, that's what I
was asking.

Thanks,
Lorenzo

> Regards,
> Jim Quinlan
> Broadcom STB
> >
> >
> >
> > Thanks,
> > Lorenzo
> >
> > > Jim Quinlan (4):
> > >   PCI: brcmstb: Check return value of clk_prepare_enable()
> > >   PCI: brcmstb: Give 7216 SOCs their own config type
> > >   PCI: brcmstb: Add panic/die handler to RC driver
> > >   PCI: brcmstb: add shutdown call to driver
> > >
> > >  drivers/pci/controller/pcie-brcmstb.c | 145 +++++++++++++++++++++++++-
> > >  1 file changed, 143 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >


