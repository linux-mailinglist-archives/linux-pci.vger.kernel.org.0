Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9D3B322
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfFJK1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 06:27:20 -0400
Received: from foss.arm.com ([217.140.110.172]:40070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfFJK1U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 06:27:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79140346;
        Mon, 10 Jun 2019 03:27:19 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530563F557;
        Mon, 10 Jun 2019 03:29:00 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:27:16 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v3] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190610102716.GD25976@redmoon>
References: <1559133469-11981-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20190531160956.GB9356@redmoon>
 <5de53585-e90f-77d2-bd96-025e1b39a573@arm.com>
 <CH2PR02MB6453666163FAF313746EC9C4A5170@CH2PR02MB6453.namprd02.prod.outlook.com>
 <86lfyfgp1a.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86lfyfgp1a.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 08:18:25AM +0100, Marc Zyngier wrote:
> On Thu, 06 Jun 2019 05:49:45 +0100,
> Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
> > 
> > > On 31/05/2019 17:09, Lorenzo Pieralisi wrote:
> > > > [+Marc]
> > > >
> > > > On Wed, May 29, 2019 at 06:07:49PM +0530, Bharat Kumar Gogada wrote:
> > > >> The current Multi MSI data programming fails if multiple end points
> > > >> requesting MSI and multi MSI are connected with switch, i.e the
> > > >> current multi MSI data being given is not considering the number of
> > > >> vectors being requested in case of multi MSI.
> > > >> Ex: Two EP's connected via switch, EP1 requesting single MSI first,
> > > >> EP2 requesting Multi MSI of count four. The current code gives MSI
> > > >> data 0x0 to EP1 and 0x1 to EP2, but EP2 can modify lower two bits due
> > > >> to which EP2 also sends interrupt with MSI data 0x0 which results in
> > > >> always invoking virq of EP1 due to which EP2 MSI interrupt never gets
> > > >> handled.
> > > >
> > > > If this is a problem it is not the only driver where it should be
> > > > fixed it seems. CC'ed Marc in case I have missed something in relation
> > > > to MSI IRQs but AFAIU it looks like HW is allowed to toggled bits
> > > > (according to bits[6:4] in Message Control for MSI) in the MSI data,
> > > > given that the data written is the hwirq number (in this specific MSI
> > > > controller) it ought to be fixed.
> > > 
> > > Yeah, it looks like a number of MSI controllers could be quite broken in this
> > > particular area.
> > > 
> > > >
> > > > The commit log and patch should be rewritten (I will do that) but
> > > > first I would like to understand if there are more drivers to be
> > > > updated.
> > > >
> > > > 
> > Hi Lorenzo and Marc, thanks for your time.
> > Marc, I'm yet to test the below suggested solution,
> > GIC v2m and GIC v3 supports multi MSI, do we see above issue in
> > these MSI controllers ?
> 
> To the best of my knowledge, these drivers do support MultiMSI
> correctly. GICv2m actually gained the support pretty recently (see
> de337ee30142). The GICv3 ITS never ha an issue with that, given that
> per device EventIDs are always 0-based.

AFAIU I think the issues is only present in controllers that use the
hwirq as MSI data and bitmap allocation that is not a power of two and
that's what Marc suggested as fix. There is still some chasing to do to
fix other MSI controllers in the kernel where this subtle issue went
undetected (and the driver has the same bitmap allocation issues as
this one).

@Bharat, please test Marc's patch and post it on completion, I will
rewrite your commit log because I want it to be clear so that we
have a reference to the issue linked to the specs.

Thanks,
Lorenzo
