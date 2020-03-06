Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CDD17BB6B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFLQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 06:16:27 -0500
Received: from foss.arm.com ([217.140.110.172]:59816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCFLQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 06:16:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9223D31B;
        Fri,  6 Mar 2020 03:16:26 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD18D3F6C4;
        Fri,  6 Mar 2020 03:16:25 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:16:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200306111620.GA10297@e121166-lin.cambridge.arm.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 12:48:48PM +0000, Bharat Kumar Gogada wrote:
> > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
> > 
> > [+MarcZ, FHI]
> > 
> > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
> > 
> > [...]
> > 
> > > > > +/* ECAM definitions */
> > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > >
> > > > You don't need these ECAM_* defines, you can use pci_generic_ecam_ops.
> > > Does this need separate ranges region for ECAM space ?
> > > We have ECAM and controller space in same region.
> > 
> > You can create an ECAM window with pci_ecam_create where *cfgres
> > represent the ECAM area, I don't get what you mean by "same region".
> > 
> > Do you mean "contiguous" ? Or something else ?
> Yes, contiguous; within ECAM region some space is for controller registers.

What does that mean ? I don't get it. Can you explain to me how this
address space works please ?

Thanks,
Lorenzo
